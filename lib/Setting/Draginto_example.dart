import 'dart:convert';
import 'dart:ui';

import 'package:drag_and_drop_lists/drag_and_drop_list_interface.dart';
import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';

import 'package:shared_preferences/shared_preferences.dart';
import '../INSERT_Log/Insert_log.dart';
import '../Model/GetSubZone_Model.dart';
import '../Model/GetZone_Model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../Constant/Myconstant.dart';

import '../Responsive/responsive.dart';
import '../Style/colors.dart';

class DragIntoListExample extends StatefulWidget {
  const DragIntoListExample({Key? key}) : super(key: key);

  @override
  State createState() => _DragIntoListExample();
}

class _DragIntoListExample extends State<DragIntoListExample> {
  final ScrollController _scrollController = ScrollController();
  List<DragAndDropList> _contents = <DragAndDropList>[];
  List<ZoneModel> zoneModels = [];
  List<SubZoneModel> subzoneModels = [];
  final _formKey = GlobalKey<FormState>();
  final zone_text = TextEditingController();

  @override
  void initState() {
    super.initState();
    read_GC_Sub_zone();
  }

  Future<Null> read_GC_Sub_zone() async {
    if (subzoneModels.length != 0) {
      setState(() {
        subzoneModels.clear();
      });
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var ren = preferences.getString('renTalSer');

    String url = '${MyConstant().domain}/GC_zone_sub.php?isAdd=true&ren=$ren';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      Map<String, dynamic> map = Map();
      map['ser'] = '0';
      map['rser'] = '0';
      map['zn'] = 'ทั้งหมด';
      map['qty'] = '0';
      map['img'] = '0';
      map['data_update'] = '0';

      SubZoneModel subzoneModelx = SubZoneModel.fromJson(map);

      setState(() {
        subzoneModels.add(subzoneModelx);
      });
      print(result);
      for (var map in result) {
        SubZoneModel subzoneModel = SubZoneModel.fromJson(map);
        setState(() {
          subzoneModels.add(subzoneModel);
        });
      }
    } catch (e) {}
    setState(() {
      read_GC_zone().then((value) =>
          _contents = List.generate(subzoneModels.length, (index) {
            return DragAndDropList(
              contentsWhenEmpty: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  subzoneModels[index].zn.toString(),
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              lastTarget: Text(
                "${subzoneModels[index].ser}",
                style: TextStyle(color: Colors.transparent),
              ),
              header: Column(
                children: <Widget>[
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8, bottom: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${subzoneModels[index].zn}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            subzoneModels[index].ser == '0'
                                ? IconButton(
                                    onPressed: () {
                                      addZone();
                                    },
                                    icon: Icon(
                                        Icons.add_circle_outline_outlined,
                                        color: Colors.green),
                                  )
                                : IconButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) => StatefulBuilder(
                                          builder: (context, setState) =>
                                              AlertDialog(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            title: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                        alignment:
                                                            Alignment.center,
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.2,
                                                        child: Text(
                                                          'ลบโซนพื้นที่ ${subzoneModels[index].zn}',
                                                          style: TextStyle(
                                                            fontSize: 20.0,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.red,
                                                          ),
                                                        )),
                                                  ],
                                                ),
                                              ],
                                            ), //AppBarColors2.Colors(),
                                            content: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    Container(
                                                      width: 130,
                                                      height: 40,
                                                      // ignore: deprecated_member_use
                                                      child: ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          backgroundColor:
                                                              Colors.green,
                                                        ),
                                                        onPressed: () async {
                                                          deleteZone(index);

                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: const Text(
                                                          'ยันยัน',
                                                          style: TextStyle(
                                                            // fontSize: 20.0,
                                                            // fontWeight: FontWeight.bold,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                        // color: Colors.orange[900],
                                                      ),
                                                    ),
                                                    Container(
                                                      width: 150,
                                                      height: 40,
                                                      // ignore: deprecated_member_use
                                                      child: ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          backgroundColor:
                                                              Colors.black,
                                                        ),
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                context),
                                                        child: const Text(
                                                          'ยกเลิก',
                                                          style: TextStyle(
                                                            // fontSize: 20.0,
                                                            // fontWeight: FontWeight.bold,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                        // color: Colors.black,
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    icon: Icon(
                                        Icons.remove_circle_outline_outlined,
                                        color: Colors.red),
                                  ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              children: <DragAndDropItem>[
                for (int indexz = 0; indexz < zoneModels.length; indexz++)
                  if (subzoneModels[index].ser == zoneModels[indexz].sub_zone)
                    DragAndDropItem(
                      feedbackWidget: Text(zoneModels[indexz].ser.toString()),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 12),
                            child: Text(
                              '${zoneModels[indexz].zn}',
                            ),
                          ),
                        ],
                      ),
                    )
                  else if (index == 0 && zoneModels[indexz].sub_zone == '0')
                    DragAndDropItem(
                      feedbackWidget: Text(zoneModels[indexz].ser.toString()),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 12),
                            child: Text(
                              '${zoneModels[indexz].zn}',
                            ),
                          ),
                        ],
                      ),
                    )
              ],
            );
          }));
    });
  }

  Future<void> deleteZone(int index) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? ren = preferences.getString('renTalSer');
    String? ser_user = preferences.getString('ser');

    var zonename = subzoneModels[index].ser;

    String url =
        '${MyConstant().domain}/DeC_Zone_sub.php?isAdd=true&ren=$ren&ser_user=$ser_user&zonename=$zonename';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);

      if (result.toString() == 'true') {
        setState(() {
          read_GC_Sub_zone();
        });
      }
    } catch (e) {}
  }

  Future<String?> addZone() {
    return showDialog<String>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => Form(
        key: _formKey,
        child: AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: const Center(
              child: Text(
            'เพิ่มโซนพื้นที่',
            style: TextStyle(
              color: SettingScreen_Color.Colors_Text1_,
              fontFamily: FontWeight_.Fonts_T,
              fontWeight: FontWeight.bold,
            ),
          )),
          content: Container(
            // height: MediaQuery.of(context).size.height / 1.5,
            width: (!Responsive.isDesktop(context))
                ? MediaQuery.of(context).size.width
                : MediaQuery.of(context).size.width * 0.5,
            decoration: const BoxDecoration(
              // color: Colors.grey[300],
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
              // border: Border.all(color: Colors.white, width: 1),
            ),
            child: SingleChildScrollView(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'ชื่อโซน',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: SettingScreen_Color.Colors_Text1_,
                            fontFamily: FontWeight_.Fonts_T,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      // width: 200,
                      child: TextFormField(
                        controller: zone_text,
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
                            // prefixIcon:
                            //     const Icon(Icons.person_pin, color: Colors.black),
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
                            labelText: 'ชื่อโซน',
                            labelStyle: const TextStyle(
                              color: Colors.black54,
                              fontFamily: FontWeight_.Fonts_T,
                            )),
                        // inputFormatters: <
                        //     TextInputFormatter>[
                        //   FilteringTextInputFormatter
                        //       .deny(RegExp("[' ']")),
                        //   // for below version 2 use this
                        //   FilteringTextInputFormatter
                        //       .allow(RegExp(
                        //           r'[a-z A-Z 1-9]')),
                        //   // for version 2 and greater youcan also use this
                        //   // FilteringTextInputFormatter
                        //   //     .digitsOnly
                        // ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            Column(
              children: [
                const SizedBox(
                  height: 5.0,
                ),
                const Divider(
                  color: Colors.grey,
                  height: 4.0,
                ),
                const SizedBox(
                  height: 5.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
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
                          child: TextButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                SharedPreferences preferences =
                                    await SharedPreferences.getInstance();
                                String? ren =
                                    preferences.getString('renTalSer');
                                String? ser_user = preferences.getString('ser');

                                var zonename = zone_text.text;

                                String url =
                                    '${MyConstant().domain}/InC_zone_sub_setring.php?isAdd=true&ren=$ren&ser_user=$ser_user&zonename=$zonename';

                                try {
                                  var response = await http.get(Uri.parse(url));

                                  var result = json.decode(response.body);

                                  Insert_log.Insert_logs('ตั้งค่า',
                                      'พื้นที่>>เพิ่ม Sub โซนพื้นที่(${zone_text.text.toString()})');
                                  if (result.toString() == 'true') {
                                    setState(() {
                                      zone_text.clear();
                                      read_GC_Sub_zone();
                                    });

                                    Navigator.pop(context, 'OK');
                                  }
                                } catch (e) {}
                              }
                            },
                            child: const Text(
                              'บันทึก',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: FontWeight_.Fonts_T,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
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
                              'ยกเลิก',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: FontWeight_.Fonts_T,
                                fontWeight: FontWeight.bold,
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
          ],
        ),
      ),
    );
  }

  Future<Null> read_GC_zone() async {
    if (zoneModels.length != 0) {
      setState(() {
        zoneModels.clear();
      });
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var ren = preferences.getString('renTalSer');

    String url = '${MyConstant().domain}/GC_zone.php?isAdd=true&ren=$ren';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);

      for (var map in result) {
        ZoneModel zoneModel = ZoneModel.fromJson(map);
        setState(() {
          zoneModels.add(zoneModel);
        });
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    var backgroundColor = const Color.fromARGB(255, 243, 242, 248);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  for (int index = 0; index < _contents.length; index++) {
                    var Order =
                        _contents[index].lastTarget.toString().indexOf('"');
                    var Order2 = _contents[index]
                        .lastTarget
                        .toString()
                        .substring(Order + 1);
                    var Order22 = Order2.toString().indexOf('"');
                    var sub_zone = Order2.toString().substring(0, Order22);
                    print('sub_zone $sub_zone');
                    var reverseOrder = _contents[index].children;

                    for (int i = 0; i < reverseOrder.length; i++) {
                      var reverse = reverseOrder[i]
                          .feedbackWidget
                          .toString()
                          .indexOf('"');
                      var reverse2 = reverseOrder[i]
                          .feedbackWidget
                          .toString()
                          .substring(reverse + 1);
                      var zone =
                          reverse2.toString().substring(0, reverse2.length - 2);
                      print('zone $zone');
                      edit_Sub_zone(sub_zone, zone, index);
                    }
                  }
                  setState(() {
                    subzoneModels.clear;
                    read_GC_Sub_zone();
                  });
                },
                child: Container(
                    height: 50,
                    width: 200,
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                      // border: Border.all(color: Colors.white, width: 1),
                    ),
                    padding: const EdgeInsets.all(8.0),
                    child: const Center(
                        child: Text(
                      'บันทึก',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: FontWeight_.Fonts_T),
                    ))),
              ),
            ),
          ],
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width * 0.35,
          child: ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(dragDevices: {
              PointerDeviceKind.touch,
              PointerDeviceKind.mouse,
            }),
            child: DragAndDropLists(
              children: _contents,
              onItemReorder: _onItemReorder,
              onListReorder: _onListReorder,
              scrollController: _scrollController,
              axis: Axis.horizontal,
              listWidth: MediaQuery.of(context).size.width * 0.2,
              listDraggingWidth: MediaQuery.of(context).size.width * 0.2,
              listPadding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              itemDivider: Divider(
                thickness: 2,
                height: 2,
                color: backgroundColor,
              ),
              itemDecorationWhileDragging: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 3,
                    offset: const Offset(0, 0), // changes position of shadow
                  ),
                ],
              ),
              listInnerDecoration: BoxDecoration(
                color: Theme.of(context).canvasColor,
                borderRadius: const BorderRadius.all(Radius.circular(8.0)),
              ),
              lastItemTargetHeight: 8,
              addLastItemTargetHeightToTop: true,
              lastListTargetSize: 40,
              listDragHandle: const DragHandle(
                verticalAlignment: DragHandleVerticalAlignment.top,
                child: Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Icon(
                    Icons.menu,
                    color: Colors.black26,
                  ),
                ),
              ),
              itemDragHandle: const DragHandle(
                child: Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Icon(
                    Icons.menu,
                    color: Colors.blueGrey,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<Null> edit_Sub_zone(String sub_zone, String zone, int index) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? ren = preferences.getString('renTalSer');
    String? ser_user = preferences.getString('ser');

    var zone_sub = sub_zone;
    var zone_name = zone;
    var row_num = index;
    print('zone_sub $zone_sub >>zone_name>> $zone_name >>index>> $index');
    String url =
        '${MyConstant().domain}/upC_zone_sub.php?isAdd=true&ren=$ren&ser_user=$ser_user&zone_sub=$zone_sub&zone_name=$zone_name&row_num=$row_num';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);

      // Insert_log.Insert_logs('ตั้งค่า', 'จัดโซนพื้นที่');
      if (result.toString() == 'true') {
        // setState(() {
        //   subzoneModels.clear;
        //   read_GC_Sub_zone();
        // });
      }
    } catch (e) {}
  }

  _onItemReorder(
      int oldItemIndex, int oldListIndex, int newItemIndex, int newListIndex) {
    setState(() {
      var movedItem = _contents[oldListIndex].children.removeAt(oldItemIndex);
      _contents[newListIndex].children.insert(newItemIndex, movedItem);
    });
  }

  _onListReorder(int oldListIndex, int newListIndex) {
    setState(() {
      var movedList = _contents.removeAt(oldListIndex);
      _contents.insert(newListIndex, movedList);
    });
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: const Text('Drag Into List'),
  //     ),
  //     body: Container(
  //       child: Column(
  //         children: [
  //           Container(
  //             width: MediaQuery.of(context).size.width,
  //             height: MediaQuery.of(context).size.width * 0.4,
  //             child: Row(
  //               children: <Widget>[
  //                 Flexible(
  //                   flex: 10,
  //                   child: Row(
  //                     crossAxisAlignment: CrossAxisAlignment.stretch,
  //                     children: <Widget>[
  //                       Expanded(
  //                         child: Container(
  //                           color: Colors.pink,
  //                           child: Column(
  //                             children: [
  //                               for (int index = 0;
  //                                   index < zone.length;
  //                                   index++)
  //                                 Center(
  //                                   child: Draggable<DragAndDropListInterface>(
  //                                     feedback: const Icon(Icons.assignment),
  //                                     data: DragAndDropList(
  //                                       header: Text(
  //                                         '${zone[index]}',
  //                                       ),
  //                                       children: <DragAndDropItem>[],
  //                                     ),
  //                                     child: Padding(
  //                                       padding: const EdgeInsets.all(8.0),
  //                                       child: Row(
  //                                         children: [
  //                                           Icon(Icons.assignment),
  //                                           Text(
  //                                             '${zone[index]}',
  //                                           )
  //                                         ],
  //                                       ),
  //                                     ),
  //                                   ),
  //                                 ),
  //                             ],
  //                           ),
  //                         ),
  //                       ),
  //                       Expanded(
  //                         child: Container(
  //                           color: Colors.orange,
  //                           child: Column(
  //                             children: [
  //                               for (int index = 0;
  //                                   index < subzone.length;
  //                                   index++)
  //                                 Center(
  //                                   child: Draggable<DragAndDropItem>(
  //                                     feedback: const Icon(Icons.photo),
  //                                     data: DragAndDropItem(
  //                                         child: Text(
  //                                       '${subzone[index]}',
  //                                     )),
  //                                     child: Padding(
  //                                       padding: const EdgeInsets.all(8.0),
  //                                       child: Row(
  //                                         children: [
  //                                           Icon(Icons.photo),
  //                                           Text(
  //                                             '${subzone[index]}',
  //                                           )
  //                                         ],
  //                                       ),
  //                                     ),
  //                                   ),
  //                                 ),
  //                             ],
  //                           ),
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //                 Flexible(
  //                   flex: 10,
  //                   child: DragAndDropLists(
  //                     children: _contents,
  //                     onItemReorder: _onItemReorder,
  //                     onListReorder: _onListReorder,
  //                     onItemAdd: _onItemAdd,
  //                     onListAdd: _onListAdd,
  //                     listGhost: const SizedBox(
  //                       height: 250,
  //                       width: 500,
  //                       child: Center(
  //                         child: Icon(Icons.add),
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.end,
  //             children: [
  //               Padding(
  //                 padding: const EdgeInsets.all(8.0),
  //                 child: InkWell(
  //                   onTap: () {
  //                     for (int index = 0; index < _contents.length; index++) {
  //                       var Order =
  //                           _contents[index].header.toString().indexOf('"');
  //                       var Order2 = _contents[index]
  //                           .header
  //                           .toString()
  //                           .substring(Order + 1);
  //                       var Order3 =
  //                           Order2.toString().substring(0, Order2.length - 2);
  //                       print(Order3);
  //                       var reverseOrder = _contents[index].children;
  //                       for (int i = 0; i < reverseOrder.length; i++) {
  //                         var reverse = reverseOrder[i].child.toString();
  //                         // print(reverse);
  //                       }
  //                     }
  //                   },
  //                   child: Container(
  //                       height: 50,
  //                       width: 200,
  //                       decoration: const BoxDecoration(
  //                         color: Colors.green,
  //                         borderRadius: BorderRadius.only(
  //                             topLeft: Radius.circular(10),
  //                             topRight: Radius.circular(10),
  //                             bottomLeft: Radius.circular(10),
  //                             bottomRight: Radius.circular(10)),
  //                         // border: Border.all(color: Colors.white, width: 1),
  //                       ),
  //                       padding: const EdgeInsets.all(8.0),
  //                       child: const Center(
  //                           child: Text(
  //                         'ยืนยัน',
  //                         style: TextStyle(
  //                             color: PeopleChaoScreen_Color.Colors_Text1_,
  //                             fontWeight: FontWeight.bold,
  //                             fontFamily: FontWeight_.Fonts_T),
  //                       ))),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // _onItemReorder(
  //     int oldItemIndex, int oldListIndex, int newItemIndex, int newListIndex) {
  //   setState(() {
  //     var movedItem = _contents[oldListIndex].children.removeAt(oldItemIndex);
  //     _contents[newListIndex].children.insert(newItemIndex, movedItem);
  //     print('_onItemReorder $movedItem');
  //   });
  // }

  // _onListReorder(int oldListIndex, int newListIndex) {
  //   setState(() {
  //     var movedList = _contents.removeAt(oldListIndex);
  //     _contents.insert(newListIndex, movedList);
  //     print('_onItemReorder $movedList');
  //   });
  // }

  // _onItemAdd(DragAndDropItem newItem, int listIndex, int itemIndex) {
  //   setState(() {
  //     if (itemIndex == -1) {
  //       _contents[listIndex].children.add(newItem);
  //     } else {
  //       _contents[listIndex].children.insert(itemIndex, newItem);
  //     }
  //   });

  //   print('_onItemAdd ${_contents.length}');
  // }

  // _onListAdd(DragAndDropListInterface newList, int listIndex) {
  //   setState(() {
  //     if (listIndex == -1) {
  //       _contents.add(newList as DragAndDropList);
  //     } else {
  //       _contents.insert(listIndex, newList as DragAndDropList);
  //     }
  //   });

  //   print('_onListAdd ${_contents.length}');
  // }
}
