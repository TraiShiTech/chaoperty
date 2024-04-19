import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_barcodes/barcodes.dart';
import '../Constant/Myconstant.dart';
import '../Model/GetArea_Model.dart';
import '../Model/GetC_regis_Model.dart';
import '../Model/GetContract_Photo_Model.dart';
import '../Model/GetRenTal_Model.dart';
import '../Model/GetTeNant_Model.dart';
import '../Model/GetTranBill_model.dart';
import '../Model/GetZone_Model.dart';
import '../Responsive/responsive.dart';
import '../Style/colors.dart';
import '../Style/downloadImage.dart';
import 'Details_Rental_customer.dart';
import 'QR_PDF.dart';

class People_GenQR extends StatefulWidget {
  const People_GenQR({super.key});

  @override
  State<People_GenQR> createState() => _People_GenQRState();
}

class _People_GenQRState extends State<People_GenQR> {
  var nFormat = NumberFormat("#,##0.00", "en_US");
  /////--------------------------->
  int limit = 24; // The maximum number of items you want
  int offset = 0; // The starting index of items you want
  int endIndex = 0;
  /////--------------------------->
  DateTime datex = DateTime.now();
  String tappedIndex_ = '';
  List<ZoneModel> zoneModels = [];
  List<TeNantModel> limitedList_teNantModels = [];
  List<TeNantModel> teNantModels = [];
  List<TeNantModel> teNantModels_Sum = [];
  List<TeNantModel> _teNantModels = <TeNantModel>[];
  List<RenTalModel> renTalModels = [];
  List<List<dynamic>> teNantModels_Save = [];
  List<ContractPhotoModel> contractPhotoModels = [];

  String? renTal_user, renTal_name, zone_ser, zone_name, Value_cid, fname_;
  int Status_cuspang = 0;
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
      bills_name_,
      imglogo_,
      imgl,
      pkname;
  String? ser_user,
      position_user,
      fname_user,
      lname_user,
      email_user,
      utype_user,
      permission_user,
      tel_user,
      img_,
      img_logo;
  String text_data = '';
  Color cardColor = Colors.green[300]!;
  int indexcardColor = 0;
  List<dynamic> colorList = [
    Colors.green[300],
    Colors.red[300],
    Colors.blue[300],
    Colors.yellow[300],
    Colors.orange[300],
    Colors.purple[300],
    Colors.teal[300],
    Colors.pink[300],
    Colors.indigo[300],
    Colors.cyan[300],
    Colors.brown[300],
    Colors.black,
    Colors.grey[300],
  ];
  void changeCardColor(namecolor) {
    setState(() {
      // Change the color to a different one
      cardColor = namecolor; // You can replace this with any color you want
    });
  }

  ///////---------------------------------------------------->

  int Status_ = 1, open_set_date = 30;
  int index_listviwe = 0;
  int renTal_lavel = 0;
  int? pkqty, pkuser, countarae;
  String? serPositioned;
  ///////---------------------------------------------------->showMyDialog_SAVE

  late List<GlobalKey> qrImageKey;
  List<Uint8List> netImage = [];

  late List<GlobalKey> controller;
  Uint8List? bytes;
  ///////---------------------------------------------------->
  @override
  void initState() {
    checkPreferance();
    read_GC_rental();
    read_GC_zone();
    teNantModels_Save = [];
    super.initState();
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
      Map<String, dynamic> map = Map();
      map['ser'] = '0';
      map['rser'] = '0';
      map['zn'] = 'กรุณาเลือกโซนพื้นที่';
      map['qty'] = '0';
      map['img'] = '0';
      map['data_update'] = '0';

      ZoneModel zoneModelx = ZoneModel.fromJson(map);

      setState(() {
        zoneModels.add(zoneModelx);
      });

      for (var map in result) {
        ZoneModel zoneModel = ZoneModel.fromJson(map);
        setState(() {
          zoneModels.add(zoneModel);
        });
      }
      zoneModels.sort((a, b) {
        if (a.zn == 'กรุณาเลือกโซนพื้นที่') {
          return -1; // 'all' should come before other elements
        } else if (b.zn == 'กรุณาเลือกโซนพื้นที่') {
          return 1; // 'all' should come after other elements
        } else {
          return a.zn!
              .compareTo(b.zn!); // sort other elements in ascending order
        }
      });
    } catch (e) {}
  }

  Future<Null> checkPreferance() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      renTal_user = preferences.getString('renTalSer');
      renTal_name = preferences.getString('renTalName');
      fname_ = preferences.getString('fname');
      renTal_lavel = int.parse(preferences.getString('lavel').toString());
      teNantModels_Save = List.generate(300, (_) => []);
    });
  }

  Future<Null> read_GC_rental() async {
    if (renTalModels.isNotEmpty) {
      renTalModels.clear();
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    var utype = preferences.getString('utype');
    var seruser = preferences.getString('ser');
    String url =
        '${MyConstant().domain}/GC_rental_setring.php?isAdd=true&ser=$seruser&type=$utype&ren=$ren';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);
      if (result != null) {
        for (var map in result) {
          RenTalModel renTalModel = RenTalModel.fromJson(map);
          var rtnamex = renTalModel.rtname;
          var typexs = renTalModel.type;
          var typexx = renTalModel.typex;
          var name = renTalModel.pn!.trim();
          var pkqtyx = int.parse(renTalModel.pkqty!);
          var pkuserx = int.parse(renTalModel.pkuser!);
          var pkx = renTalModel.pk!.trim();
          var foderx = renTalModel.dbn;
          var img = renTalModel.img;
          var imglogo = renTalModel.imglogo;
          var bill_addrx = renTalModel.bill_addr!.trim();
          var bill_taxx = renTalModel.bill_tax!.trim();
          var bill_telx = renTalModel.bill_tel!.trim();
          var bill_emailx = renTalModel.bill_email!.trim();
          var bill_defaultx = renTalModel.bill_default;
          var bill_tserx = renTalModel.tser;
          var open_set_datex = int.parse(renTalModel.open_set_date!);
          setState(() {
            open_set_date = open_set_datex == 0 ? 30 : open_set_datex;
            foder = foderx;
            rtname = rtnamex;
            type = typexs;
            typex = typexx;
            renname = name;
            pkqty = pkqtyx;
            pkuser = pkuserx;
            pkname = pkx;
            img_ = img;
            img_logo = imglogo;
            bill_addr = bill_addrx;
            bill_tax = bill_taxx;
            bill_tel = bill_telx;
            bill_email = bill_emailx;
            bill_default = bill_defaultx;
            bill_tser = bill_tserx;
            bill_name = renTalModel.bill_name;

            renTalModels.add(renTalModel);
          });
        }
      } else {}
    } catch (e) {}
    print('Peoplename>>>>>  $renname >>> $open_set_date');
  }

  /////////////////-------------------------------------------------->
  int teNantModels_Save_index = 0;
  int teNantModels_List_count = 0;
  int List_count = 0;

/////////////////////----------------------------------------->
  Future<Null> read_GC_tenant() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    var zone = zone_ser;
    setState(() {
      teNantModels_Save_index = 0;
      teNantModels_List_count = 0;
      List_count = 0;
      limitedList_teNantModels.clear();
    });
    for (int index = 0; index < teNantModels_Save.length; index++) {
      teNantModels_Save[index].clear();
    }

    String url =
        '${MyConstant().domain}/GC_tenant.php?isAdd=true&ren=$ren&zone=$zone';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);
      if (result != null) {
        for (var map in result) {
          TeNantModel teNantModel = TeNantModel.fromJson(map);
          if (teNantModel.quantity == '1') {
            var daterx = teNantModel.ldate == null
                ? teNantModel.ldate_q
                : teNantModel.ldate;

            if (daterx != null) {
              int daysBetween(DateTime from, DateTime to) {
                from = DateTime(from.year, from.month, from.day);
                to = DateTime(to.year, to.month, to.day);
                return (to.difference(from).inHours / 24).round();
              }

              var birthday = DateTime.parse('$daterx 00:00:00.000')
                  .add(const Duration(days: -30));
              var date2 = DateTime.now();
              var difference = daysBetween(birthday, date2);

              print('difference == $difference');

              var daterx_now = DateTime.now();

              var daterx_ldate = DateTime.parse('$daterx 00:00:00.000');

              final now = DateTime.now();
              final earlier = daterx_ldate.subtract(const Duration(days: 0));
              var daterx_A = now.isAfter(earlier);
              print(now.isAfter(earlier)); // true
              print(now.isBefore(earlier)); // true

              if (daterx_A != true) {
                setState(() {
                  limitedList_teNantModels.add(teNantModel);
                });
              }
            }
          }
        }
      } else {}

      setState(() {
        _teNantModels = limitedList_teNantModels;
      });
      read_tenant_limit();
    } catch (e) {}
  }

  /////////////////--------------------------->
  Future<Null> read_tenant_limit() async {
    setState(() {
      endIndex = offset + limit;
      teNantModels = limitedList_teNantModels.sublist(
          offset, // Start index
          (endIndex <= limitedList_teNantModels.length)
              ? endIndex
              : limitedList_teNantModels.length // End index
          );
    });
    setState(() {
      qrImageKey = List.generate(teNantModels.length, (_) => GlobalKey());
      teNantModels_Save = List.generate((teNantModels.length), (_) => []);
      controller =
          List.generate(limitedList_teNantModels.length, (_) => GlobalKey());
    });
  }

  /////////////////--------------------------->
  Widget Next_page_Web() {
    return Row(
      children: [
        Expanded(child: Text('')),
        StreamBuilder(
            stream: Stream.periodic(const Duration(milliseconds: 300)),
            builder: (context, snapshot) {
              return Container(
                decoration: const BoxDecoration(
                  color: AppbackgroundColor.Sub_Abg_Colors,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                ),
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.menu_book,
                      color: Colors.grey,
                      size: 20,
                    ),
                    InkWell(
                        onTap: (offset == 0)
                            ? null
                            : () async {
                                if (offset == 0) {
                                } else {
                                  setState(() {
                                    offset = offset - limit;

                                    read_tenant_limit();
                                    tappedIndex_ = '';
                                  });
                                  // _scrollController1.animateTo(
                                  //   0,
                                  //   duration: const Duration(seconds: 1),
                                  //   curve: Curves.easeOut,
                                  // );
                                }
                              },
                        child: Icon(
                          Icons.arrow_left,
                          color:
                              (offset == 0) ? Colors.grey[200] : Colors.black,
                          size: 25,
                        )),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
                      child: Text(
                        /// '*//$endIndex /${limitedList_teNantModels.length} ///${(endIndex / limit)}/${(limitedList_teNantModels.length / limit).ceil()}',
                        '${(endIndex / limit)}/${(limitedList_teNantModels.length / limit).ceil()}',
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontFamily: FontWeight_.Fonts_T,
                          //fontSize: 10.0
                        ),
                      ),
                    ),
                    InkWell(
                        onTap: (endIndex >= limitedList_teNantModels.length)
                            ? null
                            : () async {
                                setState(() {
                                  offset = offset + limit;
                                  tappedIndex_ = '';
                                  read_tenant_limit();
                                });
                                // _scrollController1.animateTo(
                                //   0,
                                //   duration: const Duration(seconds: 1),
                                //   curve: Curves.easeOut,
                                // );
                              },
                        child: Icon(
                          Icons.arrow_right,
                          color: (endIndex >= limitedList_teNantModels.length)
                              ? Colors.grey[200]
                              : Colors.black,
                          size: 25,
                        )),
                  ],
                ),
              );
            }),
      ],
    );
  }

  _searchBar() {
    return TextField(
      autofocus: false,
      keyboardType: TextInputType.text,
      style: const TextStyle(
          color: PeopleChaoScreen_Color.Colors_Text2_,
          fontFamily: Font_.Fonts_T),
      decoration: InputDecoration(
        filled: true,
        // fillColor: Colors.white,
        hintText: ' Search...',
        hintStyle: const TextStyle(
            color: PeopleChaoScreen_Color.Colors_Text2_,
            fontFamily: Font_.Fonts_T),
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
          teNantModels = _teNantModels.where((teNantModels) {
            var notTitle = teNantModels.lncode.toString().toLowerCase();
            var notTitle2 = teNantModels.cid.toString().toLowerCase();
            var notTitle3 = teNantModels.docno.toString().toLowerCase();
            var notTitle4 = teNantModels.sname.toString().toLowerCase();
            var notTitle5 = teNantModels.cname.toString().toLowerCase();
            var notTitle6 = teNantModels.zn.toString().toLowerCase();
            var notTitle7 = teNantModels.zser.toString().toLowerCase();
            var notTitle8 = teNantModels.sdate.toString().toLowerCase();
            var notTitle9 = teNantModels.fid.toString().toLowerCase();
            var notTitle10 = teNantModels.sdate_q.toString().toLowerCase();
            var notTitle11 = teNantModels.ldate_q.toString().toLowerCase();
            var notTitle12 = teNantModels.wnote.toString().toLowerCase();
            return notTitle.contains(text) ||
                notTitle2.contains(text) ||
                notTitle3.contains(text) ||
                notTitle4.contains(text) ||
                notTitle5.contains(text) ||
                notTitle6.contains(text) ||
                notTitle7.contains(text) ||
                notTitle8.contains(text) ||
                notTitle9.contains(text) ||
                notTitle12.contains(text);
          }).toList();
        });
        if (text.isEmpty) {
          read_tenant_limit();
        } else {}
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(4, 4, 4, 0),
            child: Container(
              padding: EdgeInsets.all(4),
              decoration:  BoxDecoration(
                color: AppbackgroundColor.TiTile_Colors,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(0),
                    bottomRight: Radius.circular(0)),
              ),
              width: MediaQuery.of(context).size.width,
              // padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Text(
                            'Gen QR Code',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontFamily: FontWeight_.Fonts_T,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (limitedList_teNantModels.length != 0)
                        Container(
                          width: 120,
                          decoration: const BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10)),
                          ),
                          padding: const EdgeInsets.all(4.0),
                          child: TextButton(
                            onPressed: () async {
                              showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (_) {
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
                                      child: StreamBuilder(
                                          stream: Stream.periodic(
                                              const Duration(seconds: 1)),
                                          builder: (context, snapshot) {
                                            return const SizedBox(
                                                // height: 20,
                                                width: 350,
                                                child: Padding(
                                                  padding: EdgeInsets.all(20.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.fromLTRB(
                                                                0, 0, 8, 0),
                                                        child: SizedBox(
                                                            height: 30,
                                                            child:
                                                                CircularProgressIndicator()),
                                                      ),
                                                      Text(
                                                        'กำลัง Download และแปลงไฟล์ PDF...  ',
                                                        style: TextStyle(
                                                          color:
                                                              PeopleChaoScreen_Color
                                                                  .Colors_Text1_,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily:
                                                              FontWeight_
                                                                  .Fonts_T,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ));
                                          }),
                                    );
                                  });

                              // setState(() {
                              //   serPositioned = '0';
                              // });

                              // Future.delayed(const Duration(milliseconds: 50), () async {
                              //   for (int index = 0; index < teNantModels.length; index++) {
                              //     final bytes = await controller[index].capture();
                              //     setState(() {
                              //       this.bytes = bytes;
                              //     });
                              //     netImage.add(bytes!);
                              //   }
                              // });

                              // Future.delayed(const Duration(milliseconds: 10), () async {
                              //   setState(() {
                              //     serPositioned = null;
                              //   });
                              // });
                              Future.delayed(const Duration(milliseconds: 100),
                                  () async {
                                Pdfgen_QR_.displayPdf_QR(
                                    context,
                                    renTal_name,
                                    zone_name,
                                    teNantModels,
                                    '${(endIndex / limit)}/${(limitedList_teNantModels.length / limit).ceil()}',
                                    indexcardColor);
                              }).then((value) => {
                                    // Navigator.of(context).pop(),
                                  });
                            },
                            child: Column(
                              children: [
                                Text(
                                  'พิมพ์ PDF',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    fontFamily: FontWeight_.Fonts_T,
                                  ),
                                ),
                                // Text(
                                //   '(${index_type * 24 + 1} - ${(index_type + 1) * 24})',
                                //   style: TextStyle(
                                //     color: Colors.white,
                                //     fontSize: 10,
                                //     fontFamily: FontWeight_.Fonts_T,
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      MediaQuery.of(context).size.shortestSide <
                              MediaQuery.of(context).size.width * 1
                          ? const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'โซนพื้นที่เช่า : ',
                                style: TextStyle(
                                    color: PeopleChaoScreen_Color.Colors_Text1_,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: FontWeight_.Fonts_T),
                              ),
                            )
                          : const SizedBox(),
                      Expanded(
                        flex: MediaQuery.of(context).size.shortestSide <
                                MediaQuery.of(context).size.width * 1
                            ? 2
                            : 3,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppbackgroundColor.Sub_Abg_Colors,
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10)),
                              border: Border.all(color: Colors.grey, width: 1),
                            ),
                            width: 150,
                            child: DropdownButtonFormField2(
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding: EdgeInsets.zero,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              isExpanded: true,
                              hint: Text(
                                zone_name == null
                                    ? 'กรุณาเลือกโซนพื้นที่'
                                    : '$zone_name',
                                maxLines: 1,
                                style: const TextStyle(
                                    fontSize: 14,
                                    color: PeopleChaoScreen_Color.Colors_Text2_,
                                    fontFamily: Font_.Fonts_T),
                              ),
                              icon: const Icon(
                                Icons.arrow_drop_down,
                                color: Colors.black,
                              ),
                              style: const TextStyle(
                                  color: PeopleChaoScreen_Color.Colors_Text2_,
                                  fontFamily: Font_.Fonts_T),
                              iconSize: 30,
                              buttonHeight: 40,
                              // buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                              dropdownDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              items: zoneModels
                                  .map((item) => DropdownMenuItem<String>(
                                        value: '${item.ser},${item.zn}',
                                        child: Text(
                                          item.zn!,
                                          style: const TextStyle(
                                              fontSize: 14,
                                              color: PeopleChaoScreen_Color
                                                  .Colors_Text2_,
                                              fontFamily: Font_.Fonts_T),
                                        ),
                                      ))
                                  .toList(),

                              onChanged: (value) async {
                                var zones = value!.indexOf(',');
                                var zoneSer = value.substring(0, zones);
                                var zonesName = value.substring(zones + 1);
                                print('mmmmm ${zoneSer.toString()} $zonesName');

                                setState(() {
                                  zone_ser = zoneSer;
                                  zone_name = zonesName;
                                  read_GC_tenant();
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      // Expanded(flex: 6, child: SizedBox())
                      if (Responsive.isDesktop(context))
                        const Padding(
                          padding: EdgeInsets.all(2.0),
                          child: Text(
                            'ค้นหา :',
                            style: TextStyle(
                              color: ReportScreen_Color.Colors_Text2_,
                              fontWeight: FontWeight.bold,
                              fontFamily: Font_.Fonts_T,
                            ),
                          ),
                        ),
                      if (Responsive.isDesktop(context))
                        Expanded(
                          child: Container(
                            height: 35,
                            decoration: BoxDecoration(
                              color: AppbackgroundColor.Sub_Abg_Colors,
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10)),
                              // border: Border.all(color: Colors.grey, width: 1),
                            ),
                            padding: EdgeInsets.all(4.0),
                            child: _searchBar(),
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('สี : '),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: AppbackgroundColor.Sub_Abg_Colors,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
                          border: Border.all(color: Colors.grey, width: 1),
                        ),
                        width: 70,
                        child: DropdownButtonFormField2(
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          isExpanded: true,
                          hint: Icon(Icons.circle_rounded,
                              color: cardColor, size: 16),
                          icon: const Icon(
                            Icons.arrow_drop_down,
                            color: TextHome_Color.TextHome_Colors,
                          ),
                          style: const TextStyle(
                              color: Colors.green, fontFamily: Font_.Fonts_T),
                          iconSize: 20,
                          buttonHeight: 30,
                          // buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                          dropdownDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          items: colorList
                              .map((item) => DropdownMenuItem<dynamic>(
                                    value: item,
                                    child: Icon(Icons.circle_rounded,
                                        color: item, size: 16),
                                  ))
                              .toList(),

                          onChanged: (value) async {
                            final selectedColor = value;
                            final index = colorList.indexWhere(
                                (color) => color.value == selectedColor.value);
                            setState(() {
                              indexcardColor = index;
                            });

                            changeCardColor(colorList[index]);
                          },
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                  if (!Responsive.isDesktop(context))
                    Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(2.0),
                          child: Text(
                            'ค้นหา :',
                            style: TextStyle(
                              color: ReportScreen_Color.Colors_Text2_,
                              fontWeight: FontWeight.bold,
                              fontFamily: Font_.Fonts_T,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 35,
                            decoration: const BoxDecoration(
                              color: AppbackgroundColor.Sub_Abg_Colors,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10)),
                              // border: Border.all(color: Colors.grey, width: 1),
                            ),
                            padding: EdgeInsets.all(4.0),
                            child: _searchBar(),
                          ),
                        ),
                      ],
                    ),
                  if (!Responsive.isDesktop(context)) const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // Container(
                      //   child: Row(
                      //     children: [
                      //       Text(
                      //         zone_name == null
                      //             ? 'โซนพื้นที่เช่า : ทั้งหมด'
                      //             : 'โซนพื้นที่เช่า : $zone_name',
                      //         maxLines: 1,
                      //         style: const TextStyle(
                      //           fontSize: 14.0,
                      //           color: PeopleChaoScreen_Color.Colors_Text1_,
                      //           fontWeight: FontWeight.bold,
                      //           fontFamily: FontWeight_.Fonts_T,
                      //         ),
                      //       ),
                      //       Text(
                      //         ' ( ทั้งหมด : ${limitedList_teNantModels.length} )',
                      //         maxLines: 1,
                      //         style: const TextStyle(
                      //           fontSize: 14.0,
                      //           color: PeopleChaoScreen_Color.Colors_Text1_,
                      //           // fontWeight: FontWeight.bold,
                      //           fontFamily: Font_.Fonts_T,
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          width: 200,
                          child: Next_page_Web(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            // width: MediaQuery.of(context).size.width,
            width: (Responsive.isDesktop(context))
                ? MediaQuery.of(context).size.width * 0.85
                : 1200,
            decoration: const BoxDecoration(
              color: AppbackgroundColor.Sub_Abg_Colors,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(0),
                  topRight: Radius.circular(0),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
              // border: Border.all(color: Colors.grey, width: 1),
            ),
            child: Column(
              children: [
                Container(
                  // width: (Responsive.isDesktop(context))
                  //     ? MediaQuery.of(context).size.width * 0.85
                  //     : 500,
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: (zone_name == null ||
                          zone_name.toString() == 'กรุณาเลือกโซนพื้นที่')
                      ? Center(
                          child: Text(
                            'กรุณาเลือกโซนพื้นที่',
                            maxLines: 1,
                            style: const TextStyle(
                              // fontSize: 9.0,
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontFamily: FontWeight_.Fonts_T,
                            ),
                          ),
                        )
                      : ResponsiveGridList(
                          horizontalGridMargin: 8,
                          verticalGridMargin: 8,
                          minItemWidth: 300,
                          minItemsPerRow: 1,
                          children: [
                              for (int index = 0;
                                  index < teNantModels.length;
                                  index++)
                                RepaintBoundary(
                                  key: controller[index],
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 300,
                                        // height: 135,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(0),
                                              bottomLeft: Radius.circular(10),
                                              bottomRight: Radius.circular(0)),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 3,
                                              blurRadius: 5,
                                              offset: const Offset(0,
                                                  3), // changes position of shadow
                                            ),
                                          ],
                                          image: const DecorationImage(
                                            image: AssetImage(
                                                "images/pngegg2.png"),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        child: Column(
                                          children: [
                                            Container(
                                              color: Colors.white,
                                              child: Text(
                                                '$renTal_name ',
                                                maxLines: 1,
                                                style: const TextStyle(
                                                  fontSize: 9.0,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: Font_.Fonts_T,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              color: Colors.white,
                                              child: Text(
                                                '${DateFormat('dd-MM-yyyy').format(DateTime.parse('${teNantModels[index].sdate}'))} ถึง ${DateFormat('dd-MM-yyyy').format(DateTime.parse('${teNantModels[index].ldate}'))}',
                                                // ' ${teNantModels[index].sdate} ถึง ${teNantModels[index].ldate}',
                                                maxLines: 1,
                                                style: const TextStyle(
                                                  fontSize: 8.0,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: Font_.Fonts_T,
                                                ),
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          4, 0, 0, 0),
                                                  child: Container(
                                                    color: Colors.white,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Center(
                                                            child: Container(
                                                          height: 84,
                                                          width: 84,
                                                          child:
                                                              SfBarcodeGenerator(
                                                            value:
                                                                '${teNantModels[index].cid}',
                                                            symbology: QRCode(),
                                                            showValue: false,
                                                          ),
                                                        )),
                                                        Padding(
                                                          padding: EdgeInsets
                                                              .fromLTRB(
                                                                  0, 4, 0, 0),
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Colors
                                                                  .grey[100],
                                                              borderRadius: const BorderRadius
                                                                      .only(
                                                                  topLeft:
                                                                      Radius.circular(
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
                                                              // border: Border.all(color: Colors.grey, width: 1),
                                                            ),
                                                            padding: EdgeInsets
                                                                .fromLTRB(
                                                                    2, 2, 2, 0),
                                                            child: Text(
                                                              'ลงชื่อ.....................................',
                                                              maxLines: 1,
                                                              style: TextStyle(
                                                                fontSize: 7.0,
                                                                color: PeopleChaoScreen_Color
                                                                    .Colors_Text1_,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily: Font_
                                                                    .Fonts_T,
                                                              ),
                                                            ),
                                                          ),
                                                        ),

                                                        // Center(
                                                        //   child: PrettyQr(
                                                        //     // typeNumber: 3,
                                                        //     image: const AssetImage(
                                                        //       "images/Icon-chao.png",
                                                        //     ),
                                                        //     size: 90,
                                                        //     data: '${teNantModels[index].cid}',
                                                        //     errorCorrectLevel: QrErrorCorrectLevel.M,
                                                        //     roundEdges: true,
                                                        //   ),
                                                        // ),
                                                        // Container(
                                                        //   color: Colors.white,
                                                        //   child: Text(
                                                        //     ' ${teNantModels_Save[index_type][index].sdate} ถึง ${teNantModels_Save[index_type][index].ldate}',
                                                        //     maxLines: 2,
                                                        //     style: const TextStyle(
                                                        //       fontSize: 8.0,
                                                        //       color: PeopleChaoScreen_Color.Colors_Text1_,
                                                        //       // fontWeight: FontWeight.bold,
                                                        //       fontFamily: Font_.Fonts_T,
                                                        //     ),
                                                        //   ),
                                                        // ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Stack(
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .fromLTRB(4, 4, 0, 8),
                                                      child: Container(
                                                        // decoration:
                                                        //     BoxDecoration(
                                                        //   image:
                                                        //       DecorationImage(
                                                        //     image: NetworkImage("https://www.kindpng.com/picc/m/266-2660257_dotted-background-png-image-free-download-searchpng-white.png"),
                                                        //     fit: BoxFit.cover,
                                                        //   ),
                                                        // ),
                                                        width: 170,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            // const SizedBox(
                                                            //   height: 5.0,
                                                            // ),
                                                            // const Text(
                                                            //   'เลขสัญญา',
                                                            //   style: TextStyle(
                                                            //     fontSize: 10.0,
                                                            //     color: PeopleChaoScreen_Color.Colors_Text1_,
                                                            //     // fontWeight: FontWeight.bold,
                                                            //     fontFamily: Font_.Fonts_T,
                                                            //   ),
                                                            // ),
                                                            Text(
                                                              '${teNantModels[index].cid}',
                                                              maxLines: 1,
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 11.0,
                                                                color: PeopleChaoScreen_Color
                                                                    .Colors_Text1_,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily: Font_
                                                                    .Fonts_T,
                                                              ),
                                                            ),
                                                            const Text(
                                                              'ชื่อผู้ติดต่อ',
                                                              maxLines: 1,
                                                              style: TextStyle(
                                                                fontSize: 9.0,
                                                                color: PeopleChaoScreen_Color
                                                                    .Colors_Text1_,
                                                                //fontWeight: FontWeight.bold,
                                                                fontFamily: Font_
                                                                    .Fonts_T,
                                                              ),
                                                            ),
                                                            Text(
                                                              '${teNantModels[index].cname}',
                                                              maxLines: 1,
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 11.0,
                                                                color: PeopleChaoScreen_Color
                                                                    .Colors_Text1_,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily: Font_
                                                                    .Fonts_T,
                                                              ),
                                                            ),
                                                            const Text(
                                                              'ชื่อร้านค้า',
                                                              maxLines: 1,
                                                              style: TextStyle(
                                                                fontSize: 9.0,
                                                                color: PeopleChaoScreen_Color
                                                                    .Colors_Text1_,
                                                                // fontWeight: FontWeight.bold,
                                                                fontFamily: Font_
                                                                    .Fonts_T,
                                                              ),
                                                            ),
                                                            Text(
                                                              '${teNantModels[index].sname}',
                                                              maxLines: 1,
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 11.0,
                                                                color: PeopleChaoScreen_Color
                                                                    .Colors_Text1_,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily: Font_
                                                                    .Fonts_T,
                                                              ),
                                                            ),
                                                            Text(
                                                              teNantModels[index]
                                                                          .ln_c ==
                                                                      null
                                                                  ? teNantModels[index]
                                                                              .ln_q ==
                                                                          null
                                                                      ? ''
                                                                      : 'พื้นที่ :${teNantModels[index].ln_q}'
                                                                  : 'พื้นที่ :${teNantModels[index].ln_c}',
                                                              // 'พื้นที่ : ${teNantModels[index].ln} ( ${teNantModels[index].zn} )',
                                                              maxLines: 1,
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 9.0,
                                                                color: PeopleChaoScreen_Color
                                                                    .Colors_Text1_,
                                                                // fontWeight: FontWeight.bold,
                                                                fontFamily: Font_
                                                                    .Fonts_T,
                                                              ),
                                                            ),
                                                            Text(
                                                              'โซน :${teNantModels[index].zn}',
                                                              maxLines: 1,
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 9.0,
                                                                color: PeopleChaoScreen_Color
                                                                    .Colors_Text1_,
                                                                // fontWeight: FontWeight.bold,
                                                                fontFamily: Font_
                                                                    .Fonts_T,
                                                              ),
                                                            ),

                                                            // Text(
                                                            //   ' ${teNantModels[index].sdate} ถึง ${teNantModels[index].ldate}',
                                                            //   maxLines: 2,
                                                            //   style: const TextStyle(
                                                            //     fontSize: 8.0,
                                                            //     color: PeopleChaoScreen_Color.Colors_Text1_,
                                                            //     // fontWeight: FontWeight.bold,
                                                            //     fontFamily: Font_.Fonts_T,
                                                            //   ),
                                                            // ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    // if (serPositioned == null)
                                                    //   Positioned(
                                                    //     top: 0,
                                                    //     right: 5,
                                                    //     child: InkWell(
                                                    //         child: Container(
                                                    //           width: 30.0,
                                                    //           height: 30.0,
                                                    //           decoration: BoxDecoration(
                                                    //             color: Colors.black.withOpacity(0.5),
                                                    //             shape: BoxShape.circle,
                                                    //           ),
                                                    //           child: Center(
                                                    //               child: Text(
                                                    //             '${index_type + index + 1}',
                                                    //             style: TextStyle(
                                                    //               fontSize: 12,
                                                    //               color: Colors.white,
                                                    //             ),
                                                    //           )),
                                                    //         ),
                                                    //         onTap: () async {}),
                                                    //   ),
                                                    if (serPositioned == null)
                                                      Positioned(
                                                        bottom: 5,
                                                        right: 5,
                                                        child: InkWell(
                                                          child: Container(
                                                            width: 30.0,
                                                            height: 30.0,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Colors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.5),
                                                              shape: BoxShape
                                                                  .circle,
                                                            ),
                                                            child: const Center(
                                                                child: Icon(
                                                              Icons.download,
                                                              color:
                                                                  Colors.white,
                                                            )),
                                                          ),
                                                          onTap: () async {
                                                            // showDialog(
                                                            //     barrierDismissible: false,
                                                            //     context: context,
                                                            //     builder: (_) {
                                                            //       // Future.delayed(
                                                            //       //     const Duration(
                                                            //       //         seconds:
                                                            //       //             1),
                                                            //       //     () {
                                                            //       //   Navigator.of(
                                                            //       //           context)
                                                            //       //       .pop();
                                                            //       // });

                                                            //       return Dialog(
                                                            //         child: StreamBuilder(
                                                            //             stream: Stream.periodic(const Duration(seconds: 1)),
                                                            //             builder: (context, snapshot) {
                                                            //               return const SizedBox(
                                                            //                   // height: 20,
                                                            //                   width: 350,
                                                            //                   child: Padding(
                                                            //                     padding: EdgeInsets.all(20.0),
                                                            //                     child: Row(
                                                            //                       mainAxisAlignment: MainAxisAlignment.center,
                                                            //                       children: [
                                                            //                         Padding(
                                                            //                           padding: EdgeInsets.fromLTRB(0, 0, 8, 0),
                                                            //                           child: SizedBox(height: 30, child: CircularProgressIndicator()),
                                                            //                         ),
                                                            //                         Text(
                                                            //                           'กำลัง Download และแปลงไฟล์ PDF...  ',
                                                            //                           style: TextStyle(
                                                            //                             color: PeopleChaoScreen_Color.Colors_Text1_,
                                                            //                             fontWeight: FontWeight.bold,
                                                            //                             fontFamily: FontWeight_.Fonts_T,
                                                            //                           ),
                                                            //                         ),
                                                            //                       ],
                                                            //                     ),
                                                            //                   ));
                                                            //             }),
                                                            //       );
                                                            //     });
                                                            // Pdfgen_QR_2.displayPdf_QR2(
                                                            //   context,
                                                            //   renTal_name,
                                                            //   teNantModels[index].cid,
                                                            //   teNantModels[index].cname,
                                                            //   '${teNantModels[index].sdate} ถึง ${teNantModels[index].ldate}',
                                                            //   '${teNantModels[index].sname}',

                                                            //   teNantModels[index].ln_c == null
                                                            //       ? teNantModels[index].ln_q == null
                                                            //           ? ''
                                                            //           : 'พื้นที่ :${teNantModels[index].ln_q}( ${teNantModels[index].zn} )'
                                                            //       : 'พื้นที่ :${teNantModels[index].ln_c}( ${teNantModels[index].zn} )',

                                                            // );

                                                            setState(() {
                                                              serPositioned =
                                                                  '0';
                                                            });
                                                            Future.delayed(
                                                                const Duration(
                                                                    milliseconds:
                                                                        300),
                                                                () async {
                                                              captureAndConvertToBase64(
                                                                  controller[
                                                                      index],
                                                                  'QR_${teNantModels[index].cid}');
                                                              setState(() {
                                                                serPositioned =
                                                                    null;
                                                              });
                                                            });

                                                            // Future.delayed(const Duration(milliseconds: 100), () async {
                                                            //   try {
                                                            //     final bytes = await controller[index].capture();
                                                            //     final blob = html.Blob([bytes]);
                                                            //     final url = html.Url.createObjectUrlFromBlob(blob);
                                                            //     final anchor = html.document.createElement('a') as html.AnchorElement
                                                            //       ..href = url
                                                            //       ..download = '${teNantModels[index].cid}.png';
                                                            //     html.document.body?.append(anchor);
                                                            //     anchor.click();
                                                            //     html.Url.revokeObjectUrl(url);
                                                            //     print('Image saved to: ${teNantModels[index].cid}.png');
                                                            //     setState(() {
                                                            //       serPositioned = null;
                                                            //     });
                                                            //   } catch (e) {
                                                            //     print('Error saving image: $e');
                                                            //   }
                                                            // });

                                                            // Future.delayed(const Duration(milliseconds: 100), () async {
                                                            //   final bytes = await controller[index].capture();

                                                            //   try {
                                                            //     // final tempDir = await getTemporaryDirectory();
                                                            //     final filename = '${teNantModels[index].cid}/image.png';

                                                            //     final type = MimeType.PNG;

                                                            //     final dir = await FileSaver.instance.saveFile("${NameFile_}", bytes!, "pdf", mimeType: type);

                                                            //     print('Image saved to: $filename');
                                                            //     setState(() {
                                                            //       serPositioned = null;
                                                            //     });
                                                            //   } catch (e) {
                                                            //     print('Error saving image: $e');
                                                            //   }
                                                            // });
                                                          },
                                                        ),
                                                      )
                                                    // :
                                                    // Positioned(bottom: 5, right: 5, child: Container(padding: const EdgeInsets.all(4.0), child: const CircularProgressIndicator())),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: 150,
                                        width: 15,
                                        decoration: BoxDecoration(
                                          color: cardColor,
                                          // Colors.green[300],
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(0),
                                              topRight: Radius.circular(10),
                                              bottomLeft: Radius.circular(0),
                                              bottomRight: Radius.circular(10)),
                                        ),
                                        // child: Column(
                                        //   mainAxisAlignment: MainAxisAlignment.center,
                                        //   children: [
                                        //     RotatedBox(
                                        //       quarterTurns: 1,
                                        //       child: Text(
                                        //         '$renTal_name',
                                        //         maxLines: 1,
                                        //         style: const TextStyle(
                                        //           fontSize: 9.0,
                                        //           color: Colors.white,
                                        //           // fontWeight: FontWeight.bold,
                                        //           fontFamily: Font_.Fonts_T,
                                        //         ),
                                        //       ),
                                        //     ),
                                        //   ],
                                        // ),
                                      ),
                                    ],
                                  ),
                                ),
                            ]),
                )
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
}
