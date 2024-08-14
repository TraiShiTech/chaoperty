import 'dart:convert';
import 'dart:html';
import 'dart:typed_data';
import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../Constant/Myconstant.dart';
import '../Model/GetRenTal_Model.dart';
import '../PeopleChao/Pays_.dart';
import '../Responsive/responsive.dart';
import '../Style/colors.dart';

class Bill_DocumentTemplate extends StatefulWidget {
  const Bill_DocumentTemplate({super.key});

  @override
  State<Bill_DocumentTemplate> createState() => _Bill_DocumentTemplateState();
}

class _Bill_DocumentTemplateState extends State<Bill_DocumentTemplate> {
  List<RenTalModel> renTalModels = [];
  int serfor_tem = 7;
  var renTal_name;
  String rtser = '';
  String? rtname,
      type,
      typex,
      renname,
      bill_name,
      bill_addr,
      bill_tax,
      bill_tel,
      bill_email,
      expbill,
      expbill_name,
      bill_default,
      bill_tser,
      foder,
      tem_page_ser;
  String? bills_name_;
  int sertap_dialog_tempage = 0;
  @override
  void initState() {
    super.initState();
    read_GC_rental();
    // checkPreferance();
  }

  Future<Null> checkPreferance() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    // setState(() {
    //   renTal_user = preferences.getString('renTalSer');
    //   renTal_name = preferences.getString('renTalName');
    //   fname_ = preferences.getString('fname');
    // });
    System_New_Update();
  }

  System_New_Update() async {
    // String accept_ = showst_update_!;
    showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        title: Text(
          '📢ขออภัย !!!! ',
          textAlign: TextAlign.end,
          style: TextStyle(
            fontSize: 12,
            color: Colors.red,
            fontFamily: Font_.Fonts_T,
          ),
        ),
        content: Container(
          decoration: BoxDecoration(
            image: const DecorationImage(
              image: AssetImage("images/pngegg.png"),
              // fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'ขออภัย ขณะนี้ฟังก์ชั่นก์  อยู่ในช่วงทดสอบ... !!!!!! ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontFamily: FontWeight_.Fonts_T,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: <Widget>[
          StreamBuilder(
              stream: Stream.periodic(const Duration(seconds: 1)),
              builder: (context, snapshot) {
                return Column(
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
                          Container(
                            width: 100,
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10)),
                            ),
                            padding: const EdgeInsets.all(8.0),
                            child: TextButton(
                              onPressed: () async {
                                Navigator.pop(context, 'OK');
                              },
                              child: const Text(
                                'รับทราบ',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: FontWeight_.Fonts_T),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              })
        ],
      ),
    );
  }

  Future<Null> read_GC_rental() async {
    if (renTalModels.isNotEmpty) {
      setState(() {
        renTalModels.clear();
      });
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
          setState(() {
            rtser = renTalModel.ser!.trim();
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
            tem_page_ser = renTalModel.tem_page!.trim();
            renTalModels.add(renTalModel);
            if (bill_defaultx == 'P') {
              bills_name_ = 'บิลธรรมดา';
            } else {
              bills_name_ = 'ใบกำกับภาษี';
            }
          });
        }
      } else {}
      if (rtser.toString() == '72' ||
          rtser.toString() == '92' ||
          rtser.toString() == '93' ||
          rtser.toString() == '94') {
        setState(() {
          serfor_tem = 8;
        });
      }
    } catch (e) {}

    print('name>>>>>  $renname');
  }

//////////////////////////////------------------------------------->
  TransformationController _controller = TransformationController();
  void _zoomInSVG() {
    _controller.value *= Matrix4.identity()..scale(1.2);
  }

  void _zoomOutSVG() {
    _controller.value *= Matrix4.identity()..scale(0.8);
  }

  List name_bill_png = ['B1', 'B2', 'B3'];

  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            color: AppbackgroundColor.Sub_Abg_Colors,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10)),
            // border: Border.all(color: Colors.white, width: 1),
          ),
          child: Column(children: [
            ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(dragDevices: {
                PointerDeviceKind.touch,
                PointerDeviceKind.mouse,
              }),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    for (int index = 0; index < 7; index++)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 400,
                          child: Column(
                            children: [
                              Container(
                                width: 400,
                                padding: const EdgeInsets.all(4.0),
                                decoration: BoxDecoration(
                                  color: AppbackgroundColor.TiTile_Colors,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(0),
                                    bottomRight: Radius.circular(0),
                                  ),
                                  // border: Border.all(
                                  //     color: Colors.grey, width: 1),
                                ),
                                child: Column(
                                  children: [
                                    if (index + 1 == 4)
                                      (rtser.toString() == '72' ||
                                              rtser.toString() == '92' ||
                                              rtser.toString() == '93' ||
                                              rtser.toString() == '94')
                                          ? Text(
                                              'พิเศษเฉพาะเครือ องค์การตลาด กระทรวงมหาดไทย [อ.ต.]',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.orange[900],
                                                  fontFamily:
                                                      FontWeight_.Fonts_T,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 13.0),
                                            )
                                          : (rtser.toString() == '106')
                                              ? Text(
                                                  'พิเศษเฉพาะบริษัท ชอยส์ มินิสโตร์ จำกัด',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Colors.orange[900],
                                                      fontFamily:
                                                          FontWeight_.Fonts_T,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 13.0),
                                                )
                                              : SizedBox(),
                                    Row(
                                      children: [
                                        Text(
                                          (index + 1 == 1)
                                              ? 'เทมเพลต ${index + 1} ( Standard )'
                                              : (index + 1 == 5)
                                                  ? 'เทมเพลต ${index + 1} ( Lao - ລາວ )'
                                                  : 'เทมเพลต ${index + 1} ',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: SettingScreen_Color
                                                .Colors_Text1_,
                                            fontFamily: FontWeight_.Fonts_T,
                                            fontWeight: FontWeight.bold,
                                            //fontSize: 10.0
                                          ),
                                        ),
                                        Expanded(
                                            child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              'เลือก :  ',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: SettingScreen_Color
                                                    .Colors_Text1_,
                                                fontFamily: FontWeight_.Fonts_T,
                                                fontWeight: FontWeight.bold,
                                                //fontSize: 10.0
                                              ),
                                            ),
                                            IconButton(
                                                onPressed: () async {
                                                  ///-------------------------------->
                                                  SharedPreferences
                                                      preferences =
                                                      await SharedPreferences
                                                          .getInstance();
                                                  String? ren = preferences
                                                      .getString('renTalSer');

                                                  String url =
                                                      '${MyConstant().domain}/UP_Tempage.php?isAdd=true&ren=$ren&tempage_ser=${index}';

                                                  try {
                                                    var response = await http
                                                        .get(Uri.parse(url));

                                                    var result = json
                                                        .decode(response.body);
                                                    if (result.toString() ==
                                                        'true') {
                                                      print(
                                                          'check_box ${index + 1}  ///$ren');
                                                      setState(() {
                                                        read_GC_rental();
                                                      });
                                                    }
                                                  } catch (e) {
                                                    print(e);
                                                  }
                                                },
                                                icon:
                                                    (index.toString().trim() ==
                                                            tem_page_ser
                                                                .toString()
                                                                .trim())
                                                        ? const Icon(
                                                            Icons.check_box,
                                                            color: Colors.green,
                                                          )
                                                        : const Icon(
                                                            Icons
                                                                .check_box_outline_blank,
                                                            color: Colors.grey,
                                                          ))
                                            // Container(
                                            //   width: 100,
                                            //   padding: const EdgeInsets.all(8.0),
                                            //   decoration: const BoxDecoration(
                                            //     color: Colors.white,
                                            //     borderRadius: BorderRadius.only(
                                            //       topLeft: Radius.circular(10),
                                            //       topRight: Radius.circular(10),
                                            //       bottomLeft: Radius.circular(10),
                                            //       bottomRight: Radius.circular(10),
                                            //     ),
                                            //   ),
                                            // )
                                          ],
                                        ))
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Stack(
                                children: [
                                  Container(
                                      width: 400,
                                      height: 570,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(0),
                                            topRight: Radius.circular(0),
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10)),
                                        border: Border.all(
                                            color: Colors.grey, width: 1),
                                      ),
                                      child: (index + 1 == 4)
                                          ? (rtser.toString() == '72' ||
                                                  rtser.toString() == '92' ||
                                                  rtser.toString() == '93' ||
                                                  rtser.toString() == '94')
                                              ? SfPdfViewer.asset(
                                                  'images/TP${index + 1}/B1_PDF_Ortor.pdf',
                                                  enableDocumentLinkAnnotation:
                                                      false,
                                                  canShowScrollHead: false,
                                                  canShowScrollStatus: false,
                                                  pageLayoutMode:
                                                      PdfPageLayoutMode
                                                          .continuous,
                                                  enableDoubleTapZooming: false,
                                                )
                                              : (rtser.toString() == '106')
                                                  ? SfPdfViewer.asset(
                                                      'images/TP${index + 1}/B1_PDF_Choice.pdf',
                                                      enableDocumentLinkAnnotation:
                                                          false,
                                                      canShowScrollHead: false,
                                                      canShowScrollStatus:
                                                          false,
                                                      pageLayoutMode:
                                                          PdfPageLayoutMode
                                                              .continuous,
                                                      enableDoubleTapZooming:
                                                          false,
                                                    )
                                                  : PreviewScreen_doc2(
                                                      Url: (index + 1 == 4)
                                                          ? 'images/TP${index + 1}/B1_PDF.pdf'
                                                          : 'images/TP${index + 1}/B1_PDF.pdf',
                                                      //'images/TP6/B1_TP60.pdf',
                                                      title:
                                                          '${rtser}Sample-TP${index + 1}')
                                          : PreviewScreen_doc2(
                                              Url: (index + 1 == 4)
                                                  ? 'images/TP${index + 1}/B1_PDF.pdf'
                                                  : 'images/TP${index + 1}/B1_PDF.pdf',
                                              //'images/TP6/B1_TP60.pdf',
                                              title:
                                                  '${rtser}Sample-TP${index + 1}')
                                      // Image(
                                      //   image: AssetImage(
                                      //     (index + 1 == 4)
                                      //         ? (rtser.toString() == '72' ||
                                      //                 rtser.toString() == '92' ||
                                      //                 rtser.toString() == '93' ||
                                      //                 rtser.toString() == '94')
                                      //             ? 'images/TP${index + 1}_1/B1_TP${index + 1}_1.png'
                                      //             : 'images/TP${index + 1}/B1_TP${index + 1}.png'
                                      //         : 'images/TP${index + 1}/B1_TP${index + 1}.png',
                                      //   ),
                                      // ),
                                      ),
                                  Positioned(
                                      top: 10,
                                      right: 20,
                                      child: IconButton(
                                          onPressed: () async {
                                            // showDialog<void>(
                                            //   context: context,
                                            //   barrierDismissible:
                                            //       false, // user must tap button!
                                            //   builder: (BuildContext context) {
                                            //     return
                                            // StreamBuilder(
                                            //         stream: Stream.periodic(
                                            //             const Duration(
                                            //                 milliseconds: 400)),
                                            //         builder:
                                            //             (context, snapshot) {
                                            //           return AlertDialog(
                                            //             backgroundColor:
                                            //                 Colors.grey[200],
                                            //             title: Column(
                                            //               children: [
                                            //                 if (index + 1 == 4)
                                            //                   Text(
                                            //                     (rtser.toString() == '72' ||
                                            //                             rtser.toString() ==
                                            //                                 '92' ||
                                            //                             rtser.toString() ==
                                            //                                 '93' ||
                                            //                             rtser.toString() ==
                                            //                                 '94')
                                            //                         ? 'พิเศษเฉพาะเครือ องค์การตลาด กระทรวงมหาดไทย [อ.ต.] '
                                            //                         : '',
                                            //                     textAlign:
                                            //                         TextAlign
                                            //                             .center,
                                            //                     style: TextStyle(
                                            //                         color: Colors
                                            //                                 .orange[
                                            //                             900],
                                            //                         fontFamily:
                                            //                             FontWeight_
                                            //                                 .Fonts_T,
                                            //                         fontWeight:
                                            //                             FontWeight
                                            //                                 .bold,
                                            //                         fontSize:
                                            //                             13.0),
                                            //                   ),
                                            //                 Text(
                                            //                   (index + 1 == 1)
                                            //                       ? 'ตัวอย่าง เทมเพลต ${index + 1} ( Standard )'
                                            //                       : 'ตัวอย่าง เทมเพลต ${index + 1} ',
                                            //                   textAlign:
                                            //                       TextAlign
                                            //                           .center,
                                            //                   style: TextStyle(
                                            //                     fontSize: 12,
                                            //                     color: Colors
                                            //                         .black,
                                            //                     fontFamily: Font_
                                            //                         .Fonts_T,
                                            //                   ),
                                            //                 ),
                                            //                 Row(
                                            //                   children: [
                                            //                     for (int i = 0;
                                            //                         i < 3;
                                            //                         i++)
                                            //                       Padding(
                                            //                         padding:
                                            //                             const EdgeInsets.all(
                                            //                                 2.0),
                                            //                         child:
                                            //                             InkWell(
                                            //                           onTap:
                                            //                               () async {
                                            //                             setState(
                                            //                                 () {
                                            //                               sertap_dialog_tempage =
                                            //                                   i;
                                            //                               _controller
                                            //                                   .value = Matrix4.identity()
                                            //                                 ..scale(1.0);
                                            //                             });
                                            //                             // print(
                                            //                             //     '${'images/TP${index + 1}/${name_bill_png[sertap_dialog_tempage]}_TP${index + 1}.png'}');
                                            //                           },
                                            //                           child:
                                            //                               Container(
                                            //                             decoration:
                                            //                                 BoxDecoration(
                                            //                               color: (sertap_dialog_tempage != i)
                                            //                                   ? null
                                            //                                   : Colors.blue[200],
                                            //                               borderRadius: BorderRadius.only(
                                            //                                   topLeft: Radius.circular(10),
                                            //                                   topRight: Radius.circular(10),
                                            //                                   bottomLeft: Radius.circular(10),
                                            //                                   bottomRight: Radius.circular(10)),
                                            //                             ),
                                            //                             padding:
                                            //                                 const EdgeInsets.all(8.0),
                                            //                             child:
                                            //                                 Text(
                                            //                               '${i + 1}',
                                            //                               textAlign:
                                            //                                   TextAlign.center,
                                            //                               style:
                                            //                                   TextStyle(
                                            //                                 fontSize:
                                            //                                     12,
                                            //                                 color:
                                            //                                     Colors.blue,
                                            //                                 fontFamily:
                                            //                                     Font_.Fonts_T,
                                            //                               ),
                                            //                             ),
                                            //                           ),
                                            //                         ),
                                            //                       ),
                                            //                   ],
                                            //                 )
                                            //               ],
                                            //             ),
                                            //             content:
                                            //                 InteractiveViewer(
                                            //               alignment:
                                            //                   Alignment.center,
                                            //               scaleEnabled: false,
                                            //               trackpadScrollCausesScale:
                                            //                   false,
                                            //               transformationController:
                                            //                   _controller,
                                            //               minScale: 0.9,
                                            //               maxScale: 2.0,
                                            //               constrained: true,
                                            //               boundaryMargin:
                                            //                   const EdgeInsets
                                            //                           .all(
                                            //                       double
                                            //                           .infinity),
                                            //               child:
                                            //                   SingleChildScrollView(
                                            //                 child: ListBody(
                                            //                   children: <Widget>[
                                            //                     Image(
                                            //                       image:
                                            //                           AssetImage(
                                            //                         (index + 1 ==
                                            //                                 4)
                                            //                             ? (rtser.toString() == '72' ||
                                            //                                     rtser.toString() == '92' ||
                                            //                                     rtser.toString() == '93' ||
                                            //                                     rtser.toString() == '94')
                                            //                                 ? 'images/TP${index + 1}_1/${name_bill_png[sertap_dialog_tempage]}_TP${index + 1}_1.png'
                                            //                                 : 'images/TP${index + 1}/${name_bill_png[sertap_dialog_tempage]}_TP${index + 1}.png'
                                            //                             : 'images/TP${index + 1}/${name_bill_png[sertap_dialog_tempage]}_TP${index + 1}.png',
                                            //                         // 'images/TP${index + 1}/${name_bill_png[sertap_dialog_tempage]}_TP${index + 1}.png'
                                            //                       ),
                                            //                     ),
                                            //                   ],
                                            //                 ),
                                            //               ),
                                            //             ),
                                            //             actions: <Widget>[
                                            //               Column(
                                            //                 children: [
                                            //                   Divider(
                                            //                     color: Colors
                                            //                         .grey[300],
                                            //                     height: 1.0,
                                            //                   ),
                                            //                   const SizedBox(
                                            //                     height: 5.0,
                                            //                   ),
                                            //                   Row(
                                            //                     children: [
                                            //                       Container(
                                            //                         decoration:
                                            //                             const BoxDecoration(
                                            //                           color: Colors
                                            //                               .grey,
                                            //                           borderRadius: BorderRadius.only(
                                            //                               topLeft: Radius.circular(
                                            //                                   10),
                                            //                               topRight: Radius.circular(
                                            //                                   10),
                                            //                               bottomLeft: Radius.circular(
                                            //                                   10),
                                            //                               bottomRight:
                                            //                                   Radius.circular(10)),
                                            //                         ),
                                            //                         child: Row(
                                            //                           children: [
                                            //                             IconButton(
                                            //                               icon:
                                            //                                   const Icon(
                                            //                                 Icons.zoom_in,
                                            //                                 color:
                                            //                                     Colors.black,
                                            //                               ),
                                            //                               onPressed:
                                            //                                   _zoomInSVG,
                                            //                             ),
                                            //                             IconButton(
                                            //                               icon:
                                            //                                   const Icon(
                                            //                                 Icons.zoom_out,
                                            //                                 color:
                                            //                                     Colors.black,
                                            //                               ),
                                            //                               onPressed:
                                            //                                   _zoomOutSVG,
                                            //                             ),
                                            //                           ],
                                            //                         ),
                                            //                       ),
                                            //                       Expanded(
                                            //                         child:
                                            //                             Align(
                                            //                           alignment:
                                            //                               Alignment
                                            //                                   .centerRight,
                                            //                           child:
                                            //                               Container(
                                            //                             width:
                                            //                                 80,
                                            //                             decoration:
                                            //                                 const BoxDecoration(
                                            //                               color:
                                            //                                   Colors.black,
                                            //                               borderRadius: BorderRadius.only(
                                            //                                   topLeft: Radius.circular(10),
                                            //                                   topRight: Radius.circular(10),
                                            //                                   bottomLeft: Radius.circular(10),
                                            //                                   bottomRight: Radius.circular(10)),
                                            //                             ),
                                            //                             padding:
                                            //                                 const EdgeInsets.all(8.0),
                                            //                             child:
                                            //                                 TextButton(
                                            //                               onPressed:
                                            //                                   () {
                                            //                                 setState(() {
                                            //                                   _controller.value = Matrix4.identity()..scale(1.0);
                                            //                                 });
                                            //                                 Navigator.pop(context,
                                            //                                     'OK');
                                            //                               },
                                            //                               child:
                                            //                                   const Text(
                                            //                                 'ปิด',
                                            //                                 style: TextStyle(
                                            //                                     color: Colors.white,
                                            //                                     fontWeight: FontWeight.bold,
                                            //                                     fontFamily: FontWeight_.Fonts_T),
                                            //                               ),
                                            //                             ),
                                            //                           ),
                                            //                         ),
                                            //                       ),
                                            //                     ],
                                            //                   ),
                                            //                 ],
                                            //               ),
                                            //             ],
                                            //           );
                                            //         });
                                            //   },
                                            // );

                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      PreviewScreen_doc(
                                                          Url: (index + 1 == 4)
                                                              ? (rtser.toString() == '72' ||
                                                                      rtser.toString() ==
                                                                          '92' ||
                                                                      rtser.toString() ==
                                                                          '93' ||
                                                                      rtser.toString() ==
                                                                          '94')
                                                                  ? 'images/TP${index + 1}/B1_PDF_Ortor.pdf'
                                                                  : (rtser.toString() ==
                                                                          '106')
                                                                      ? 'images/TP${index + 1}/B1_PDF_Choice.pdf'
                                                                      : 'images/TP${index + 1}/B1_PDF.pdf'
                                                              : 'images/TP${index + 1}/B1_PDF.pdf',
                                                          //'images/TP6/B1_TP60.pdf',
                                                          title: (index + 1 ==
                                                                  1)
                                                              ? 'ตัวอย่าง เทมเพลต ${index + 1} ( Standard )'
                                                              : 'ตัวอย่าง เทมเพลต ${index + 1} ')),
                                            );
                                          },
                                          icon: Icon(
                                            Icons.visibility,
                                            color: Colors.blue.withOpacity(0.5),
                                          )))
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ]),
        ));
  }
}

class PreviewScreen_doc extends StatefulWidget {
  final title;
  final Url;

  const PreviewScreen_doc({super.key, required this.title, required this.Url});
  @override
  _PreviewScreen_docState createState() => _PreviewScreen_docState();
}

class _PreviewScreen_docState extends State<PreviewScreen_doc> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey =
      GlobalKey<SfPdfViewerState>();
  final PdfViewerController _pdfViewerController = PdfViewerController();
  double _currentZoomLevel = 1.0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        // title: 'Flutter Demo',

        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: AppBarColors.hexColor,
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.arrow_back_outlined,
                color: Colors.white,
              ),
            ),
            centerTitle: true,
            title: Text('${widget.title}'),
            actions: [
              IconButton(
                icon: Icon(Icons.zoom_in),
                onPressed: () {
                  setState(() {
                    _currentZoomLevel += 0.25;
                    if (_currentZoomLevel > 3.0) _currentZoomLevel = 3.0;
                    _pdfViewerController.zoomLevel = _currentZoomLevel;
                  });
                },
              ),
              IconButton(
                icon: Icon(Icons.zoom_out),
                onPressed: () {
                  setState(() {
                    _currentZoomLevel -= 0.25;
                    if (_currentZoomLevel < 1.0) _currentZoomLevel = 1.0;
                    _pdfViewerController.zoomLevel = _currentZoomLevel;
                  });
                },
              ),
            ],
          ),
          body: SfPdfViewer.asset(
            '${widget.Url}',
            key: _pdfViewerKey,
            controller: _pdfViewerController,
            enableDocumentLinkAnnotation: false,
            canShowScrollHead: false,
            canShowScrollStatus: false,
            pageLayoutMode: PdfPageLayoutMode.continuous,
            enableDoubleTapZooming: true,
            onZoomLevelChanged: (details) {
              setState(() {
                _currentZoomLevel = details.newZoomLevel;
              });
            },
          ),
        ));
  }
}

class PreviewScreen_doc2 extends StatefulWidget {
  final title;
  final Url;

  const PreviewScreen_doc2({super.key, required this.title, required this.Url});
  @override
  _PreviewScreen_doc2State createState() => _PreviewScreen_doc2State();
}

class _PreviewScreen_doc2State extends State<PreviewScreen_doc2> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey =
      GlobalKey<SfPdfViewerState>();
  final PdfViewerController _pdfViewerController = PdfViewerController();
  double _currentZoomLevel = 1.0;

  @override
  Widget build(BuildContext context) {
    return SfPdfViewer.asset(
      '${widget.Url}',
      key: _pdfViewerKey,
      controller: _pdfViewerController,
      enableDocumentLinkAnnotation: false,
      canShowScrollHead: false,
      canShowScrollStatus: false,
      pageLayoutMode: PdfPageLayoutMode.continuous,
      enableDoubleTapZooming: false,
    );
  }
}
