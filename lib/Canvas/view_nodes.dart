import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:ui';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:infinite_canvas/infinite_canvas.dart';
import 'package:popup_menu_plus/popup_menu_plus.dart';
import 'package:random_color/random_color.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slide_switcher/slide_switcher.dart';

import '../AdminScaffold/AdminScaffold.dart';
import '../Constant/Myconstant.dart';
import '../Model/GetArea_Model.dart';
import '../Model/GetArea_quot.dart';
import '../Model/GetAreax_con_Model.dart';
import '../Model/GetSubZone_Model.dart';
import '../Model/GetZone_Model.dart';
import '../Responsive/responsive.dart';
import '../Style/Translate.dart';
import '../Style/colors.dart';
import '../Style/view_pagenow.dart';
import 'Custom_Painter/CustomPainter_Circle.dart';
import 'Custom_Painter/CustomPainter_Crop.dart';
import 'Custom_Painter/CustomPainter_Crop2.dart';
import 'Custom_Painter/CustomPainter_Drink.dart';
import 'Custom_Painter/CustomPainter_Foods.dart';
import 'Custom_Painter/CustomPainter_Map.dart';
import 'Custom_Painter/CustomPainter_Rectangle.dart';
import 'Custom_Painter/CustomPainter_Shop.dart';
import 'Custom_Painter/CustomPainter_Shop2.dart';
import 'Custom_Painter/CustomPainter_Triangle.dart';
import 'Type_Node.dart';

class NodeDataScreen2 extends StatefulWidget {
  const NodeDataScreen2({
    super.key,
  });

  @override
  State<NodeDataScreen2> createState() => _NodeDataScreen2State();
}

class _NodeDataScreen2State extends State<NodeDataScreen2> {
  String Ser_nowpage = '3';
  late InfiniteCanvasController controller;
  final gridSize = const Size.square(20);
  List<NodeData2> nodeDatas = [];
  List<AreaModel> areaModels = [];
  List<ZoneModel> zoneModels = [];
  List<AreaQuotModel> areaQuotModels = [];
  List<AreaxConModel> areaxConModels = [];
  List<SubZoneModel> subzoneModels = [];
  List<GlobalKey> _btnKeys = [];
  // List<InfiniteCanvasNode> nodess = const [];
  String tappedIndex_ = '';
  String? zone_Subname, zone_name, zone_Subser, zone_ser;
  // int Touch_ = 0;
  // int Create_ = 0;
  final colors = RandomColor();
  @override
  @override
  void initState() {
    super.initState();

    read_GC_zone();
    controller = InfiniteCanvasController(nodes: [], edges: []);
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

      for (var map in result) {
        ZoneModel zoneModel = ZoneModel.fromJson(map);
        var sub = zoneModel.sub_zone;
        setState(() {
          zoneModels.add(zoneModel);
        });
      }
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
      if (zoneModels.length != 0) {
        setState(() {
          zone_ser = zoneModels[0].ser!;
          zone_name = zoneModels[0].zn;
        });
        red_Node_Accessories().then((value) => {red_Node()});

        // red_area();
      }
    } catch (e) {}
  }

  // Future<void> red_area() async {
  //   if (areaModels.isNotEmpty) {
  //     setState(() {
  //       areaModels.clear();
  //     });
  //   }

  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   var ren = preferences.getString('renTalSer');
  //   String url =
  //       '${MyConstant().domain}/GC_area_nodes.php?isAdd=true&ren=${ren}&zser=$zone_ser';

  //   try {
  //     var response = await http.get(Uri.parse(url));
  //     var result = json.decode(response.body);

  //     if (result.toString() != 'null') {
  //       for (var map in result) {
  //         AreaModel areaModelss = AreaModel.fromJson(map);
  //         setState(() {
  //           areaModels.add(areaModelss);
  //         });
  //       }
  //     }
  //   } catch (e) {
  //     print('Error fetching data: $e');
  //   }
  // }

  Future<void> red_Node() async {
    // if (nodeDatas.isNotEmpty) {
    //   setState(() {
    //     nodeDatas.clear();
    //   });
    // }

    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    String url =
        '${MyConstant().domain}/GC_nodes_area.php?isAdd=true&ren=$ren&zser=$zone_ser';

    try {
      var response = await http.get(Uri.parse(url));
      var result = json.decode(response.body);

      if (result.toString() != 'null') {
        for (var map in result) {
          NodeData2 nodeData = NodeData2.fromJson(map);
          AreaModel areaModel = AreaModel.fromJson(map);
          setState(() {
            nodeDatas.add(nodeData);
            areaModels.add(areaModel);
          });
          if (areaModel.quantity != '1' && areaModel.quantity != null) {
            var qin = areaModel.ln_q;
            var qinser = areaModel.ser;
            String url =
                '${MyConstant().domain}/GC_area_quot.php?isAdd=true&ren=$ren&qin=$qin&qinser=$qinser';

            try {
              var response = await http.get(Uri.parse(url));

              var result = json.decode(response.body);
              // print(result);
              if (result != null) {
                for (var map in result) {
                  AreaQuotModel areaQuotModel = AreaQuotModel.fromJson(map);
                  setState(() {
                    areaQuotModels.add(areaQuotModel);
                  });
                }
              }
            } catch (e) {}
          }
        }
        _btnKeys = List.generate(nodeDatas.length, (_) => GlobalKey());

        _updateNodes();
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  Future<void> red_Node_Accessories() async {
    if (nodeDatas.isNotEmpty) {
      setState(() {
        nodeDatas.clear();
      });
    }

    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    String url =
        '${MyConstant().domain}/GC_nodes_area_Accessories.php?isAdd=true&ren=$ren&zser=$zone_ser';

    try {
      var response = await http.get(Uri.parse(url));
      var result = json.decode(response.body);

      if (result.toString() != 'null') {
        for (var map in result) {
          NodeData2 nodeData = NodeData2.fromJson(map);

          setState(() {
            nodeDatas.add(nodeData);
            // areaModels.add(areaModel);
          });
        }
        // _btnKeys = List.generate(nodeDatas.length, (_) => GlobalKey());

        _updateNodes();
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
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

  Dia_log2(context) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) {
          // Timer(Duration(milliseconds: 2400), () {
          //   Navigator.of(context).pop();
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

  DateTime datex = DateTime.now();
  int open_set_date = 30;
  PopupMenu? menu;

  void _updateNodes() {
    final nodes = nodeDatas.map((nodeData) {
      int Index = nodeDatas
          .indexWhere((item) => item.ser.toString() == nodeData.ser.toString());
      print('Index: $Index, NodeData: $nodeData');
      // print('Index --${nodeData.aser}');
      // print(Index);
      // print('-------------------------');
      // final color = Colors.blueGrey[200]!.withOpacity(0.9);
      final color = (nodeData.aser.toString() == '0')
          ? Colors.grey[400]!.withOpacity(0.9)
          : nodeData.quantity == '1'
              ? datex.isAfter(DateTime.parse('${nodeData.ldate} 00:00:00.000')
                          .subtract(Duration(days: open_set_date))) ==
                      true
                  ? Colors.grey.shade700
                  : Colors.red.shade700
              : nodeData.quantity == '2'
                  ? Colors.blue.shade700
                  : nodeData.quantity == '3'
                      ? Colors.purple.shade700
                      : Colors.green.shade700;
      final color_text = Colors.white;
      return InfiniteCanvasNode(
        key: UniqueKey(),
        value: nodeData.ser.toString(),
        // label: nodeData.lncode.toString(),
        allowResize: false,
        allowMove: false,
        offset: Offset(
          double.parse(nodeData.dx.toString()),
          double.parse(nodeData.dy.toString()),
        ),
        size: Size(
          double.parse(nodeData.width.toString()),
          double.parse(nodeData.height.toString()),
        ),
        child: MaterialButton(
          key: _btnKeys[Index],
          onPressed: (nodeData.aser.toString() == '0')
              ? null
              : () {
                  print('Node Size: ${nodeData.cid} ---- ${nodeData.ln}');
                  read_GC_con_area(Index);
                  Future.delayed(const Duration(milliseconds: 400), () {
                    maxColumn(Index, context);
                    menu!.show(widgetKey: _btnKeys[Index]);

                    // TypeNode2(context, color, color_text, nodeData, nodeData.type);
                  });
                },
          child: TypeNode(context, color, color_text, nodeData, nodeData.type),
        ),
      );
    }).toList();

    setState(() {
      controller = InfiniteCanvasController(nodes: nodes, edges: []);
      controller.formatter = (node) {
        node.offset = Offset(
          (node.offset.dx / gridSize.width).roundToDouble() * gridSize.width,
          (node.offset.dy / gridSize.height).roundToDouble() * gridSize.height,
        );
      };
    });
  }

  Future<Null> read_GC_con_area(int index) async {
    if (areaxConModels.length != 0) {
      setState(() {
        areaxConModels.clear();
      });
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var zoneSubSer = preferences.getString('zoneSubSer');
    var zonesSubName = preferences.getString('zonesSubName');
    var ren = preferences.getString('renTalSer');
    var aser = areaModels[index].ser.toString();

    String url =
        '${MyConstant().domain}/GC_areax_con.php?isAdd=true&ren=$ren&aser=$aser';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);
      areaxConModels.clear();
      for (var map in result) {
        AreaxConModel areaxConModel = AreaxConModel.fromJson(map);
        var cid = areaModels[index].cid;
        var cser = areaxConModel.cser;
        setState(() {
          if (cid != cser) {
            areaxConModels.add(areaxConModel);
          }
        });
      }
    } catch (e) {}
  }

  maxColumn(int index, context) {
    menu = PopupMenu(
      context: context,
      // config: const MenuConfig(
      //   type: MenuType.custom,
      //   itemHeight: 200,
      //   itemWidth: 200,
      //   backgroundColor: Colors.green,
      // ),
      config: MenuConfig(
          border: BorderConfig(
            color: Color.fromARGB(255, 56, 56, 56),
          ),
          itemWidth: 300,
          backgroundColor: Color.fromARGB(255, 252, 251, 251).withOpacity(0.95),
          type: MenuType.list,
          lineColor: Colors.greenAccent,
          maxColumn: 10),
      items: [
        if (areaModels[index].quantity == '1' &&
            areaModels[index].docno != null)
          PopUpMenuItem(
              // title:
              //     'เสนอราคา: ${areaModels[index].lncode} (${areaModels[index].ln})',
              // textStyle: const TextStyle(
              //     color: PeopleChaoScreen_Color.Colors_Text2_,
              //     //fontWeight: FontWeight.bold,
              //     fontFamily: Font_.Fonts_T),
              image: InkWell(
                  onTap: () async {
                    // if (renTal_lavel <= 2) {
                    //   menu!.dismiss();
                    //   infomation();
                    // } else {
                    //   SharedPreferences preferences =
                    //       await SharedPreferences.getInstance();
                    //   preferences.setString(
                    //       'zoneSer', areaModels[index].zser.toString());
                    //   preferences.setString(
                    //       'zonesName', areaModels[index].zn.toString());
                    //   setState(() {
                    //     Ser_Body = 1;
                    //     a_ln = areaModels[index].lncode;
                    //     a_ser = areaModels[index].ser;
                    //     a_area = areaModels[index].area;
                    //     a_rent = areaModels[index].rent;
                    //     a_page = '1';
                    //   });
                    //   menu!.dismiss();
                    // }
                    // Navigator.pop(context);
                  },
                  child: Container(
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
                            'เสนอราคา: ${areaModels[index].lncode} (${areaModels[index].ln})',
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: PeopleChaoScreen_Color.Colors_Text2_,
                                //fontWeight: FontWeight.bold,
                                fontFamily: Font_.Fonts_T),
                          ),
                        ),
                        Icon(Iconsax.arrow_circle_right,
                            color: getRandomColor(index)),
                      ],
                    ),
                  ))),
        if (areaModels[index].quantity != '1')
          PopUpMenuItem(
              // title:
              //     'เสนอราคา: ${areaModels[index].lncode} (${areaModels[index].ln})',
              // textStyle: const TextStyle(
              //     color: PeopleChaoScreen_Color.Colors_Text2_,
              //     //fontWeight: FontWeight.bold,
              //     fontFamily: Font_.Fonts_T),
              image: InkWell(
                  onTap: () async {
                    // if (renTal_lavel <= 2) {
                    //   menu!.dismiss();
                    //   infomation();
                    // } else {
                    //   SharedPreferences preferences =
                    //       await SharedPreferences.getInstance();
                    //   preferences.setString(
                    //       'zoneSer', areaModels[index].zser.toString());
                    //   preferences.setString(
                    //       'zonesName', areaModels[index].zn.toString());
                    //   setState(() {
                    //     Ser_Body = 1;
                    //     a_ln = areaModels[index].lncode;
                    //     a_ser = areaModels[index].ser;
                    //     a_area = areaModels[index].area;
                    //     a_rent = areaModels[index].rent;
                    //     a_page = '1';
                    //   });
                    //   menu!.dismiss();
                    // }
                    // Navigator.pop(context);
                  },
                  child: Container(
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
                            'เสนอราคา: ${areaModels[index].lncode} (${areaModels[index].ln})',
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: PeopleChaoScreen_Color.Colors_Text2_,
                                //fontWeight: FontWeight.bold,
                                fontFamily: Font_.Fonts_T),
                          ),
                        ),
                        Icon(Iconsax.arrow_circle_right,
                            color: getRandomColor(index)),
                      ],
                    ),
                  ))),
        if (areaModels[index].quantity == '1' &&
            areaModels[index].cc_date != null &&
            areaModels[index].cc_date.toString() != "0000-00-00")
          PopUpMenuItem(
              // title:
              //     'เสนอราคา: ${areaModels[index].lncode} (${areaModels[index].ln})',
              // textStyle: const TextStyle(
              //     color: PeopleChaoScreen_Color.Colors_Text2_,
              //     //fontWeight: FontWeight.bold,
              //     fontFamily: Font_.Fonts_T),
              image: InkWell(
                  onTap: () async {
                    // if (renTal_lavel <= 2) {
                    //   menu!.dismiss();
                    //   infomation();
                    // } else {
                    //   SharedPreferences preferences =
                    //       await SharedPreferences.getInstance();
                    //   preferences.setString(
                    //       'zoneSer', areaModels[index].zser.toString());
                    //   preferences.setString(
                    //       'zonesName', areaModels[index].zn.toString());
                    //   setState(() {
                    //     Ser_Body = 1;
                    //     a_ln = areaModels[index].lncode;
                    //     a_ser = areaModels[index].ser;
                    //     a_area = areaModels[index].area;
                    //     a_rent = areaModels[index].rent;
                    //     a_page = '1';
                    //   });
                    //   menu!.dismiss();
                    // }
                    // Navigator.pop(context);
                  },
                  child: Container(
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
                            'เสนอราคา: ${areaModels[index].lncode} (${areaModels[index].ln})',
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: PeopleChaoScreen_Color.Colors_Text2_,
                                //fontWeight: FontWeight.bold,
                                fontFamily: Font_.Fonts_T),
                          ),
                        ),
                        Icon(Iconsax.arrow_circle_right,
                            color: getRandomColor(index)),
                      ],
                    ),
                  ))),

////////////-------------------------->
        ///
        if (areaModels[index].quantity != '1')
          PopUpMenuItem(
              // title:
              //     'ทำสัญญา: ${areaModels[index].lncode} (${areaModels[index].ln})',
              // textStyle: const TextStyle(
              //     color: PeopleChaoScreen_Color.Colors_Text2_,
              //     //fontWeight: FontWeight.bold,
              //     fontFamily: Font_.Fonts_T),
              image: InkWell(
                  onTap: () async {
                    // if (renTal_lavel <= 2) {
                    //   menu!.dismiss();
                    //   infomation();
                    // } else {
                    //   SharedPreferences preferences =
                    //       await SharedPreferences.getInstance();
                    //   preferences.setString(
                    //       'zoneSer', areaModels[index].zser.toString());
                    //   preferences.setString(
                    //       'zonesName', areaModels[index].zn.toString());

                    //   setState(() {
                    //     Ser_Body = 2;
                    //     a_ln = areaModels[index].lncode;
                    //     a_ser = areaModels[index].ser;
                    //     a_area = areaModels[index].area;
                    //     a_rent = areaModels[index].rent;
                    //     a_page = '1';
                    //   });
                    //   menu!.dismiss();
                    // }
                    // Navigator.pop(context);
                  },
                  child: Container(
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
                            'ทำสัญญา: ${areaModels[index].lncode} (${areaModels[index].ln})',
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: PeopleChaoScreen_Color.Colors_Text2_,
                                //fontWeight: FontWeight.bold,
                                fontFamily: Font_.Fonts_T),
                          ),
                        ),
                        Icon(Iconsax.arrow_circle_right,
                            color: getRandomColor(index)),
                      ],
                    ),
                  ))),

        if (areaModels[index].quantity == '1' &&
            areaModels[index].cc_date != null &&
            areaModels[index].cc_date.toString() != "0000-00-00")
          PopUpMenuItem(
              // title:
              //     'ทำสัญญา: ${areaModels[index].lncode} (${areaModels[index].ln})',
              // textStyle: const TextStyle(
              //     color: PeopleChaoScreen_Color.Colors_Text2_,
              //     //fontWeight: FontWeight.bold,
              //     fontFamily: Font_.Fonts_T),
              image: InkWell(
                  onTap: () async {
                    // if (renTal_lavel <= 2) {
                    //   menu!.dismiss();
                    //   infomation();
                    // } else {
                    //   SharedPreferences preferences =
                    //       await SharedPreferences.getInstance();
                    //   preferences.setString(
                    //       'zoneSer', areaModels[index].zser.toString());
                    //   preferences.setString(
                    //       'zonesName', areaModels[index].zn.toString());

                    //   setState(() {
                    //     Ser_Body = 2;
                    //     a_ln = areaModels[index].lncode;
                    //     a_ser = areaModels[index].ser;
                    //     a_area = areaModels[index].area;
                    //     a_rent = areaModels[index].rent;
                    //     a_page = '1';
                    //   });
                    //   menu!.dismiss();
                    // }
                    // Navigator.pop(context);
                  },
                  child: Container(
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
                            'ทำสัญญา: ${areaModels[index].lncode} (${areaModels[index].ln})',
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: PeopleChaoScreen_Color.Colors_Text2_,
                                //fontWeight: FontWeight.bold,
                                fontFamily: Font_.Fonts_T),
                          ),
                        ),
                        Icon(Iconsax.arrow_circle_right,
                            color: getRandomColor(index)),
                      ],
                    ),
                  ))),
////////////-------------------------->
        if (areaModels[index].quantity == '1')
          for (int i = 0; i < areaxConModels.length; i++)
            PopUpMenuItem(
                // title: '${areaxConModels[i].cser} (${areaxConModels[i].cname})',
                // textStyle: const TextStyle(
                //     color: PeopleChaoScreen_Color.Colors_Text2_,
                //     //fontWeight: FontWeight.bold,
                //     fontFamily: Font_.Fonts_T),
                image: InkWell(
                    onTap: () async {
                      // if (renTal_lavel <= 2) {
                      //   menu!.dismiss();
                      //   infomation();
                      // } else {
                      //   setState(() {
                      //     Ser_Body = 3;
                      //     Value_stasus = '0';
                      //     Value_cid = areaxConModels[i].cser;
                      //     ser_cidtan = '1';
                      //   });
                      //   menu!.dismiss();
                      // }
                      // Navigator.pop(context);
                    },
                    child: Container(
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
                              '${areaxConModels[i].cser} (${areaxConModels[i].cname})',
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  color: PeopleChaoScreen_Color.Colors_Text2_,
                                  //fontWeight: FontWeight.bold,
                                  fontFamily: Font_.Fonts_T),
                            ),
                          ),
                          Icon(Iconsax.arrow_circle_right,
                              color: getRandomColor(index)),
                        ],
                      ),
                    ))),
        if (areaModels[index].quantity == '1')
          if (areaModels[index].cid != areaModels[index].fid &&
              areaModels[index].con_st_cid == 'สัญญาปัจจุบัน')
            PopUpMenuItem(
                // title:
                //     'เช่าอยู่: ${areaModels[index].cid} (${areaModels[index].cname})',
                // textStyle: const TextStyle(
                //     color: PeopleChaoScreen_Color.Colors_Text2_,
                //     //fontWeight: FontWeight.bold,
                //     fontFamily: Font_.Fonts_T),
                image: InkWell(
                    onTap: () async {
                      // if (renTal_lavel <= 2) {
                      //   menu!.dismiss();
                      //   infomation();
                      // } else {
                      //   setState(() {
                      //     Ser_Body = 3;
                      //     Value_stasus = areaModels[index].quantity == '1'
                      //         ? datex.isAfter(DateTime.parse(
                      //                         '${areaModels[index].ldate} 00:00:00.000')
                      //                     .subtract(const Duration(days: 0))) ==
                      //                 true
                      //             ? 'หมดสัญญา'
                      //             : datex.isAfter(DateTime.parse(
                      //                             '${areaModels[index].ldate} 00:00:00.000')
                      //                         .subtract(Duration(
                      //                             days: open_set_date))) ==
                      //                     true
                      //                 ? 'ใกล้หมดสัญญา'
                      //                 : 'เช่าอยู่'
                      //         : areaModels[index].quantity == '2'
                      //             ? 'เสนอราคา'
                      //             : areaModels[index].quantity == '3'
                      //                 ? 'เสนอราคา(มัดจำ)'
                      //                 : 'ว่าง';
                      //     Value_cid = areaModels[index].fid;
                      //     ser_cidtan = '1';
                      //   });
                      //   menu!.dismiss();
                      // }
                      // Navigator.pop(context);
                    },
                    child: Container(
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
                              'สัญญาเดิม: ${areaModels[index].fid} (${areaModels[index].cname})',
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  color: PeopleChaoScreen_Color.Colors_Text2_,
                                  //fontWeight: FontWeight.bold,
                                  fontFamily: Font_.Fonts_T),
                            ),
                          ),
                          Icon(Iconsax.arrow_circle_right,
                              color: getRandomColor(index)),
                        ],
                      ),
                    ))),
////////////-------------------------->
        if (areaModels[index].quantity == '1')
          PopUpMenuItem(
              // title:
              //     'เช่าอยู่: ${areaModels[index].cid} (${areaModels[index].cname})',
              // textStyle: const TextStyle(
              //     color: PeopleChaoScreen_Color.Colors_Text2_,
              //     //fontWeight: FontWeight.bold,
              //     fontFamily: Font_.Fonts_T),
              image: InkWell(
                  onTap: () async {
                    // if (renTal_lavel <= 2) {
                    //   menu!.dismiss();
                    //   infomation();
                    // } else {
                    //   setState(() {
                    //     Ser_Body = 3;
                    //     Value_stasus = areaModels[index].quantity == '1'
                    //         ? datex.isAfter(DateTime.parse(
                    //                         '${areaModels[index].ldate} 00:00:00.000')
                    //                     .subtract(const Duration(days: 0))) ==
                    //                 true
                    //             ? 'หมดสัญญา'
                    //             : datex.isAfter(DateTime.parse(
                    //                             '${areaModels[index].ldate} 00:00:00.000')
                    //                         .subtract(Duration(
                    //                             days: open_set_date))) ==
                    //                     true
                    //                 ? 'ใกล้หมดสัญญา'
                    //                 : 'เช่าอยู่'
                    //         : areaModels[index].quantity == '2'
                    //             ? 'เสนอราคา'
                    //             : areaModels[index].quantity == '3'
                    //                 ? 'เสนอราคา(มัดจำ)'
                    //                 : 'ว่าง';
                    //     Value_cid = areaModels[index].cid;
                    //     ser_cidtan = '1';
                    //   });
                    //   menu!.dismiss();
                    // }
                    // Navigator.pop(context);
                  },
                  child: Container(
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
                            areaModels[index].scfid == 'N'
                                ? 'N: ${areaModels[index].cid} (${areaModels[index].cname})'
                                : 'เช่าอยู่: ${areaModels[index].cid} (${areaModels[index].cname})',
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: PeopleChaoScreen_Color.Colors_Text2_,
                                //fontWeight: FontWeight.bold,
                                fontFamily: Font_.Fonts_T),
                          ),
                        ),
                        Icon(Iconsax.arrow_circle_right,
                            color: getRandomColor(index)),
                      ],
                    ),
                  ))),

////////////-------------------------->
        if (areaModels[index].quantity == '1')
          PopUpMenuItem(
              // title:
              //     'รับชำระ: ${areaModels[index].cid} (${areaModels[index].cname})',
              // textStyle: const TextStyle(
              //     color: PeopleChaoScreen_Color.Colors_Text2_,
              //     //fontWeight: FontWeight.bold,
              //     fontFamily: Font_.Fonts_T),
              image: InkWell(
                  onTap: () async {
                    // if (renTal_lavel <= 2) {
                    //   menu!.dismiss();
                    //   infomation();
                    // } else {
                    //   setState(() {
                    //     Value_stasus = areaModels[index].quantity == '1'
                    //         ? datex.isAfter(DateTime.parse(
                    //                         '${areaModels[index].ldate} 00:00:00.000')
                    //                     .subtract(const Duration(days: 0))) ==
                    //                 true
                    //             ? 'หมดสัญญา'
                    //             : datex.isAfter(DateTime.parse(
                    //                             '${areaModels[index].ldate} 00:00:00.000')
                    //                         .subtract(Duration(
                    //                             days: open_set_date))) ==
                    //                     true
                    //                 ? 'ใกล้หมดสัญญา'
                    //                 : 'เช่าอยู่'
                    //         : areaModels[index].quantity == '2'
                    //             ? 'เสนอราคา'
                    //             : areaModels[index].quantity == '3'
                    //                 ? 'เสนอราคา(มัดจำ)'
                    //                 : 'ว่าง';
                    //     Ser_Body = 4;
                    //     Value_cid = areaModels[index].cid;
                    //     ser_cidtan = '1';
                    //   });
                    //   menu!.dismiss();
                    // }
                    // Navigator.pop(context);
                  },
                  child: Container(
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
                            areaModels[index].scfid == 'N'
                                ? 'N: ${areaModels[index].cid} (${areaModels[index].cname})'
                                : 'รับชำระ: ${areaModels[index].cid} (${areaModels[index].cname})',
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: PeopleChaoScreen_Color.Colors_Text2_,
                                //fontWeight: FontWeight.bold,
                                fontFamily: Font_.Fonts_T),
                          ),
                        ),
                        Icon(Iconsax.arrow_circle_right,
                            color: getRandomColor(index)),
                      ],
                    ),
                  ))),
        ////////////-------------------------->
        if (areaModels[index].quantity == '2')
          for (int i = 0; i < areaQuotModels.length; i++)
            if (areaQuotModels[i]
                    .ln_q!
                    .contains(areaModels[index].lncode.toString()) ==
                true)
              PopUpMenuItem(
                  // title: 'เสนอราคา: ${areaQuotModels[i].docno}',
                  // textStyle: const TextStyle(
                  //     color: PeopleChaoScreen_Color.Colors_Text2_,
                  //     //fontWeight: FontWeight.bold,
                  //     fontFamily: Font_.Fonts_T),
                  image: InkWell(
                      onTap: () async {
                        // if (renTal_lavel <= 2) {
                        //   menu!.dismiss();
                        //   infomation();
                        // } else {
                        //   setState(() {
                        //     Ser_Body = 3;
                        //     Value_stasus = '1';
                        //     Value_cid = areaQuotModels[i].docno;
                        //     ser_cidtan = '2';
                        //   });
                        //   menu!.dismiss();
                        // }
                        // Navigator.pop(context);
                      },
                      child: Container(
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
                                'เสนอราคา: ${areaQuotModels[i].docno}',
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    color: PeopleChaoScreen_Color.Colors_Text2_,
                                    //fontWeight: FontWeight.bold,
                                    fontFamily: Font_.Fonts_T),
                              ),
                            ),
                            Icon(Iconsax.arrow_circle_right,
                                color: getRandomColor(index)),
                          ],
                        ),
                      ))),
        ////////////-------------------------->
        if (areaModels[index].quantity == '3')
          // for (int i = 0; i < areaQuotModels.length; i++)
          for (int i = 0; i < areaQuotModels.length; i++)
            if (areaQuotModels[i]
                    .ln_q!
                    .contains(areaModels[index].lncode.toString()) ==
                true)
              PopUpMenuItem(
                  // title: 'เสนอราคา: (มัดจำ) ${areaQuotModels[i].docno}',
                  // textStyle: const TextStyle(
                  //     color: PeopleChaoScreen_Color.Colors_Text2_,
                  //     //fontWeight: FontWeight.bold,
                  //     fontFamily: Font_.Fonts_T),
                  image: InkWell(
                      onTap: () async {
                        // if (renTal_lavel <= 2) {
                        //   menu!.dismiss();
                        //   infomation();
                        // } else {
                        //   setState(() {
                        //     Ser_Body = 3;
                        //     Value_stasus = '1';
                        //     Value_cid = areaQuotModels[i].docno;
                        //     ser_cidtan = '2';
                        //   });
                        //   menu!.dismiss();
                        // }
                        // Navigator.pop(context);
                      },
                      child: Container(
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
                                'เสนอราคา: (มัดจำ) ${areaQuotModels[i].docno}',
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    color: PeopleChaoScreen_Color.Colors_Text2_,
                                    //fontWeight: FontWeight.bold,
                                    fontFamily: Font_.Fonts_T),
                              ),
                            ),
                            Icon(Iconsax.arrow_circle_right,
                                color: getRandomColor(index)),
                          ],
                        ),
                      ))),

        if (areaModels[index].quantity == '1' && areaModels[index].cfid != null)
          PopUpMenuItem(
              // title:
              //     'เช่าอยู่: ${areaModels[index].cid} (${areaModels[index].cname})',
              // textStyle: const TextStyle(
              //     color: PeopleChaoScreen_Color.Colors_Text2_,
              //     //fontWeight: FontWeight.bold,
              //     fontFamily: Font_.Fonts_T),
              image: InkWell(
                  onTap: () async {
                    // if (renTal_lavel <= 2) {
                    //   menu!.dismiss();
                    //   infomation();
                    // } else {
                    //   setState(() {
                    //     Ser_Body = 3;
                    //     Value_stasus = areaModels[index].quantity == '1'
                    //         ? datex.isAfter(DateTime.parse(
                    //                         '${areaModels[index].ldate} 00:00:00.000')
                    //                     .subtract(const Duration(days: 0))) ==
                    //                 true
                    //             ? 'หมดสัญญา'
                    //             : datex.isAfter(DateTime.parse(
                    //                             '${areaModels[index].ldate} 00:00:00.000')
                    //                         .subtract(Duration(
                    //                             days: open_set_date))) ==
                    //                     true
                    //                 ? 'ใกล้หมดสัญญา'
                    //                 : 'เช่าอยู่'
                    //         : areaModels[index].quantity == '2'
                    //             ? 'เสนอราคา'
                    //             : areaModels[index].quantity == '3'
                    //                 ? 'เสนอราคา(มัดจำ)'
                    //                 : 'ว่าง';
                    //     Value_cid = areaModels[index].cfid;
                    //     ser_cidtan = '1';
                    //   });
                    //   menu!.dismiss();
                    // }
                    // Navigator.pop(context);
                  },
                  child: Container(
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
                            'เช่าอยู่: ${areaModels[index].cfid}',
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: PeopleChaoScreen_Color.Colors_Text2_,
                                //fontWeight: FontWeight.bold,
                                fontFamily: Font_.Fonts_T),
                          ),
                        ),
                        Icon(Iconsax.arrow_circle_right,
                            color: getRandomColor(index)),
                      ],
                    ),
                  ))),
      ],
    );
  }

  Color getRandomColor(index) {
    final random = Random();
    return areaModels[index].quantity == '1'
        ? datex.isAfter(
                    DateTime.parse('${areaModels[index].ldate} 00:00:00.000')
                        .subtract(Duration(days: open_set_date))) ==
                true
            ? Colors.grey.shade700
            : Colors.red.shade700
        : areaModels[index].quantity == '2'
            ? Colors.blue.shade700
            : areaModels[index].quantity == '3'
                ? Colors.purple.shade700
                : Colors.green.shade700;
  }

  Offset _canvasOffset = Offset.zero;
  Offset _startOffset = Offset.zero;

///////////--------------------------------------->
  @override
  Widget build(BuildContext context) {
    const inset = 2.0;
    return controller == null
        ? const Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
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
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  AutoSizeText(
                                    'บัญชี ',
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
                                    ' > >',
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
                      child: viewpage(context, '$Ser_nowpage'),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                  child: ScrollConfiguration(
                    behavior:
                        ScrollConfiguration.of(context).copyWith(dragDevices: {
                      PointerDeviceKind.touch,
                      PointerDeviceKind.mouse,
                    }),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 27, 26, 39),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10)),
                              border: Border.all(color: Colors.grey, width: 1),
                            ),
                            width: (Responsive.isDesktop(context))
                                ? MediaQuery.of(context).size.width / 1.18
                                : 1200,
                            // width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.85,
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: InkWell(
                                      onTap: () {},
                                      child: SlideSwitcher(
                                        containerBorderRadius: 10,
                                        initialIndex: 3,
                                        onSelect: (index) async {
                                          if (index == 3) {
                                          } else {
                                            SharedPreferences preferences =
                                                await SharedPreferences
                                                    .getInstance();

                                            String? _route =
                                                preferences.getString('route');

                                            MaterialPageRoute route =
                                                MaterialPageRoute(
                                              builder: (context) =>
                                                  AdminScafScreen(
                                                      route: _route),
                                            );
                                            Navigator.pushAndRemoveUntil(
                                                context,
                                                route,
                                                (route) => false);
                                          }
                                        },
                                        containerHeight: 40,
                                        containerWight: 130,
                                        containerColor: Colors.grey,
                                        children: [
                                          Icon(
                                            Icons.grid_view_rounded,
                                            color: Colors.black,
                                          ),
                                          Icon(
                                            Icons.calendar_month_rounded,
                                            color: Colors.black,
                                          ),
                                          Icon(
                                            Icons.list,
                                            color: Colors.black,
                                          ),
                                          Icon(
                                            Icons.map_outlined,
                                            color: Colors.blue[900],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  // Padding(
                                  //   padding: const EdgeInsets.all(8.0),
                                  //   child: InkWell(
                                  //     onTap: () {},
                                  //     child: SizedBox(
                                  //       height: 30,
                                  //       child: SlideSwitcher(
                                  //         containerBorderRadius: 10,
                                  //         initialIndex: 2,
                                  //         onSelect: (index) async {
                                  //           // if (index + 1 == 1 ||
                                  //           //     index + 1 == 2) {
                                  //           //   widget.updateMessage(
                                  //           //       '1', '', 'PeopleChaoScreen');
                                  //           // } else {}
                                  //         },
                                  //         containerHeight: 40,
                                  //         containerWight: 100,
                                  //         containerColor: Colors.grey,
                                  //         children: [
                                  //           const Icon(
                                  //             Icons.list,
                                  //             color: Colors.black,
                                  //           ),
                                  //           const Icon(
                                  //             Icons.grid_view_rounded,
                                  //             color: Colors.black,
                                  //           ),
                                  //           Icon(
                                  //             Icons.map_outlined,
                                  //             color: Colors.blue[900],
                                  //           )
                                  //         ],
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(8, 8, 8, 0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 27, 26, 39),
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10)),
                                      border: Border.all(
                                          color: Colors.grey, width: 1),
                                    ),
                                    width: MediaQuery.of(context).size.width,
                                    height: 40,
                                    padding: const EdgeInsets.all(4.0),
                                    child: Row(
                                      children: [
                                        InkWell(
                                          onTap: () async {
                                            setState(() {
                                              if (tappedIndex_ == 'Touch') {
                                                tappedIndex_ = '';
                                              } else {
                                                tappedIndex_ = 'Touch';
                                              }
                                            });
                                          },
                                          child: Container(
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.touch_app,
                                                  color:
                                                      (tappedIndex_ == 'Touch')
                                                          ? Colors.blue
                                                          : Colors.white,
                                                ),
                                                Translate.TranslateAndSetText(
                                                    'สัมผัส',
                                                    (tappedIndex_ == 'Touch')
                                                        ? Colors.blue
                                                        : Colors.white,
                                                    TextAlign.center,
                                                    FontWeight.bold,
                                                    FontWeight_.Fonts_T,
                                                    14,
                                                    1),
                                                // Text(
                                                //   ' Touch ',
                                                //   style: TextStyle(
                                                //       color:
                                                //(tappedIndex_ == 'Touch')
                                                //           ? Colors.blue
                                                //           : Colors.white,
                                                //       fontFamily: Font_.Fonts_T),
                                                // ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 30,
                                          width: 1,
                                          color: Colors.grey.withOpacity(0.5),
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 24),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            controller.zoomIn();
                                          },
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.zoom_in,
                                                color: Colors.white,
                                                size: 18,
                                              ),
                                              Translate.TranslateAndSetText(
                                                  'ซูมเข้า',
                                                  Colors.white,
                                                  TextAlign.center,
                                                  FontWeight.bold,
                                                  FontWeight_.Fonts_T,
                                                  14,
                                                  1),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          height: 30,
                                          width: 1,
                                          color: Colors.grey.withOpacity(0.5),
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 24),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            controller.zoomOut();
                                          },
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.zoom_in,
                                                color: Colors.white,
                                                size: 18,
                                              ),
                                              Translate.TranslateAndSetText(
                                                  'ซูมออก',
                                                  Colors.white,
                                                  TextAlign.center,
                                                  FontWeight.bold,
                                                  FontWeight_.Fonts_T,
                                                  14,
                                                  1),
                                            ],
                                          ),
                                        ),
                                        Spacer(),
                                        Padding(
                                          padding: EdgeInsets.all(4.0),
                                          child: Translate.TranslateAndSetText(
                                              ' โซน ',
                                              Colors.white,
                                              TextAlign.center,
                                              FontWeight.bold,
                                              Font_.Fonts_T,
                                              14,
                                              1),
                                          // Text(
                                          //   'โซน : ',
                                          //   style: TextStyle(
                                          //       color: Colors.white,
                                          //       fontFamily: Font_.Fonts_T),
                                          // ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            color:
                                                Color.fromARGB(255, 56, 55, 70),
                                            borderRadius: const BorderRadius
                                                    .only(
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(10),
                                                bottomLeft: Radius.circular(10),
                                                bottomRight:
                                                    Radius.circular(10)),
                                            border: Border.all(
                                                color: Colors.white,
                                                width: 0.5),
                                          ),
                                          width: 200,
                                          child: DropdownButtonFormField2(
                                            decoration: InputDecoration(
                                              isDense: true,
                                              contentPadding: EdgeInsets.zero,
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                            ),
                                            isExpanded: true,
                                            hint: Text(
                                              zone_name == null
                                                  ? 'ทั้งหมด'
                                                  : '$zone_name',
                                              maxLines: 1,
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.white,
                                                  fontFamily: Font_.Fonts_T),
                                            ),
                                            icon: const Icon(
                                              Icons.arrow_drop_down,
                                              color: Colors.white,
                                            ),
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontFamily: Font_.Fonts_T),
                                            iconSize: 30,
                                            buttonHeight: 40,
                                            // buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                                            dropdownDecoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            items: zoneModels
                                                .map((item) =>
                                                    DropdownMenuItem<String>(
                                                      value:
                                                          '${item.ser},${item.zn}',
                                                      child: Text(
                                                        item.zn!,
                                                        style: const TextStyle(
                                                            fontSize: 14,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    145,
                                                                    144,
                                                                    144),
                                                            fontFamily:
                                                                Font_.Fonts_T),
                                                      ),
                                                    ))
                                                .toList(),

                                            onChanged: (value) async {
                                              var zones = value!.indexOf(',');
                                              var zoneSer =
                                                  value.substring(0, zones);
                                              var zonesName =
                                                  value.substring(zones + 1);
                                              setState(() {
                                                controller =
                                                    InfiniteCanvasController(
                                                        nodes: [], edges: []);
                                                zone_ser = zoneSer.toString();
                                                zone_name =
                                                    zonesName.toString();
                                              });
                                              red_Node();
                                              // red_area();
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  // flex: 3,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Listener(
                                      onPointerDown: (tappedIndex_ != 'Touch')
                                          ? null
                                          : (details) {
                                              controller.mouseDown = true;
                                              controller.checkSelection(
                                                  details.localPosition);

                                              _startOffset = details.position;
                                            },
                                      onPointerMove: (tappedIndex_ != 'Touch')
                                          ? null
                                          : (details) {
                                              if (controller.mouseDown) {
                                                controller.pan(details.delta);
                                              }
                                            },
                                      onPointerUp: (tappedIndex_ != 'Touch')
                                          ? null
                                          : (details) {
                                              controller.mouseDown = false;
                                            },
                                      onPointerCancel: (tappedIndex_ != 'Touch')
                                          ? null
                                          : (details) {
                                              controller.mouseDown = false;
                                            },
                                      child: InfiniteCanvas(
                                        menuVisible: false,
                                        drawVisibleOnly: false,
                                        canAddEdges: false,
                                        controller: controller,
                                        backgroundBuilder: (context, rect) {
                                          return Container(
                                            width: 300,
                                            height: 300,
                                            decoration: BoxDecoration(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(10),
                                                  topRight: Radius.circular(10),
                                                  bottomLeft:
                                                      Radius.circular(10),
                                                  bottomRight:
                                                      Radius.circular(10)),
                                              border: Border.all(
                                                  color: Colors.grey, width: 1),
                                            ),
                                            child: CustomPaint(
                                              size: rect.size,
                                              painter: GridPainter(
                                                  gridSize: gridSize),
                                            ),
                                          );
                                        },
                                        // gridSize: gridSize,
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
                ),
              ],
            ),
          );
  }

  String _text = '';
  TypeNode2(context, color, color_text, nodeData, type) {
    DateTime datex = DateTime.now();

    return showDialog(
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
                  '${nodeData.ln}',
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
                    // int index_ = int.parse(details.resource!.id.toString());

                    // setState(() {
                    //   Ser_Body = 1;
                    //   a_ln = areaModels[index_].lncode;
                    //   a_ser = areaModels[index_].ser;
                    //   a_area = areaModels[index_].area;
                    //   a_rent = areaModels[index_].rent;
                    //   a_page = '1';
                    // });
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
                            'เสนอราคา: ${nodeData.ln} ',
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
                    // int index_ = int.parse(details.resource!.id.toString());

                    // setState(() {
                    //   Ser_Body = 2;
                    //   a_ln = areaModels[index_].lncode;
                    //   a_ser = areaModels[index_].ser;
                    //   a_area = areaModels[index_].area;
                    //   a_rent = areaModels[index_].rent;
                    //   a_page = '1';
                    // });
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
                            'ทำสัญญา: ${nodeData.ln}',
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
          );
        });
  }
}

class InlineCustomPainter extends CustomPainter {
  const InlineCustomPainter({
    required this.brush,
    required this.builder,
    this.isAntiAlias = true,
  });
  final Paint brush;
  final bool isAntiAlias;
  final void Function(Paint paint, Canvas canvas, Rect rect) builder;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    brush.isAntiAlias = isAntiAlias;
    canvas.save();
    builder(brush, canvas, rect);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class NodeData {
  final String label;
  final Offset offset;
  final Size size;
  final int color; // Use int for color value

  NodeData({
    required this.label,
    required this.offset,
    required this.size,
    required this.color,
  });

  Map<String, dynamic> toJson() => {
        'label': label,
        'offset': {'dx': offset.dx, 'dy': offset.dy},
        'size': {'width': size.width, 'height': size.height},
        'color': color,
      };

  static NodeData fromJson(Map<String, dynamic> json) {
    return NodeData(
      label: json['label'],
      offset: Offset(json['offset']['dx'], json['offset']['dy']),
      size: Size(json['size']['width'], json['size']['height']),
      color: json['color'],
    );
  }

  @override
  String toString() {
    return 'NodeData(label: $label, offset: $offset, size: $size, color: $color)';
  }
}

class GridPainter extends CustomPainter {
  final Size gridSize;
  GridPainter({required this.gridSize});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey[300]!
      ..strokeWidth = 1;

    for (double x = 0; x < size.width; x += gridSize.width) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }

    for (double y = 0; y < size.height; y += gridSize.height) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class NodeData2 {
  String? ser;
  String? user;
  String? datex;
  String? timex;
  String? zser;
  String? aser;
  String? lncode;
  String? ln;
  String? offset;
  String? size;
  String? color;
  String? st;
  String? dx;
  String? dy;
  String? width;
  String? height;
  String? type;

  String? data_update;
  String? custno;
  String? dtype;
  String? date;
  String? total;
  String? refno;

  String? no;
  String? sname;
  String? zn;

  String? ln_c;
  String? in_docno;
  String? docno;
  String? ser_docno;
  String? quantity;
  String? id;
  String? path;

  String? name;
  String? ser_area;
  String? cid;
  String? ldate;

  NodeData2(
      {this.ser,
      this.user,
      this.datex,
      this.timex,
      this.zser,
      this.aser,
      this.lncode,
      this.ln,
      this.offset,
      this.size,
      this.color,
      this.st,
      this.dx,
      this.dy,
      this.width,
      this.height,
      this.type,
      this.data_update,
      this.custno,
      this.dtype,
      this.date,
      this.total,
      this.refno,
      this.no,
      this.sname,
      this.zn,
      this.ln_c,
      this.in_docno,
      this.docno,
      this.ser_docno,
      this.quantity,
      this.id,
      this.path,
      this.name,
      this.ser_area,
      this.cid,
      this.ldate});

  NodeData2.fromJson(Map<String, dynamic> json) {
    ser = json['ser'];
    user = json['user'];
    datex = json['datex'];
    timex = json['timex'];
    zser = json['zser'];
    aser = json['aser'];
    lncode = json['lncode'];
    ln = json['ln'];
    offset = json['offset'];
    size = json['size'];
    color = json['color'];
    st = json['st'];
    dx = json['dx'];
    dy = json['dy'];
    width = json['width'];
    height = json['height'];
    type = json['type'];
    data_update = json['data_update'];

    custno = json['custno'];
    dtype = json['dtype'];
    date = json['date'];
    total = json['total'];
    refno = json['refno'];

    no = json['no'];
    sname = json['sname'];
    zn = json['zn'];

    ln_c = json['ln_c'];
    in_docno = json['in_docno'];
    docno = json['docno'];
    ser_docno = json['ser_docno'];
    quantity = json['quantity'];
    id = json['id'];
    path = json['path'];

    name = json['name'];
    ser_area = json['ser_area'];
    cid = json['cid'];
    ldate = json['ldate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ser'] = this.ser;
    data['user'] = this.user;
    data['datex'] = this.datex;
    data['timex'] = this.timex;
    data['zser'] = this.zser;
    data['aser'] = this.aser;
    data['lncode'] = this.lncode;
    data['ln'] = this.ln;
    data['offset'] = this.offset;
    data['size'] = this.size;
    data['color'] = this.color;
    data['st'] = this.st;
    data['dx'] = this.dx;
    data['dy'] = this.dy;
    data['width'] = this.width;
    data['height'] = this.height;
    data['type'] = this.type;
    data['data_update'] = this.data_update;
    data['custno'] = this.custno;
    data['dtype'] = this.dtype;
    data['date'] = this.date;
    data['total'] = this.total;
    data['refno'] = this.refno;

    data['no'] = this.no;
    data['sname'] = this.sname;
    data['zn'] = this.zn;

    data['ln_c'] = this.ln_c;
    data['in_docno'] = this.in_docno;
    data['docno'] = this.docno;
    data['ser_docno'] = this.ser_docno;
    data['quantity'] = this.quantity;
    data['id'] = this.id;
    data['path'] = this.path;

    data['name'] = this.name;
    data['ser_area'] = this.ser_area;
    data['cid'] = this.cid;
    data['ldate'] = this.ldate;
    return data;
  }
}
