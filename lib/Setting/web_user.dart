import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:marquee/marquee.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import '../Constant/Myconstant.dart';
import '../Model/GetRenTal_Model.dart';
import '../Model/Get_Image_pro_model.dart';
import '../Model/Get_Image_pro_set_model.dart';
import '../Model/Get_Image_text_model.dart';
import '../Style/colors.dart';

class WebUser extends StatefulWidget {
  const WebUser({super.key});

  @override
  State<WebUser> createState() => _WebUserState();
}

class _WebUserState extends State<WebUser> {
  List<RenTalModel> renTalModels = [];
  List<ImageTextModel> imgList = [];
  List<String> textList = [];
  List<Widget> imageSliders = [];
  List<ImageProModel> imageProModels = [];
  List<ImageProSetModel> imageProSetModels = [];
  final url_text = TextEditingController();
  final text_text = TextEditingController();
  String? ser_user,
      position_user,
      fname_user,
      lname_user,
      email_user,
      utype_user,
      permission_user,
      renTal_Email,
      rtname,
      type,
      typex,
      renname,
      pkname,
      ser_Zonex,
      bill_name,
      bill_addr,
      renTal_name,
      img_,
      img_logo,
      foder,
      ser_ren;
  int index_b = 0, pageimg = 0, pagetext = 0;
  String? base64_Slip, fileName_Slip, extension_ = 'png';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    read_GC_rental();
    read_GC_imagepro().then((value) {
      for (var i = 0; i < imgList.length; i++) {
        Widget imageSlider = Container(
          child: Container(
            margin: EdgeInsets.all(2.0),
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                child: Stack(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () async {
                        print(imgList[i].url.toString());
                        if (imgList[i].url.toString() != '' &&
                            imgList[i].url != null &&
                            imgList[i].url.toString() != 'null') {
                          Uri url = Uri.parse(imgList[i].url.toString());
                          if (!await launchUrl(
                            url,
                            mode: LaunchMode.externalApplication,
                          )) {
                            throw Exception('Could not launch $url');
                          }
                        }
                      },
                      child: Image.network(imgList[i].image.toString(),
                          fit: BoxFit.cover, width: 1500.0),
                    ),
                  ],
                )),
          ),
        );
        setState(() {
          imageSliders.add(imageSlider);
        });
      }
    });
  }

  Future<Null> read_GC_imagepro() async {
    if (imageSliders.isNotEmpty) {
      imageSliders.clear();
      imgList.clear();
      textList.clear();
    }

    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    String url = '${MyConstant().domain}/GC_img_pro.php?isAdd=true&ren=$ren';
    try {
      var response = await http.get(Uri.parse(url));
      var result = json.decode(response.body);
      // print(result);
      if (result != null) {
        for (var map in result) {
          ImageProModel imageProModel = ImageProModel.fromJson(map);
          print(imageProModel.url);

          setState(() {
            if (imageProModel.type == 'IM') {
              var foderx =
                  'https://www.dzentric.com/chao_perty/chao_api/${imageProModel.imgName.toString()}';
              var urlx = imageProModel.url;
              Map<String, dynamic> map = Map();
              map['image'] = foderx;
              map['url'] = urlx;

              ImageTextModel imageTextModel = ImageTextModel.fromJson(map);

              imgList.add(imageTextModel);
            } else {
              var foderx = imageProModel.textPro.toString();
              textList.add(foderx);
            }

            imageProModels.add(imageProModel);
          });
        }
      } else {}
    } catch (e) {}
    setState(() {
      read_GC_imagepro_set();
    });
  }

  Future<Null> read_GC_imagepro_set() async {
    if (imageProSetModels.isNotEmpty) {
      imageProSetModels.clear();
    }

    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    String url =
        '${MyConstant().domain}/GC_img_pro_set.php?isAdd=true&ren=$ren';
    try {
      var response = await http.get(Uri.parse(url));
      var result = json.decode(response.body);
      // print(result);
      if (result != null) {
        for (var map in result) {
          ImageProSetModel imageProSetModel = ImageProSetModel.fromJson(map);
          setState(() {
            imageProSetModels.add(imageProSetModel);
          });
        }
      } else {}
    } catch (e) {}
  }

  Future<Null> read_GC_rental() async {
    if (renTalModels.isNotEmpty) {
      renTalModels.clear();
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    String url =
        '${MyConstant().domain}/GC_rental_setring.php?isAdd=true&ren=$ren';

    setState(() {
      ser_ren = ren;
    });

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print(result);
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
          var billname = renTalModel.bill_name;
          var billaddr = renTalModel.bill_addr;
          setState(() {
            preferences.setString(
                'renTalName', renTalModel.pn!.trim().toString());
            renTal_name = preferences.getString('renTalName');
            renTal_Email = renTalModel.bill_email.toString();
            foder = foderx;
            rtname = rtnamex;
            type = typexs;
            typex = typexx;
            renname = name;
            pkname = pkx;
            img_ = img;
            img_logo = imglogo;
            bill_name = billname;
            bill_addr = billaddr;
            renTalModels.add(renTalModel);
          });
        }
      } else {}
    } catch (e) {}
    print('name>>>>>  $renname');
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: AutoSizeText(
                minFontSize: 20,
                maxFontSize: 30,
                'ตั้งค่า ข่าวสาร',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: FontWeight_.Fonts_T,
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
              flex: 8,
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "ตัวอย่างข่าวสาร",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: FontWeight_.Fonts_T,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: AutoSizeText(
                  'รูปภาพ',
                  minFontSize: 10,
                  maxFontSize: 16,
                  maxLines: 1,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: FontWeight_.Fonts_T,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    AutoSizeText(
                      pageimg == 0 ? 'เพิ่ม' : 'ยกเลิก',
                      minFontSize: 10,
                      maxFontSize: 18,
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: FontWeight_.Fonts_T,
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          // showAddImg();
                          setState(() {
                            if (pageimg == 1) {
                              pageimg = 0;
                            } else {
                              pageimg = 1;
                            }
                            base64_Slip = null;
                            url_text.clear();
                          });
                        },
                        icon: Icon(
                          pageimg == 0
                              ? Icons.add_circle_outline
                              : Icons.close_outlined,
                          color: pageimg == 0 ? Colors.black : Colors.red,
                        )),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: AutoSizeText(
                  'ข้อความ',
                  minFontSize: 10,
                  maxFontSize: 18,
                  maxLines: 1,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: FontWeight_.Fonts_T,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    AutoSizeText(
                      pagetext == 0 ? 'เพิ่ม' : 'ยกเลิก',
                      minFontSize: 10,
                      maxFontSize: 18,
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: FontWeight_.Fonts_T,
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          // showAddImg();
                          setState(() {
                            if (pagetext == 1) {
                              pagetext = 0;
                            } else {
                              pagetext = 1;
                            }
                            text_text.clear();
                          });
                        },
                        icon: Icon(
                          pagetext == 0
                              ? Icons.add_circle_outline
                              : Icons.close_outlined,
                          color: pagetext == 0 ? Colors.black : Colors.red,
                        )),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(8),
                              child: CarouselSlider(
                                options: CarouselOptions(
                                  autoPlay: true,
                                  aspectRatio: 2.0,
                                  enlargeCenterPage: true,
                                ),
                                items: imageSliders,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      child: Row(
                        children: [
                          Expanded(
                            child: Marquee(
                              text: '${textList.map((e) => e)}',
                              style: TextStyle(
                                fontFamily: Font_.Fonts_T,
                              ),
                              scrollAxis: Axis.horizontal,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              blankSpace: 20.0,
                              velocity: 30.0,
                              // pauseAfterRound: Duration(seconds: 1),
                              startPadding: 10.0,
                              // accelerationDuration: Duration(seconds: 1),
                              // accelerationCurve: Curves.linear,
                              // decelerationDuration: Duration(milliseconds: 500),
                              // decelerationCurve: Curves.easeOut,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
            Expanded(
              flex: 4,
              child: pageimg == 1
                  ? Container(
                      color: Colors.white,
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    base64_Slip == null
                                        ? Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Icon(Icons
                                                  .image_not_supported_sharp),
                                            ),
                                          )
                                        : Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Image.memory(
                                              base64Decode(
                                                  base64_Slip.toString()),
                                              // height: 200,
                                              // fit: BoxFit.cover,
                                            ),
                                          ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(top: 4.0),
                                            child: Container(
                                              alignment: Alignment.centerRight,
                                              child: SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.6,
                                                  child: ElevatedButton(
                                                    style: ButtonStyle(
                                                        shape: MaterialStateProperty.all<
                                                                OutlinedBorder>(
                                                            const RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius.all(
                                                                        Radius.circular(
                                                                            5)))),
                                                        foregroundColor:
                                                            MaterialStateProperty.all<
                                                                    Color>(
                                                                Colors.black),
                                                        backgroundColor:
                                                            MaterialStateProperty
                                                                .all<Color>(
                                                          Colors
                                                              .orange.shade900,
                                                        )),
                                                    onPressed: () {
                                                      uploadFile_Slip();
                                                    },
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text(
                                                        base64_Slip == null
                                                            ? "อัพโหลดรูปภาพ"
                                                            : "อัพโหลดอีกครั้ง",
                                                        style: TextStyle(
                                                            fontFamily:
                                                                Font_.Fonts_T,
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                  )),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    base64_Slip == null
                                        ? SizedBox()
                                        : Row(
                                            children: [
                                              Expanded(
                                                child: TextFormField(
                                                  maxLines: 10,
                                                  minLines: 5,
                                                  controller: url_text,
                                                  onChanged: (value) async {},

                                                  decoration: InputDecoration(
                                                      fillColor: Colors.white
                                                          .withOpacity(0.3),
                                                      filled: true,

                                                      // suffixIcon: Icon(Icons.clear, color: Colors.black),
                                                      focusedBorder:
                                                          const OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                          topRight:
                                                              Radius.circular(
                                                                  15),
                                                          topLeft:
                                                              Radius.circular(
                                                                  15),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  15),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  15),
                                                        ),
                                                        borderSide: BorderSide(
                                                          width: 1,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      errorStyle: TextStyle(
                                                          fontFamily:
                                                              Font_.Fonts_T),
                                                      enabledBorder:
                                                          const OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                          topRight:
                                                              Radius.circular(
                                                                  15),
                                                          topLeft:
                                                              Radius.circular(
                                                                  15),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  15),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  15),
                                                        ),
                                                        borderSide: BorderSide(
                                                          width: 1,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      labelText: 'URL',
                                                      labelStyle:
                                                          const TextStyle(
                                                              fontSize: 14,
                                                              color: Colors
                                                                  .black54,
                                                              fontFamily: Font_
                                                                  .Fonts_T)),
                                                  // inputFormatters: <TextInputFormatter>[
                                                  //   // for below version 2 use this
                                                  //   // FilteringTextInputFormatter(RegExp("[a-zA-Z1-9@.]"),
                                                  //   //     allow: true),
                                                  //   FilteringTextInputFormatter.allow(
                                                  //       RegExp(r'[0-9 .]')),
                                                  //   // for version 2 and greater youcan also use this
                                                  //   // FilteringTextInputFormatter.digitsOnly
                                                  // ],
                                                ),
                                              ),
                                            ],
                                          ),
                                    SizedBox(
                                      height: 50,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(top: 4.0),
                                            child: Container(
                                              alignment: Alignment.centerRight,
                                              child: SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.6,
                                                  child: ElevatedButton(
                                                    style: ButtonStyle(
                                                        shape: MaterialStateProperty.all<
                                                                OutlinedBorder>(
                                                            const RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius.all(
                                                                        Radius.circular(
                                                                            5)))),
                                                        foregroundColor:
                                                            MaterialStateProperty.all<
                                                                    Color>(
                                                                Colors.black),
                                                        backgroundColor:
                                                            MaterialStateProperty
                                                                .all<Color>(
                                                          Colors.blue.shade900,
                                                        )),
                                                    onPressed: () {
                                                      OKuploadFile_Slip();
                                                    },
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text(
                                                        "บันทึก",
                                                        style: TextStyle(
                                                            fontFamily:
                                                                Font_.Fonts_T,
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                  )),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  : Column(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.6,
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                for (int index = 0;
                                    index < imageProSetModels.length;
                                    index++)
                                  if (imageProSetModels[index].type == 'IM')
                                    Container(
                                      color: Colors.white,
                                      child: SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.25,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              flex: 4,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Image.network(
                                                    '${MyConstant().domain}/${imageProSetModels[index].imgName}',
                                                    fit: BoxFit.fitWidth),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Center(
                                                child: Column(
                                                  children: [
                                                    IconButton(
                                                        onPressed: () {
                                                          var ser =
                                                              imageProSetModels[
                                                                      index]
                                                                  .ser;

                                                          setState(() {
                                                            DeImgon(ser);
                                                          });
                                                        },
                                                        icon: Icon(
                                                          Icons.delete_outlined,
                                                        )),
                                                    IconButton(
                                                        onPressed: () {
                                                          var ser =
                                                              imageProSetModels[
                                                                      index]
                                                                  .ser;
                                                          var st =
                                                              imageProSetModels[
                                                                              index]
                                                                          .st ==
                                                                      '0'
                                                                  ? '1'
                                                                  : '0';
                                                          setState(() {
                                                            UpImgon(ser, st);
                                                          });
                                                        },
                                                        icon: Icon(
                                                          imageProSetModels[
                                                                          index]
                                                                      .st ==
                                                                  '1'
                                                              ? Icons
                                                                  .toggle_on_outlined
                                                              : Icons
                                                                  .toggle_off_outlined,
                                                          color: imageProSetModels[
                                                                          index]
                                                                      .st ==
                                                                  '1'
                                                              ? Colors.green
                                                              : Colors.red,
                                                        )),
                                                    AutoSizeText(
                                                      imageProSetModels[index]
                                                                  .st ==
                                                              '1'
                                                          ? 'เปิดอยู่'
                                                          : 'ปิดอยู่',
                                                      minFontSize: 10,
                                                      maxFontSize: 16,
                                                      maxLines: 1,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontFamily:
                                                            FontWeight_.Fonts_T,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
            Expanded(
              flex: 4,
              child: pagetext == 1
                  ? Container(
                      color: Colors.white,
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  maxLines: 25,
                                  minLines: 10,
                                  maxLength: 180,
                                  controller: text_text,
                                  onChanged: (value) async {},

                                  decoration: InputDecoration(
                                      fillColor: Colors.white.withOpacity(0.3),
                                      filled: true,

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
                                      errorStyle:
                                          TextStyle(fontFamily: Font_.Fonts_T),
                                      enabledBorder: const OutlineInputBorder(
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
                                      labelText: 'ข้อความ',
                                      labelStyle: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.black54,
                                          fontFamily: Font_.Fonts_T)),
                                  // inputFormatters: <TextInputFormatter>[
                                  //   // for below version 2 use this
                                  //   // FilteringTextInputFormatter(RegExp("[a-zA-Z1-9@.]"),
                                  //   //     allow: true),
                                  //   FilteringTextInputFormatter.allow(
                                  //       RegExp(r'[0-9 .]')),
                                  //   // for version 2 and greater youcan also use this
                                  //   // FilteringTextInputFormatter.digitsOnly
                                  // ],
                                ),
                              ),
                            ],
                          ),
                          // SizedBox(
                          //   height: 50,
                          // ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 4.0),
                                  child: Container(
                                    alignment: Alignment.centerRight,
                                    child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.6,
                                        child: ElevatedButton(
                                          style: ButtonStyle(
                                              shape: MaterialStateProperty.all<
                                                      OutlinedBorder>(
                                                  const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  5)))),
                                              foregroundColor:
                                                  MaterialStateProperty.all<
                                                      Color>(Colors.black),
                                              backgroundColor:
                                                  MaterialStateProperty.all<
                                                      Color>(
                                                Colors.blue.shade900,
                                              )),
                                          onPressed: () {
                                            var type = 'TX';
                                            UpImg(type);
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              "บันทึก",
                                              style: TextStyle(
                                                  fontFamily: Font_.Fonts_T,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        )),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.6,
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                for (int index = 0;
                                    index < imageProSetModels.length;
                                    index++)
                                  if (imageProSetModels[index].type == 'TX')
                                    Container(
                                      color: Colors.white,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            flex: 6,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: AutoSizeText(
                                                '${index + 1}. ${imageProSetModels[index].textPro}',
                                                minFontSize: 10,
                                                maxFontSize: 16,
                                                maxLines: 5,
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: Font_.Fonts_T,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                              flex: 1,
                                              child: Center(
                                                child: Column(
                                                  children: [
                                                    IconButton(
                                                        onPressed: () {
                                                          var ser =
                                                              imageProSetModels[
                                                                      index]
                                                                  .ser;

                                                          setState(() {
                                                            DeImgon(ser);
                                                          });
                                                        },
                                                        icon: Icon(
                                                          Icons.delete_outlined,
                                                        )),
                                                    IconButton(
                                                        onPressed: () {
                                                          var ser =
                                                              imageProSetModels[
                                                                      index]
                                                                  .ser;
                                                          var st =
                                                              imageProSetModels[
                                                                              index]
                                                                          .st ==
                                                                      '0'
                                                                  ? '1'
                                                                  : '0';
                                                          setState(() {
                                                            UpImgon(ser, st);
                                                          });
                                                        },
                                                        icon: Icon(
                                                          imageProSetModels[
                                                                          index]
                                                                      .st ==
                                                                  '1'
                                                              ? Icons
                                                                  .toggle_on_outlined
                                                              : Icons
                                                                  .toggle_off_outlined,
                                                          color: imageProSetModels[
                                                                          index]
                                                                      .st ==
                                                                  '1'
                                                              ? Colors.green
                                                              : Colors.red,
                                                        )),
                                                    AutoSizeText(
                                                      imageProSetModels[index]
                                                                  .st ==
                                                              '1'
                                                          ? 'เปิดอยู่'
                                                          : 'ปิดอยู่',
                                                      minFontSize: 10,
                                                      maxFontSize: 16,
                                                      maxLines: 1,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontFamily:
                                                            FontWeight_.Fonts_T,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )),
                                        ],
                                      ),
                                    ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
            )
          ],
        ),
      )
    ]));
  }

  Future<void> OKuploadFile_Slip() async {
    if (base64_Slip != null) {
      String Path_foder = 'ProMoImg';
      String dateTimeNow = DateTime.now().toString();
      String date = DateFormat('ddMMyyyy')
          .format(DateTime.parse('${dateTimeNow}'))
          .toString();
      final dateTimeNow2 = DateTime.now().toUtc().add(const Duration(hours: 7));
      final formatter2 = DateFormat('HHmmss');
      final formattedTime2 = formatter2.format(dateTimeNow2);
      String Time_ = formattedTime2.toString();

      setState(() {
        fileName_Slip = '${date}_$Time_.png';
      });

      try {
        // 2. Read the image as bytes
        // final imageBytes = await pickedFile.readAsBytes();

        // 3. Encode the image as a base64 string
        // final base64Image = base64Encode(imageBytes);

        // 4. Make an HTTP POST request to your server
        final url =
            '${MyConstant().domain}/File_uploadPro.php?name=$fileName_Slip&Foder=$Path_foder&extension=png';

        final response = await http.post(
          Uri.parse(url),
          body: {
            'image': base64_Slip,
            'Foder': 'ProMoImg',
            'name': fileName_Slip,
            'ex': 'png'
          }, // Send the image as a form field named 'image'
        );

        if (response.statusCode == 200) {
          print('File uploaded successfully!*** : $fileName_Slip');
          var type = 'IM';
          UpImg(type);
        } else {
          print('Image upload failed');
        }
      } catch (e) {
        print('Error during image processing: $e');
      }
    } else {
      print('ยังไม่ได้เลือกรูปภาพ');
    }
  }

  Future<void> UpImgon(ser, st) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    String url =
        '${MyConstant().domain}/up_imgpro.php?isAdd=true&ser=$ser&st=$st';
    var response = await http.get(Uri.parse(url));

    var result = json.decode(response.body);
    print(result.toString());
    try {
      if (result.toString() == 'true') {
        setState(() {
          read_GC_imagepro().then((value) {
            for (var i = 0; i < imgList.length; i++) {
              Widget imageSlider = Container(
                child: Container(
                  margin: EdgeInsets.all(2.0),
                  child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      child: Stack(
                        children: <Widget>[
                          GestureDetector(
                            onTap: () async {
                              print(imgList[i].url.toString());
                              if (imgList[i].url.toString() != '' &&
                                  imgList[i].url != null &&
                                  imgList[i].url.toString() != 'null') {
                                Uri url = Uri.parse(imgList[i].url.toString());
                                if (!await launchUrl(
                                  url,
                                  mode: LaunchMode.externalApplication,
                                )) {
                                  throw Exception('Could not launch $url');
                                }
                              }
                            },
                            child: Image.network(imgList[i].image.toString(),
                                fit: BoxFit.cover, width: 1500.0),
                          ),
                        ],
                      )),
                ),
              );
              setState(() {
                imageSliders.add(imageSlider);
              });
            }
          });
        });
      } else {}
    } catch (e) {}
  }

  Future<void> DeImgon(ser) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    String url = '${MyConstant().domain}/De_imgpro.php?isAdd=true&ser=$ser';
    var response = await http.get(Uri.parse(url));

    var result = json.decode(response.body);
    print(result.toString());
    try {
      if (result.toString() == 'true') {
        setState(() {
          read_GC_imagepro().then((value) {
            for (var i = 0; i < imgList.length; i++) {
              Widget imageSlider = Container(
                child: Container(
                  margin: EdgeInsets.all(2.0),
                  child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      child: Stack(
                        children: <Widget>[
                          GestureDetector(
                            onTap: () async {
                              print(imgList[i].url.toString());
                              if (imgList[i].url.toString() != '' &&
                                  imgList[i].url != null &&
                                  imgList[i].url.toString() != 'null') {
                                Uri url = Uri.parse(imgList[i].url.toString());
                                if (!await launchUrl(
                                  url,
                                  mode: LaunchMode.externalApplication,
                                )) {
                                  throw Exception('Could not launch $url');
                                }
                              }
                            },
                            child: Image.network(imgList[i].image.toString(),
                                fit: BoxFit.cover, width: 1500.0),
                          ),
                        ],
                      )),
                ),
              );
              setState(() {
                imageSliders.add(imageSlider);
              });
            }
          });
        });
      } else {}
    } catch (e) {}
  }

  Future<void> UpImg(type) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var ren = preferences.getString('renTalSer');
    var tru = url_text.text;
    var trt = text_text.text;

    String url =
        '${MyConstant().domain}/In_imgpro.php?isAdd=true&ren=$ren&type=$type&imgname=$fileName_Slip&text=$trt&url=$tru';
    var response = await http.get(Uri.parse(url));

    var result = json.decode(response.body);
    print(result.toString());
    try {
      if (result.toString() == 'true') {
        setState(() {
          if (type == 'IM') {
            url_text.clear();
            pageimg = 0;
            fileName_Slip = null;
            base64_Slip = null;
          } else {
            text_text.clear();
            pagetext = 0;
          }
          read_GC_imagepro_set();
        });
      } else {}
    } catch (e) {}
  }

  Future<void> uploadFile_Slip() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.getImage(
        source: ImageSource.gallery, maxHeight: 100, maxWidth: 100);

    if (pickedFile == null) {
      // print('User canceled image selection');
      return;
    } else {
      // 2. Read the image as bytes
      final imageBytes = await pickedFile.readAsBytes();
      // Define the target width and height
      final int targetWidth = 100;
      final int targetHeight = 100;

      // Resize the image to the target width and height
      // final img.Image resizedImage = img.copyResize(
      //   img.decodeImage(imageBytes)!,
      //   width: targetWidth,
      //   height: targetHeight,
      // );
      // 3. Encode the resized image as a base64 string
      //  final base64Image = base64Encode(img.encodePng(resizedImage));

      // 3. Encode the image as a base64 string
      final base64Image = base64Encode(imageBytes);
      setState(() {
        base64_Slip = base64Image;
      });
    }
  }
}
