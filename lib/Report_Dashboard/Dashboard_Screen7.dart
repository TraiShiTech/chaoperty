import 'dart:convert';
import 'dart:ui';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slide_switcher/slide_switcher.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:http/http.dart' as http;
import '../Constant/Myconstant.dart';
import '../Man_PDF/Man_ChartReport_Generate.dart';
import '../Model/GetZone_Model.dart';
import '../Model/Get_maintenance_model.dart';
import '../Style/colors.dart';
import '../Style/downloadImage.dart';

class Dashboard_Screen7 extends StatefulWidget {
  const Dashboard_Screen7({super.key});

  @override
  State<Dashboard_Screen7> createState() => _Dashboard_Screen7State();
}

class _Dashboard_Screen7State extends State<Dashboard_Screen7> {
  ChartSeriesController? _chartSeriesController1, _chartSeriesController2;
  final chartKey1 = GlobalKey();
  final chartKey2 = GlobalKey();
  final chartKey3 = GlobalKey();
  final chartKey4 = GlobalKey();
  List<String> YE_Th = [];
  List<String> Mont_Th = [];
  List<ZoneModel> zoneModels_report = [];
  List<ZoneModel> zoneModels = [];
  List<MaintenanceModel> maintenanceModels = [];
  String? renTal_user,
      renTal_name,
      Status_pe,
      Status_pe_ser,
      Value_Chang_Zone_People,
      Value_Chang_Zone_People_Ser,
      Value_Chang_Zone_People_Cancel,
      Value_Chang_Zone_People_Ser_Cancel,
      Visit_1,
      Visit_2;
  String? Mon_maintenance_Mon;
  String? YE_maintenance_Mon;
  String? zone_ser_maintenance,
      zone_name_maintenance,
      Status_maintenance_,
      Status_maintenance_ser;
  // late List<_Maintenance> data_tatol_Maintenance = [];

  late List<List<_Maintenance>> data_tatol_Maintenance;

  List maintenance_Status = [
    'ทั้งหมด',
    'รอดำเนินการ',
    'เสร็จสิ้น',
  ];
  List<String> monthsInThai = [
    'ม.ค.',
    'ก.พ',
    'มี.ค',
    'เม.ย',
    'พ.ค',
    'มิ.ย',
    'ก.ค',
    'ส.ค',
    'ก.ย',
    'ต.ค',
    'พ.ย.',
    'ธ.ค',
  ];

  @override
  void initState() {
    super.initState();
    checkPreferance();
    read_GC_zone();
  }

  /////////------------------------------------------------------------->
  Future<Null> checkPreferance() async {
    int currentYear = DateTime.now().year;
    for (int i = currentYear; i >= currentYear - 10; i--) {
      YE_Th.add(i.toString());
    }
    for (int i2 = 0; i2 < 12; i2++) {
      Mont_Th.add('${i2 + 1}');
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      renTal_user = preferences.getString('renTalSer');
      renTal_name = preferences.getString('renTalName');
    });
    // System_New_Update();
  }

  Future<Null> read_GC_zone() async {
    if (zoneModels.length != 0) {
      zoneModels.clear();
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var ren = preferences.getString('renTalSer');

    String url = '${MyConstant().domain}/GC_zone.php?isAdd=true&ren=$ren';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);
      // Map<String, dynamic> map = Map();
      // map['ser'] = '0';
      // map['rser'] = '0';
      // map['zn'] = 'ทั้งหมด';
      // map['qty'] = '0';
      // map['img'] = '0';
      // map['data_update'] = '0';

      // ZoneModel zoneModelx = ZoneModel.fromJson(map);

      // setState(() {
      //   zoneModels.add(zoneModelx);
      // });

      for (var map in result) {
        ZoneModel zoneModel = ZoneModel.fromJson(map);
        setState(() {
          zoneModels.add(zoneModel);
          zoneModels_report.add(zoneModel);
        });
      }
      zoneModels_report.sort((a, b) => a.zn!.compareTo(b.zn!));
      zoneModels.sort((a, b) {
        if (a.zn == 'ทั้งหมด') {
          return -1; // 'all' should come before other elements
        } else if (b.zn == 'ทั้งหมด') {
          return 1; // 'all' should come after other elements
        } else {
          return a.zn!
              .compareTo(b.zn!); // sort other elements in ascending order
        }
      });
      print(
        zoneModels.length,
      );
    } catch (e) {}
    data_tatol_Maintenance = List.generate(zoneModels_report.length, (_) => []);
  }

  //////////--------------------------------------------->
  Future<Null> red_Trans_c_maintenance(context1) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    setState(() {
      data_tatol_Maintenance.clear();
      maintenanceModels.clear();
      data_tatol_Maintenance =
          List.generate(zoneModels_report.length, (_) => []);
    });
    for (int index1 = 0; index1 < zoneModels_report.length; index1++) {
      if (index1 == 0) {
        Dialog_(context1, index1);
      } else {}
      for (int index2 = 0; index2 < monthsInThai.length; index2++) {
        setState(() {
          maintenanceModels.clear();
        });
        String url =
            '${MyConstant().domain}/GC_maintenance_mst_Zone_Report.php?isAdd=true&ren=$ren&serZone=${zoneModels_report[index1].ser}&monx=${index2 + 1}&yex=$YE_maintenance_Mon';

        try {
          var response = await http.get(Uri.parse(url));

          var result = json.decode(response.body);
          // print('result $ciddoc');
          if (result.toString() != 'null') {
            for (var map in result) {
              MaintenanceModel maintenanceModel =
                  MaintenanceModel.fromJson(map);
              if (Status_maintenance_ser == '0') {
                setState(() {
                  maintenanceModels.add(maintenanceModel);
                });
              } else {
                if (Status_maintenance_ser.toString() ==
                    maintenanceModel.mst.toString()) {
                  setState(() {
                    maintenanceModels.add(maintenanceModel);
                  });
                } else {}
              }
            }
          }
          await Future.delayed(const Duration(milliseconds: 100));
          // print(
          //     '${index2 + 1}  :   ${maintenanceModels.length} || ${zoneModels_report[index1].zn}');

          setState(() {
            data_tatol_Maintenance[index1].add(_Maintenance(
                '${monthsInThai[index2]}',
                double.parse('${maintenanceModels.length}')));
          });
        } catch (e) {}
      }
      await Future.delayed(const Duration(milliseconds: 100));
      if (index1 + 1 == zoneModels_report.length) {
        Dialog_(context1, index1);
      } else {}
    }
  }

  Dialog_(context, index1) {
    // if (index1 + 1 == zoneModels_report.length) {
    //   setState(() {
    //     YE_Income = null;
    //   });
    // }
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) {
          if (index1 + 1 == zoneModels_report.length) {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          } else {}
          // Future.delayed(
          //     const Duration(
          //         seconds:
          //             1),
          //     () {
          //   Navigator.of(
          //           context)
          //       .pop();
          // });
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

  ///----------------------------------------------------------->
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            decoration: const BoxDecoration(
              color: AppbackgroundColor.Sub_Abg_Colors,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
              // border: Border.all(color: Colors.grey, width: 1),
            ),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.7,
            child: SingleChildScrollView(
                child: Column(children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        color: AppbackgroundColor.TiTile_Colors,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(0),
                            bottomRight: Radius.circular(0)),
                        // border: Border.all(color: Colors.grey, width: 1),
                      ),
                      child: ScrollConfiguration(
                        behavior: ScrollConfiguration.of(context)
                            .copyWith(dragDevices: {
                          PointerDeviceKind.touch,
                          PointerDeviceKind.mouse,
                        }),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'รายงาน ข้อมูลการแจ้งซ่อม  : ',
                                  style: TextStyle(
                                    color: ReportScreen_Color.Colors_Text2_,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: FontWeight_.Fonts_T,
                                  ),
                                ),
                              ),
                              // const Padding(
                              //   padding: EdgeInsets.all(8.0),
                              //   child: Text(
                              //     'เดือน :',
                              //     style: TextStyle(
                              //       color: ReportScreen_Color.Colors_Text2_,
                              //       // fontWeight: FontWeight.bold,
                              //       fontFamily: Font_.Fonts_T,
                              //     ),
                              //   ),
                              // ),
                              // Padding(
                              //   padding: const EdgeInsets.all(8.0),
                              //   child: Container(
                              //     decoration: const BoxDecoration(
                              //       color: AppbackgroundColor.Sub_Abg_Colors,
                              //       borderRadius: BorderRadius.only(
                              //           topLeft: Radius.circular(10),
                              //           topRight: Radius.circular(10),
                              //           bottomLeft: Radius.circular(10),
                              //           bottomRight: Radius.circular(10)),
                              //       // border: Border.all(color: Colors.grey, width: 1),
                              //     ),
                              //     width: 120,
                              //     padding: const EdgeInsets.all(8.0),
                              //     child: DropdownButtonFormField2(
                              //       alignment: Alignment.center,
                              //       focusColor: Colors.white,
                              //       autofocus: false,
                              //       decoration: InputDecoration(
                              //         floatingLabelAlignment:
                              //             FloatingLabelAlignment.center,
                              //         enabled: true,
                              //         hoverColor: Colors.brown,
                              //         prefixIconColor: Colors.blue,
                              //         fillColor: Colors.white.withOpacity(0.05),
                              //         filled: false,
                              //         isDense: true,
                              //         contentPadding: EdgeInsets.zero,
                              //         border: OutlineInputBorder(
                              //           borderSide:
                              //               const BorderSide(color: Colors.red),
                              //           borderRadius: BorderRadius.circular(10),
                              //         ),
                              //         focusedBorder: const OutlineInputBorder(
                              //           borderRadius: BorderRadius.only(
                              //             topRight: Radius.circular(10),
                              //             topLeft: Radius.circular(10),
                              //             bottomRight: Radius.circular(10),
                              //             bottomLeft: Radius.circular(10),
                              //           ),
                              //           borderSide: BorderSide(
                              //             width: 1,
                              //             color: Color.fromARGB(255, 231, 227, 227),
                              //           ),
                              //         ),
                              //       ),
                              //       isExpanded: false,
                              //       value: Mon_maintenance_Mon,
                              //       // hint: Text(
                              //       //   Mon_Income == null
                              //       //       ? 'เลือก'
                              //       //       : '$Mon_Income',
                              //       //   maxLines: 2,
                              //       //   textAlign: TextAlign.center,
                              //       //   style: const TextStyle(
                              //       //     overflow:
                              //       //         TextOverflow.ellipsis,
                              //       //     fontSize: 14,
                              //       //     color: Colors.grey,
                              //       //   ),
                              //       // ),
                              //       icon: const Icon(
                              //         Icons.arrow_drop_down,
                              //         color: Colors.black,
                              //       ),
                              //       style: const TextStyle(
                              //         color: Colors.grey,
                              //       ),
                              //       iconSize: 20,
                              //       buttonHeight: 40,
                              //       buttonWidth: 200,
                              //       // buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                              //       dropdownDecoration: BoxDecoration(
                              //         // color: Colors
                              //         //     .amber,
                              //         borderRadius: BorderRadius.circular(10),
                              //         border:
                              //             Border.all(color: Colors.white, width: 1),
                              //       ),
                              //       items: [
                              //         for (int item = 1; item < 13; item++)
                              //           DropdownMenuItem<String>(
                              //             value: '${item}',
                              //             child: Text(
                              //               '${monthsInThai[item - 1]}',
                              //               //'${item}',
                              //               textAlign: TextAlign.center,
                              //               style: const TextStyle(
                              //                 overflow: TextOverflow.ellipsis,
                              //                 fontSize: 14,
                              //                 color: Colors.grey,
                              //               ),
                              //             ),
                              //           )
                              //       ],

                              //       onChanged: (value) async {
                              //         Mon_maintenance_Mon = value;

                              //         // if (Value_Chang_Zone_Income !=
                              //         //     null) {
                              //         //   red_Trans_billIncome();
                              //         //   red_Trans_billMovemen();
                              //         // }
                              //       },
                              //     ),
                              //   ),
                              // ),
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'ปี :',
                                  style: TextStyle(
                                    color: ReportScreen_Color.Colors_Text2_,
                                    // fontWeight: FontWeight.bold,
                                    fontFamily: Font_.Fonts_T,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: AppbackgroundColor.Sub_Abg_Colors,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10)),
                                    // border: Border.all(color: Colors.grey, width: 1),
                                  ),
                                  width: 120,
                                  padding: const EdgeInsets.all(8.0),
                                  child: DropdownButtonFormField2(
                                    alignment: Alignment.center,
                                    focusColor: Colors.white,
                                    autofocus: false,
                                    decoration: InputDecoration(
                                      floatingLabelAlignment:
                                          FloatingLabelAlignment.center,
                                      enabled: true,
                                      hoverColor: Colors.brown,
                                      prefixIconColor: Colors.blue,
                                      fillColor: Colors.white.withOpacity(0.05),
                                      filled: false,
                                      isDense: true,
                                      contentPadding: EdgeInsets.zero,
                                      border: OutlineInputBorder(
                                        borderSide:
                                            const BorderSide(color: Colors.red),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      focusedBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(10),
                                          topLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10),
                                          bottomLeft: Radius.circular(10),
                                        ),
                                        borderSide: BorderSide(
                                          width: 1,
                                          color: Color.fromARGB(
                                              255, 231, 227, 227),
                                        ),
                                      ),
                                    ),
                                    isExpanded: false,
                                    value: YE_maintenance_Mon,
                                    // hint: Text(
                                    //   YE_Income == null
                                    //       ? 'เลือก'
                                    //       : '$YE_Income',
                                    //   maxLines: 2,
                                    //   textAlign: TextAlign.center,
                                    //   style: const TextStyle(
                                    //     overflow:
                                    //         TextOverflow.ellipsis,
                                    //     fontSize: 14,
                                    //     color: Colors.grey,
                                    //   ),
                                    // ),
                                    icon: const Icon(
                                      Icons.arrow_drop_down,
                                      color: Colors.black,
                                    ),
                                    style: const TextStyle(
                                      color: Colors.grey,
                                    ),
                                    iconSize: 20,
                                    buttonHeight: 40,
                                    buttonWidth: 200,
                                    // buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                                    dropdownDecoration: BoxDecoration(
                                      // color: Colors
                                      //     .amber,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: Colors.white, width: 1),
                                    ),
                                    items: YE_Th.map((item) =>
                                        DropdownMenuItem<String>(
                                          value: '${item}',
                                          child: Text(
                                            '${item}',
                                            // '${int.parse(item) + 543}',
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              overflow: TextOverflow.ellipsis,
                                              fontSize: 14,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        )).toList(),

                                    onChanged: (value) async {
                                      YE_maintenance_Mon = value;

                                      // if (Value_Chang_Zone_Income !=
                                      //     null) {
                                      //   red_Trans_billIncome();
                                      //   red_Trans_billMovemen();
                                      // }
                                    },
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'สถานะ :',
                                  style: TextStyle(
                                    color: ReportScreen_Color.Colors_Text2_,
                                    // fontWeight: FontWeight.bold,
                                    fontFamily: Font_.Fonts_T,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: AppbackgroundColor.Sub_Abg_Colors,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10)),
                                    // border: Border.all(color: Colors.grey, width: 1),
                                  ),
                                  width: 140,
                                  padding: const EdgeInsets.all(8.0),
                                  child: DropdownButtonFormField2(
                                    value: Status_maintenance_,

                                    alignment: Alignment.center,
                                    focusColor: Colors.white,
                                    autofocus: false,
                                    decoration: InputDecoration(
                                      enabled: true,
                                      hoverColor: Colors.brown,
                                      prefixIconColor: Colors.blue,
                                      fillColor: Colors.white.withOpacity(0.05),
                                      filled: false,
                                      isDense: true,
                                      contentPadding: EdgeInsets.zero,
                                      border: OutlineInputBorder(
                                        borderSide:
                                            const BorderSide(color: Colors.red),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      focusedBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(10),
                                          topLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10),
                                          bottomLeft: Radius.circular(10),
                                        ),
                                        borderSide: BorderSide(
                                          width: 1,
                                          color: Color.fromARGB(
                                              255, 231, 227, 227),
                                        ),
                                      ),
                                    ),
                                    isExpanded: false,

                                    icon: const Icon(
                                      Icons.arrow_drop_down,
                                      color: Colors.black,
                                    ),
                                    style: const TextStyle(
                                      color: Colors.grey,
                                    ),
                                    iconSize: 20,
                                    buttonHeight: 40,
                                    buttonWidth: 240,
                                    // buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                                    dropdownDecoration: BoxDecoration(
                                      // color: Colors
                                      //     .amber,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: Colors.white, width: 1),
                                    ),
                                    items: maintenance_Status
                                        .map((item) => DropdownMenuItem<String>(
                                              value: '${item}',
                                              child: Text(
                                                '${item}',
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  fontSize: 14,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ))
                                        .toList(),

                                    onChanged: (value) async {
                                      int selectedIndex = maintenance_Status
                                          .indexWhere((item) => item == value);
                                      setState(() {
                                        Status_maintenance_ = value!;
                                        Status_maintenance_ser =
                                            '${selectedIndex}';
                                      });
                                      print(Status_maintenance_ser);
                                    },
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: () async {
                                    if (Status_maintenance_ != null &&
                                        YE_maintenance_Mon != null) {
                                      red_Trans_c_maintenance(context);
                                    }
                                  },
                                  child: Container(
                                      width: 100,
                                      padding: const EdgeInsets.all(8.0),
                                      decoration: BoxDecoration(
                                        color: Colors.green[700],
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10)),
                                      ),
                                      child: const Center(
                                        child: Text(
                                          'ค้นหา',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: FontWeight_.Fonts_T,
                                          ),
                                        ),
                                      )),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color:
                            AppbackgroundColor.TiTile_Colors.withOpacity(0.4),
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(0),
                            topRight: Radius.circular(0),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                        // border: Border.all(color: Colors.grey, width: 1),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: () {},
                                  child: SlideSwitcher(
                                    containerBorder: Border.all(
                                        color: Colors.grey, width: 1),
                                    slidersColors: [Colors.white],
                                    containerBorderRadius: 10,
                                    onSelect: (index) async {
                                      setState(() {
                                        // switcherIndex1 = index;
                                        setState(() {
                                          Visit_1 = '${index + 1}';
                                        });
                                      });
                                    },
                                    containerHeight: 35,
                                    containerWight: 100,
                                    containerColor: Colors.grey,
                                    children: [
                                      Icon(
                                        Icons.line_axis,
                                        color: (Visit_1 == '1')
                                            ? Colors.blue[900]
                                            : Colors.black,
                                      ),
                                      Icon(
                                        Icons.view_column,
                                        color: (Visit_1 == '2')
                                            ? Colors.blue[900]
                                            : Colors.black,
                                      ),
                                    ],
                                  ),
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: Colors.green[50]!.withOpacity(0.5),
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      (Visit_1 == '1' || Visit_1 == null)
                          ? RepaintBoundary(
                              key: chartKey1,
                              child: SfCartesianChart(
                                  trackballBehavior: TrackballBehavior(
                                    activationMode: ActivationMode.singleTap,
                                    enable: true,
                                    tooltipDisplayMode:
                                        TrackballDisplayMode.groupAllPoints,
                                    tooltipSettings: const InteractiveTooltip(
                                        format: 'point.y',
                                        enable: true,
                                        color: Colors.black54),
                                    markerSettings:
                                        const TrackballMarkerSettings(
                                            markerVisibility:
                                                TrackballVisibilityMode
                                                    .visible),
                                  ),
                                  zoomPanBehavior: ZoomPanBehavior(
                                      enableMouseWheelZooming: true,
                                      maximumZoomLevel: 0.5,
                                      enablePinching: true,
                                      zoomMode: ZoomMode.x,
                                      enablePanning: true,
                                      enableSelectionZooming: true,
                                      enableDoubleTapZooming: true),
                                  // trackballBehavior: TrackballBehavior(),
                                  title: ChartTitle(
                                      text: (YE_maintenance_Mon == null)
                                          ? 'รายงานการแจ้งซ่อม '
                                          : 'รายงานการแจ้งซ่อม $YE_maintenance_Mon'),
                                  legend: Legend(
                                      isVisible: true,
                                      textStyle:
                                          const TextStyle(color: Colors.black)),
                                  // primaryYAxis: NumericAxis(isInversed: false),
                                  primaryXAxis: CategoryAxis(
                                    title: AxisTitle(
                                        text: 'เดือน',
                                        textStyle:
                                            const TextStyle(fontSize: 16)),
                                    labelStyle: const TextStyle(
                                        fontSize: 12, color: Colors.black),
                                  ),
                                  primaryYAxis: NumericAxis(
                                    title: AxisTitle(
                                        text: 'หน่วย (ครั้ง)',
                                        textStyle:
                                            const TextStyle(fontSize: 16)),
                                    numberFormat: NumberFormat.compact(),
                                    isInversed: false,
                                    //  interval: 1000,
                                    minimum: 0,
                                    isVisible:
                                        true, // Set isVisible to false to hide the left y-axis   116
                                  ),
                                  series: <ChartSeries<_Maintenance, String>>[
                                    for (int index = 0;
                                        index < data_tatol_Maintenance.length;
                                        index++)
                                      LineSeries<_Maintenance, String>(
                                        // color: Colors.green,
                                        animationDuration: 100,
                                        onRendererCreated:
                                            (ChartSeriesController controller) {
                                          _chartSeriesController1 = controller;
                                        },
                                        dataSource:
                                            data_tatol_Maintenance[index],
                                        xValueMapper: (_Maintenance data, _) =>
                                            data.monts,
                                        yValueMapper: (_Maintenance data, _) =>
                                            data.total,
                                        name: '${zoneModels_report[index].zn}',
                                      ),
                                  ]))
                          : RepaintBoundary(
                              key: chartKey2,
                              child: SfCartesianChart(
                                  trackballBehavior: TrackballBehavior(
                                    activationMode: ActivationMode.singleTap,
                                    enable: true,
                                    tooltipDisplayMode:
                                        TrackballDisplayMode.groupAllPoints,
                                    tooltipSettings: const InteractiveTooltip(
                                        format: 'point.y ',
                                        enable: true,
                                        color: Colors.black54),
                                    markerSettings:
                                        const TrackballMarkerSettings(
                                            markerVisibility:
                                                TrackballVisibilityMode
                                                    .visible),
                                  ),
                                  zoomPanBehavior: ZoomPanBehavior(
                                      enableMouseWheelZooming: true,
                                      maximumZoomLevel: 0.5,
                                      enablePinching: true,
                                      zoomMode: ZoomMode.x,
                                      enablePanning: true,
                                      enableSelectionZooming: true,
                                      enableDoubleTapZooming: true),
                                  // trackballBehavior: TrackballBehavior(),
                                  title: ChartTitle(
                                      text: (YE_maintenance_Mon == null)
                                          ? 'รายงานการแจ้งซ่อม '
                                          : 'รายงานการแจ้งซ่อม $YE_maintenance_Mon'),
                                  legend: Legend(
                                      isVisible: true,
                                      textStyle:
                                          const TextStyle(color: Colors.black)),
                                  // primaryYAxis: NumericAxis(isInversed: false),
                                  primaryXAxis: CategoryAxis(
                                    title: AxisTitle(
                                        text: 'เดือน',
                                        textStyle:
                                            const TextStyle(fontSize: 16)),
                                    labelStyle: const TextStyle(
                                        fontSize: 12, color: Colors.black),
                                  ),
                                  primaryYAxis: NumericAxis(
                                    title: AxisTitle(
                                        text: 'หน่วย (ครั้ง)',
                                        textStyle:
                                            const TextStyle(fontSize: 16)),
                                    numberFormat: NumberFormat.compact(),
                                    isInversed: false,
                                    //  interval: 1000,
                                    minimum: 0,
                                    isVisible:
                                        true, // Set isVisible to false to hide the left y-axis   116
                                  ),
                                  series: <ChartSeries<_Maintenance, String>>[
                                    for (int index = 0;
                                        index < data_tatol_Maintenance.length;
                                        index++)
                                      ColumnSeries<_Maintenance, String>(
                                        // color: Colors.green,
                                        // trackColor: Colors.green,
                                        animationDuration: 100,
                                        onRendererCreated:
                                            (ChartSeriesController controller) {
                                          _chartSeriesController2 = controller;
                                        },
                                        dataSource:
                                            data_tatol_Maintenance[index],
                                        xValueMapper: (_Maintenance data, _) =>
                                            data.monts,
                                        yValueMapper: (_Maintenance data, _) =>
                                            data.total,
                                        name: '${zoneModels_report[index].zn}',
                                      ),
                                  ]),
                            ),
                      // Row(
                      //   children: [
                      //     Expanded(
                      //       child: Align(
                      //         alignment: Alignment.centerRight,
                      //         child: Padding(
                      //           padding: const EdgeInsets.all(8.0),
                      //           child: InkWell(
                      //             onTap: () async {
                      //               if (Visit_1 == '1' || Visit_1 == null) {
                      //                 captureAndConvertToBase64(chartKey1, '');
                      //               } else {
                      //                 captureAndConvertToBase64(chartKey2, '');
                      //               }
                      //             },
                      //             child: Container(
                      //                 width: 120,
                      //                 padding: const EdgeInsets.all(8.0),
                      //                 decoration: BoxDecoration(
                      //                   color: Colors.red[700],
                      //                   borderRadius: const BorderRadius.only(
                      //                       topLeft: Radius.circular(8),
                      //                       topRight: Radius.circular(8),
                      //                       bottomLeft: Radius.circular(8),
                      //                       bottomRight: Radius.circular(8)),
                      //                 ),
                      //                 child: const Center(
                      //                   child: Text(
                      //                     'SAVE(.PNG)',
                      //                     style: TextStyle(
                      //                       color: Colors.white,
                      //                       fontWeight: FontWeight.bold,
                      //                       fontFamily: FontWeight_.Fonts_T,
                      //                     ),
                      //                   ),
                      //                 )),
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () async {
                            if (Visit_1 == '1' || Visit_1 == null) {
                              capture(chartKey1, chartKey3);
                            } else {
                              capture(chartKey2, chartKey4);
                            }
                          },
                          child: Container(
                              width: 120,
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                color: Colors.green[700],
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    topRight: Radius.circular(8),
                                    bottomLeft: Radius.circular(8),
                                    bottomRight: Radius.circular(8)),
                              ),
                              child: const Center(
                                child: Text(
                                  'พิมพ์',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: FontWeight_.Fonts_T,
                                  ),
                                ),
                              )),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ]))));
  }

  dynamic capture(chartKey01, chartKey02) async {
    final boundary01 =
        chartKey01.currentContext!.findRenderObject() as RenderRepaintBoundary;
    final image01 = await boundary01.toImage(
        pixelRatio: 3.0); // Adjust pixelRatio as needed

    // Convert the captured image to bytes
    final byteData01 = await image01.toByteData(format: ImageByteFormat.png);
    final buffer01 = byteData01!.buffer.asUint8List();
/////////------------------------------->

    Man_ChartReport_GeneratePDF.man_chartReport_GeneratePDF(
        context, buffer01, '', '7');
  }
}

class _Maintenance {
  _Maintenance(this.monts, this.total);

  final String monts;
  final double total;
}
