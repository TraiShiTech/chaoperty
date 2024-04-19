// ignore_for_file: unused_import, unused_local_variable, unnecessary_null_comparison, unused_field, override_on_non_overriding_member, prefer_const_constructors, unnecessary_import, implementation_imports, prefer_const_constructors_in_immutables, non_constant_identifier_names, avoid_init_to_null, prefer_void_to_null, unnecessary_brace_in_string_interps, avoid_print, empty_catches, sized_box_for_whitespace, use_build_context_synchronously, file_names, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_string_interpolations, prefer_collection_literals, sort_child_properties_last, avoid_unnecessary_containers, prefer_is_empty, prefer_final_fields, camel_case_types, avoid_web_libraries_in_flutter, prefer_typing_uninitialized_variables, no_leading_underscores_for_local_identifiers, deprecated_member_use
import 'dart:convert';
import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:drag_and_drop_lists/drag_and_drop_list_interface.dart';
import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';

import 'package:shared_preferences/shared_preferences.dart';
import '../INSERT_Log/Insert_log.dart';
import '../Model/GetContract_Rownum_Model.dart';
import '../Model/GetSubZone_Model.dart';
import '../Model/GetZone_Model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../Constant/Myconstant.dart';

import '../Responsive/responsive.dart';
import '../Style/colors.dart';

class RownumExample extends StatefulWidget {
  final Get_name_Zone;
  final Get_ser_Zonex;
  const RownumExample({
    Key? key,
    this.Get_name_Zone,
    this.Get_ser_Zonex,
  }) : super(key: key);

  @override
  State createState() => _RownumExample();
}

class _RownumExample extends State<RownumExample> {
  final ScrollController _scrollController = ScrollController();
  List<DragAndDropList> _contents = <DragAndDropList>[];
  List<ContractRownumModel> contractRownumModels = [];
  String? name_Zone, ser_Zone;
  @override
  void initState() {
    super.initState();
    name_Zone = widget.Get_name_Zone;
    ser_Zone = widget.Get_ser_Zonex;
    read_GC_rownum().then((value) => _contents = List.generate(1, (index) {
          return DragAndDropList(
            contentsWhenEmpty: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                "${widget.Get_name_Zone}",
                style: TextStyle(color: Colors.grey),
              ),
            ),
            lastTarget: Text(
              "${widget.Get_name_Zone}",
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
                            '${widget.Get_name_Zone}',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            children: <DragAndDropItem>[
              for (int indexc = 0;
                  indexc < contractRownumModels.length;
                  indexc++)
                DragAndDropItem(
                  feedbackWidget: Text("${contractRownumModels[indexc].ser}"),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 12),
                          child: Text(
                            '${contractRownumModels[indexc].sw}',
                            style: TextStyle(
                                color: PeopleChaoScreen_Color.Colors_Text2_,
                                fontFamily: Font_.Fonts_T),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 12),
                          child: Text(
                            '${contractRownumModels[indexc].ln}',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: PeopleChaoScreen_Color.Colors_Text2_,
                                fontFamily: Font_.Fonts_T),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 12),
                          child: Text(
                            '${contractRownumModels[indexc].sname}',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: PeopleChaoScreen_Color.Colors_Text2_,
                                fontFamily: Font_.Fonts_T),
                          ),
                        ),
                      )
                    ],
                  ),
                )
            ],
          );
        }));
  }

  Future<Null> read_GC_rownum() async {
    print('resultzone >>> $name_Zone $ser_Zone');
    if (contractRownumModels.length != 0) {
      setState(() {
        contractRownumModels.clear();
      });
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var ren = preferences.getString('renTalSer');

    String url = (name_Zone.toString().trim() == 'ทั้งหมด')
        ? '${MyConstant().domain}/GC_areaAll_rownum.php?isAdd=true&ren=$ren&zone=0'
        : '${MyConstant().domain}/GC_areaAll_rownum.php?isAdd=true&ren=$ren&zone=$ser_Zone';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);
      if (result != null) {
        contractRownumModels.clear();
        for (var map in result) {
          ContractRownumModel contractRownumModel =
              ContractRownumModel.fromJson(map);
          setState(() {
            contractRownumModels.add(contractRownumModel);
          });
        }
      } else {}
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    var backgroundColor = const Color.fromARGB(255, 243, 242, 248);

    return Column(
      children: [
        Container(
          height: 50,
          decoration:  BoxDecoration(
            color: AppbackgroundColor.TiTile_Colors,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(0)),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: AutoSizeText(
                  minFontSize: 10,
                  maxFontSize: 25,
                  maxLines: 1,
                  'ลำดับ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: PeopleChaoScreen_Color.Colors_Text2_,
                      fontFamily: FontWeight_.Fonts_T),
                ),
              ),
              Expanded(
                flex: 4,
                child: AutoSizeText(
                  minFontSize: 10,
                  maxFontSize: 25,
                  maxLines: 1,
                  'รหัสพื้นที่',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: PeopleChaoScreen_Color.Colors_Text2_,
                      fontFamily: FontWeight_.Fonts_T),
                ),
              ),
              Expanded(
                flex: 4,
                child: AutoSizeText(
                  minFontSize: 10,
                  maxFontSize: 25,
                  maxLines: 1,
                  'ชื่อผู้เช่า',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: PeopleChaoScreen_Color.Colors_Text2_,
                      fontFamily: FontWeight_.Fonts_T),
                ),
              ),
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
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
                        for (int index = 0; index < _contents.length; index++) {
                          // var Order = _contents[index]
                          //     .lastTarget
                          //     .toString()
                          //     .indexOf('"');
                          // var Order2 = _contents[index]
                          //     .lastTarget
                          //     .toString()
                          //     .substring(Order + 1);
                          // var Order22 = Order2.toString().indexOf('"');
                          // var sub_zone =
                          //     Order2.toString().substring(0, Order22);
                          // print('sub_zone $sub_zone');
                          var sub_zone =
                              (_contents[index].lastTarget as Text).data;
                          List<DragAndDropItem> reverseOrder =
                              _contents[index].children;

                          for (int i = 0; i < reverseOrder.length; i++) {
                            // var reverse = reverseOrder[i]
                            //     .feedbackWidget
                            //     .toString()
                            //     .indexOf('"');
                            // var reverse2 = reverseOrder[i]
                            //     .feedbackWidget
                            //     .toString()
                            //     .substring(reverse + 1);
                            // var zone = reverse2
                            //     .toString()
                            //     .substring(0, reverse2.length - 2);
                            var zone =
                                (reverseOrder[i].feedbackWidget as Text).data;
                            print('zone $zone');
                            edit_SW(i, zone!);
                          }
                        }
                        setState(() {
                          read_GC_rownum();
                        });
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
              )
            ],
          ),
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
              listWidth: Responsive.isDesktop(context)
                  ? MediaQuery.of(context).size.width * 0.8
                  : MediaQuery.of(context).size.width * 0.8,
              listDraggingWidth: Responsive.isDesktop(context)
                  ? MediaQuery.of(context).size.width * 0.8
                  : MediaQuery.of(context).size.width * 0.8,
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

  Future<Null> edit_SW(int sub_zone, String zone) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? ren = preferences.getString('renTalSer');
    String? ser_user = preferences.getString('ser');
    var vser = zone;
    String url =
        '${MyConstant().domain}/UpC_rownum.php?isAdd=true&ren=$ren&vser=$vser&value=${sub_zone + 1}&ser_user=$ser_user';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print(result);
      if (result.toString() == 'true') {
        // setState(() {
        //   read_GC_rownum();
        // });
      } else {}
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
