import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../AdminScaffold/AdminScaffold.dart';
import '../Constant/Myconstant.dart';
import '../Model/GetArea_Model.dart';
import '../Model/GetArea_quot.dart';
import '../Model/GetRenTal_Model.dart';
import '../Model/GetUser_Model.dart';
import '../Model/GetZone_Model.dart';
import '../Model/dashboard_Trans_Model.dart';
import '../Model/dashboard_financ_Model.dart';
import '../Responsive/responsive.dart';
import '../Style/colors.dart';
import 'package:http/http.dart' as http;

class HomeDashboard extends StatefulWidget {
  const HomeDashboard({super.key});

  @override
  State<HomeDashboard> createState() => _HomeDashboardState();
}

class _HomeDashboardState extends State<HomeDashboard> {
  var nFormat = NumberFormat("#,##0.00", "en_US");
  var nFormat2 = NumberFormat("#,##0", "en_US");
  DateTime now = DateTime.now();
  String? SDatex_total1_;
  String? LDatex_total1_;
  String? ser_ren;
  int shoe_detel = 0,
      shoe_index = -1,
      show_dashFinTran = 0,
      show_area = 0,
      ser_renTal = 0;
  List<RenTalModel> renTalModels = [];

  List<AreaModel> areaModels = [];
  List<AreaQuotModel> areaQuotModels = [];
  List<UserModel> userModels = [];
  List<DashboardTransModel> dashboardTransModels = [];
  List<DashboardfinancModel> dashboardfinancModels = [];
  List<ZoneModel> zoneModels = [];

  @override
  void initState() {
    super.initState();
    SDatex_total1_ = DateFormat('yyyy-MM-dd').format(now);
    LDatex_total1_ = DateFormat('yyyy-MM-dd').format(now);
    read_GC_rental();
  }

  Future<Null> read_GC_zone(data_ser) async {
    if (zoneModels.length != 0) {
      zoneModels.clear();
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();

    // var ren = preferences.getString('renTalSer');

    String url =
        '${MyConstant().domain}/GC_zone_das.php?isAdd=true&ren=$data_ser';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);
      for (var map in result) {
        ZoneModel zoneModel = ZoneModel.fromJson(map);
        setState(() {
          zoneModels.add(zoneModel);
        });
      }
      // zoneModels.sort((a, b) {
      //   if (a.zn == 'ทั้งหมด') {
      //     return -1; // 'all' should come before other elements
      //   } else if (b.zn == 'ทั้งหมด') {
      //     return 1; // 'all' should come after other elements
      //   } else {
      //     return a.zn!
      //         .compareTo(b.zn!); // sort other elements in ascending order
      //   }
      // });
    } catch (e) {}
  }

  daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }

  Future<Null> read_GC_User(data_ser) async {
    String url =
        '${MyConstant().domain}/GC_userSetting.php?isAdd=true&ren=$data_ser';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);
      if (result != null) {
        for (var map in result) {
          UserModel userModel = UserModel.fromJson(map);
          setState(() {
            userModels.add(userModel);
          });
          // if (DateFormat('yyyy-MM-dd').format(now).toString() ==
          //     DateFormat('yyyy-MM-dd')
          //         .format(DateTime.parse('${userModel.connected}'))
          //         .toString()) {
          //   user_today++;
          // }
        }
      } else {}
    } catch (e) {}
  }

  Future<Null> read_GC_area(data_ser) async {
    String url =
        '${MyConstant().domain}/GC_areaAll.php?isAdd=true&ren=$data_ser';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print(result);
      if (result != null) {
        for (var map in result) {
          AreaModel areaModel = AreaModel.fromJson(map);
          setState(() {
            areaModels.add(areaModel);
          });

          // if (areaModel.quantity != '1') {
          //   var qin = areaModel.ln_q;
          //   var qinser = areaModel.ser;
          //   String url =
          //       '${MyConstant().domain}/GC_area_quot.php?isAdd=true&ren=$data_ser&qin=$qin&qinser=$qinser';

          //   try {
          //     var response = await http.get(Uri.parse(url));

          //     var result = json.decode(response.body);
          //     // print(result);
          //     if (result != null) {
          //       for (var map in result) {
          //         AreaQuotModel areaQuotModel = AreaQuotModel.fromJson(map);
          //         setState(() {
          //           areaQuotModels.add(areaQuotModel);
          //         });
          //       }
          //     }
          //   } catch (e) {}
          // }
        }
      }
    } catch (e) {}
  }

  Future<Null> read_GC_rental() async {
    setState(() {
      renTalModels.clear();
      userModels.clear();
      areaQuotModels.clear();
      areaModels.clear();
      dashboardTransModels.clear();
      dashboardfinancModels.clear();
    });
    // if (renTalModels.isNotEmpty) {
    //   setState(() {
    //     renTalModels.clear();
    //     userModels.clear();
    //     areaQuotModels.clear();
    //     areaModels.clear();
    //     dashboardTransModels.clear();
    //     dashboardfinancModels.clear();
    //   });
    // }
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var seruser = preferences.getString('ser');
    var utype = preferences.getString('utype');
    var renTal = preferences.getString('renTalSer');
    String url =
        '${MyConstant().domain}/GC_rental.php?isAdd=true&ser=$seruser&type=$utype&ren=$renTal';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);

      Map<String, dynamic> map = Map();
      map['ser'] = '0';
      map['pn'] = 'ทั้งหมด';

      RenTalModel renTalModel = RenTalModel.fromJson(map);

      setState(() {
        ser_renTal = int.parse(renTal!);
        renTalModels.add(renTalModel);
      });

      for (var map in result) {
        RenTalModel renTalModel = RenTalModel.fromJson(map);

        var data_ser = renTalModel.ser;
        setState(() {
          renTalModels.add(renTalModel);
        });
        read_GC_User(data_ser);
        read_GC_area(data_ser);
        red_Sum_billTrans(data_ser);
        red_Sum_billFinnect(data_ser);
        read_GC_zone(data_ser);
      }
    } catch (e) {}
  }

  Future<Null> red_Sum_billTrans(data_ser) async {
    String url =
        '${MyConstant().domain}/GC_dash_tran.php?isAdd=true&ren=$data_ser&sdate=$SDatex_total1_&ldate=$LDatex_total1_';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print('result $ciddoc');
      if (result.toString() != 'null') {
        for (var map in result) {
          DashboardTransModel dashboardTransModel =
              DashboardTransModel.fromJson(map);
          setState(() {
            dashboardTransModels.add(dashboardTransModel);
          });
        }
      }
    } catch (e) {}
  }

  Future<Null> red_Sum_billFinnect(data_ser) async {
    print(
        'SDatex_total1_SDatex_total1_SDatex_total1_ $SDatex_total1_ $LDatex_total1_');
    String url =
        '${MyConstant().domain}/GC_dash_fin.php?isAdd=true&ren=$data_ser&sdate=$SDatex_total1_&ldate=$LDatex_total1_';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print('result $ciddoc');
      if (result.toString() != 'null') {
        for (var map in result) {
          DashboardfinancModel dashboardfinancModel =
              DashboardfinancModel.fromJson(map);
          setState(() {
            dashboardfinancModels.add(dashboardfinancModel);
          });
        }
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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

                                  String? _route =
                                      preferences.getString('route');

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
                            InkWell(
                              onTap: () async {
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
                              child: Container(
                                  width: 130,
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    color: Colors.green.shade900,
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(8),
                                        topRight: Radius.circular(8),
                                        bottomLeft: Radius.circular(8),
                                        bottomRight: Radius.circular(8)),
                                    border: Border.all(
                                        color: Colors.white, width: 1),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      'Dashboard',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: FontWeight_.Fonts_T,
                                      ),
                                    ),
                                  )),
                            ),
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
                        const Padding(
                          padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                          child: Text(
                            'ถึง',
                            style: TextStyle(
                              color: ReportScreen_Color.Colors_Text1_,
                              fontWeight: FontWeight.bold,
                              fontFamily: FontWeight_.Fonts_T,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                          child: InkWell(
                            onTap: () {
                              _select_financial_LtartDate(context);
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
                                    (LDatex_total1_ == null)
                                        ? 'เลือก'
                                        : '$LDatex_total1_',
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      // Padding(
                                      //   padding: const EdgeInsets.all(8.0),
                                      //   child: Divider(),
                                      // ),
                                      // for (int i = 0;
                                      //   i <5;
                                      //   i++)
                                      for (int index = 0;
                                          index < renTalModels.length;
                                          index++)
                                        if (renTalModels[index].ser != '0')
                                          ren_value_ren(context, index)
                                        else
                                          ren_value_ren_all(context)
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
            ],
          ),
        ),
      ),
    );
  }

  Padding ren_value_ren_all(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Container(
        padding: const EdgeInsets.all(15),
        width: MediaQuery.of(context).size.width * 0.45,
        // height: MediaQuery.of(context).size.width *
        //     0.43,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          // color: Color(0xFFA8BFDB),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 6,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 8, 8),
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            color: Colors.blue[700],
                          ),
                          child: IconButton(
                            onPressed: () async {
                              DateTime now =
                                  DateTime.parse('$SDatex_total1_ 00:00:00');
                              int lastday =
                                  DateTime(now.year, now.month + 1, 0).day;
                              print(lastday);
                            },
                            icon: Icon(
                              Icons.location_pin,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Text(
                          'ทั้งหมด',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            shadows: [
                              Shadow(color: Colors.black, offset: Offset(0, -5))
                            ],
                            color: Colors.transparent,
                            // decoration: TextDecoration
                            //     .underline,
                            decorationColor: Colors.grey,
                            decorationThickness: 4,
                            // decorationStyle:
                            //     TextDecorationStyle
                            //         .dashed,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: FontWeight_.Fonts_T,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
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
                      const Padding(
                        padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                        child: Text(
                          'ถึง',
                          style: TextStyle(
                            color: ReportScreen_Color.Colors_Text1_,
                            fontWeight: FontWeight.bold,
                            fontFamily: FontWeight_.Fonts_T,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                        child: InkWell(
                          onTap: () {
                            _select_financial_LtartDate(context);
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
                                  (LDatex_total1_ == null)
                                      ? 'เลือก'
                                      : '$LDatex_total1_',
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
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          color: Colors.red[700],
                        ),
                        child: const Icon(
                          Icons.account_balance_wallet,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'ยอดค้างชำระ',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          // fontSize:
                          //     12,
                          // decoration:
                          //     TextDecoration.underline,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontFamily: FontWeight_.Fonts_T,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    child: SfCircularChart(
                      legend: Legend(
                          isVisible: true,
                          position: LegendPosition.left,
                          // Overflowing legend content will be wraped
                          overflowMode: LegendItemOverflowMode.wrap),
                      series: <CircularSeries>[
                        PieSeries<ChartData, String>(
                          dataSource: [
                            for (int indexc = 0;
                                indexc < renTalModels.length;
                                indexc++)
                              if (renTalModels[indexc].ser != '0')
                                ChartData(
                                    '${renTalModels[indexc].pn}',
                                    (((dashboardTransModels.isEmpty ? 0 : dashboardTransModels.map((e) => e.rser == renTalModels[indexc].ser ? double.parse(e.total.toString()) : 0).reduce((value, element) => value + element)) * 100) /
                                                ((dashboardfinancModels.isEmpty ? 0 : dashboardfinancModels.map((e) => e.rser == renTalModels[indexc].ser ? double.parse(e.total.toString()) : 0).reduce((value, element) => value + element)) +
                                                    (dashboardTransModels.isEmpty
                                                        ? 0
                                                        : dashboardTransModels.map((e) => e.rser == renTalModels[indexc].ser ? double.parse(e.total.toString()) : 0).reduce((value,
                                                                element) =>
                                                            value + element))))
                                            .isNaN
                                        ? 0
                                        : ((dashboardTransModels.isEmpty ? 0 : dashboardTransModels.map((e) => e.rser == renTalModels[indexc].ser ? double.parse(e.total.toString()) : 0).reduce((value, element) => value + element)) *
                                                100) /
                                            ((dashboardfinancModels.isEmpty ? 0 : dashboardfinancModels.map((e) => e.rser == renTalModels[indexc].ser ? double.parse(e.total.toString()) : 0).reduce((value, element) => value + element)) +
                                                (dashboardTransModels.isEmpty
                                                    ? 0
                                                    : dashboardTransModels
                                                        .map((e) => e.rser == renTalModels[indexc].ser ? double.parse(e.total.toString()) : 0)
                                                        .reduce((value, element) => value + element))),
                                    '${(((dashboardTransModels.isEmpty ? 0 : dashboardTransModels.map((e) => e.rser == renTalModels[indexc].ser ? double.parse(e.total.toString()) : 0).reduce((value, element) => value + element)) * 100) / ((dashboardfinancModels.isEmpty ? 0 : dashboardfinancModels.map((e) => e.rser == renTalModels[indexc].ser ? double.parse(e.total.toString()) : 0).reduce((value, element) => value + element)) + (dashboardTransModels.isEmpty ? 0 : dashboardTransModels.map((e) => e.rser == renTalModels[indexc].ser ? double.parse(e.total.toString()) : 0).reduce((value, element) => value + element)))).isNaN ? 0 : (((dashboardTransModels.isEmpty ? 0 : dashboardTransModels.map((e) => e.rser == renTalModels[indexc].ser ? double.parse(e.total.toString()) : 0).reduce((value, element) => value + element)) * 100) / ((dashboardfinancModels.isEmpty ? 0 : dashboardfinancModels.map((e) => e.rser == renTalModels[indexc].ser ? double.parse(e.total.toString()) : 0).reduce((value, element) => value + element)) + (dashboardTransModels.isEmpty ? 0 : dashboardTransModels.map((e) => e.rser == renTalModels[indexc].ser ? double.parse(e.total.toString()) : 0).reduce((value, element) => value + element)))).toStringAsFixed(0)} %'),
                          ],
                          // pointColorMapper: (ChartData data, _) => data.color,
                          xValueMapper: (ChartData data, _) => data.x,
                          yValueMapper: (ChartData data, _) => data.y,
                          // dataLabelMapper: (ChartData data, _) => data.x,
                          // radius: '40%',
                          explode: true,
                          // All the segments will be exploded  ser_renTal
                          explodeIndex: (renTalModels.indexWhere((item) =>
                                  item.ser.toString() ==
                                  ser_renTal.toString()) -
                              1),
                          dataLabelSettings: DataLabelSettings(
                              isVisible: true,
                              useSeriesColor: true,
                              builder: (dynamic data,
                                  dynamic point,
                                  dynamic series,
                                  int pointIndex,
                                  int seriesIndex) {
                                return Container(
                                  height: 65,
                                  width: 68,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        '${data.z}',
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 12,
                                          // decoration:
                                          //     TextDecoration.underline,
                                          // color: Colors.white,
                                          // fontWeight: FontWeight.bold,
                                          fontFamily: Font_.Fonts_T,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }
                              // labelIntersectAction: LabelIntersectAction.shift,
                              // connectorLineSettings: ConnectorLineSettings(
                              //     type: ConnectorType.curve, length: '8%'),
                              ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Divider(),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 8, 8),
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            color: Colors.teal[700],
                          ),
                          child: const Icon(
                            Icons.monetization_on_rounded,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'รวมรายรับ (ชำระแล้ว Cash/Bank)',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          // fontSize:
                          //     12,
                          // decoration:
                          //     TextDecoration.underline,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontFamily: FontWeight_.Fonts_T,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    child: SfCircularChart(
                      legend: Legend(
                          isVisible: true,
                          position: LegendPosition.left,
                          // Overflowing legend content will be wraped
                          overflowMode: LegendItemOverflowMode.wrap),
                      series: <CircularSeries>[
                        PieSeries<ChartData, String>(
                          dataSource: [
                            for (int indexc = 0;
                                indexc < renTalModels.length;
                                indexc++)
                              if (renTalModels[indexc].ser != '0')
                                ChartData(
                                  '${renTalModels[indexc].pn}',
                                  (((dashboardfinancModels.isEmpty ? 0 : dashboardfinancModels.map((e) => e.rser == renTalModels[indexc].ser ? double.parse(e.total.toString()) : 0).reduce((value, element) => value + element)) * 100) /
                                              ((dashboardfinancModels.isEmpty ? 0 : dashboardfinancModels.map((e) => e.rser == renTalModels[indexc].ser ? double.parse(e.total.toString()) : 0).reduce((value, element) => value + element)) +
                                                  (dashboardTransModels.isEmpty
                                                      ? 0
                                                      : dashboardTransModels.map((e) => e.rser == renTalModels[indexc].ser ? double.parse(e.total.toString()) : 0).reduce((value, element) =>
                                                          value + element))))
                                          .isNaN
                                      ? 0
                                      : ((dashboardfinancModels.isEmpty ? 0 : dashboardfinancModels.map((e) => e.rser == renTalModels[indexc].ser ? double.parse(e.total.toString()) : 0).reduce((value, element) => value + element)) * 100) /
                                          ((dashboardfinancModels.isEmpty
                                                  ? 0
                                                  : dashboardfinancModels.map((e) => e.rser == renTalModels[indexc].ser ? double.parse(e.total.toString()) : 0).reduce(
                                                      (value, element) =>
                                                          value + element)) +
                                              (dashboardTransModels.isEmpty
                                                  ? 0
                                                  : dashboardTransModels
                                                      .map((e) => e.rser == renTalModels[indexc].ser ? double.parse(e.total.toString()) : 0)
                                                      .reduce((value, element) => value + element))),
                                  '${(((dashboardfinancModels.isEmpty ? 0 : dashboardfinancModels.map((e) => e.rser == renTalModels[indexc].ser ? double.parse(e.total.toString()) : 0).reduce((value, element) => value + element)) * 100) / ((dashboardfinancModels.isEmpty ? 0 : dashboardfinancModels.map((e) => e.rser == renTalModels[indexc].ser ? double.parse(e.total.toString()) : 0).reduce((value, element) => value + element)) + (dashboardTransModels.isEmpty ? 0 : dashboardTransModels.map((e) => e.rser == renTalModels[indexc].ser ? double.parse(e.total.toString()) : 0).reduce((value, element) => value + element)))).isNaN ? 0 : (((dashboardfinancModels.isEmpty ? 0 : dashboardfinancModels.map((e) => e.rser == renTalModels[indexc].ser ? double.parse(e.total.toString()) : 0).reduce((value, element) => value + element)) * 100) / ((dashboardfinancModels.isEmpty ? 0 : dashboardfinancModels.map((e) => e.rser == renTalModels[indexc].ser ? double.parse(e.total.toString()) : 0).reduce((value, element) => value + element)) + (dashboardTransModels.isEmpty ? 0 : dashboardTransModels.map((e) => e.rser == renTalModels[indexc].ser ? double.parse(e.total.toString()) : 0).reduce((value, element) => value + element)))).toStringAsFixed(0)} %',
                                ),
                          ],
                          // pointColorMapper: (ChartData data, _) => data.color,
                          xValueMapper: (ChartData data, _) => data.x,
                          yValueMapper: (ChartData data, _) => data.y,
                          // dataLabelMapper: (ChartData data, _) => data.x,
                          // radius: '40%',
                          explode: true,
                          // All the segments will be exploded  ser_renTal
                          explodeIndex: (renTalModels.indexWhere((item) =>
                                  item.ser.toString() ==
                                  ser_renTal.toString()) -
                              1),
                          dataLabelSettings: DataLabelSettings(
                              isVisible: true,
                              useSeriesColor: true,
                              builder: (dynamic data,
                                  dynamic point,
                                  dynamic series,
                                  int pointIndex,
                                  int seriesIndex) {
                                return Container(
                                  height: 65,
                                  width: 68,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        '${data.z}',
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 12,
                                          // decoration:
                                          //     TextDecoration.underline,
                                          // color: Colors.white,
                                          // fontWeight: FontWeight.bold,
                                          fontFamily: Font_.Fonts_T,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }
                              // labelIntersectAction: LabelIntersectAction.shift,
                              // connectorLineSettings: ConnectorLineSettings(
                              //     type: ConnectorType.curve, length: '8%'),
                              ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Divider(),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 8, 8),
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            color: Colors.orange[700],
                          ),
                          child: const Icon(
                            Icons.map_outlined,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'พื้นที่',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          // fontSize:
                          //     12,
                          // decoration:
                          //     TextDecoration.underline,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontFamily: FontWeight_.Fonts_T,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    child: SfCircularChart(
                      legend: Legend(
                          isVisible: true,
                          position: LegendPosition.left,
                          // Overflowing legend content will be wraped
                          overflowMode: LegendItemOverflowMode.wrap),
                      series: <CircularSeries>[
                        PieSeries<ChartData, String>(
                          dataSource: [
                            for (int indexc = 0;
                                indexc < renTalModels.length;
                                indexc++)
                              if (renTalModels[indexc].ser != '0')
                                ChartData(
                                  '${renTalModels[indexc].pn}',
                                  (((areaModels.map((e) => e.ser_ren == renTalModels[indexc].ser && e.quantity == '1' ? 1 : 0).reduce(
                                                      (value, element) =>
                                                          value + element) *
                                                  100) /
                                              areaModels.map((e) => e.ser_ren == renTalModels[indexc].ser ? 1 : 0).reduce(
                                                  (value, element) =>
                                                      value + element)))
                                          .isNaN
                                      ? 0
                                      : ((areaModels.map((e) => e.ser_ren == renTalModels[indexc].ser && e.quantity == '1' ? 1 : 0).reduce(
                                                  (value, element) =>
                                                      value + element) *
                                              100) /
                                          areaModels
                                              .map((e) => e.ser_ren == renTalModels[indexc].ser ? 1 : 0)
                                              .reduce((value, element) => value + element)),
                                  '${(((areaModels.map((e) => e.ser_ren == renTalModels[indexc].ser && e.quantity == '1' ? 1 : 0).reduce((value, element) => value + element) * 100) / areaModels.map((e) => e.ser_ren == renTalModels[indexc].ser ? 1 : 0).reduce((value, element) => value + element))).isNaN ? 0 : ((areaModels.map((e) => e.ser_ren == renTalModels[indexc].ser && e.quantity == '1' ? 1 : 0).reduce((value, element) => value + element) * 100) / areaModels.map((e) => e.ser_ren == renTalModels[indexc].ser ? 1 : 0).reduce((value, element) => value + element)).toStringAsFixed(0)} %',
                                ),
                          ],
                          // pointColorMapper: (ChartData data, _) => data.color,
                          xValueMapper: (ChartData data, _) => data.x,
                          yValueMapper: (ChartData data, _) => data.y,
                          dataLabelMapper: (ChartData data, _) => data.x,
                          // radius: '40%',
                          explode: true,
                          // All the segments will be exploded  ser_renTal
                          explodeIndex: (renTalModels.indexWhere((item) =>
                                  item.ser.toString() ==
                                  ser_renTal.toString()) -
                              1),
                          dataLabelSettings: DataLabelSettings(
                              isVisible: true,
                              useSeriesColor: true,
                              // labelPosition: ChartDataLabelPosition.outside,
                              builder: (dynamic data,
                                  dynamic point,
                                  dynamic series,
                                  int pointIndex,
                                  int seriesIndex) {
                                return Container(
                                  height: 65,
                                  width: 68,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        '${data.z}',
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 12,
                                          // decoration:
                                          //     TextDecoration.underline,
                                          // color: Colors.black,
                                          // fontWeight: FontWeight.bold,
                                          fontFamily: Font_.Fonts_T,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }
                              // labelIntersectAction: LabelIntersectAction.shift,
                              // connectorLineSettings: ConnectorLineSettings(
                              //     type: ConnectorType.curve, length: '8%'),
                              ),
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
    );
  }

  Padding ren_value_ren(BuildContext context, int index) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Container(
        padding: const EdgeInsets.all(15),
        width: shoe_detel == 0
            ? MediaQuery.of(context).size.width * 0.2
            : shoe_index != index
                ? MediaQuery.of(context).size.width * 0.2
                : MediaQuery.of(context).size.width * 0.6,
        // height: MediaQuery.of(context).size.width *
        //     0.43,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          // color: Color(0xFFA8BFDB),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: shoe_detel == 0
                  ? 6
                  : shoe_index != index
                      ? 6
                      : 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 8, 8),
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            color: Colors.blue[700],
                          ),
                          child: IconButton(
                            onPressed: () async {
                              var renTalSer = renTalModels[index].ser;
                              var renTalName = renTalModels[index].pn;
                              print(
                                  'mmmmm ${renTalSer.toString()} $renTalName');

                              SharedPreferences preferences =
                                  await SharedPreferences.getInstance();
                              preferences.setString(
                                  'renTalSer', renTalSer.toString());
                              preferences.setString(
                                  'renTalName', renTalName.toString());
                              String? _route = preferences.getString('route');

                              preferences.remove('zoneSer');
                              preferences.remove('zonesName');
                              preferences.remove('zonePSer');
                              preferences.remove('zonesPName');

                              MaterialPageRoute route = MaterialPageRoute(
                                builder: (context) =>
                                    AdminScafScreen(route: _route),
                              );
                              Navigator.pushAndRemoveUntil(
                                  context, route, (route) => false);
                            },
                            icon: Icon(
                              Icons.location_pin,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Text(
                          '${renTalModels[index].pn}',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            shadows: [
                              Shadow(color: Colors.black, offset: Offset(0, -5))
                            ],
                            color: Colors.transparent,
                            // decoration: TextDecoration
                            //     .underline,
                            decorationColor: Colors.grey,
                            decorationThickness: 4,
                            // decorationStyle:
                            //     TextDecorationStyle
                            //         .dashed,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: FontWeight_.Fonts_T,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 8, 8),
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            color: Colors.red[700],
                          ),
                          child: const Icon(
                            Icons.account_balance_wallet,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 8, 8),
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            // color:
                            //     Colors.red[700],
                          ),
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                if (shoe_detel == 1) {
                                  shoe_detel = 0;
                                  shoe_index = -1;
                                  show_dashFinTran = 0;
                                  ser_ren = '';
                                } else {
                                  shoe_detel = 1;
                                  shoe_index = index;
                                  show_dashFinTran = 1;
                                  ser_ren = renTalModels[index].ser;
                                }
                              });
                            },
                            icon: Icon(
                              shoe_detel == 1
                                  ? Icons.chevron_left
                                  : Icons.chevron_right,
                            ),
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Text(
                    'ยอดค้างชำระ',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      shadows: [
                        Shadow(color: Colors.black, offset: Offset(0, -5))
                      ],
                      color: Colors.transparent,
                      // decoration: TextDecoration
                      //     .underline,
                      decorationColor: Colors.grey,
                      decorationThickness: 4,
                      // decorationStyle:
                      //     TextDecorationStyle
                      //         .dashed,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      fontFamily: FontWeight_.Fonts_T,
                    ),
                  ),
                  Container(
                    child: Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: LinearPercentIndicator(
                            // width: MediaQuery.of(context)
                            //         .size
                            //         .width /
                            //     10,
                            animation: true,
                            lineHeight: 14.0,
                            leading: Container(
                              width: ((MediaQuery.of(context).size.width) < 650)
                                  ? 40
                                  : 100,
                              child: const Text(
                                'ทั้งหมด',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 12,
                                  // decoration:
                                  //     TextDecoration.underline,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: FontWeight_.Fonts_T,
                                ),
                              ),
                            ),
                            animationDuration: 3000,
                            percent: (double.parse((((dashboardfinancModels.isEmpty
                                            ? 0
                                            : dashboardfinancModels
                                                .map((e) => e.rser == renTalModels[index].ser
                                                    ? double.parse(
                                                        e.total.toString())
                                                    : 0)
                                                .reduce((value, element) =>
                                                    value + element)) +
                                        (dashboardTransModels.isEmpty
                                            ? 0
                                            : dashboardTransModels
                                                .map((e) => e.rser == renTalModels[index].ser
                                                    ? double.parse(e.total.toString())
                                                    : 0)
                                                .reduce((value, element) => value + element))))
                                    .toString()))
                                .clamp(0.0, 1.0),
                            center: Text(
                              '${nFormat.format(((dashboardfinancModels.isEmpty ? 0 : dashboardfinancModels.map((e) => e.rser == renTalModels[index].ser ? double.parse(e.total.toString()) : 0).reduce((value, element) => value + element)) + (dashboardTransModels.isEmpty ? 0 : dashboardTransModels.map((e) => e.rser == renTalModels[index].ser ? double.parse(e.total.toString()) : 0).reduce((value, element) => value + element))))} บาท',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 11.5,

                                color: Colors.black,
                                // fontWeight: FontWeight.bold,
                                fontFamily: Font_.Fonts_T,
                              ),
                            ),
                            linearStrokeCap: LinearStrokeCap.roundAll,
                            progressColor: Colors.blue[300],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            '${(((dashboardfinancModels.isEmpty ? 0 : dashboardfinancModels.map((e) => e.rser == renTalModels[index].ser ? double.parse(e.total.toString()) : 0).reduce((value, element) => value + element)) + (dashboardTransModels.isEmpty ? 0 : dashboardTransModels.map((e) => e.rser == renTalModels[index].ser ? double.parse(e.total.toString()) : 0).reduce((value, element) => value + element))) * 100 / ((dashboardfinancModels.isEmpty ? 0 : dashboardfinancModels.map((e) => e.rser == renTalModels[index].ser ? double.parse(e.total.toString()) : 0).reduce((value, element) => value + element)) + (dashboardTransModels.isEmpty ? 0 : dashboardTransModels.map((e) => e.rser == renTalModels[index].ser ? double.parse(e.total.toString()) : 0).reduce((value, element) => value + element)))).toStringAsFixed(0)} %',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 12,
                              // decoration:
                              //     TextDecoration.underline,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontFamily: FontWeight_.Fonts_T,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: LinearPercentIndicator(
                            // width: MediaQuery.of(context)
                            //         .size
                            //         .width /
                            //     10,
                            animation: true,
                            lineHeight: 14.0,
                            leading: Container(
                              width: ((MediaQuery.of(context).size.width) < 650)
                                  ? 40
                                  : 100,
                              child: const Text(
                                'รายรับ',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 12,
                                  // decoration:
                                  //     TextDecoration.underline,
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: FontWeight_.Fonts_T,
                                ),
                              ),
                            ),
                            animationDuration: 3000,
                            percent: (dashboardfinancModels.isEmpty)
                                ? (0.00).clamp(0.0, 1.0)
                                : (double.parse(dashboardfinancModels
                                        .map((e) => e.rser ==
                                                renTalModels[index].ser
                                            ? double.parse(e.total.toString())
                                            : 0)
                                        .reduce(
                                            (value, element) => value + element)
                                        .toString()))
                                    .clamp(0.0, 1.0),
                            center: Text(
                              (dashboardfinancModels.isEmpty)
                                  ? '0.00 บาท'
                                  : '${nFormat.format(dashboardfinancModels.map((e) => e.rser == renTalModels[index].ser ? double.parse(e.total.toString()) : 0).reduce((value, element) => value + element))} บาท',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 11.5,

                                color: Colors.black,
                                // fontWeight: FontWeight.bold,
                                fontFamily: Font_.Fonts_T,
                              ),
                            ),
                            linearStrokeCap: LinearStrokeCap.roundAll,
                            progressColor: Colors.green[300],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            '${(((dashboardfinancModels.isEmpty ? 0 : dashboardfinancModels.map((e) => e.rser == renTalModels[index].ser ? double.parse(e.total.toString()) : 0).reduce((value, element) => value + element)) * 100) / ((dashboardfinancModels.isEmpty ? 0 : dashboardfinancModels.map((e) => e.rser == renTalModels[index].ser ? double.parse(e.total.toString()) : 0).reduce((value, element) => value + element)) + (dashboardTransModels.isEmpty ? 0 : dashboardTransModels.map((e) => e.rser == renTalModels[index].ser ? double.parse(e.total.toString()) : 0).reduce((value, element) => value + element)))).toStringAsFixed(0)} %',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 12,
                              // decoration:
                              //     TextDecoration.underline,
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                              fontFamily: FontWeight_.Fonts_T,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: LinearPercentIndicator(
                            // width: MediaQuery.of(context)
                            //         .size
                            //         .width /
                            //     10,
                            animation: true,
                            lineHeight: 14.0,
                            leading: Container(
                              width: ((MediaQuery.of(context).size.width) < 650)
                                  ? 40
                                  : 100,
                              child: const Text(
                                'ค้างชำระ',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 12,
                                  // decoration:
                                  //     TextDecoration.underline,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: FontWeight_.Fonts_T,
                                ),
                              ),
                            ),
                            animationDuration: 3000,
                            // percent: (total1_ / total2_)
                            //     .clamp(0.0, 1.0),
                            percent: (dashboardTransModels.isEmpty)
                                ? (0.00).clamp(0.0, 1.0)
                                : ((double.parse(dashboardTransModels
                                            .map((e) =>
                                                e.rser == renTalModels[index].ser
                                                    ? double.parse(
                                                        e.total.toString())
                                                    : 0)
                                            .reduce((value, element) =>
                                                value + element)
                                            .toString())) /
                                        (dashboardfinancModels.isEmpty
                                            ? 0
                                            : (double.parse(dashboardfinancModels
                                                .map((e) => e.rser == renTalModels[index].ser
                                                    ? double.parse(e.total.toString())
                                                    : 0)
                                                .reduce((value, element) => value + element)
                                                .toString()))))
                                    .clamp(0.0, 1.0),
                            center: Text(
                              (dashboardTransModels.isEmpty)
                                  ? '0.00 บาท'
                                  : '${nFormat.format(dashboardTransModels.map((e) => e.rser == renTalModels[index].ser ? double.parse(e.total.toString()) : 0).reduce((value, element) => value + element))} บาท',
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 11.5,
                                // decoration:
                                //     TextDecoration.underline,
                                color: Colors.black,
                                // fontWeight: FontWeight.bold,
                                fontFamily: Font_.Fonts_T,
                              ),
                            ),
                            linearStrokeCap: LinearStrokeCap.roundAll,
                            progressColor: Colors.red[300],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            (dashboardTransModels.isEmpty)
                                ? '0 %'
                                : '${(((dashboardTransModels.isEmpty ? 0 : dashboardTransModels.map((e) => e.rser == renTalModels[index].ser ? double.parse(e.total.toString()) : 0).reduce((value, element) => value + element)) * 100) / ((dashboardfinancModels.isEmpty ? 0 : dashboardfinancModels.map((e) => e.rser == renTalModels[index].ser ? double.parse(e.total.toString()) : 0).reduce((value, element) => value + element)) + (dashboardTransModels.isEmpty ? 0 : dashboardTransModels.map((e) => e.rser == renTalModels[index].ser ? double.parse(e.total.toString()) : 0).reduce((value, element) => value + element)))).toStringAsFixed(0)} %',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 12,
                              // decoration:
                              //     TextDecoration.underline,
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontFamily: FontWeight_.Fonts_T,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Divider(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 8, 8),
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            color: Colors.teal[700],
                          ),
                          child: const Icon(
                            Icons.monetization_on_rounded,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 8, 8),
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            // color:
                            //     Colors.red[700],
                          ),
                          child: IconButton(
                            onPressed: () {
                              if (shoe_detel == 1) {
                                shoe_detel = 0;
                                shoe_index = -1;
                                show_dashFinTran = 0;
                                ser_ren = '';
                              } else {
                                shoe_detel = 1;
                                shoe_index = index;
                                show_dashFinTran = 2;
                                ser_ren = renTalModels[index].ser;
                              }
                            },
                            icon: Icon(
                              shoe_detel == 1
                                  ? Icons.chevron_left
                                  : Icons.chevron_right,
                            ),
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Text(
                    'รวมรายรับ (ชำระแล้ว Cash/Bank)',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      shadows: [
                        Shadow(color: Colors.black, offset: Offset(0, -5))
                      ],
                      color: Colors.transparent,
                      // decoration: TextDecoration
                      //     .underline,
                      decorationColor: Colors.grey,
                      decorationThickness: 4,
                      // decorationStyle:
                      //     TextDecorationStyle
                      //         .dashed,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      fontFamily: FontWeight_.Fonts_T,
                    ),
                  ),
                  Container(
                    child: Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: LinearPercentIndicator(
                            // width: MediaQuery.of(context)
                            //         .size
                            //         .width /
                            //     10,
                            animation: true,
                            lineHeight: 14.0,
                            leading: Container(
                              width: ((MediaQuery.of(context).size.width) < 650)
                                  ? 40
                                  : 100,
                              child: const Text(
                                'ทั้งหมด',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 12,
                                  // decoration:
                                  //     TextDecoration.underline,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: FontWeight_.Fonts_T,
                                ),
                              ),
                            ),
                            animationDuration: 3000,
                            percent: (dashboardfinancModels.isEmpty)
                                ? (0.00).clamp(0.0, 1.0)
                                : (double.parse(dashboardfinancModels
                                        .map((e) => e.rser ==
                                                renTalModels[index].ser
                                            ? double.parse(e.total.toString())
                                            : 0)
                                        .reduce(
                                            (value, element) => value + element)
                                        .toString()))
                                    .clamp(0.0, 1.0),
                            center: Text(
                              (dashboardfinancModels.isEmpty)
                                  ? '0.00 บาท'
                                  : '${nFormat.format(dashboardfinancModels.map((e) => e.rser == renTalModels[index].ser ? double.parse(e.total.toString()) : 0).reduce((value, element) => value + element))} บาท',
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 11.5,
                                // decoration:
                                //     TextDecoration.underline,
                                color: Colors.black,
                                // fontWeight: FontWeight.bold,
                                fontFamily: Font_.Fonts_T,
                              ),
                            ),
                            linearStrokeCap: LinearStrokeCap.roundAll,
                            progressColor: Colors.blue[300],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            '${(((dashboardfinancModels.isEmpty ? 0 : dashboardfinancModels.map((e) => e.rser == renTalModels[index].ser ? double.parse(e.total.toString()) : 0).reduce((value, element) => value + element)) * 100) / ((dashboardfinancModels.isEmpty ? 0 : dashboardfinancModels.map((e) => e.rser == renTalModels[index].ser ? double.parse(e.total.toString()) : 0).reduce((value, element) => value + element)) + (dashboardTransModels.isEmpty ? 0 : dashboardTransModels.map((e) => e.rser == renTalModels[index].ser ? double.parse(e.total.toString()) : 0).reduce((value, element) => value + element)))).toStringAsFixed(0)} %',

                            // (dashboardfinancModels
                            //         .isEmpty)
                            //     ? '0 %'
                            //     : '${((dashboardfinancModels.map((e) => e.rser == renTalModels[index].ser ? double.parse(e.total.toString()) : 0).reduce((value, element) => value + element) * 100) / dashboardfinancModels.map((e) => e.rser == renTalModels[index].ser ? double.parse(e.total.toString()) : 0).reduce((value, element) => value + element)).toStringAsFixed(0)} %',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 12,
                              // decoration:
                              //     TextDecoration.underline,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontFamily: FontWeight_.Fonts_T,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: LinearPercentIndicator(
                            // width: MediaQuery.of(context)
                            //         .size
                            //         .width /
                            //     10,
                            animation: true,
                            lineHeight: 14.0,
                            leading: Container(
                              width: ((MediaQuery.of(context).size.width) < 650)
                                  ? 40
                                  : 100,
                              child: const Text(
                                'Cash',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 12,
                                  // decoration:
                                  //     TextDecoration.underline,
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: FontWeight_.Fonts_T,
                                ),
                              ),
                            ),
                            animationDuration: 3000,
                            percent: (dashboardfinancModels.isEmpty)
                                ? (0.00).clamp(0.0, 1.0)
                                : ((double.parse(dashboardfinancModels
                                            .map((e) => e.rser == renTalModels[index].ser &&
                                                    e.type == 'CASH'
                                                ? double.parse(
                                                    e.total.toString())
                                                : 0)
                                            .reduce((value, element) =>
                                                value + element)
                                            .toString())) /
                                        (double.parse(dashboardfinancModels
                                            .map((e) => e.rser == renTalModels[index].ser
                                                ? double.parse(e.total.toString())
                                                : 0)
                                            .reduce((value, element) => value + element)
                                            .toString())))
                                    .clamp(0.0, 1.0),
                            center: Text(
                              (dashboardfinancModels.isEmpty)
                                  ? '0.00 บาท'
                                  : '${nFormat.format(dashboardfinancModels.map((e) => e.rser == renTalModels[index].ser && e.type == 'CASH' ? double.parse(e.total.toString()) : 0).reduce((value, element) => value + element))} บาท',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 11.5,

                                color: Colors.black,
                                // fontWeight: FontWeight.bold,
                                fontFamily: Font_.Fonts_T,
                              ),
                            ),
                            linearStrokeCap: LinearStrokeCap.roundAll,
                            progressColor: Colors.green[300],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            (dashboardfinancModels.isEmpty)
                                ? '0 %'
                                : '${((dashboardfinancModels.map((e) => e.rser == renTalModels[index].ser && e.type == 'CASH' ? double.parse(e.total.toString()) : 0).reduce((value, element) => value + element) * 100) / dashboardfinancModels.map((e) => e.rser == renTalModels[index].ser ? double.parse(e.total.toString()) : 0).reduce((value, element) => value + element)).toStringAsFixed(0)} %',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 12,
                              // decoration:
                              //     TextDecoration.underline,
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                              fontFamily: FontWeight_.Fonts_T,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: LinearPercentIndicator(
                            // width: MediaQuery.of(context)
                            //         .size
                            //         .width /
                            //     10,
                            animation: true,
                            lineHeight: 14.0,
                            leading: Container(
                              width: ((MediaQuery.of(context).size.width) < 650)
                                  ? 40
                                  : 100,
                              child: const Text(
                                'Bank',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 12,
                                  // decoration:
                                  //     TextDecoration.underline,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: FontWeight_.Fonts_T,
                                ),
                              ),
                            ),
                            percent: (dashboardfinancModels.isEmpty)
                                ? (0.00).clamp(0.0, 1.0)
                                : ((double.parse(dashboardfinancModels
                                            .map((e) =>
                                                e.rser == renTalModels[index].ser &&
                                                        e.type != 'CASH' &&
                                                        e.type != 'DISCOUNT'
                                                    ? double.parse(
                                                        e.total.toString())
                                                    : 0)
                                            .reduce((value, element) =>
                                                value + element)
                                            .toString())) /
                                        (double.parse(dashboardfinancModels
                                            .map((e) =>
                                                e.rser == renTalModels[index].ser ? double.parse(e.total.toString()) : 0)
                                            .reduce((value, element) => value + element)
                                            .toString())))
                                    .clamp(0.0, 1.0),
                            center: Text(
                              (dashboardfinancModels.isEmpty)
                                  ? '0.00 บาท'
                                  : '${nFormat.format(dashboardfinancModels.map((e) => e.rser == renTalModels[index].ser && e.type != 'CASH' && e.type != 'DISCOUNT' ? double.parse(e.total.toString()) : 0).reduce((value, element) => value + element))} บาท',
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 11.5,
                                // decoration:
                                //     TextDecoration.underline,
                                color: Colors.black,
                                // fontWeight: FontWeight.bold,
                                fontFamily: Font_.Fonts_T,
                              ),
                            ),
                            linearStrokeCap: LinearStrokeCap.roundAll,
                            progressColor: Colors.red[300],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            (dashboardfinancModels.isEmpty)
                                ? '0 %'
                                : '${((dashboardfinancModels.map((e) => e.rser == renTalModels[index].ser && e.type != 'CASH' && e.type != 'DISCOUNT' ? double.parse(e.total.toString()) : 0).reduce((value, element) => value + element) * 100) / dashboardfinancModels.map((e) => e.rser == renTalModels[index].ser ? double.parse(e.total.toString()) : 0).reduce((value, element) => value + element)).toStringAsFixed(0)} %',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 12,
                              // decoration:
                              //     TextDecoration.underline,
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontFamily: FontWeight_.Fonts_T,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Divider(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 8, 8),
                        child: Container(
                          height: 40,
                          // width: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            color: Colors.orange[700],
                          ),
                          padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.map_outlined,
                                color: Colors.white,
                              ),
                              Text(
                                // 'พื้นที่  ',
                                '   ${((areaModels.map((e) => e.ser_ren == renTalModels[index].ser && e.quantity == '1' ? 1 : 0).reduce((value, element) => value + element) * 100) / areaModels.map((e) => e.ser_ren == renTalModels[index].ser ? 1 : 0).reduce((value, element) => value + element)).toStringAsFixed(0)} %',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: FontWeight_.Fonts_T,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 8, 8),
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            // color:
                            //     Colors.red[700],
                          ),
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                if (shoe_detel == 1) {
                                  shoe_detel = 0;
                                  shoe_index = -1;
                                  show_dashFinTran = 0;
                                  ser_ren = '';
                                  show_area = 0;
                                } else {
                                  shoe_detel = 1;
                                  shoe_index = index;
                                  show_dashFinTran = 3;
                                  ser_ren = renTalModels[index].ser;
                                  show_area = 1;
                                }
                              });
                            },
                            icon: Icon(
                              shoe_detel == 1
                                  ? Icons.chevron_left
                                  : Icons.chevron_right,
                            ),
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    // 'พื้นที่  ',
                    'พื้นที่',

                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      shadows: [
                        Shadow(color: Colors.black, offset: Offset(0, -5))
                      ],
                      color: Colors.transparent,
                      // decoration: TextDecoration
                      //     .underline,
                      decorationColor: Colors.grey,
                      decorationThickness: 4,
                      // decorationStyle:
                      //     TextDecorationStyle
                      //         .dashed,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      fontFamily: FontWeight_.Fonts_T,
                    ),
                  ),
                  Container(
                    child: Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: LinearPercentIndicator(
                            // width: MediaQuery.of(context)
                            //         .size
                            //         .width /
                            //     10,
                            animation: true,
                            lineHeight: 14.0,
                            leading: Container(
                              width: ((MediaQuery.of(context).size.width) < 650)
                                  ? 40
                                  : 100,
                              child: const Text(
                                'ทั้งหมด',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 12,
                                  // decoration:
                                  //     TextDecoration.underline,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: FontWeight_.Fonts_T,
                                ),
                              ),
                            ),
                            animationDuration: 3000,
                            percent: (double.parse(areaModels
                                    .map((e) =>
                                        e.ser_ren == renTalModels[index].ser
                                            ? 1
                                            : 0)
                                    .reduce((value, element) => value + element)
                                    .toString()))
                                .clamp(0.0, 1.0),
                            center: Text(
                              '${nFormat2.format(areaModels.map((e) => e.ser_ren == renTalModels[index].ser ? 1 : 0).reduce((value, element) => value + element))} พื้นที่',
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 11.5,
                                // decoration:
                                //     TextDecoration.underline,
                                color: Colors.black,
                                // fontWeight: FontWeight.bold,
                                fontFamily: Font_.Fonts_T,
                              ),
                            ),
                            linearStrokeCap: LinearStrokeCap.roundAll,
                            progressColor: Colors.blue[300],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            '${((areaModels.map((e) => e.ser_ren == renTalModels[index].ser ? 1 : 0).reduce((value, element) => value + element)) * 100) / areaModels.map((e) => e.ser_ren == renTalModels[index].ser ? 1 : 0).reduce((value, element) => value + element)} %',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 12,
                              // decoration:
                              //     TextDecoration.underline,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontFamily: FontWeight_.Fonts_T,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: LinearPercentIndicator(
                            // width: MediaQuery.of(context)
                            //         .size
                            //         .width /
                            //     10,
                            animation: true,
                            lineHeight: 14.0,
                            leading: Container(
                              width: ((MediaQuery.of(context).size.width) < 650)
                                  ? 40
                                  : 100,
                              child: const Text(
                                'ว่าง',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 12,
                                  // decoration:
                                  //     TextDecoration.underline,
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: FontWeight_.Fonts_T,
                                ),
                              ),
                            ),
                            animationDuration: 3000,
                            percent: (double.parse(areaModels
                                        .map((e) => e.ser_ren ==
                                                    renTalModels[index].ser &&
                                                e.quantity == null
                                            ? 1
                                            : 0)
                                        .reduce(
                                            (value, element) => value + element)
                                        .toString()) /
                                    double.parse(areaModels
                                        .map((e) => e.ser_ren ==
                                                    renTalModels[index].ser &&
                                                e.quantity != null
                                            ? 1
                                            : 0)
                                        .reduce(
                                            (value, element) => value + element)
                                        .toString()))
                                .clamp(0.0, 1.0),
                            center: Text(
                              '${nFormat2.format(areaModels.map((e) => e.ser_ren == renTalModels[index].ser && e.quantity == null ? 1 : 0).reduce((value, element) => value + element))} พื้นที่',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 11.5,

                                color: Colors.black,
                                // fontWeight: FontWeight.bold,
                                fontFamily: Font_.Fonts_T,
                              ),
                            ),
                            linearStrokeCap: LinearStrokeCap.roundAll,
                            progressColor: Colors.green[300],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            '${((areaModels.map((e) => e.ser_ren == renTalModels[index].ser && e.quantity == null ? 1 : 0).reduce((value, element) => value + element) * 100) / areaModels.map((e) => e.ser_ren == renTalModels[index].ser ? 1 : 0).reduce((value, element) => value + element)).toStringAsFixed(0)} %',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 12,
                              // decoration:
                              //     TextDecoration.underline,
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                              fontFamily: FontWeight_.Fonts_T,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: LinearPercentIndicator(
                            // width: MediaQuery.of(context)
                            //         .size
                            //         .width /
                            //     10,
                            animation: true,
                            lineHeight: 14.0,
                            leading: Container(
                              width: ((MediaQuery.of(context).size.width) < 650)
                                  ? 40
                                  : 100,
                              child: const Text(
                                'เช่าอยู่',
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 12,
                                  // decoration:
                                  //     TextDecoration.underline,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: FontWeight_.Fonts_T,
                                ),
                              ),
                            ),
                            animationDuration: 3000,
                            percent: (double.parse(areaModels
                                        .map((e) => e.ser_ren ==
                                                    renTalModels[index].ser &&
                                                e.quantity == '1'
                                            ? 1
                                            : 0)
                                        .reduce(
                                            (value, element) => value + element)
                                        .toString()) /
                                    double.parse(areaModels
                                        .map((e) => e.ser_ren ==
                                                    renTalModels[index].ser &&
                                                e.quantity == null
                                            ? 1
                                            : 0)
                                        .reduce(
                                            (value, element) => value + element)
                                        .toString()))
                                .clamp(0.0, 1.0),
                            center: Text(
                              '${nFormat2.format(areaModels.map((e) => e.ser_ren == renTalModels[index].ser && e.quantity == '1' ? 1 : 0).reduce((value, element) => value + element))} พื้นที่',
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 11.5,
                                // decoration:
                                //     TextDecoration.underline,
                                color: Colors.black,
                                // fontWeight: FontWeight.bold,
                                fontFamily: Font_.Fonts_T,
                              ),
                            ),
                            linearStrokeCap: LinearStrokeCap.roundAll,
                            progressColor: Colors.red[300],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            '${((areaModels.map((e) => e.ser_ren == renTalModels[index].ser && e.quantity == '1' ? 1 : 0).reduce((value, element) => value + element) * 100) / areaModels.map((e) => e.ser_ren == renTalModels[index].ser ? 1 : 0).reduce((value, element) => value + element)).toStringAsFixed(0)} %',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 12,
                              // decoration:
                              //     TextDecoration.underline,
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontFamily: FontWeight_.Fonts_T,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: LinearPercentIndicator(
                            // width: MediaQuery.of(context)
                            //         .size
                            //         .width /
                            //     10,
                            animation: true,
                            lineHeight: 14.0,
                            leading: Container(
                              width: ((MediaQuery.of(context).size.width) < 650)
                                  ? 40
                                  : 100,
                              child: const Text(
                                'เสนอราคา',
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 12,
                                  // decoration:
                                  //     TextDecoration.underline,
                                  color: Colors.purple,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: FontWeight_.Fonts_T,
                                ),
                              ),
                            ),
                            animationDuration: 3000,
                            percent: (double.parse(areaModels
                                        .map((e) => e.ser_ren ==
                                                    renTalModels[index].ser &&
                                                e.quantity != '1' &&
                                                e.quantity != null
                                            ? 1
                                            : 0)
                                        .reduce(
                                            (value, element) => value + element)
                                        .toString()) /
                                    double.parse(areaModels
                                        .map((e) => e.ser_ren ==
                                                    renTalModels[index].ser &&
                                                e.quantity == null
                                            ? 1
                                            : 0)
                                        .reduce(
                                            (value, element) => value + element)
                                        .toString()))
                                .clamp(0.0, 1.0),
                            center: Text(
                              '${nFormat2.format(areaModels.map((e) => e.ser_ren == renTalModels[index].ser && e.quantity != '1' && e.quantity != null ? 1 : 0).reduce((value, element) => value + element))} พื้นที่',
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 11.5,
                                // decoration:
                                //     TextDecoration.underline,
                                color: Colors.black,
                                // fontWeight: FontWeight.bold,
                                fontFamily: Font_.Fonts_T,
                              ),
                            ),
                            linearStrokeCap: LinearStrokeCap.roundAll,
                            progressColor: Colors.purple[300],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            '${((areaModels.map((e) => e.ser_ren == renTalModels[index].ser && e.quantity != '1' && e.quantity != null ? 1 : 0).reduce((value, element) => value + element) * 100) / areaModels.map((e) => e.ser_ren == renTalModels[index].ser ? 1 : 0).reduce((value, element) => value + element)).toStringAsFixed(0)} %',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 12,
                              // decoration:
                              //     TextDecoration.underline,
                              color: Colors.purple,
                              fontWeight: FontWeight.bold,
                              fontFamily: FontWeight_.Fonts_T,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: LinearPercentIndicator(
                            // width: MediaQuery.of(context)
                            //         .size
                            //         .width /
                            //     10,
                            animation: true,
                            lineHeight: 14.0,
                            leading: Container(
                              width: ((MediaQuery.of(context).size.width) < 650)
                                  ? 40
                                  : 100,
                              child: const Text(
                                'ใกล้หมดสัญญา',
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 12,
                                  // decoration:
                                  //     TextDecoration.underline,
                                  color: Colors.orange,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: FontWeight_.Fonts_T,
                                ),
                              ),
                            ),
                            animationDuration: 3000,
                            percent: (double.parse(areaModels
                                        .map((e) => e.ser_ren ==
                                                renTalModels[index].ser
                                            ? e.quantity == '1'
                                                ? (daysBetween(DateTime.parse('${e.ldate} 00:00:00').add(Duration(days: -(int.parse(e.set_date.toString())))), now) <
                                                            int.parse(e.set_date
                                                                .toString()) &&
                                                        daysBetween(DateTime.parse('${e.ldate} 00:00:00').add(Duration(days: -(int.parse(e.set_date.toString())))), now) >
                                                            0)
                                                    ? 1
                                                    : 0
                                                : 0
                                            : 0)
                                        .reduce(
                                            (value, element) => value + element)
                                        .toString()) /
                                    double.parse(areaModels
                                        .map((e) => e.ser_ren ==
                                                    renTalModels[index].ser &&
                                                e.quantity == null
                                            ? 1
                                            : 0)
                                        .reduce((value, element) => value + element)
                                        .toString()))
                                .clamp(0.0, 1.0),
                            center: Text(
                              '${nFormat2.format(areaModels.map((e) => e.ser_ren == renTalModels[index].ser ? e.quantity == '1' ? (daysBetween(DateTime.parse('${e.ldate} 00:00:00').add(Duration(days: -(int.parse(e.set_date.toString())))), now) < int.parse(e.set_date.toString()) && daysBetween(DateTime.parse('${e.ldate} 00:00:00').add(Duration(days: -(int.parse(e.set_date.toString())))), now) > 0) ? 1 : 0 : 0 : 0).reduce((value, element) => value + element))} พื้นที่',
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 11.5,
                                // decoration:
                                //     TextDecoration.underline,
                                color: Colors.black,
                                // fontWeight: FontWeight.bold,
                                fontFamily: Font_.Fonts_T,
                              ),
                            ),
                            linearStrokeCap: LinearStrokeCap.roundAll,
                            progressColor: Colors.orange[300],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            '${((areaModels.map((e) => e.ser_ren == renTalModels[index].ser ? e.quantity == '1' ? (daysBetween(DateTime.parse('${e.ldate} 00:00:00').add(Duration(days: -(int.parse(e.set_date.toString())))), now) < int.parse(e.set_date.toString()) && daysBetween(DateTime.parse('${e.ldate} 00:00:00').add(Duration(days: -(int.parse(e.set_date.toString())))), now) > 0) ? 1 : 0 : 0 : 0).reduce((value, element) => value + element) * 100) / areaModels.map((e) => e.ser_ren == renTalModels[index].ser ? 1 : 0).reduce((value, element) => value + element)).toStringAsFixed(0)} %',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 12,
                              // decoration:
                              //     TextDecoration.underline,
                              color: Colors.orange,
                              fontWeight: FontWeight.bold,
                              fontFamily: FontWeight_.Fonts_T,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Text(
                  //   (total2_ == null) ? '0.00' : '${nFormat.format(total2_)}',
                  // ),
                  // const Text(
                  //   'บาท',
                  // ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Divider(),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 8, 8),
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        color: Colors.blue[700],
                      ),
                      child: const Icon(
                        Icons.people,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const Text(
                    'แอดมิน',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      shadows: [
                        Shadow(color: Colors.black, offset: Offset(0, -5))
                      ],
                      color: Colors.transparent,
                      // decoration: TextDecoration
                      //     .underline,
                      decorationColor: Colors.grey,
                      decorationThickness: 4,
                      // decorationStyle:
                      //     TextDecorationStyle
                      //         .dashed,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      fontFamily: FontWeight_.Fonts_T,
                    ),
                  ),

                  Container(
                    child: Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: LinearPercentIndicator(
                            // width: MediaQuery.of(context)
                            //         .size
                            //         .width /
                            //     10,
                            animation: true,
                            lineHeight: 14.0,
                            leading: Container(
                              width: ((MediaQuery.of(context).size.width) < 650)
                                  ? 40
                                  : 100,
                              child: const Text(
                                'ทั้งหมด',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 12,
                                  // decoration:
                                  //     TextDecoration.underline,
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: FontWeight_.Fonts_T,
                                ),
                              ),
                            ),
                            animationDuration: 3000,
                            percent: (double.parse(userModels
                                    .map((e) =>
                                        e.rser == renTalModels[index].ser
                                            ? 1
                                            : 0)
                                    .reduce((value, element) => value + element)
                                    .toString()))
                                .clamp(0.0, 1.0),
                            center: Text(
                              '${nFormat2.format(userModels.map((e) => e.rser == renTalModels[index].ser ? 1 : 0).reduce((value, element) => value + element))} คน',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 11.5,

                                color: Colors.black,
                                // fontWeight: FontWeight.bold,
                                fontFamily: Font_.Fonts_T,
                              ),
                            ),
                            linearStrokeCap: LinearStrokeCap.roundAll,
                            progressColor: Colors.green[300],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            '${((userModels.map((e) => e.rser == renTalModels[index].ser ? 1 : 0).reduce((value, element) => value + element) * 100) / userModels.map((e) => e.rser == renTalModels[index].ser ? 1 : 0).reduce((value, element) => value + element)).toStringAsFixed(0)} %',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 12,
                              // decoration:
                              //     TextDecoration.underline,
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                              fontFamily: FontWeight_.Fonts_T,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: LinearPercentIndicator(
                            // width: MediaQuery.of(context)
                            //         .size
                            //         .width /
                            //     10,
                            animation: true,
                            lineHeight: 14.0,
                            leading: Container(
                              width: ((MediaQuery.of(context).size.width) < 650)
                                  ? 40
                                  : 100,
                              child: const Text(
                                'ใช้งานวันนี้',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 12,
                                  // decoration:
                                  //     TextDecoration.underline,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: FontWeight_.Fonts_T,
                                ),
                              ),
                            ),
                            animationDuration: 3000,
                            percent: (double.parse(userModels
                                    .map((e) =>
                                        e.rser == renTalModels[index].ser
                                            ? DateFormat('yyyy-MM-dd')
                                                        .format(now)
                                                        .toString() ==
                                                    DateFormat('yyyy-MM-dd')
                                                        .format(DateTime.parse(
                                                            '${e.connected}'))
                                                        .toString()
                                                ? 1
                                                : 0
                                            : 0)
                                    .reduce((value, element) => value + element)
                                    .toString()))
                                .clamp(0.0, 1.0),
                            center: Text(
                              '${nFormat2.format(userModels.map((e) => e.rser == renTalModels[index].ser ? DateFormat('yyyy-MM-dd').format(now).toString() == DateFormat('yyyy-MM-dd').format(DateTime.parse('${e.connected}')).toString() ? 1 : 0 : 0).reduce((value, element) => value + element))} คน',

                              // '${nFormat2.format(2)} คน',
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 11.5,
                                // decoration:
                                //     TextDecoration.underline,
                                color: Colors.black,
                                // fontWeight: FontWeight.bold,
                                fontFamily: Font_.Fonts_T,
                              ),
                            ),
                            linearStrokeCap: LinearStrokeCap.roundAll,
                            progressColor: Colors.red[300],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            '${((userModels.map((e) => e.rser == renTalModels[index].ser ? DateFormat('yyyy-MM-dd').format(now).toString() == DateFormat('yyyy-MM-dd').format(DateTime.parse('${e.connected}')).toString() ? 1 : 0 : 0).reduce((value, element) => value + element) * 100) / userModels.map((e) => e.rser == renTalModels[index].ser ? 1 : 0).reduce((value, element) => value + element)).toStringAsFixed(0)} %',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 12,
                              // decoration:
                              //     TextDecoration.underline,
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontFamily: FontWeight_.Fonts_T,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (shoe_detel == 1)
              if (shoe_index == index)
                Expanded(
                  flex: 6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 8, 8),
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                // color:
                                //     Colors.red[700],
                              ),
                              child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    if (shoe_detel == 1) {
                                      shoe_detel = 0;
                                      shoe_index = -1;
                                      show_dashFinTran = 0;
                                    } else {
                                      shoe_detel = 1;
                                      shoe_index = index;
                                      show_dashFinTran = 1;
                                    }
                                  });
                                },
                                icon: Icon(
                                  Icons.arrow_back_ios,
                                ),
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Text(
                            '${renTalModels[index].pn}',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              shadows: [
                                Shadow(
                                    color: Colors.black, offset: Offset(0, -5))
                              ],
                              color: Colors.transparent,
                              // decoration: TextDecoration
                              //     .underline,
                              decorationColor: Colors.grey,
                              decorationThickness: 4,
                              // decorationStyle:
                              //     TextDecorationStyle
                              //         .dashed,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: FontWeight_.Fonts_T,
                            ),
                          ),
                        ],
                      ),
                      show_dashFinTran == 1
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                    padding: const EdgeInsets.all(24.0),
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.grey.shade200,
                                      // color: Color(0xFFA8BFDB),
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 8, 8),
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Container(
                                                      height: 40,
                                                      width: 40,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(7),
                                                        color: Colors.blue[700],
                                                      ),
                                                      child: const Icon(
                                                        Icons.attach_money,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                      'รวมยอด',
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        // fontSize:
                                                        //     12,
                                                        // decoration:
                                                        //     TextDecoration.underline,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily:
                                                            FontWeight_.Fonts_T,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Row(
                                                  children: [
                                                    Container(
                                                      height: 40,
                                                      width: 40,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(7),
                                                        color: Colors.red[700],
                                                      ),
                                                      child: const Icon(
                                                        Icons
                                                            .account_balance_wallet,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                      'ยอดค้างชำระ',
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        // fontSize:
                                                        //     12,
                                                        // decoration:
                                                        //     TextDecoration.underline,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily:
                                                            FontWeight_.Fonts_T,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(0, 0, 8, 8),
                                                    child: Text(
                                                      '${nFormat.format(((dashboardfinancModels.isEmpty ? 0 : dashboardfinancModels.map((e) => e.rser == renTalModels[index].ser ? double.parse(e.total.toString()) : 0).reduce((value, element) => value + element)) + (dashboardTransModels.isEmpty ? 0 : dashboardTransModels.map((e) => e.rser == renTalModels[index].ser ? double.parse(e.total.toString()) : 0).reduce((value, element) => value + element))))} บาท',
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      textAlign: TextAlign.end,
                                                      style: const TextStyle(
                                                        // decoration:
                                                        //     TextDecoration.underline,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily:
                                                            FontWeight_.Fonts_T,
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
                                                    padding: const EdgeInsets
                                                        .fromLTRB(0, 0, 8, 8),
                                                    child: Text(
                                                      (dashboardTransModels
                                                              .isEmpty)
                                                          ? '0.00 บาท'
                                                          : '${nFormat.format(dashboardTransModels.map((e) => e.rser == renTalModels[index].ser ? double.parse(e.total.toString()) : 0).reduce((value, element) => value + element))} บาท',
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      textAlign: TextAlign.end,
                                                      style: const TextStyle(
                                                        // decoration:
                                                        //     TextDecoration.underline,
                                                        color: Colors.black,
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
                                      ],
                                    )),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                    padding: const EdgeInsets.all(24.0),
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    // height: MediaQuery.of(
                                    //             context)
                                    //         .size
                                    //         .width *
                                    //     0.4 /
                                    //     3,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.grey.shade200,
                                      // color: Color(0xFFA8BFDB),
                                    ),
                                    child: Column(
                                      children: [
                                        Container(
                                          child: Row(
                                            children: [
                                              Expanded(
                                                flex: 4,
                                                child: LinearPercentIndicator(
                                                  // width: MediaQuery.of(context)
                                                  //         .size
                                                  //         .width /
                                                  //     10,
                                                  animation: true,
                                                  lineHeight: 25,
                                                  leading: Container(
                                                    width:
                                                        ((MediaQuery.of(context)
                                                                    .size
                                                                    .width) <
                                                                650)
                                                            ? 40
                                                            : 100,
                                                    // height: 30,
                                                    child: const Text(
                                                      'รายรับ',
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        // decoration:
                                                        //     TextDecoration.underline,
                                                        color: Colors.green,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily:
                                                            FontWeight_.Fonts_T,
                                                      ),
                                                    ),
                                                  ),
                                                  animationDuration: 3000,
                                                  percent: (dashboardfinancModels
                                                          .isEmpty)
                                                      ? (0.00).clamp(0.0, 1.0)
                                                      : (double.parse(dashboardfinancModels
                                                              .map((e) => e
                                                                          .rser ==
                                                                      renTalModels[index]
                                                                          .ser
                                                                  ? double.parse(e
                                                                      .total
                                                                      .toString())
                                                                  : 0)
                                                              .reduce((value,
                                                                      element) =>
                                                                  value +
                                                                  element)
                                                              .toString()))
                                                          .clamp(0.0, 1.0),
                                                  center: Text(
                                                    (dashboardfinancModels
                                                            .isEmpty)
                                                        ? '0.00 บาท'
                                                        : '${nFormat.format(dashboardfinancModels.map((e) => e.rser == renTalModels[index].ser ? double.parse(e.total.toString()) : 0).reduce((value, element) => value + element))} บาท',
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                      fontSize: 11.5,

                                                      color: Colors.black,
                                                      // fontWeight: FontWeight.bold,
                                                      fontFamily: Font_.Fonts_T,
                                                    ),
                                                  ),
                                                  linearStrokeCap:
                                                      LinearStrokeCap.roundAll,
                                                  progressColor:
                                                      Colors.green[300],
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Text(
                                                  '${(((dashboardfinancModels.isEmpty ? 0 : dashboardfinancModels.map((e) => e.rser == renTalModels[index].ser ? double.parse(e.total.toString()) : 0).reduce((value, element) => value + element)) * 100) / ((dashboardfinancModels.isEmpty ? 0 : dashboardfinancModels.map((e) => e.rser == renTalModels[index].ser ? double.parse(e.total.toString()) : 0).reduce((value, element) => value + element)) + (dashboardTransModels.isEmpty ? 0 : dashboardTransModels.map((e) => e.rser == renTalModels[index].ser ? double.parse(e.total.toString()) : 0).reduce((value, element) => value + element)))).toStringAsFixed(0)} %',
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    // decoration:
                                                    //     TextDecoration.underline,
                                                    color: Colors.green,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                          child: Row(
                                            children: [
                                              Expanded(
                                                flex: 4,
                                                child: LinearPercentIndicator(
                                                  // width: MediaQuery.of(context)
                                                  //         .size
                                                  //         .width /
                                                  //     10,
                                                  animation: true,
                                                  lineHeight: 25,
                                                  leading: Container(
                                                    width:
                                                        ((MediaQuery.of(context)
                                                                    .size
                                                                    .width) <
                                                                650)
                                                            ? 40
                                                            : 100,
                                                    // height: 50,
                                                    child: const Text(
                                                      'ค้างชำระ',
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        // decoration:
                                                        //     TextDecoration.underline,
                                                        color: Colors.red,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily:
                                                            FontWeight_.Fonts_T,
                                                      ),
                                                    ),
                                                  ),
                                                  animationDuration: 3000,
                                                  // percent: (total1_ / total2_)
                                                  //     .clamp(0.0, 1.0),
                                                  percent: (dashboardTransModels
                                                          .isEmpty)
                                                      ? (0.00).clamp(0.0, 1.0)
                                                      : ((double.parse(dashboardTransModels
                                                                  .map((e) => e.rser == renTalModels[index].ser
                                                                      ? double.parse(e.total
                                                                          .toString())
                                                                      : 0)
                                                                  .reduce((value, element) =>
                                                                      value +
                                                                      element)
                                                                  .toString())) /
                                                              (dashboardfinancModels.isEmpty
                                                                  ? 0
                                                                  : (double.parse(dashboardfinancModels.map((e) => e.rser == renTalModels[index].ser ? double.parse(e.total.toString()) : 0).reduce((value, element) => value + element).toString()))))
                                                          .clamp(0.0, 1.0),
                                                  center: Text(
                                                    (dashboardTransModels
                                                            .isEmpty)
                                                        ? '0.00 บาท'
                                                        : '${nFormat.format(dashboardTransModels.map((e) => e.rser == renTalModels[index].ser ? double.parse(e.total.toString()) : 0).reduce((value, element) => value + element))} บาท',
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                      fontSize: 11.5,
                                                      // decoration:
                                                      //     TextDecoration.underline,
                                                      color: Colors.black,
                                                      // fontWeight: FontWeight.bold,
                                                      fontFamily: Font_.Fonts_T,
                                                    ),
                                                  ),
                                                  linearStrokeCap:
                                                      LinearStrokeCap.roundAll,
                                                  progressColor:
                                                      Colors.red[300],
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Text(
                                                  (dashboardTransModels.isEmpty)
                                                      ? '0 %'
                                                      : '${(((dashboardTransModels.isEmpty ? 0 : dashboardTransModels.map((e) => e.rser == renTalModels[index].ser ? double.parse(e.total.toString()) : 0).reduce((value, element) => value + element)) * 100) / ((dashboardfinancModels.isEmpty ? 0 : dashboardfinancModels.map((e) => e.rser == renTalModels[index].ser ? double.parse(e.total.toString()) : 0).reduce((value, element) => value + element)) + (dashboardTransModels.isEmpty ? 0 : dashboardTransModels.map((e) => e.rser == renTalModels[index].ser ? double.parse(e.total.toString()) : 0).reduce((value, element) => value + element)))).toStringAsFixed(0)} %',
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    // decoration:
                                                    //     TextDecoration.underline,
                                                    color: Colors.red,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Divider(),
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                'ประเภท',
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  // decoration:
                                                  //     TextDecoration.underline,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                'ก่อน VAT',
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.end,
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  // decoration:
                                                  //     TextDecoration.underline,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                'VAT',
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.end,
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  // decoration:
                                                  //     TextDecoration.underline,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                'หัก ณ ที่จ่าย',
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.end,
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  // decoration:
                                                  //     TextDecoration.underline,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                'ยอดรวม',
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.end,
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  // decoration:
                                                  //     TextDecoration.underline,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Divider(),
                                        for (int indexfin = 0;
                                            indexfin <
                                                dashboardTransModels.length;
                                            indexfin++)
                                          if (dashboardTransModels[indexfin]
                                                  .rser ==
                                              ser_ren)
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    '${dashboardTransModels[indexfin].expname}',
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      // decoration:
                                                      //     TextDecoration.underline,
                                                      color: Colors.black,

                                                      fontFamily: Font_.Fonts_T,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    '${nFormat.format(double.parse(dashboardTransModels[indexfin].pvat.toString()))}',
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    textAlign: TextAlign.end,
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      // decoration:
                                                      //     TextDecoration.underline,
                                                      color: Colors.black,
                                                      fontFamily: Font_.Fonts_T,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    '${nFormat.format(double.parse(dashboardTransModels[indexfin].vat.toString()))}',
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    textAlign: TextAlign.end,
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      // decoration:
                                                      //     TextDecoration.underline,
                                                      color: Colors.black,
                                                      fontFamily: Font_.Fonts_T,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    '${nFormat.format(double.parse(dashboardTransModels[indexfin].wht.toString()))}',
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    textAlign: TextAlign.end,
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      // decoration:
                                                      //     TextDecoration.underline,
                                                      color: Colors.black,
                                                      fontFamily: Font_.Fonts_T,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    '${nFormat.format(double.parse(dashboardTransModels[indexfin].total.toString()))}',
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    textAlign: TextAlign.end,
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      // decoration:
                                                      //     TextDecoration.underline,
                                                      color: Colors.black,
                                                      fontFamily: Font_.Fonts_T,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                      ],
                                    )),
                              ],
                            )
                          : show_dashFinTran == 2
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                        padding: const EdgeInsets.all(24.0),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.4,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.grey.shade200,
                                          // color: Color(0xFFA8BFDB),
                                        ),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 0, 8, 8),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      height: 40,
                                                      width: 40,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(7),
                                                        color: Colors.teal[700],
                                                      ),
                                                      child: const Icon(
                                                        Icons
                                                            .monetization_on_rounded,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                      'รวมรายรับ',
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        // fontSize:
                                                        //     12,
                                                        // decoration:
                                                        //     TextDecoration.underline,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily:
                                                            FontWeight_.Fonts_T,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(0, 0, 8, 8),
                                                    child: Text(
                                                      (dashboardfinancModels
                                                              .isEmpty)
                                                          ? '0.00 บาท'
                                                          : '${nFormat.format(dashboardfinancModels.map((e) => e.rser == renTalModels[index].ser ? double.parse(e.total.toString()) : 0).reduce((value, element) => value + element))} บาท',
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      textAlign: TextAlign.end,
                                                      style: const TextStyle(
                                                        // decoration:
                                                        //     TextDecoration.underline,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily:
                                                            FontWeight_.Fonts_T,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        )),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                        padding: const EdgeInsets.all(24.0),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.4,
                                        // height: MediaQuery.of(
                                        //             context)
                                        //         .size
                                        //         .width *
                                        //     0.4 /
                                        //     3,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.grey.shade200,
                                          // color: Color(0xFFA8BFDB),
                                        ),
                                        child: Column(
                                          children: [
                                            Container(
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    flex: 4,
                                                    child:
                                                        LinearPercentIndicator(
                                                      // width: MediaQuery.of(context)
                                                      //         .size
                                                      //         .width /
                                                      //     10,
                                                      animation: true,
                                                      lineHeight: 25,
                                                      leading: Container(
                                                        width: ((MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width) <
                                                                650)
                                                            ? 40
                                                            : 100,
                                                        child: const Text(
                                                          'ทั้งหมด',
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            // decoration:
                                                            //     TextDecoration.underline,
                                                            color: Colors.blue,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontFamily:
                                                                FontWeight_
                                                                    .Fonts_T,
                                                          ),
                                                        ),
                                                      ),
                                                      animationDuration: 3000,
                                                      percent: (dashboardfinancModels
                                                              .isEmpty)
                                                          ? (0.00)
                                                              .clamp(0.0, 1.0)
                                                          : (double.parse(dashboardfinancModels
                                                                  .map((e) => e.rser ==
                                                                          renTalModels[index]
                                                                              .ser
                                                                      ? double.parse(e
                                                                          .total
                                                                          .toString())
                                                                      : 0)
                                                                  .reduce((value,
                                                                          element) =>
                                                                      value + element)
                                                                  .toString()))
                                                              .clamp(0.0, 1.0),
                                                      center: Text(
                                                        (dashboardfinancModels
                                                                .isEmpty)
                                                            ? '0.00 บาท'
                                                            : '${nFormat.format(dashboardfinancModels.map((e) => e.rser == renTalModels[index].ser ? double.parse(e.total.toString()) : 0).reduce((value, element) => value + element))} บาท',
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: const TextStyle(
                                                          fontSize: 11.5,
                                                          // decoration:
                                                          //     TextDecoration.underline,
                                                          color: Colors.black,
                                                          // fontWeight: FontWeight.bold,
                                                          fontFamily:
                                                              Font_.Fonts_T,
                                                        ),
                                                      ),
                                                      linearStrokeCap:
                                                          LinearStrokeCap
                                                              .roundAll,
                                                      progressColor:
                                                          Colors.blue[300],
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Text(
                                                      '${(((dashboardfinancModels.isEmpty ? 0 : dashboardfinancModels.map((e) => e.rser == renTalModels[index].ser ? double.parse(e.total.toString()) : 0).reduce((value, element) => value + element)) * 100) / ((dashboardfinancModels.isEmpty ? 0 : dashboardfinancModels.map((e) => e.rser == renTalModels[index].ser ? double.parse(e.total.toString()) : 0).reduce((value, element) => value + element)) + (dashboardTransModels.isEmpty ? 0 : dashboardTransModels.map((e) => e.rser == renTalModels[index].ser ? double.parse(e.total.toString()) : 0).reduce((value, element) => value + element)))).toStringAsFixed(0)} %',

                                                      // (dashboardfinancModels.isEmpty) ? '0 %' : '${((dashboardfinancModels.map((e) => e.rser == renTalModels[index].ser ? double.parse(e.total.toString()) : 0).reduce((value, element) => value + element) * 100) / dashboardfinancModels.map((e) => e.rser == renTalModels[index].ser ? double.parse(e.total.toString()) : 0).reduce((value, element) => value + element)).toStringAsFixed(0)} %',
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        // decoration:
                                                        //     TextDecoration.underline,
                                                        color: Colors.blue,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily:
                                                            FontWeight_.Fonts_T,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    flex: 4,
                                                    child:
                                                        LinearPercentIndicator(
                                                      // width: MediaQuery.of(context)
                                                      //         .size
                                                      //         .width /
                                                      //     10,
                                                      animation: true,
                                                      lineHeight: 25,
                                                      leading: Container(
                                                        width: ((MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width) <
                                                                650)
                                                            ? 40
                                                            : 100,
                                                        child: const Text(
                                                          'Cash',
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            // decoration:
                                                            //     TextDecoration.underline,
                                                            color: Colors.green,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontFamily:
                                                                FontWeight_
                                                                    .Fonts_T,
                                                          ),
                                                        ),
                                                      ),
                                                      animationDuration: 3000,
                                                      percent: (dashboardfinancModels
                                                              .isEmpty)
                                                          ? (0.00)
                                                              .clamp(0.0, 1.0)
                                                          : ((double.parse(dashboardfinancModels.map((e) => e.rser == renTalModels[index].ser && e.type == 'CASH' ? double.parse(e.total.toString()) : 0).reduce((value, element) => value + element).toString())) /
                                                                  (double.parse(dashboardfinancModels
                                                                      .map((e) => e.rser == renTalModels[index].ser
                                                                          ? double.parse(e
                                                                              .total
                                                                              .toString())
                                                                          : 0)
                                                                      .reduce((value, element) =>
                                                                          value + element)
                                                                      .toString())))
                                                              .clamp(0.0, 1.0),
                                                      center: Text(
                                                        (dashboardfinancModels
                                                                .isEmpty)
                                                            ? '0.00 บาท'
                                                            : '${nFormat.format(dashboardfinancModels.map((e) => e.rser == renTalModels[index].ser && e.type == 'CASH' ? double.parse(e.total.toString()) : 0).reduce((value, element) => value + element))} บาท',
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: const TextStyle(
                                                          fontSize: 11.5,

                                                          color: Colors.black,
                                                          // fontWeight: FontWeight.bold,
                                                          fontFamily:
                                                              Font_.Fonts_T,
                                                        ),
                                                      ),
                                                      linearStrokeCap:
                                                          LinearStrokeCap
                                                              .roundAll,
                                                      progressColor:
                                                          Colors.green[300],
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Text(
                                                      (dashboardfinancModels
                                                              .isEmpty)
                                                          ? '0 %'
                                                          : '${((dashboardfinancModels.map((e) => e.rser == renTalModels[index].ser && e.type == 'CASH' ? double.parse(e.total.toString()) : 0).reduce((value, element) => value + element) * 100) / dashboardfinancModels.map((e) => e.rser == renTalModels[index].ser ? double.parse(e.total.toString()) : 0).reduce((value, element) => value + element)).toStringAsFixed(0)} %',
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        // decoration:
                                                        //     TextDecoration.underline,
                                                        color: Colors.green,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily:
                                                            FontWeight_.Fonts_T,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    flex: 4,
                                                    child:
                                                        LinearPercentIndicator(
                                                      // width: MediaQuery.of(context)
                                                      //         .size
                                                      //         .width /
                                                      //     10,
                                                      animation: true,
                                                      lineHeight: 25,
                                                      leading: Container(
                                                        width: ((MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width) <
                                                                650)
                                                            ? 40
                                                            : 100,
                                                        child: const Text(
                                                          'Bank',
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            // decoration:
                                                            //     TextDecoration.underline,
                                                            color: Colors.red,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontFamily:
                                                                FontWeight_
                                                                    .Fonts_T,
                                                          ),
                                                        ),
                                                      ),
                                                      percent: (dashboardfinancModels
                                                              .isEmpty)
                                                          ? (0.00)
                                                              .clamp(0.0, 1.0)
                                                          : ((double.parse(dashboardfinancModels.map((e) => e.rser == renTalModels[index].ser && e.type != 'CASH' && e.type != 'DISCOUNT' ? double.parse(e.total.toString()) : 0).reduce((value, element) => value + element).toString())) /
                                                                  (double.parse(dashboardfinancModels
                                                                      .map((e) => e.rser == renTalModels[index].ser
                                                                          ? double.parse(e.total
                                                                              .toString())
                                                                          : 0)
                                                                      .reduce((value,
                                                                              element) =>
                                                                          value + element)
                                                                      .toString())))
                                                              .clamp(0.0, 1.0),
                                                      center: Text(
                                                        (dashboardfinancModels
                                                                .isEmpty)
                                                            ? '0.00 บาท'
                                                            : '${nFormat.format(dashboardfinancModels.map((e) => e.rser == renTalModels[index].ser && e.type != 'CASH' && e.type != 'DISCOUNT' ? double.parse(e.total.toString()) : 0).reduce((value, element) => value + element))} บาท',
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: const TextStyle(
                                                          fontSize: 11.5,
                                                          // decoration:
                                                          //     TextDecoration.underline,
                                                          color: Colors.black,
                                                          // fontWeight: FontWeight.bold,
                                                          fontFamily:
                                                              Font_.Fonts_T,
                                                        ),
                                                      ),
                                                      linearStrokeCap:
                                                          LinearStrokeCap
                                                              .roundAll,
                                                      progressColor:
                                                          Colors.red[300],
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Text(
                                                      (dashboardfinancModels
                                                              .isEmpty)
                                                          ? '0 %'
                                                          : '${((dashboardfinancModels.map((e) => e.rser == renTalModels[index].ser && e.type != 'CASH' && e.type != 'DISCOUNT' ? double.parse(e.total.toString()) : 0).reduce((value, element) => value + element) * 100) / dashboardfinancModels.map((e) => e.rser == renTalModels[index].ser ? double.parse(e.total.toString()) : 0).reduce((value, element) => value + element)).toStringAsFixed(0)} %',
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        // decoration:
                                                        //     TextDecoration.underline,
                                                        color: Colors.red,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily:
                                                            FontWeight_.Fonts_T,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Divider(),
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    '',
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    textAlign: TextAlign.end,
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      // decoration:
                                                      //     TextDecoration.underline,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily:
                                                          FontWeight_.Fonts_T,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    'ประเภท',
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      // decoration:
                                                      //     TextDecoration.underline,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily:
                                                          FontWeight_.Fonts_T,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    'รายการ',
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      // decoration:
                                                      //     TextDecoration.underline,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily:
                                                          FontWeight_.Fonts_T,
                                                    ),
                                                  ),
                                                ),
                                                // Expanded(
                                                //   child: Text(
                                                //     'ธนาคาร',
                                                //     maxLines: 2,
                                                //     overflow: TextOverflow.ellipsis,
                                                //     textAlign: TextAlign.end,
                                                //     style: TextStyle(
                                                //       fontSize: 12,
                                                //       // decoration:
                                                //       //     TextDecoration.underline,
                                                //       color: Colors.black,
                                                //       fontWeight: FontWeight.bold,
                                                //       fontFamily: FontWeight_.Fonts_T,
                                                //     ),
                                                //   ),
                                                // ),
                                                Expanded(
                                                  child: Text(
                                                    'เลขที่บัญชี',
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    textAlign: TextAlign.end,
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      // decoration:
                                                      //     TextDecoration.underline,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily:
                                                          FontWeight_.Fonts_T,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    'ยอดรวม',
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    textAlign: TextAlign.end,
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      // decoration:
                                                      //     TextDecoration.underline,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily:
                                                          FontWeight_.Fonts_T,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Divider(),
                                            for (int indexfin = 0;
                                                indexfin <
                                                    dashboardfinancModels
                                                        .length;
                                                indexfin++)
                                              if (dashboardfinancModels[
                                                          indexfin]
                                                      .rser ==
                                                  ser_ren)
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        '${dashboardfinancModels[indexfin].type}',
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          // decoration:
                                                          //     TextDecoration.underline,
                                                          color: Colors.black,

                                                          fontFamily:
                                                              Font_.Fonts_T,
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        dashboardfinancModels[
                                                                        indexfin]
                                                                    .ptname ==
                                                                null
                                                            ? 'ส่วนลด'
                                                            : '${dashboardfinancModels[indexfin].ptname}',
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          // decoration:
                                                          //     TextDecoration.underline,
                                                          color: Colors.black,

                                                          fontFamily:
                                                              Font_.Fonts_T,
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        '${dashboardfinancModels[indexfin].bills}',
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          // decoration:
                                                          //     TextDecoration.underline,
                                                          color: Colors.black,
                                                          fontFamily:
                                                              Font_.Fonts_T,
                                                        ),
                                                      ),
                                                    ),
                                                    // Expanded(
                                                    //   child: Text(
                                                    //     '${dashboardfinancModels[indexfin].bank}',
                                                    //     maxLines: 2,
                                                    //     overflow: TextOverflow.ellipsis,
                                                    //     textAlign: TextAlign.end,
                                                    //     style: TextStyle(
                                                    //       fontSize: 12,
                                                    //       // decoration:
                                                    //       //     TextDecoration.underline,
                                                    //       color: Colors.black,
                                                    //       fontFamily: Font_.Fonts_T,
                                                    //     ),
                                                    //   ),
                                                    // ),
                                                    Expanded(
                                                      child: Text(
                                                        '${dashboardfinancModels[indexfin].bno}',
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        textAlign:
                                                            TextAlign.end,
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          // decoration:
                                                          //     TextDecoration.underline,
                                                          color: Colors.black,
                                                          fontFamily:
                                                              Font_.Fonts_T,
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        '${nFormat.format(double.parse(dashboardfinancModels[indexfin].total.toString()))}',
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        textAlign:
                                                            TextAlign.end,
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          // decoration:
                                                          //     TextDecoration.underline,
                                                          color: Colors.black,
                                                          fontFamily:
                                                              Font_.Fonts_T,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                          ],
                                        )),
                                  ],
                                )
                              : show_dashFinTran == 3
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                            padding: const EdgeInsets.all(24.0),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.4,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Colors.grey.shade200,
                                              // color: Color(0xFFA8BFDB),
                                            ),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(0, 0, 8, 8),
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          height: 40,
                                                          width: 40,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        7),
                                                            color: Colors
                                                                .orange[700],
                                                          ),
                                                          child: const Icon(
                                                            Icons.map_outlined,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Text(
                                                          'พื้นที่',
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                            // fontSize:
                                                            //     12,
                                                            // decoration:
                                                            //     TextDecoration.underline,
                                                            color: Colors.black,
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
                                                Expanded(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                0, 0, 8, 8),
                                                        child: Text(
                                                          '${nFormat2.format(areaModels.map((e) => e.ser_ren == renTalModels[index].ser ? 1 : 0).reduce((value, element) => value + element))}',
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          textAlign:
                                                              TextAlign.end,
                                                          style:
                                                              const TextStyle(
                                                            // decoration:
                                                            //     TextDecoration.underline,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontFamily:
                                                                FontWeight_
                                                                    .Fonts_T,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            )),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                            padding: const EdgeInsets.all(24.0),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.4,
                                            // height: MediaQuery.of(
                                            //             context)
                                            //         .size
                                            //         .width *
                                            //     0.4 /
                                            //     3,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Colors.grey.shade200,
                                              // color: Color(0xFFA8BFDB),
                                            ),
                                            child: Column(
                                              children: [
                                                Container(
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        flex: 4,
                                                        child:
                                                            LinearPercentIndicator(
                                                          // width: MediaQuery.of(context)
                                                          //         .size
                                                          //         .width /
                                                          //     10,
                                                          animation: true,
                                                          lineHeight: 14.0,
                                                          leading: Container(
                                                            width: ((MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width) <
                                                                    650)
                                                                ? 40
                                                                : 100,
                                                            child: const Text(
                                                              'ทั้งหมด',
                                                              maxLines: 2,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: TextStyle(
                                                                fontSize: 12,
                                                                // decoration:
                                                                //     TextDecoration.underline,
                                                                color:
                                                                    Colors.blue,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily:
                                                                    FontWeight_
                                                                        .Fonts_T,
                                                              ),
                                                            ),
                                                          ),
                                                          animationDuration:
                                                              3000,
                                                          percent: (double.parse(areaModels
                                                                  .map((e) => e
                                                                              .ser_ren ==
                                                                          renTalModels[index]
                                                                              .ser
                                                                      ? 1
                                                                      : 0)
                                                                  .reduce((value,
                                                                          element) =>
                                                                      value +
                                                                      element)
                                                                  .toString()))
                                                              .clamp(0.0, 1.0),
                                                          center: Text(
                                                            '${nFormat2.format(areaModels.map((e) => e.ser_ren == renTalModels[index].ser ? 1 : 0).reduce((value, element) => value + element))} พื้นที่',
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 11.5,
                                                              // decoration:
                                                              //     TextDecoration.underline,
                                                              color:
                                                                  Colors.black,
                                                              // fontWeight: FontWeight.bold,
                                                              fontFamily:
                                                                  Font_.Fonts_T,
                                                            ),
                                                          ),
                                                          linearStrokeCap:
                                                              LinearStrokeCap
                                                                  .roundAll,
                                                          progressColor:
                                                              Colors.blue[300],
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Text(
                                                          '${((areaModels.map((e) => e.ser_ren == renTalModels[index].ser ? 1 : 0).reduce((value, element) => value + element)) * 100) / areaModels.map((e) => e.ser_ren == renTalModels[index].ser ? 1 : 0).reduce((value, element) => value + element)} %',
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            // decoration:
                                                            //     TextDecoration.underline,
                                                            color: Colors.blue,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontFamily:
                                                                FontWeight_
                                                                    .Fonts_T,
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        flex: 4,
                                                        child:
                                                            LinearPercentIndicator(
                                                          // width: MediaQuery.of(context)
                                                          //         .size
                                                          //         .width /
                                                          //     10,
                                                          animation: true,
                                                          lineHeight: 14.0,
                                                          leading: Container(
                                                            width: ((MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width) <
                                                                    650)
                                                                ? 40
                                                                : 100,
                                                            child: const Text(
                                                              'ว่าง',
                                                              maxLines: 2,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: TextStyle(
                                                                fontSize: 12,
                                                                // decoration:
                                                                //     TextDecoration.underline,
                                                                color: Colors
                                                                    .green,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily:
                                                                    FontWeight_
                                                                        .Fonts_T,
                                                              ),
                                                            ),
                                                          ),
                                                          animationDuration:
                                                              3000,
                                                          percent: (double.parse(areaModels
                                                                      .map((e) =>
                                                                          e.ser_ren == renTalModels[index].ser && e.quantity == null
                                                                              ? 1
                                                                              : 0)
                                                                      .reduce((value, element) =>
                                                                          value +
                                                                          element)
                                                                      .toString()) /
                                                                  double.parse(areaModels
                                                                      .map((e) =>
                                                                          e.ser_ren == renTalModels[index].ser && e.quantity != null ? 1 : 0)
                                                                      .reduce((value, element) => value + element)
                                                                      .toString()))
                                                              .clamp(0.0, 1.0),
                                                          center: Text(
                                                            '${nFormat2.format(areaModels.map((e) => e.ser_ren == renTalModels[index].ser && e.quantity == null ? 1 : 0).reduce((value, element) => value + element))} พื้นที่',
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 11.5,

                                                              color:
                                                                  Colors.black,
                                                              // fontWeight: FontWeight.bold,
                                                              fontFamily:
                                                                  Font_.Fonts_T,
                                                            ),
                                                          ),
                                                          linearStrokeCap:
                                                              LinearStrokeCap
                                                                  .roundAll,
                                                          progressColor:
                                                              Colors.green[300],
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Text(
                                                          '${((areaModels.map((e) => e.ser_ren == renTalModels[index].ser && e.quantity == null ? 1 : 0).reduce((value, element) => value + element) * 100) / areaModels.map((e) => e.ser_ren == renTalModels[index].ser ? 1 : 0).reduce((value, element) => value + element)).toStringAsFixed(0)} %',
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            // decoration:
                                                            //     TextDecoration.underline,
                                                            color: Colors.green,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontFamily:
                                                                FontWeight_
                                                                    .Fonts_T,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        flex: 4,
                                                        child:
                                                            LinearPercentIndicator(
                                                          // width: MediaQuery.of(context)
                                                          //         .size
                                                          //         .width /
                                                          //     10,
                                                          animation: true,
                                                          lineHeight: 14.0,
                                                          leading: Container(
                                                            width: ((MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width) <
                                                                    650)
                                                                ? 40
                                                                : 100,
                                                            child: const Text(
                                                              'เช่าอยู่',
                                                              maxLines: 3,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: TextStyle(
                                                                fontSize: 12,
                                                                // decoration:
                                                                //     TextDecoration.underline,
                                                                color:
                                                                    Colors.red,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily:
                                                                    FontWeight_
                                                                        .Fonts_T,
                                                              ),
                                                            ),
                                                          ),
                                                          animationDuration:
                                                              3000,
                                                          percent: (double.parse(areaModels
                                                                      .map((e) =>
                                                                          e.ser_ren == renTalModels[index].ser && e.quantity == '1'
                                                                              ? 1
                                                                              : 0)
                                                                      .reduce((value, element) =>
                                                                          value +
                                                                          element)
                                                                      .toString()) /
                                                                  double.parse(areaModels
                                                                      .map((e) =>
                                                                          e.ser_ren == renTalModels[index].ser && e.quantity == null ? 1 : 0)
                                                                      .reduce((value, element) => value + element)
                                                                      .toString()))
                                                              .clamp(0.0, 1.0),
                                                          center: Text(
                                                            '${nFormat2.format(areaModels.map((e) => e.ser_ren == renTalModels[index].ser && e.quantity == '1' ? 1 : 0).reduce((value, element) => value + element))} พื้นที่',
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 11.5,
                                                              // decoration:
                                                              //     TextDecoration.underline,
                                                              color:
                                                                  Colors.black,
                                                              // fontWeight: FontWeight.bold,
                                                              fontFamily:
                                                                  Font_.Fonts_T,
                                                            ),
                                                          ),
                                                          linearStrokeCap:
                                                              LinearStrokeCap
                                                                  .roundAll,
                                                          progressColor:
                                                              Colors.red[300],
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Text(
                                                          '${((areaModels.map((e) => e.ser_ren == renTalModels[index].ser && e.quantity == '1' ? 1 : 0).reduce((value, element) => value + element) * 100) / areaModels.map((e) => e.ser_ren == renTalModels[index].ser ? 1 : 0).reduce((value, element) => value + element)).toStringAsFixed(0)} %',
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            // decoration:
                                                            //     TextDecoration.underline,
                                                            color: Colors.red,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontFamily:
                                                                FontWeight_
                                                                    .Fonts_T,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        flex: 4,
                                                        child:
                                                            LinearPercentIndicator(
                                                          // width: MediaQuery.of(context)
                                                          //         .size
                                                          //         .width /
                                                          //     10,
                                                          animation: true,
                                                          lineHeight: 14.0,
                                                          leading: Container(
                                                            width: ((MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width) <
                                                                    650)
                                                                ? 40
                                                                : 100,
                                                            child: const Text(
                                                              'เสนอราคา',
                                                              maxLines: 3,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: TextStyle(
                                                                fontSize: 12,
                                                                // decoration:
                                                                //     TextDecoration.underline,
                                                                color: Colors
                                                                    .purple,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily:
                                                                    FontWeight_
                                                                        .Fonts_T,
                                                              ),
                                                            ),
                                                          ),
                                                          animationDuration:
                                                              3000,
                                                          percent: (double.parse(areaModels
                                                                      .map((e) =>
                                                                          e.ser_ren == renTalModels[index].ser && e.quantity != '1' && e.quantity != null
                                                                              ? 1
                                                                              : 0)
                                                                      .reduce((value,
                                                                              element) =>
                                                                          value +
                                                                          element)
                                                                      .toString()) /
                                                                  double.parse(areaModels
                                                                      .map((e) =>
                                                                          e.ser_ren == renTalModels[index].ser && e.quantity == null ? 1 : 0)
                                                                      .reduce((value, element) => value + element)
                                                                      .toString()))
                                                              .clamp(0.0, 1.0),
                                                          center: Text(
                                                            '${nFormat2.format(areaModels.map((e) => e.ser_ren == renTalModels[index].ser && e.quantity != '1' && e.quantity != null ? 1 : 0).reduce((value, element) => value + element))} พื้นที่',
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 11.5,
                                                              // decoration:
                                                              //     TextDecoration.underline,
                                                              color:
                                                                  Colors.black,
                                                              // fontWeight: FontWeight.bold,
                                                              fontFamily:
                                                                  Font_.Fonts_T,
                                                            ),
                                                          ),
                                                          linearStrokeCap:
                                                              LinearStrokeCap
                                                                  .roundAll,
                                                          progressColor: Colors
                                                              .purple[300],
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Text(
                                                          '${((areaModels.map((e) => e.ser_ren == renTalModels[index].ser && e.quantity != '1' && e.quantity != null ? 1 : 0).reduce((value, element) => value + element) * 100) / areaModels.map((e) => e.ser_ren == renTalModels[index].ser ? 1 : 0).reduce((value, element) => value + element)).toStringAsFixed(0)} %',
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            // decoration:
                                                            //     TextDecoration.underline,
                                                            color:
                                                                Colors.purple,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontFamily:
                                                                FontWeight_
                                                                    .Fonts_T,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        flex: 4,
                                                        child:
                                                            LinearPercentIndicator(
                                                          // width: MediaQuery.of(context)
                                                          //         .size
                                                          //         .width /
                                                          //     10,
                                                          animation: true,
                                                          lineHeight: 14.0,
                                                          leading: Container(
                                                            width: ((MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width) <
                                                                    650)
                                                                ? 40
                                                                : 100,
                                                            child: const Text(
                                                              'ใกล้หมดสัญญา',
                                                              maxLines: 3,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: TextStyle(
                                                                fontSize: 12,
                                                                // decoration:
                                                                //     TextDecoration.underline,
                                                                color: Colors
                                                                    .orange,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily:
                                                                    FontWeight_
                                                                        .Fonts_T,
                                                              ),
                                                            ),
                                                          ),
                                                          animationDuration:
                                                              3000,
                                                          percent: (double.parse(areaModels
                                                                      .map((e) => e.ser_ren == renTalModels[index].ser
                                                                          ? e.quantity == '1'
                                                                              ? (daysBetween(DateTime.parse('${e.ldate} 00:00:00').add(Duration(days: -(int.parse(e.set_date.toString())))), now) < int.parse(e.set_date.toString()) && daysBetween(DateTime.parse('${e.ldate} 00:00:00').add(Duration(days: -(int.parse(e.set_date.toString())))), now) > 0)
                                                                                  ? 1
                                                                                  : 0
                                                                              : 0
                                                                          : 0)
                                                                      .reduce((value, element) => value + element)
                                                                      .toString()) /
                                                                  double.parse(areaModels.map((e) => e.ser_ren == renTalModels[index].ser && e.quantity == null ? 1 : 0).reduce((value, element) => value + element).toString()))
                                                              .clamp(0.0, 1.0),
                                                          center: Text(
                                                            '${nFormat2.format(areaModels.map((e) => e.ser_ren == renTalModels[index].ser ? e.quantity == '1' ? (daysBetween(DateTime.parse('${e.ldate} 00:00:00').add(Duration(days: -(int.parse(e.set_date.toString())))), now) < int.parse(e.set_date.toString()) && daysBetween(DateTime.parse('${e.ldate} 00:00:00').add(Duration(days: -(int.parse(e.set_date.toString())))), now) > 0) ? 1 : 0 : 0 : 0).reduce((value, element) => value + element))} พื้นที่',
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 11.5,
                                                              // decoration:
                                                              //     TextDecoration.underline,
                                                              color:
                                                                  Colors.black,
                                                              // fontWeight: FontWeight.bold,
                                                              fontFamily:
                                                                  Font_.Fonts_T,
                                                            ),
                                                          ),
                                                          linearStrokeCap:
                                                              LinearStrokeCap
                                                                  .roundAll,
                                                          progressColor: Colors
                                                              .orange[300],
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Text(
                                                          '${((areaModels.map((e) => e.ser_ren == renTalModels[index].ser ? e.quantity == '1' ? (daysBetween(DateTime.parse('${e.ldate} 00:00:00').add(Duration(days: -(int.parse(e.set_date.toString())))), now) < int.parse(e.set_date.toString()) && daysBetween(DateTime.parse('${e.ldate} 00:00:00').add(Duration(days: -(int.parse(e.set_date.toString())))), now) > 0) ? 1 : 0 : 0 : 0).reduce((value, element) => value + element) * 100) / areaModels.map((e) => e.ser_ren == renTalModels[index].ser ? 1 : 0).reduce((value, element) => value + element)).toStringAsFixed(0)} %',
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            // decoration:
                                                            //     TextDecoration.underline,
                                                            color:
                                                                Colors.orange,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontFamily:
                                                                FontWeight_
                                                                    .Fonts_T,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Divider(),
                                                ),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      flex: 2,
                                                      child: Text(
                                                        'Zone',
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          // decoration:
                                                          //     TextDecoration.underline,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily:
                                                              FontWeight_
                                                                  .Fonts_T,
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: Text(
                                                        'All',
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          // decoration:
                                                          //     TextDecoration.underline,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily:
                                                              FontWeight_
                                                                  .Fonts_T,
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 10,
                                                      child: Container(
                                                        child: const Row(children: [
                                                          Expanded(
                                                            flex: 3,
                                                            child: Text(
                                                              'ว่าง',
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                fontSize: 12,
                                                                // decoration:
                                                                //     TextDecoration.underline,
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily:
                                                                    FontWeight_
                                                                        .Fonts_T,
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 3,
                                                            child: Text(
                                                              'เช่าอยู่',
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                fontSize: 12,
                                                                // decoration:
                                                                //     TextDecoration.underline,
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily:
                                                                    FontWeight_
                                                                        .Fonts_T,
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 3,
                                                            child: Text(
                                                              'เสนอราคา',
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                fontSize: 12,
                                                                // decoration:
                                                                //     TextDecoration.underline,
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily:
                                                                    FontWeight_
                                                                        .Fonts_T,
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 3,
                                                            child: Text(
                                                              'ใกล้หมดสัญญา',
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                fontSize: 12,
                                                                // decoration:
                                                                //     TextDecoration.underline,
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily:
                                                                    FontWeight_
                                                                        .Fonts_T,
                                                              ),
                                                            ),
                                                          ),
                                                        ]),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Divider(),
                                                for (int indexzn = 0;
                                                    indexzn < zoneModels.length;
                                                    indexzn++)
                                                  if (zoneModels[indexzn]
                                                          .ser_ren ==
                                                      ser_ren)
                                                    Column(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                              flex: 2,
                                                              child: Text(
                                                                '${zoneModels[indexzn].zn}',
                                                                maxLines: 2,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 12,
                                                                  // decoration:
                                                                  //     TextDecoration.underline,
                                                                  color: Colors
                                                                      .black,

                                                                  fontFamily: Font_
                                                                      .Fonts_T,
                                                                ),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              flex: 1,
                                                              child: Text(
                                                                '${zoneModels[indexzn].qty}',
                                                                maxLines: 2,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 12,
                                                                  // decoration:
                                                                  //     TextDecoration.underline,
                                                                  color: Colors
                                                                      .black,

                                                                  fontFamily: Font_
                                                                      .Fonts_T,
                                                                ),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              flex: 10,
                                                              child: Container(
                                                                child: Row(
                                                                  children: [
                                                                    Expanded(
                                                                      flex: 2,
                                                                      child:
                                                                          LinearPercentIndicator(
                                                                        animation:
                                                                            true,
                                                                        lineHeight:
                                                                            14.0,
                                                                        animationDuration:
                                                                            3000,
                                                                        percent: (double.parse(areaModels.map((e) => e.ser_ren == renTalModels[index].ser && e.quantity == null && zoneModels[indexzn].ser == e.zser ? 1 : 0).reduce((value, element) => value + element).toString()) / double.parse(areaModels.map((e) => e.ser_ren == renTalModels[index].ser && e.quantity != null ? 1 : 0).reduce((value, element) => value + element).toString())).clamp(
                                                                            0.0,
                                                                            1.0),
                                                                        center:
                                                                            Text(
                                                                          '${nFormat2.format(areaModels.map((e) => e.ser_ren == renTalModels[index].ser && e.quantity == null && zoneModels[indexzn].ser == e.zser ? 1 : 0).reduce((value, element) => value + element))}',
                                                                          maxLines:
                                                                              1,
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                          style:
                                                                              const TextStyle(
                                                                            fontSize:
                                                                                11.5,

                                                                            color:
                                                                                Colors.black,
                                                                            // fontWeight: FontWeight.bold,
                                                                            fontFamily:
                                                                                Font_.Fonts_T,
                                                                          ),
                                                                        ),
                                                                        linearStrokeCap:
                                                                            LinearStrokeCap.roundAll,
                                                                        progressColor:
                                                                            Colors.green[300],
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      flex: 1,
                                                                      child:
                                                                          Text(
                                                                        '${((areaModels.map((e) => e.ser_ren == renTalModels[index].ser && e.quantity == null && zoneModels[indexzn].ser == e.zser ? 1 : 0).reduce((value, element) => value + element) * 100) / areaModels.map((e) => e.ser_ren == renTalModels[index].ser ? 1 : 0).reduce((value, element) => value + element)).toStringAsFixed(0)} %',
                                                                        maxLines:
                                                                            1,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        style:
                                                                            const TextStyle(
                                                                          fontSize:
                                                                              11.5,

                                                                          color:
                                                                              Colors.black,
                                                                          // fontWeight: FontWeight.bold,
                                                                          fontFamily:
                                                                              Font_.Fonts_T,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      flex: 2,
                                                                      child:
                                                                          LinearPercentIndicator(
                                                                        animation:
                                                                            true,
                                                                        lineHeight:
                                                                            14.0,
                                                                        animationDuration:
                                                                            3000,
                                                                        percent: (double.parse(areaModels.map((e) => e.ser_ren == renTalModels[index].ser && e.quantity == '1' && zoneModels[indexzn].ser == e.zser ? 1 : 0).reduce((value, element) => value + element).toString()) / double.parse(areaModels.map((e) => e.ser_ren == renTalModels[index].ser && e.quantity == null ? 1 : 0).reduce((value, element) => value + element).toString())).clamp(
                                                                            0.0,
                                                                            1.0),
                                                                        center:
                                                                            Text(
                                                                          '${nFormat2.format(areaModels.map((e) => e.ser_ren == renTalModels[index].ser && e.quantity == '1' && zoneModels[indexzn].ser == e.zser ? 1 : 0).reduce((value, element) => value + element))}',
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                          style:
                                                                              const TextStyle(
                                                                            fontSize:
                                                                                11.5,
                                                                            // decoration:
                                                                            //     TextDecoration.underline,
                                                                            color:
                                                                                Colors.black,
                                                                            // fontWeight: FontWeight.bold,
                                                                            fontFamily:
                                                                                Font_.Fonts_T,
                                                                          ),
                                                                        ),
                                                                        linearStrokeCap:
                                                                            LinearStrokeCap.roundAll,
                                                                        progressColor:
                                                                            Colors.red[300],
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      flex: 1,
                                                                      child:
                                                                          Text(
                                                                        '${((areaModels.map((e) => e.ser_ren == renTalModels[index].ser && e.quantity == '1' && zoneModels[indexzn].ser == e.zser ? 1 : 0).reduce((value, element) => value + element) * 100) / areaModels.map((e) => e.ser_ren == renTalModels[index].ser ? 1 : 0).reduce((value, element) => value + element)).toStringAsFixed(0)} %',
                                                                        maxLines:
                                                                            1,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        style:
                                                                            const TextStyle(
                                                                          fontSize:
                                                                              11.5,

                                                                          color:
                                                                              Colors.black,
                                                                          // fontWeight: FontWeight.bold,
                                                                          fontFamily:
                                                                              Font_.Fonts_T,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      flex: 2,
                                                                      child:
                                                                          LinearPercentIndicator(
                                                                        animation:
                                                                            true,
                                                                        lineHeight:
                                                                            14.0,
                                                                        animationDuration:
                                                                            3000,
                                                                        percent: (double.parse(areaModels.map((e) => e.ser_ren == renTalModels[index].ser && e.quantity != '1' && e.quantity != null && zoneModels[indexzn].ser == e.zser ? 1 : 0).reduce((value, element) => value + element).toString()) / double.parse(areaModels.map((e) => e.ser_ren == renTalModels[index].ser && e.quantity == null ? 1 : 0).reduce((value, element) => value + element).toString())).clamp(
                                                                            0.0,
                                                                            1.0),
                                                                        center:
                                                                            Text(
                                                                          '${nFormat2.format(areaModels.map((e) => e.ser_ren == renTalModels[index].ser && e.quantity != '1' && e.quantity != null && zoneModels[indexzn].ser == e.zser ? 1 : 0).reduce((value, element) => value + element))}',
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                          style:
                                                                              const TextStyle(
                                                                            fontSize:
                                                                                11.5,
                                                                            // decoration:
                                                                            //     TextDecoration.underline,
                                                                            color:
                                                                                Colors.black,
                                                                            // fontWeight: FontWeight.bold,
                                                                            fontFamily:
                                                                                Font_.Fonts_T,
                                                                          ),
                                                                        ),
                                                                        linearStrokeCap:
                                                                            LinearStrokeCap.roundAll,
                                                                        progressColor:
                                                                            Colors.purple[300],
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      flex: 1,
                                                                      child:
                                                                          Text(
                                                                        '${((areaModels.map((e) => e.ser_ren == renTalModels[index].ser && e.quantity != '1' && e.quantity != null && zoneModels[indexzn].ser == e.zser ? 1 : 0).reduce((value, element) => value + element) * 100) / areaModels.map((e) => e.ser_ren == renTalModels[index].ser ? 1 : 0).reduce((value, element) => value + element)).toStringAsFixed(0)} %',
                                                                        maxLines:
                                                                            1,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        style:
                                                                            const TextStyle(
                                                                          fontSize:
                                                                              11.5,

                                                                          color:
                                                                              Colors.black,
                                                                          // fontWeight: FontWeight.bold,
                                                                          fontFamily:
                                                                              Font_.Fonts_T,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      flex: 2,
                                                                      child:
                                                                          LinearPercentIndicator(
                                                                        animation:
                                                                            true,
                                                                        lineHeight:
                                                                            14.0,
                                                                        animationDuration:
                                                                            3000,
                                                                        percent: (double.parse(areaModels
                                                                                    .map((e) => e.ser_ren == renTalModels[index].ser
                                                                                        ? e.quantity == '1'
                                                                                            ? (daysBetween(DateTime.parse('${e.ldate} 00:00:00').add(Duration(days: -(int.parse(e.set_date.toString())))), now) < int.parse(e.set_date.toString()) && daysBetween(DateTime.parse('${e.ldate} 00:00:00').add(Duration(days: -(int.parse(e.set_date.toString())))), now) > 0) && zoneModels[indexzn].ser == e.zser
                                                                                                ? 1
                                                                                                : 0
                                                                                            : 0
                                                                                        : 0)
                                                                                    .reduce((value, element) => value + element)
                                                                                    .toString()) /
                                                                                double.parse(areaModels.map((e) => e.ser_ren == renTalModels[index].ser && e.quantity == null ? 1 : 0).reduce((value, element) => value + element).toString()))
                                                                            .clamp(0.0, 1.0),
                                                                        center:
                                                                            Text(
                                                                          '${nFormat2.format(areaModels.map((e) => e.ser_ren == renTalModels[index].ser ? e.quantity == '1' ? (daysBetween(DateTime.parse('${e.ldate} 00:00:00').add(Duration(days: -(int.parse(e.set_date.toString())))), now) < int.parse(e.set_date.toString()) && daysBetween(DateTime.parse('${e.ldate} 00:00:00').add(Duration(days: -(int.parse(e.set_date.toString())))), now) > 0) && zoneModels[indexzn].ser == e.zser ? 1 : 0 : 0 : 0).reduce((value, element) => value + element))}',
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                          style:
                                                                              const TextStyle(
                                                                            fontSize:
                                                                                11.5,
                                                                            // decoration:
                                                                            //     TextDecoration.underline,
                                                                            color:
                                                                                Colors.black,
                                                                            // fontWeight: FontWeight.bold,
                                                                            fontFamily:
                                                                                Font_.Fonts_T,
                                                                          ),
                                                                        ),
                                                                        linearStrokeCap:
                                                                            LinearStrokeCap.roundAll,
                                                                        progressColor:
                                                                            Colors.orange[300],
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      flex: 1,
                                                                      child:
                                                                          Text(
                                                                        '${((areaModels.map((e) => e.ser_ren == renTalModels[index].ser ? e.quantity == '1' ? (daysBetween(DateTime.parse('${e.ldate} 00:00:00').add(Duration(days: -(int.parse(e.set_date.toString())))), now) < int.parse(e.set_date.toString()) && daysBetween(DateTime.parse('${e.ldate} 00:00:00').add(Duration(days: -(int.parse(e.set_date.toString())))), now) > 0) && zoneModels[indexzn].ser == e.zser ? 1 : 0 : 0 : 0).reduce((value, element) => value + element) * 100) / areaModels.map((e) => e.ser_ren == renTalModels[index].ser ? 1 : 0).reduce((value, element) => value + element)).toStringAsFixed(0)} %',
                                                                        maxLines:
                                                                            1,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        style:
                                                                            const TextStyle(
                                                                          fontSize:
                                                                              11.5,

                                                                          color:
                                                                              Colors.black,
                                                                          // fontWeight: FontWeight.bold,
                                                                          fontFamily:
                                                                              Font_.Fonts_T,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            // Expanded(
                                                            //   child: Text(
                                                            //     '${dashboardfinancModels[indexfin].bank}',
                                                            //     maxLines: 2,
                                                            //     overflow: TextOverflow.ellipsis,
                                                            //     textAlign: TextAlign.end,
                                                            //     style: TextStyle(
                                                            //       fontSize: 12,
                                                            //       // decoration:
                                                            //       //     TextDecoration.underline,
                                                            //       color: Colors.black,
                                                            //       fontFamily: Font_.Fonts_T,
                                                            //     ),
                                                            //   ),
                                                            // ),
                                                            // Expanded(
                                                            //   child: Text(
                                                            //     '${dashboardfinancModels[indexzn].bno}',
                                                            //     maxLines: 2,
                                                            //     overflow: TextOverflow.ellipsis,
                                                            //     textAlign: TextAlign.end,
                                                            //     style: TextStyle(
                                                            //       fontSize: 12,
                                                            //       // decoration:
                                                            //       //     TextDecoration.underline,
                                                            //       color: Colors.black,
                                                            //       fontFamily: Font_.Fonts_T,
                                                            //     ),
                                                            //   ),
                                                            // ),
                                                            // Expanded(
                                                            //   child: Text(
                                                            //     '${nFormat.format(double.parse(dashboardfinancModels[indexzn].total.toString()))}',
                                                            //     maxLines: 2,
                                                            //     overflow: TextOverflow.ellipsis,
                                                            //     textAlign: TextAlign.end,
                                                            //     style: TextStyle(
                                                            //       fontSize: 12,
                                                            //       // decoration:
                                                            //       //     TextDecoration.underline,
                                                            //       color: Colors.black,
                                                            //       fontFamily: Font_.Fonts_T,
                                                            //     ),
                                                            //   ),
                                                            // ),
                                                          ],
                                                        ),
                                                        Divider(),
                                                      ],
                                                    ),
                                              ],
                                            )),
                                      ],
                                    )
                                  : SizedBox(),
                    ],
                  ),
                ),
          ],
        ),
      ),
    );
  }

  Future<Null> _select_financial_StartDate(BuildContext context) async {
    final Future<DateTime?> picked = showDatePicker(
      // locale: const Locale('th', 'TH'),
      helpText: 'เลือกวันที่เริ่มต้น', confirmText: 'ตกลง',
      cancelText: 'ยกเลิก',
      context: context,
      initialDate: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day - 1),
      initialDatePickerMode: DatePickerMode.day,
      firstDate: DateTime(2023, 1, 1),
      lastDate: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day),
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
        var formatter = DateFormat('yyyy-MM-dd');
        print("${formatter.format(result!)}");
        setState(() {
          SDatex_total1_ = "${formatter.format(result)}";
        });
        read_GC_rental();
      }
    });
  }

  Future<Null> _select_financial_LtartDate(BuildContext context) async {
    final Future<DateTime?> picked = showDatePicker(
      // locale: const Locale('th', 'TH'),
      helpText: 'เลือกวันที่สุดท้าย', confirmText: 'ตกลง',
      cancelText: 'ยกเลิก',
      context: context,
      initialDate: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day - 1),
      initialDatePickerMode: DatePickerMode.day,
      firstDate: DateTime(2023, 1, 1),
      lastDate: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day),
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
        var formatter = DateFormat('yyyy-MM-dd');
        print("${formatter.format(result!)}");
        setState(() {
          LDatex_total1_ = "${formatter.format(result)}";
        });
        read_GC_rental();
      }
    });
  }
}

class ChartData {
  ChartData(this.x, this.y, this.z, [this.color]);
  final String x;
  final double y;
  final String z;
  final Color? color;
}
