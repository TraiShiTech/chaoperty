import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:ui';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:infinite_canvas/infinite_canvas.dart';
import 'package:random_color/random_color.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../AdminScaffold/AdminScaffold.dart';
import '../Constant/Myconstant.dart';
import '../Model/GetArea_Model.dart';
import '../Model/GetSubZone_Model.dart';
import '../Model/GetZone_Model.dart';
import '../Responsive/responsive.dart';
import '../Style/Translate.dart';
import '../Style/colors.dart';
import 'Custom_Painter/CustomPainter_Circle.dart';
import 'Custom_Painter/CustomPainter_Crop.dart';
import 'Custom_Painter/CustomPainter_Crop10.dart';
import 'Custom_Painter/CustomPainter_Crop2.dart';
import 'Custom_Painter/CustomPainter_Crop3.dart';
import 'Custom_Painter/CustomPainter_Crop4.dart';
import 'Custom_Painter/CustomPainter_Crop5.dart';
import 'Custom_Painter/CustomPainter_Crop6.dart';
import 'Custom_Painter/CustomPainter_Crop7.dart';
import 'Custom_Painter/CustomPainter_Crop8.dart';
import 'Custom_Painter/CustomPainter_Crop9.dart';
import 'Custom_Painter/CustomPainter_Drink.dart';
import 'Custom_Painter/CustomPainter_Foods.dart';
import 'Custom_Painter/CustomPainter_Map.dart';
import 'Custom_Painter/CustomPainter_Rectangle.dart';
import 'Custom_Painter/CustomPainter_Road1.dart';
import 'Custom_Painter/CustomPainter_Road2.dart';
import 'Custom_Painter/CustomPainter_Road3.dart';
import 'Custom_Painter/CustomPainter_Road4.dart';
import 'Custom_Painter/CustomPainter_Road5.dart';
import 'Custom_Painter/CustomPainter_Road6.dart';
import 'Custom_Painter/CustomPainter_Shop.dart';
import 'Custom_Painter/CustomPainter_Shop2.dart';
import 'Custom_Painter/CustomPainter_Triangle.dart';
import 'Type_Node.dart';

class GeneratedNodes extends StatefulWidget {
  const GeneratedNodes({super.key});

  @override
  State<GeneratedNodes> createState() => _GeneratedNodesState();
}

class _GeneratedNodesState extends State<GeneratedNodes> {
  late InfiniteCanvasController controller;
  final gridSize = const Size.square(20);
  List<NodeData2> nodeDatas = [];
  List<AreaModel> areaModels = [];
  List<ZoneModel> zoneModels = [];
  List<SubZoneModel> subzoneModels = [];
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
        red_Trans_Kon();
        red_area();
      }
    } catch (e) {}
  }

  Future<void> red_area() async {
    if (areaModels.isNotEmpty) {
      setState(() {
        areaModels.clear();
      });
    }

    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    String url =
        '${MyConstant().domain}/GC_area_nodes.php?isAdd=true&ren=${ren}&zser=$zone_ser';

    try {
      var response = await http.get(Uri.parse(url));
      var result = json.decode(response.body);

      if (result.toString() != 'null') {
        for (var map in result) {
          AreaModel areaModelss = AreaModel.fromJson(map);
          setState(() {
            areaModels.add(areaModelss);
          });
        }
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  Future<void> red_Trans_Kon() async {
    if (nodeDatas.isNotEmpty) {
      setState(() {
        nodeDatas.clear();
      });
    }

    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    String url =
        '${MyConstant().domain}/GC_nodes_area_Setting.php?isAdd=true&ren=$ren&zser=$zone_ser';

    try {
      var response = await http.get(Uri.parse(url));
      var result = json.decode(response.body);

      if (result.toString() != 'null') {
        for (var map in result) {
          NodeData2 nodeData = NodeData2.fromJson(map);
          setState(() {
            nodeDatas.add(nodeData);
          });
        }
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

  void _updateNodes() {
    final nodes = nodeDatas.map((nodeData) {
      final color = (nodeData.aser.toString() == '0')
          ? Colors.grey[400]!.withOpacity(0.9)
          : Colors.blueGrey[200]!.withOpacity(0.9);
      final color_text = Colors.white;
      return InfiniteCanvasNode(
        key: UniqueKey(),
        value: nodeData.ser.toString(),
        // label: nodeData.lncode.toString(),
        allowResize: true,
        offset: Offset(
          double.parse(nodeData.dx.toString()),
          double.parse(nodeData.dy.toString()),
        ),
        size: Size(
          double.parse(nodeData.width.toString()),
          double.parse(nodeData.height.toString()),
        ),
        child: PopupMenuButton(
          color: Colors.white.withOpacity(0.9),
          child: TypeNode(context, color, color_text, nodeData, nodeData.type),
          tooltip: '${nodeData.ln}(${nodeData.lncode})',
          itemBuilder: (BuildContext context) => [
            PopupMenuItem(
              height: 20,
              padding: EdgeInsets.all(3),
              onTap: () async {
                UPDATE_Nodes(nodeData.zser, nodeData.ser);
                // Navigator.pop(context);
              },
              child: Row(
                children: [
                  Icon(
                    Icons.save_as_sharp,
                    color: Colors.green[900],
                    size: 18,
                  ),
                  Translate.TranslateAndSetText(' บันทึก ', Colors.black,
                      TextAlign.center, FontWeight.bold, Font_.Fonts_T, 12, 1),
                  // Text(
                  //   ' Save',
                  //   style: TextStyle(
                  //       fontSize: 12,
                  //       color: PeopleChaoScreen_Color.Colors_Text1_,
                  //       fontWeight: FontWeight.w700,
                  //       fontFamily: Font_.Fonts_T),
                  // ),
                ],
              ),
            ),
            PopupMenuItem(
              height: 20,
              padding: EdgeInsets.all(3),
              onTap: () async {
                DELETE_Nodes(nodeData.zser, nodeData.ser);
                // Navigator.pop(context);
              },
              child: Row(
                children: [
                  Icon(
                    Icons.delete,
                    color: Colors.red[900],
                    size: 18,
                  ),
                  Translate.TranslateAndSetText(' ลบ ', Colors.black,
                      TextAlign.center, FontWeight.bold, Font_.Fonts_T, 12, 1),
                  // Text(
                  //   ' Remove',
                  //   style: TextStyle(
                  //       fontSize: 12,
                  //       color: PeopleChaoScreen_Color.Colors_Text1_,
                  //       fontWeight: FontWeight.w700,
                  //       fontFamily: Font_.Fonts_T),
                  // ),
                ],
              ),
            ),
          ],
        ),
        // InkWell(
        //     onTap: () {
        //       for (var node
        //           in controller.nodes.where((node) => node.value == '1')) {
        //         // print('Node Position: ${node.offset}');
        //         print('Node Size: ${node.value} ---- ${node.offset}');
        //       }
        //     },
        //     child: TypeNode(context, color, nodeData, nodeData.type)),
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

// gridSize.width).roundToDouble() * gridSize.width,
//           (node.offset.dy / gridSize.height)
  Future<void> INSERT_Nodes(node, zser, aser, type) async {
    var nodeData = NodeData2(
      zser: zser.toString(),
      aser: aser.toString(),
      ln: node.label.toString(),
      lncode: node.label.toString(),
      size: node.size.toString(),
      offset: node.offset.toString(),
      dx: node.offset.dx.toString(),
      dy: node.offset.dy.toString(),
      width: node.size.width.toString(),
      height: node.size.height.toString(),
      color: '0xFF000000',
      type: '${type}',
    );
    print(nodeData.zser);
    print(nodeData.aser);
    print(nodeData.ln);
    print(nodeData.lncode);
    print(nodeData.offset);
    print(nodeData.dx);
    print(nodeData.dy);
    print(nodeData.size);
    print(nodeData.width);
    print(nodeData.height);
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    String? ser_user = preferences.getString('ser');
    try {
      String url = '${MyConstant().domain}/In_node.php?isAdd=true&ren=$ren';

      final response = await http.post(
        Uri.parse(url),
        body: {
          'zser': nodeData.zser.toString(),
          'aser': nodeData.aser.toString(),
          'ln': (aser.toString() == '0') ? type : nodeData.ln.toString(),
          'lncode':
              (aser.toString() == '0') ? type : nodeData.lncode.toString(),
          'offset': nodeData.offset.toString(),
          'size': nodeData.size.toString(),
          'color': nodeData.color.toString(),
          'dx': nodeData.dx.toString(),
          'dy': nodeData.dy.toString(),
          'width': nodeData.width.toString(),
          'height': nodeData.height.toString(),
          'ser_user': ser_user.toString(),
          'type': type.toString()
        },
      );
      // print('Response status: ${response.statusCode}');
      // print('Response body: ${response.body}');
      var result = json.decode(response.body);
      if (result.toString() == 'true') {
        print('Node saved successfully');
        setState(() {
          controller = InfiniteCanvasController(nodes: [], edges: []);
        });
        red_area();
        red_Trans_Kon();
      } else {
        print('Failed to save node');
      }
    } catch (e) {
      print('Error saving node to server: $e');
    }
  }

  Future<void> UPDATE_Nodes(zser, aser) async {
    int Index = await controller.nodes.indexWhere((item) => item.value == aser);
    Dia_log();
    // print(controller.nodes[Index].size);

    // print(nodeDatas[Index].lncode);

    var nodeData = NodeData2(
      zser: zser.toString(),
      aser: aser.toString(),
      ln: '',
      lncode: '',
      size: controller.nodes[Index].size.toString(),
      offset: controller.nodes[Index].offset.toString(),
      dx: controller.nodes[Index].offset.dx.toString(),
      dy: controller.nodes[Index].offset.dy.toString(),
      width: controller.nodes[Index].size.width.toString(),
      height: controller.nodes[Index].size.height.toString(),
      color: '0xFF000000',
    );
    print(nodeData.ser);
    print(nodeData.aser);
    print(nodeData.ln);
    print(nodeData.lncode);
    print(nodeData.offset);
    print(nodeData.dx);
    print(nodeData.dy);
    print(nodeData.size);
    print(nodeData.width);
    print(nodeData.height);
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    String? ser_user = preferences.getString('ser');
    try {
      String url = '${MyConstant().domain}/UP_node.php?isAdd=true&ren=$ren';

      final response = await http.post(
        Uri.parse(url),
        body: {
          'ser': aser.toString(),
          'offset': nodeData.offset.toString(),
          'size': nodeData.size.toString(),
          'color': nodeData.color.toString(),
          'dx': nodeData.dx.toString(),
          'dy': nodeData.dy.toString(),
          'width': nodeData.width.toString(),
          'height': nodeData.height.toString(),
          'ser_user': ser_user.toString()
        },
      );

      var result = json.decode(response.body);
      if (result.toString() == 'true') {
        print('UPDATE_Nodes saved successfully');
        setState(() {
          controller = InfiniteCanvasController(nodes: [], edges: []);
        });
        red_area();
        red_Trans_Kon();
      } else {
        print('Failed to save node');
      }
    } catch (e) {
      print('Error saving node to server: $e');
    }
  }

  Future<void> UPDATE_NodesAll(context) async {
    Dia_log2(context);
    int i = 0;
    for (var node in controller.nodes) {
      int Index = await nodeDatas.indexWhere((item) => item.ser == node.value);

      // print(controller.nodes[Index].size);

      // print(nodeDatas[Index].lncode);

      var nodeData = NodeData2(
        ser: nodeDatas[Index].ser.toString(),
        zser: nodeDatas[Index].zser.toString(),
        aser: nodeDatas[Index].aser.toString(),
        ln: '',
        lncode: '',
        size: controller.nodes[Index].size.toString(),
        offset: controller.nodes[Index].offset.toString(),
        dx: controller.nodes[Index].offset.dx.toString(),
        dy: controller.nodes[Index].offset.dy.toString(),
        width: controller.nodes[Index].size.width.toString(),
        height: controller.nodes[Index].size.height.toString(),
        color: '0xFF000000',
      );

      SharedPreferences preferences = await SharedPreferences.getInstance();
      var ren = preferences.getString('renTalSer');
      String? ser_user = preferences.getString('ser');
      try {
        String url = '${MyConstant().domain}/UP_node.php?isAdd=true&ren=$ren';

        final response = await http.post(
          Uri.parse(url),
          body: {
            'ser': nodeData.ser.toString(),
            'offset': nodeData.offset.toString(),
            'size': nodeData.size.toString(),
            'color': nodeData.color.toString(),
            'dx': nodeData.dx.toString(),
            'dy': nodeData.dy.toString(),
            'width': nodeData.width.toString(),
            'height': nodeData.height.toString(),
            'ser_user': ser_user.toString()
          },
        );

        var result = json.decode(response.body);
        if (result.toString() == 'true') {
          if (i + 1 != controller.nodes.length) {
            print(
                'UPDATE_Nodes saved successfully ${nodeData.ser.toString()} /// ${i + 1}');
            // break;
          } else {
            Navigator.of(context).pop();
            setState(() {
              controller = InfiniteCanvasController(nodes: [], edges: []);
            });
            red_area();
            red_Trans_Kon();
          }
        } else {
          print('Failed to save node');
        }
      } catch (e) {
        print('Error saving node to server: $e');
      }
      i = i + 1;
    }
  }

  Future<void> DELETE_Nodes(zser, aser) async {
    int Index = await controller.nodes.indexWhere((item) => item.value == aser);
    Dia_log();

    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    String? ser_user = preferences.getString('ser');
    try {
      String url = '${MyConstant().domain}/De_node.php?isAdd=true&ren=$ren';

      final response = await http.post(
        Uri.parse(url),
        body: {
          'ser': nodeDatas[Index].ser,
          'type': 'One',
        },
      );

      var result = json.decode(response.body);
      if (result.toString() == 'true') {
        print('DELETE_Nodes saved successfully ${nodeDatas[Index].ser}');
        setState(() {
          controller = InfiniteCanvasController(nodes: [], edges: []);
        });
        red_area();
        red_Trans_Kon();
      } else {
        print('Failed to save node');
      }
    } catch (e) {
      print('Error saving node to server: $e');
    }
  }

  Future<void> DELETE_NodesAll() async {
    Dia_log();

    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    String? ser_user = preferences.getString('ser');
    try {
      String url = '${MyConstant().domain}/De_node.php?isAdd=true&ren=$ren';

      final response = await http.post(
        Uri.parse(url),
        body: {
          'ser': '0',
          'type': 'All',
          'zser': zone_ser,
        },
      );

      var result = json.decode(response.body);
      if (result.toString() == 'true') {
        print('DELETE_NodesAll saved successfully ');
        setState(() {
          controller = InfiniteCanvasController(nodes: [], edges: []);
        });
        red_area();
        red_Trans_Kon();
      } else {
        print('Failed to save node');
      }
    } catch (e) {
      print('Error saving node to server: $e');
    }
  }

  Offset _canvasOffset = Offset.zero;
  Offset _startOffset = Offset.zero;

///////////--------------------------------------->
  @override
  Widget build(BuildContext context) {
    const inset = 2.0;
    return controller == null
        ? const Center(child: CircularProgressIndicator())
        : Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
            child: ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(dragDevices: {
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
                      height: MediaQuery.of(context).size.height * 0.8,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 27, 26, 39),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10)),
                                border:
                                    Border.all(color: Colors.grey, width: 1),
                              ),
                              width: MediaQuery.of(context).size.width,
                              height: 40,
                              padding: const EdgeInsets.all(4.0),
                              child: Row(
                                children: [
                                  // Container(
                                  //   height: 30,
                                  //   width: 1,
                                  //   color: Colors.grey.withOpacity(0.5),
                                  //   margin: const EdgeInsets.symmetric(horizontal: 24),
                                  // ),

                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        if (tappedIndex_ == 'Create') {
                                          tappedIndex_ = '';
                                        } else {
                                          tappedIndex_ = 'Create';
                                        }
                                      });
                                    },
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.create,
                                          color: (tappedIndex_ == 'Create')
                                              ? Colors.blue
                                              : Colors.white,
                                        ),
                                        Translate.TranslateAndSetText(
                                            'สร้าง',
                                            Colors.white,
                                            TextAlign.center,
                                            FontWeight.bold,
                                            FontWeight_.Fonts_T,
                                            14,
                                            1),
                                        // Text(
                                        //   ' Create',
                                        //   style: TextStyle(
                                        //       color: Colors.white,
                                        //       fontFamily: Font_.Fonts_T),
                                        // ),
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
                                            color: (tappedIndex_ == 'Touch')
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
                                  PopupMenuButton(
                                    color: Colors.white.withOpacity(0.9),
                                    child: Icon(
                                      Icons.zoom_in,
                                      color: Colors.white,
                                    ),
                                    tooltip: 'zoom',
                                    itemBuilder: (BuildContext context) => [
                                      PopupMenuItem(
                                        height: 20,
                                        padding: EdgeInsets.all(3),
                                        onTap: () async {
                                          controller.zoomIn();
                                        },
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.zoom_in,
                                              color: Colors.green[900],
                                              size: 18,
                                            ),
                                            Translate.TranslateAndSetText(
                                                'ซูมเข้า',
                                                Colors.black,
                                                TextAlign.center,
                                                FontWeight.w700,
                                                Font_.Fonts_T,
                                                12,
                                                1),
                                            // Text(
                                            //   ' Zoom In',
                                            //   style: TextStyle(
                                            //       fontSize: 12,
                                            //       color: PeopleChaoScreen_Color
                                            //           .Colors_Text1_,
                                            //       fontWeight: FontWeight.w700,
                                            //       fontFamily: Font_.Fonts_T),
                                            // ),
                                          ],
                                        ),
                                      ),
                                      PopupMenuItem(
                                        height: 20,
                                        padding: EdgeInsets.all(3),
                                        onTap: () async {
                                          controller.zoomOut();
                                        },
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.zoom_in,
                                              color: Colors.red[900],
                                              size: 18,
                                            ),
                                            Translate.TranslateAndSetText(
                                                'ซูมออก',
                                                Colors.black,
                                                TextAlign.center,
                                                FontWeight.w700,
                                                Font_.Fonts_T,
                                                12,
                                                1),
                                            // Text(
                                            //   ' Zoom Out',
                                            //   style: TextStyle(
                                            //       fontSize: 12,
                                            //       color: PeopleChaoScreen_Color
                                            //           .Colors_Text1_,
                                            //       fontWeight: FontWeight.w700,
                                            //       fontFamily: Font_.Fonts_T),
                                            // ),
                                          ],
                                        ),
                                      ),
                                    ],
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
                                        12,
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
                                      color: Color.fromARGB(255, 56, 55, 70),
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10)),
                                      border: Border.all(
                                          color: Colors.white, width: 0.5),
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
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      items: zoneModels
                                          .map((item) =>
                                              DropdownMenuItem<String>(
                                                value: '${item.ser},${item.zn}',
                                                child: Text(
                                                  item.zn!,
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      color: Color.fromARGB(
                                                          255, 145, 144, 144),
                                                      fontFamily:
                                                          Font_.Fonts_T),
                                                ),
                                              ))
                                          .toList(),

                                      onChanged: (value) async {
                                        var zones = value!.indexOf(',');
                                        var zoneSer = value.substring(0, zones);
                                        var zonesName =
                                            value.substring(zones + 1);
                                        setState(() {
                                          controller = InfiniteCanvasController(
                                              nodes: [], edges: []);
                                          zone_ser = zoneSer.toString();
                                          zone_name = zonesName.toString();
                                        });
                                        red_Trans_Kon();
                                        red_area();
                                      },
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
                                    onTap: () async {
                                      DELETE_NodesAll();
                                    },
                                    child: Container(
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          ),
                                          Translate.TranslateAndSetText(
                                              ' ลบทั้งหมด',
                                              Colors.white,
                                              TextAlign.center,
                                              FontWeight.bold,
                                              Font_.Fonts_T,
                                              12,
                                              1),
                                          // Text(
                                          //   ' Remove All ',
                                          //   style: TextStyle(
                                          //       color: Colors.white,
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
                                    onTap: () async {
                                      UPDATE_NodesAll(context);
                                    },
                                    child: Container(
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.save_as,
                                            color: Colors.green,
                                          ),
                                          Translate.TranslateAndSetText(
                                              ' บันทึกทั้งหมด',
                                              Colors.white,
                                              TextAlign.center,
                                              FontWeight.bold,
                                              Font_.Fonts_T,
                                              12,
                                              1),
                                          // Text(
                                          //   ' Save All ',
                                          //   style: TextStyle(
                                          //       color: Colors.white,
                                          //       fontFamily: Font_.Fonts_T),
                                          // ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          if (tappedIndex_ == 'Create')
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 56, 55, 70),
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10)),
                                  border:
                                      Border.all(color: Colors.grey, width: 1),
                                ),
                                padding: const EdgeInsets.all(4.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: ScrollConfiguration(
                                          behavior:
                                              ScrollConfiguration.of(context)
                                                  .copyWith(dragDevices: {
                                            PointerDeviceKind.touch,
                                            PointerDeviceKind.mouse,
                                          }),
                                          child: SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Row(children: [
                                                const Text(
                                                  'พื้นที่ : ',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily:
                                                          FontWeight_.Fonts_T),
                                                ),
                                                for (int index = 0;
                                                    index < areaModels.length;
                                                    index++)
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            4.0),
                                                    child: PopupMenuButton(
                                                      padding:
                                                          EdgeInsets.all(3),
                                                      child: Container(
                                                        width: 80,
                                                        height: 30,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Color.fromARGB(
                                                              255,
                                                              114,
                                                              113,
                                                              134),
                                                          borderRadius: BorderRadius.only(
                                                              topLeft: Radius
                                                                  .circular(10),
                                                              topRight: Radius
                                                                  .circular(10),
                                                              bottomLeft: Radius
                                                                  .circular(10),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          10)),
                                                          border: Border.all(
                                                              color:
                                                                  Colors.grey,
                                                              width: 1),
                                                        ),
                                                        padding:
                                                            const EdgeInsets
                                                                .all(2.0),
                                                        child: Center(
                                                          child: Text(
                                                            '${areaModels[index].ln}',
                                                            maxLines: 2,
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                color: Colors
                                                                    .black,
                                                                fontFamily: Font_
                                                                    .Fonts_T),
                                                          ),
                                                        ),
                                                      ),
                                                      itemBuilder: (BuildContext
                                                              context) =>
                                                          [
                                                        PopupMenuItem(
                                                          padding:
                                                              EdgeInsets.all(2),
                                                          child: InkWell(
                                                              onTap: () async {
                                                                final color =
                                                                    RandomColor()
                                                                        .randomColor();
                                                                final node =
                                                                    InfiniteCanvasNode(
                                                                  key:
                                                                      UniqueKey(),
                                                                  label:
                                                                      '${areaModels[index].ln}',
                                                                  allowResize:
                                                                      true,
                                                                  offset: controller
                                                                      .mousePosition,
                                                                  size: Size(
                                                                    Random().nextDouble() *
                                                                            100 +
                                                                        100,
                                                                    Random().nextDouble() *
                                                                            100 +
                                                                        100,
                                                                  ),
                                                                  child:
                                                                      Builder(
                                                                    builder:
                                                                        (context) {
                                                                      return CustomPaint(
                                                                        painter:
                                                                            InlineCustomPainter(
                                                                          brush: Paint()
                                                                            ..color =
                                                                                color,
                                                                          builder: (brush,
                                                                              canvas,
                                                                              rect) {
                                                                            // Draw circle
                                                                            final diameter =
                                                                                min(rect.width, rect.height);
                                                                            final radius =
                                                                                diameter / 2;
                                                                            canvas.drawCircle(
                                                                                rect.center,
                                                                                radius,
                                                                                brush);
                                                                          },
                                                                        ),
                                                                      );
                                                                    },
                                                                  ),
                                                                );
                                                                controller
                                                                    .add(node);
                                                                INSERT_Nodes(
                                                                    node,
                                                                    areaModels[
                                                                            index]
                                                                        .zser,
                                                                    areaModels[
                                                                            index]
                                                                        .ser,
                                                                    'Circle');
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: Container(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          10),
                                                                  width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width,
                                                                  child: Row(
                                                                    children: [
                                                                      CustomPaint(
                                                                        size:
                                                                            Size(
                                                                          30.00,
                                                                          30.00,
                                                                        ),
                                                                        painter:
                                                                            RPSCustomPainter_Circle(Colors.grey),
                                                                      ),
                                                                      Expanded(
                                                                        child: Translate.TranslateAndSetText(
                                                                            ' วงกลม ',
                                                                            Colors.black,
                                                                            TextAlign.left,
                                                                            FontWeight.bold,
                                                                            FontWeight_.Fonts_T,
                                                                            12,
                                                                            1),
                                                                        //  Text(
                                                                        //   'Circle',
                                                                        //   style: TextStyle(
                                                                        //       color: PeopleChaoScreen_Color
                                                                        //           .Colors_Text1_,
                                                                        //       fontWeight:
                                                                        //           FontWeight
                                                                        //               .bold,
                                                                        //       fontFamily:
                                                                        //           FontWeight_.Fonts_T),
                                                                        // ),
                                                                      )
                                                                    ],
                                                                  ))),
                                                        ),
                                                        PopupMenuItem(
                                                          padding:
                                                              EdgeInsets.all(2),
                                                          child: InkWell(
                                                              onTap: () async {
                                                                final color =
                                                                    RandomColor()
                                                                        .randomColor();
                                                                final node =
                                                                    InfiniteCanvasNode(
                                                                  key:
                                                                      UniqueKey(),
                                                                  label:
                                                                      '${areaModels[index].ln}',
                                                                  allowResize:
                                                                      true,
                                                                  offset: controller
                                                                      .mousePosition,
                                                                  size: Size(
                                                                    Random().nextDouble() *
                                                                            200 +
                                                                        100,
                                                                    Random().nextDouble() *
                                                                            200 +
                                                                        100,
                                                                  ),
                                                                  child:
                                                                      Builder(
                                                                    builder:
                                                                        (context) {
                                                                      return CustomPaint(
                                                                        painter:
                                                                            InlineCustomPainter(
                                                                          brush: Paint()
                                                                            ..color =
                                                                                color,
                                                                          builder: (brush,
                                                                              canvas,
                                                                              rect) {
                                                                            // Draw rectangle
                                                                            canvas.drawRect(rect,
                                                                                brush);
                                                                          },
                                                                        ),
                                                                      );
                                                                    },
                                                                  ),
                                                                );
                                                                controller
                                                                    .add(node);
                                                                INSERT_Nodes(
                                                                    node,
                                                                    areaModels[
                                                                            index]
                                                                        .zser,
                                                                    areaModels[
                                                                            index]
                                                                        .ser,
                                                                    'Rectangle');
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: Container(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          10),
                                                                  width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width,
                                                                  child: Row(
                                                                    children: [
                                                                      CustomPaint(
                                                                        size:
                                                                            Size(
                                                                          30.00,
                                                                          30.00,
                                                                        ),
                                                                        painter:
                                                                            RPSCustomPainter_Rectangle(Colors.grey),
                                                                      ),
                                                                      Expanded(
                                                                        child: Translate.TranslateAndSetText(
                                                                            ' สี่เหลี่ยมผืนผ้า ',
                                                                            Colors.black,
                                                                            TextAlign.left,
                                                                            FontWeight.bold,
                                                                            FontWeight_.Fonts_T,
                                                                            12,
                                                                            1),
                                                                        //  Text(
                                                                        //   'Rectangle',
                                                                        //   style: TextStyle(
                                                                        //       color: PeopleChaoScreen_Color
                                                                        //           .Colors_Text1_,
                                                                        //       fontWeight:
                                                                        //           FontWeight
                                                                        //               .bold,
                                                                        //       fontFamily:
                                                                        //           FontWeight_.Fonts_T),
                                                                        // ),
                                                                      )
                                                                    ],
                                                                  ))),
                                                        ),
                                                        PopupMenuItem(
                                                          padding:
                                                              EdgeInsets.all(2),
                                                          child: InkWell(
                                                              onTap: () async {
                                                                final color =
                                                                    RandomColor()
                                                                        .randomColor();
                                                                final node =
                                                                    InfiniteCanvasNode(
                                                                  key:
                                                                      UniqueKey(),
                                                                  label:
                                                                      '${areaModels[index].ln}',
                                                                  allowResize:
                                                                      true,
                                                                  offset: controller
                                                                      .mousePosition,
                                                                  size: Size(
                                                                    Random().nextDouble() *
                                                                            200 +
                                                                        100,
                                                                    Random().nextDouble() *
                                                                            200 +
                                                                        100,
                                                                  ),
                                                                  child:
                                                                      Builder(
                                                                    builder:
                                                                        (context) {
                                                                      return CustomPaint(
                                                                        painter:
                                                                            InlineCustomPainter(
                                                                          brush: Paint()
                                                                            ..color =
                                                                                color,
                                                                          builder: (brush,
                                                                              canvas,
                                                                              rect) {
                                                                            // Draw triangle
                                                                            final path = Path()
                                                                              ..moveTo(rect.left, rect.bottom)
                                                                              ..lineTo(rect.right, rect.bottom)
                                                                              ..lineTo(rect.center.dx, rect.top)
                                                                              ..close();
                                                                            canvas.drawPath(path,
                                                                                brush);
                                                                          },
                                                                        ),
                                                                      );
                                                                    },
                                                                  ),
                                                                );
                                                                controller
                                                                    .add(node);
                                                                INSERT_Nodes(
                                                                    node,
                                                                    areaModels[
                                                                            index]
                                                                        .zser,
                                                                    areaModels[
                                                                            index]
                                                                        .ser,
                                                                    'Triangle');

                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: Container(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          10),
                                                                  width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width,
                                                                  child: Row(
                                                                    children: [
                                                                      CustomPaint(
                                                                        size:
                                                                            Size(
                                                                          30.00,
                                                                          30.00,
                                                                        ),
                                                                        painter:
                                                                            RPSCustomPainter_Triangle(Colors.grey),
                                                                      ),
                                                                      Expanded(
                                                                        child: Translate.TranslateAndSetText(
                                                                            ' สามเหลี่ยม ',
                                                                            Colors.black,
                                                                            TextAlign.left,
                                                                            FontWeight.bold,
                                                                            FontWeight_.Fonts_T,
                                                                            12,
                                                                            1),
                                                                        //  Text(
                                                                        //   'Triangle',
                                                                        //   style: TextStyle(
                                                                        //       color: PeopleChaoScreen_Color
                                                                        //           .Colors_Text1_,
                                                                        //       fontWeight:
                                                                        //           FontWeight
                                                                        //               .bold,
                                                                        //       fontFamily:
                                                                        //           FontWeight_.Fonts_T),
                                                                        // ),
                                                                      )
                                                                    ],
                                                                  ))),
                                                        ),
                                                        PopupMenuItem(
                                                          padding:
                                                              EdgeInsets.all(2),
                                                          child: InkWell(
                                                              onTap: () async {
                                                                final color =
                                                                    RandomColor()
                                                                        .randomColor();
                                                                final node =
                                                                    InfiniteCanvasNode(
                                                                  key:
                                                                      UniqueKey(),
                                                                  label:
                                                                      '${areaModels[index].ln}',
                                                                  allowResize:
                                                                      true,
                                                                  offset: controller
                                                                      .mousePosition,
                                                                  size: Size(
                                                                    Random().nextDouble() *
                                                                            200 +
                                                                        100,
                                                                    Random().nextDouble() *
                                                                            200 +
                                                                        100,
                                                                  ),
                                                                  child:
                                                                      Builder(
                                                                    builder:
                                                                        (context) {
                                                                      return CustomPaint(
                                                                        painter:
                                                                            InlineCustomPainter(
                                                                          brush: Paint()
                                                                            ..color =
                                                                                color,
                                                                          builder: (brush,
                                                                              canvas,
                                                                              rect) {
                                                                            // Draw triangle
                                                                            final path = Path()
                                                                              ..moveTo(rect.left, rect.bottom)
                                                                              ..lineTo(rect.right, rect.bottom)
                                                                              ..lineTo(rect.center.dx, rect.top)
                                                                              ..close();
                                                                            canvas.drawPath(path,
                                                                                brush);
                                                                          },
                                                                        ),
                                                                      );
                                                                    },
                                                                  ),
                                                                );
                                                                controller
                                                                    .add(node);
                                                                INSERT_Nodes(
                                                                    node,
                                                                    areaModels[
                                                                            index]
                                                                        .zser,
                                                                    areaModels[
                                                                            index]
                                                                        .ser,
                                                                    'Crop');

                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: Container(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          10),
                                                                  width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width,
                                                                  child: Row(
                                                                    children: [
                                                                      CustomPaint(
                                                                        size:
                                                                            Size(
                                                                          30.00,
                                                                          30.00,
                                                                        ),
                                                                        painter:
                                                                            RPSCustomPainter_Crop(Colors.grey),
                                                                      ),
                                                                      Expanded(
                                                                        child: Translate.TranslateAndSetText(
                                                                            ' แบบแปลนพื้นที่ ',
                                                                            Colors.black,
                                                                            TextAlign.left,
                                                                            FontWeight.bold,
                                                                            FontWeight_.Fonts_T,
                                                                            12,
                                                                            1),
                                                                        //  Text(
                                                                        //   'Triangle',
                                                                        //   style: TextStyle(
                                                                        //       color: PeopleChaoScreen_Color
                                                                        //           .Colors_Text1_,
                                                                        //       fontWeight:
                                                                        //           FontWeight
                                                                        //               .bold,
                                                                        //       fontFamily:
                                                                        //           FontWeight_.Fonts_T),
                                                                        // ),
                                                                      )
                                                                    ],
                                                                  ))),
                                                        ),
                                                        for (int index = 0;
                                                            index < 9;
                                                            index++)
                                                          PopupMenuItem(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    2),
                                                            child: InkWell(
                                                                onTap:
                                                                    () async {
                                                                  final color =
                                                                      RandomColor()
                                                                          .randomColor();
                                                                  final node =
                                                                      InfiniteCanvasNode(
                                                                    key:
                                                                        UniqueKey(),
                                                                    label:
                                                                        '${areaModels[index].ln}',
                                                                    allowResize:
                                                                        true,
                                                                    offset: controller
                                                                        .mousePosition,
                                                                    size: Size(
                                                                      Random().nextDouble() *
                                                                              200 +
                                                                          100,
                                                                      Random().nextDouble() *
                                                                              200 +
                                                                          100,
                                                                    ),
                                                                    child:
                                                                        Builder(
                                                                      builder:
                                                                          (context) {
                                                                        return CustomPaint(
                                                                          painter:
                                                                              InlineCustomPainter(
                                                                            brush: Paint()
                                                                              ..color = color,
                                                                            builder: (brush,
                                                                                canvas,
                                                                                rect) {
                                                                              // Draw triangle
                                                                              final path = Path()
                                                                                ..moveTo(rect.left, rect.bottom)
                                                                                ..lineTo(rect.right, rect.bottom)
                                                                                ..lineTo(rect.center.dx, rect.top)
                                                                                ..close();
                                                                              canvas.drawPath(path, brush);
                                                                            },
                                                                          ),
                                                                        );
                                                                      },
                                                                    ),
                                                                  );
                                                                  controller
                                                                      .add(
                                                                          node);
                                                                  INSERT_Nodes(
                                                                      node,
                                                                      areaModels[
                                                                              index]
                                                                          .zser,
                                                                      areaModels[
                                                                              index]
                                                                          .ser,
                                                                      'Crop${index + 2}');

                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child:
                                                                    Container(
                                                                        padding:
                                                                            const EdgeInsets.all(
                                                                                10),
                                                                        width: MediaQuery.of(context)
                                                                            .size
                                                                            .width,
                                                                        child:
                                                                            Row(
                                                                          children: [
                                                                            CustomPaint(
                                                                              size: Size(
                                                                                30.00,
                                                                                30.00,
                                                                              ),
                                                                              painter: (index + 2 == 1)
                                                                                  ? RPSCustomPainter_Crop2(Colors.grey)
                                                                                  : (index + 2 == 2)
                                                                                      ? RPSCustomPainter_Crop2(Colors.grey)
                                                                                      : (index + 2 == 3)
                                                                                          ? RPSCustomPainter_Crop3(Colors.grey)
                                                                                          : (index + 2 == 4)
                                                                                              ? RPSCustomPainter_Crop4(Colors.grey)
                                                                                              : (index + 2 == 5)
                                                                                                  ? RPSCustomPainter_Crop5(Colors.grey)
                                                                                                  : (index + 2 == 6)
                                                                                                      ? RPSCustomPainter_Crop6(Colors.grey)
                                                                                                      : (index + 2 == 7)
                                                                                                          ? RPSCustomPainter_Crop7(Colors.grey)
                                                                                                          : (index + 2 == 8)
                                                                                                              ? RPSCustomPainter_Crop8(Colors.grey)
                                                                                                              : (index + 2 == 9)
                                                                                                                  ? RPSCustomPainter_Crop9(Colors.grey)
                                                                                                                  : RPSCustomPainter_Crop10(Colors.grey),
                                                                            ),
                                                                            Expanded(
                                                                              child: Translate.TranslateAndSetText(' แบบแปลนพื้นที่${index + 2} ', Colors.black, TextAlign.left, FontWeight.bold, FontWeight_.Fonts_T, 12, 1),
                                                                            )
                                                                          ],
                                                                        ))),
                                                          ),
                                                        PopupMenuItem(
                                                          padding:
                                                              EdgeInsets.all(2),
                                                          child: InkWell(
                                                              onTap: () async {
                                                                final color =
                                                                    RandomColor()
                                                                        .randomColor();
                                                                final node =
                                                                    InfiniteCanvasNode(
                                                                  key:
                                                                      UniqueKey(),
                                                                  label:
                                                                      '${areaModels[index].ln}',
                                                                  allowResize:
                                                                      true,
                                                                  offset: controller
                                                                      .mousePosition,
                                                                  size: Size(
                                                                    Random().nextDouble() *
                                                                            200 +
                                                                        100,
                                                                    Random().nextDouble() *
                                                                            200 +
                                                                        100,
                                                                  ),
                                                                  child:
                                                                      Builder(
                                                                    builder:
                                                                        (context) {
                                                                      return CustomPaint(
                                                                        painter:
                                                                            InlineCustomPainter(
                                                                          brush: Paint()
                                                                            ..color =
                                                                                color,
                                                                          builder: (brush,
                                                                              canvas,
                                                                              rect) {
                                                                            // Draw triangle
                                                                            final path = Path()
                                                                              ..moveTo(rect.left, rect.bottom)
                                                                              ..lineTo(rect.right, rect.bottom)
                                                                              ..lineTo(rect.center.dx, rect.top)
                                                                              ..close();
                                                                            canvas.drawPath(path,
                                                                                brush);
                                                                          },
                                                                        ),
                                                                      );
                                                                    },
                                                                  ),
                                                                );
                                                                controller
                                                                    .add(node);
                                                                INSERT_Nodes(
                                                                    node,
                                                                    areaModels[
                                                                            index]
                                                                        .zser,
                                                                    areaModels[
                                                                            index]
                                                                        .ser,
                                                                    'Foods');

                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: Container(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          10),
                                                                  width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width,
                                                                  child: Row(
                                                                    children: [
                                                                      CustomPaint(
                                                                        size:
                                                                            Size(
                                                                          30.00,
                                                                          30.00,
                                                                        ),
                                                                        painter:
                                                                            RPSCustomPainter_Foods(Colors.grey),
                                                                      ),
                                                                      Expanded(
                                                                        child: Translate.TranslateAndSetText(
                                                                            ' อาหาร ',
                                                                            Colors.black,
                                                                            TextAlign.left,
                                                                            FontWeight.bold,
                                                                            FontWeight_.Fonts_T,
                                                                            12,
                                                                            1),
                                                                        //  Text(
                                                                        //   'Foods',
                                                                        //   style: TextStyle(
                                                                        //       color: PeopleChaoScreen_Color
                                                                        //           .Colors_Text1_,
                                                                        //       fontWeight:
                                                                        //           FontWeight
                                                                        //               .bold,
                                                                        //       fontFamily:
                                                                        //           FontWeight_.Fonts_T),
                                                                        // ),
                                                                      )
                                                                    ],
                                                                  ))),
                                                        ),
                                                        PopupMenuItem(
                                                          padding:
                                                              EdgeInsets.all(2),
                                                          child: InkWell(
                                                              onTap: () async {
                                                                final color =
                                                                    RandomColor()
                                                                        .randomColor();
                                                                final node =
                                                                    InfiniteCanvasNode(
                                                                  key:
                                                                      UniqueKey(),
                                                                  label:
                                                                      '${areaModels[index].ln}',
                                                                  allowResize:
                                                                      true,
                                                                  offset: controller
                                                                      .mousePosition,
                                                                  size: Size(
                                                                    Random().nextDouble() *
                                                                            200 +
                                                                        100,
                                                                    Random().nextDouble() *
                                                                            200 +
                                                                        100,
                                                                  ),
                                                                  child:
                                                                      Builder(
                                                                    builder:
                                                                        (context) {
                                                                      return CustomPaint(
                                                                        painter:
                                                                            InlineCustomPainter(
                                                                          brush: Paint()
                                                                            ..color =
                                                                                color,
                                                                          builder: (brush,
                                                                              canvas,
                                                                              rect) {
                                                                            // Draw triangle
                                                                            final path = Path()
                                                                              ..moveTo(rect.left, rect.bottom)
                                                                              ..lineTo(rect.right, rect.bottom)
                                                                              ..lineTo(rect.center.dx, rect.top)
                                                                              ..close();
                                                                            canvas.drawPath(path,
                                                                                brush);
                                                                          },
                                                                        ),
                                                                      );
                                                                    },
                                                                  ),
                                                                );
                                                                controller
                                                                    .add(node);
                                                                INSERT_Nodes(
                                                                    node,
                                                                    areaModels[
                                                                            index]
                                                                        .zser,
                                                                    areaModels[
                                                                            index]
                                                                        .ser,
                                                                    'Drink');

                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: Container(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          10),
                                                                  width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width,
                                                                  child: Row(
                                                                    children: [
                                                                      CustomPaint(
                                                                        size:
                                                                            Size(
                                                                          30.00,
                                                                          30.00,
                                                                        ),
                                                                        painter:
                                                                            RPSCustomPainter_Drink(Colors.grey),
                                                                      ),
                                                                      Expanded(
                                                                        child: Translate.TranslateAndSetText(
                                                                            ' เครื่องดื่ม ',
                                                                            Colors.black,
                                                                            TextAlign.left,
                                                                            FontWeight.bold,
                                                                            FontWeight_.Fonts_T,
                                                                            12,
                                                                            1),
                                                                        //  Text(
                                                                        //   'Drink',
                                                                        //   style: TextStyle(
                                                                        //       color: PeopleChaoScreen_Color
                                                                        //           .Colors_Text1_,
                                                                        //       fontWeight:
                                                                        //           FontWeight
                                                                        //               .bold,
                                                                        //       fontFamily:
                                                                        //           FontWeight_.Fonts_T),
                                                                        // ),
                                                                      )
                                                                    ],
                                                                  ))),
                                                        ),
                                                        PopupMenuItem(
                                                          padding:
                                                              EdgeInsets.all(2),
                                                          child: InkWell(
                                                              onTap: () async {
                                                                final color =
                                                                    RandomColor()
                                                                        .randomColor();
                                                                final node =
                                                                    InfiniteCanvasNode(
                                                                  key:
                                                                      UniqueKey(),
                                                                  label:
                                                                      '${areaModels[index].ln}',
                                                                  allowResize:
                                                                      true,
                                                                  offset: controller
                                                                      .mousePosition,
                                                                  size: Size(
                                                                    Random().nextDouble() *
                                                                            200 +
                                                                        100,
                                                                    Random().nextDouble() *
                                                                            200 +
                                                                        100,
                                                                  ),
                                                                  child:
                                                                      Builder(
                                                                    builder:
                                                                        (context) {
                                                                      return CustomPaint(
                                                                        painter:
                                                                            InlineCustomPainter(
                                                                          brush: Paint()
                                                                            ..color =
                                                                                color,
                                                                          builder: (brush,
                                                                              canvas,
                                                                              rect) {
                                                                            // Draw triangle
                                                                            final path = Path()
                                                                              ..moveTo(rect.left, rect.bottom)
                                                                              ..lineTo(rect.right, rect.bottom)
                                                                              ..lineTo(rect.center.dx, rect.top)
                                                                              ..close();
                                                                            canvas.drawPath(path,
                                                                                brush);
                                                                          },
                                                                        ),
                                                                      );
                                                                    },
                                                                  ),
                                                                );
                                                                controller
                                                                    .add(node);
                                                                INSERT_Nodes(
                                                                    node,
                                                                    areaModels[
                                                                            index]
                                                                        .zser,
                                                                    areaModels[
                                                                            index]
                                                                        .ser,
                                                                    'Map');

                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: Container(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          10),
                                                                  width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width,
                                                                  child: Row(
                                                                    children: [
                                                                      CustomPaint(
                                                                        size:
                                                                            Size(
                                                                          30.00,
                                                                          30.00,
                                                                        ),
                                                                        painter:
                                                                            RPSCustomPainter_Map(Colors.grey),
                                                                      ),
                                                                      Expanded(
                                                                        child: Translate.TranslateAndSetText(
                                                                            ' แผนที่ ',
                                                                            Colors.black,
                                                                            TextAlign.left,
                                                                            FontWeight.bold,
                                                                            FontWeight_.Fonts_T,
                                                                            12,
                                                                            1),
                                                                        //  Text(
                                                                        //   'Map',
                                                                        //   style: TextStyle(
                                                                        //       color: PeopleChaoScreen_Color
                                                                        //           .Colors_Text1_,
                                                                        //       fontWeight:
                                                                        //           FontWeight
                                                                        //               .bold,
                                                                        //       fontFamily:
                                                                        //           FontWeight_.Fonts_T),
                                                                        // ),
                                                                      )
                                                                    ],
                                                                  ))),
                                                        ),
                                                        PopupMenuItem(
                                                          padding:
                                                              EdgeInsets.all(2),
                                                          child: InkWell(
                                                              onTap: () async {
                                                                final color =
                                                                    RandomColor()
                                                                        .randomColor();
                                                                final node =
                                                                    InfiniteCanvasNode(
                                                                  key:
                                                                      UniqueKey(),
                                                                  label:
                                                                      '${areaModels[index].ln}',
                                                                  allowResize:
                                                                      true,
                                                                  offset: controller
                                                                      .mousePosition,
                                                                  size: Size(
                                                                    Random().nextDouble() *
                                                                            200 +
                                                                        100,
                                                                    Random().nextDouble() *
                                                                            200 +
                                                                        100,
                                                                  ),
                                                                  child:
                                                                      Builder(
                                                                    builder:
                                                                        (context) {
                                                                      return CustomPaint(
                                                                        painter:
                                                                            InlineCustomPainter(
                                                                          brush: Paint()
                                                                            ..color =
                                                                                color,
                                                                          builder: (brush,
                                                                              canvas,
                                                                              rect) {
                                                                            // Draw triangle
                                                                            final path = Path()
                                                                              ..moveTo(rect.left, rect.bottom)
                                                                              ..lineTo(rect.right, rect.bottom)
                                                                              ..lineTo(rect.center.dx, rect.top)
                                                                              ..close();
                                                                            canvas.drawPath(path,
                                                                                brush);
                                                                          },
                                                                        ),
                                                                      );
                                                                    },
                                                                  ),
                                                                );
                                                                controller
                                                                    .add(node);
                                                                INSERT_Nodes(
                                                                    node,
                                                                    areaModels[
                                                                            index]
                                                                        .zser,
                                                                    areaModels[
                                                                            index]
                                                                        .ser,
                                                                    'Shop1');

                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: Container(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          10),
                                                                  width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width,
                                                                  child: Row(
                                                                    children: [
                                                                      CustomPaint(
                                                                        size:
                                                                            Size(
                                                                          30.00,
                                                                          30.00,
                                                                        ),
                                                                        painter:
                                                                            RPSCustomPainter_Shop(Colors.grey),
                                                                      ),
                                                                      Expanded(
                                                                        child: Translate.TranslateAndSetText(
                                                                            ' ร้านค้า1 ',
                                                                            Colors.black,
                                                                            TextAlign.left,
                                                                            FontWeight.bold,
                                                                            FontWeight_.Fonts_T,
                                                                            12,
                                                                            1),
                                                                        // Text(
                                                                        //   'Shop1',
                                                                        //   style: TextStyle(
                                                                        //       color: PeopleChaoScreen_Color
                                                                        //           .Colors_Text1_,
                                                                        //       fontWeight:
                                                                        //           FontWeight
                                                                        //               .bold,
                                                                        //       fontFamily:
                                                                        //           FontWeight_.Fonts_T),
                                                                        // ),
                                                                      )
                                                                    ],
                                                                  ))),
                                                        ),
                                                        PopupMenuItem(
                                                          padding:
                                                              EdgeInsets.all(2),
                                                          child: InkWell(
                                                              onTap: () async {
                                                                final color =
                                                                    RandomColor()
                                                                        .randomColor();
                                                                final node =
                                                                    InfiniteCanvasNode(
                                                                  key:
                                                                      UniqueKey(),
                                                                  label:
                                                                      '${areaModels[index].ln}',
                                                                  allowResize:
                                                                      true,
                                                                  offset: controller
                                                                      .mousePosition,
                                                                  size: Size(
                                                                    Random().nextDouble() *
                                                                            200 +
                                                                        100,
                                                                    Random().nextDouble() *
                                                                            200 +
                                                                        100,
                                                                  ),
                                                                  child:
                                                                      Builder(
                                                                    builder:
                                                                        (context) {
                                                                      return CustomPaint(
                                                                        painter:
                                                                            InlineCustomPainter(
                                                                          brush: Paint()
                                                                            ..color =
                                                                                color,
                                                                          builder: (brush,
                                                                              canvas,
                                                                              rect) {
                                                                            // Draw triangle
                                                                            final path = Path()
                                                                              ..moveTo(rect.left, rect.bottom)
                                                                              ..lineTo(rect.right, rect.bottom)
                                                                              ..lineTo(rect.center.dx, rect.top)
                                                                              ..close();
                                                                            canvas.drawPath(path,
                                                                                brush);
                                                                          },
                                                                        ),
                                                                      );
                                                                    },
                                                                  ),
                                                                );
                                                                controller
                                                                    .add(node);
                                                                INSERT_Nodes(
                                                                    node,
                                                                    areaModels[
                                                                            index]
                                                                        .zser,
                                                                    areaModels[
                                                                            index]
                                                                        .ser,
                                                                    'Shop2');

                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: Container(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          10),
                                                                  width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width,
                                                                  child: Row(
                                                                    children: [
                                                                      CustomPaint(
                                                                        size:
                                                                            Size(
                                                                          30.00,
                                                                          30.00,
                                                                        ),
                                                                        painter:
                                                                            RPSCustomPainter_Shop2(Colors.grey),
                                                                      ),
                                                                      Expanded(
                                                                        child: Translate.TranslateAndSetText(
                                                                            ' ร้านค้า2 ',
                                                                            Colors.black,
                                                                            TextAlign.left,
                                                                            FontWeight.bold,
                                                                            FontWeight_.Fonts_T,
                                                                            12,
                                                                            1),
                                                                        // Text(
                                                                        //   'Shop2',
                                                                        //   style: TextStyle(
                                                                        //       color: PeopleChaoScreen_Color
                                                                        //           .Colors_Text1_,
                                                                        //       fontWeight:
                                                                        //           FontWeight
                                                                        //               .bold,
                                                                        //       fontFamily:
                                                                        //           FontWeight_.Fonts_T),
                                                                        // ),
                                                                      )
                                                                    ],
                                                                  ))),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                              ]))),
                                    ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: PopupMenuButton(
                                        color: Colors.white.withOpacity(0.9),
                                        child: Container(
                                          color: Colors.white.withOpacity(0.9),
                                          padding: EdgeInsets.all(4.0),
                                          child: Row(
                                            children: [
                                              Icon(Icons.more),
                                              Translate.TranslateAndSetText(
                                                  '  ตกแต่ง',
                                                  Colors.black,
                                                  TextAlign.left,
                                                  FontWeight.bold,
                                                  FontWeight_.Fonts_T,
                                                  12,
                                                  1),
                                            ],
                                          ),
                                        ),
                                        itemBuilder: (BuildContext context) => [
                                          for (int index2 = 0;
                                              index2 < 6;
                                              index2++)
                                            PopupMenuItem(
                                              padding: EdgeInsets.all(2),
                                              child: InkWell(
                                                  onTap: () async {
                                                    final color = RandomColor()
                                                        .randomColor();
                                                    final node =
                                                        InfiniteCanvasNode(
                                                      key: UniqueKey(),
                                                      label:
                                                          'Road${index2 + 1}',
                                                      allowResize: true,
                                                      offset: controller
                                                          .mousePosition,
                                                      size: Size(
                                                        100,
                                                        100,
                                                      ),
                                                      child: Builder(
                                                        builder: (context) {
                                                          return CustomPaint(
                                                            painter:
                                                                InlineCustomPainter(
                                                              brush: Paint()
                                                                ..color = color,
                                                              builder: (brush,
                                                                  canvas,
                                                                  rect) {
                                                                // Draw triangle
                                                                final path =
                                                                    Path()
                                                                      ..moveTo(
                                                                          rect.left,
                                                                          rect.bottom)
                                                                      ..lineTo(
                                                                          rect.right,
                                                                          rect.bottom)
                                                                      ..lineTo(
                                                                          rect.center
                                                                              .dx,
                                                                          rect.top)
                                                                      ..close();
                                                                canvas.drawPath(
                                                                    path,
                                                                    brush);
                                                              },
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    );
                                                    controller.add(node);
                                                    INSERT_Nodes(node, zone_ser,
                                                        0, 'Road${index2 + 1}');

                                                    Navigator.pop(context);
                                                  },
                                                  child: Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10),
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      child: Row(
                                                        children: [
                                                          CustomPaint(
                                                            size: Size(
                                                              30.00,
                                                              30.00,
                                                            ),
                                                            painter: (index2 +
                                                                        1 ==
                                                                    1)
                                                                ? RPSCustomPainter_Road1(
                                                                    Colors.grey)
                                                                : (index2 + 1 ==
                                                                        2)
                                                                    ? RPSCustomPainter_Road2(
                                                                        Colors
                                                                            .grey)
                                                                    : (index2 + 1 ==
                                                                            3)
                                                                        ? RPSCustomPainter_Road3(Colors
                                                                            .grey)
                                                                        : (index2 + 1 ==
                                                                                4)
                                                                            ? RPSCustomPainter_Road4(Colors.grey)
                                                                            : (index2 + 1 == 5)
                                                                                ? RPSCustomPainter_Road5(Colors.grey)
                                                                                : RPSCustomPainter_Road6(Colors.grey),
                                                          ),
                                                          Expanded(
                                                            child: Translate
                                                                .TranslateAndSetText(
                                                                    'Road${index2 + 1}',
                                                                    Colors
                                                                        .black,
                                                                    TextAlign
                                                                        .left,
                                                                    FontWeight
                                                                        .bold,
                                                                    FontWeight_
                                                                        .Fonts_T,
                                                                    12,
                                                                    1),
                                                          )
                                                        ],
                                                      ))),
                                            ),
                                        ],
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
                                        color: Colors.grey.withOpacity(0.5),
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10)),
                                        border: Border.all(
                                            color: Colors.grey, width: 1),
                                      ),
                                      child: CustomPaint(
                                        size: rect.size,
                                        painter:
                                            GridPainter(gridSize: gridSize),
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
          );
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
      this.cid});

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
    return data;
  }
}
