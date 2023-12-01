// ignore_for_file: body_might_complete_normally_catch_error

import 'dart:convert';
import 'dart:html';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import '../Constant/Myconstant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Model/GetCustomer_Model.dart';
import '../Model/GetRenTal_Model.dart';
import '../Model/GetTrans_Model.dart';
import '../Model/GetType_Model.dart';
import '../Model/card_model.dart';
import '../Style/colors.dart';
import 'dart:js' as js;

class ReadCard extends StatefulWidget {
  const ReadCard({super.key});

  @override
  State<ReadCard> createState() => _ReadCardState();
}

class _ReadCardState extends State<ReadCard> {
  List<CerdModel> cerdModels = [];
  List<TypeModel> typeModels = [];
  List<TransModel> _TransModels = [];
  String? read_card, id_card;
  int page_open = 0;

  final _formKey = GlobalKey<FormState>();
  final Status4Form_nameshop = TextEditingController();
  final Status4Form_typeshop = TextEditingController();
  final Status4Form_bussshop = TextEditingController();
  final Status4Form_bussscontact = TextEditingController();
  final Status4Form_address = TextEditingController();
  final Status4Form_tel = TextEditingController();
  final Status4Form_email = TextEditingController();
  final Status4Form_tax = TextEditingController();
  String? _Form_nameshop,
      _Form_typeshop,
      _Form_bussshop,
      _Form_bussscontact,
      _Form_address,
      _Form_tel,
      _Form_email,
      _Form_tax;
  String? renTal_user,
      renTal_name,
      zone_ser,
      zone_name,
      Value_cid,
      fname_,
      pdate,
      number_custno;
  String? ser_user,
      foder,
      position_user,
      fname_user,
      lname_user,
      email_user,
      utype_user,
      permission_user,
      tel_user,
      img_,
      img_logo;
  String _verticalGroupValue = '';
  int Value_AreaSer_ = 0;

  @override
  void initState() {
    super.initState();
    red_card();
    checkPreferance();
    read_GC_type();
    read_GC_rental();
  }

  Future<Null> checkPreferance() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      renTal_user = preferences.getString('renTalSer');
      renTal_name = preferences.getString('renTalName');
      fname_ = preferences.getString('fname');
    });
  }

  Future<Null> read_GC_rental() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    var utype = preferences.getString('utype');
    var seruser = preferences.getString('ser');
    String url =
        '${MyConstant().domain}/GC_rental.php?isAdd=true&ser=$seruser&type=$utype';

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
          setState(() {
            foder = foderx;

            img_ = img;
            img_logo = imglogo;
          });
        }
      } else {}
    } catch (e) {}
  }

  Future<Null> read_GC_type() async {
    if (typeModels.isNotEmpty) {
      typeModels.clear();
    }

    String url = '${MyConstant().domain}/GC_type.php?isAdd=true';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print(result);
      if (result != null) {
        for (var map in result) {
          TypeModel typeModel = TypeModel.fromJson(map);
          setState(() {
            typeModels.add(typeModel);
          });
        }
        // setState(() {
        //   for (var i = 0; i < typeModels.length; i++) {
        //     _verticalGroupValue = typeModels[i].type!;
        //   }
        // });
      } else {}
    } catch (e) {}
  }

  Future<Null> red_card() async {
    if (cerdModels.length != 0) {
      setState(() {
        cerdModels.clear();
      });
    }
    Map<String, String> requestHeaders = {
      'Access-Control-Allow-Origin': '*',
      'Access-Control-Allow-Credentials': 'true',
      'Access-Control-Allow-Methods': 'PUT,GET,POST,DELETE,OPTIONS',
      'Access-Control-Allow-Headers':
          'Origin,Content-Type,Authorization,Accept,X-Requested-With,x-xsrf-token"',
      'Content-Type': 'application/javascript; charset=utf-8',
    };

    var response = await Dio()
        .request(
      'https://localhost:8182/thaiid/read.jsonp?&section1=true&section2a=true&section2b=true',
      options: Options(
        method: 'GET',
        headers: requestHeaders,
      ),
    )
        .catchError((errr) {
      setState(() {
        id_card = null;
        read_card =
            'คุณอาจยังไม่ติดตั้ง หรือ เปิดโปรแกรม Smartdcard Reader หรือ ยังไม่เปิดใช้งาน Cors Unblock';
      });
    });

    try {
      if (response.statusCode == 200) {
        cerdModels.clear();
        var result = json.decode('[' +
            response.data
                .toString()
                .substring(13, response.data.toString().length - 1) +
            ']');

        if (result.toString().substring(1, result.toString().length - 1) !=
            'null') {
          for (var map in result) {
            CerdModel cerdModel = CerdModel.fromJson(map);
            var id_cardx = cerdModel.citizenNo;
            setState(() {
              id_card = id_cardx;
              cerdModels.add(cerdModel);
            });
          }
        } else {
          setState(() {
            id_card = null;
            read_card = 'ตรวจสอบ บัตรประชาชนเสียบแล้ว หรือไม่??';
          });
        }
      }
    } catch (e) {
      setState(() {
        id_card = null;
        read_card =
            'คุณอาจยังไม่ติดตั้ง หรือ ลงโปรแกรม Smartdcard Reader หรือ ยังไม่เปิดใช้งาน Cors Unblock';
      });
    }
  }

  String? fileName_Slip;
  String? base64_Image;
  String? cust_no_;

  Future<void> convert_base64(ImageSource source) async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.getImage(source: source);
    if (pickedFile == null) {
      print('User canceled image selection');
      return;
    } // 2. Read the image as bytes
    final imageBytes = await pickedFile.readAsBytes();

    // 3. Encode the image as a base64 string
    final base64Image = base64Encode(imageBytes);
    setState(() {
      base64_Image = base64Image;
    });
    // uploadImage();
  }

  Future<void> uploadImage() async {
    int timestamp = DateTime.now().millisecondsSinceEpoch;
    setState(() {
      fileName_Slip = 'pic_${cust_no_}_$timestamp.jpg';
    });
    // 4. Make an HTTP POST request to your server
    try {
      final url =
          '${MyConstant().domain}/File_photo.php?name=$fileName_Slip&Foder=$foder';

      final response = await http.post(
        Uri.parse(url),
        body: {
          'image': base64_Image,
          'Foder': foder,
          'name': fileName_Slip
        }, // Send the image as a form field named 'image'
      );

      if (response.statusCode == 200) {
        print('Image uploaded successfully');

        await Future.delayed(Duration(milliseconds: 100));
        up_photo_string();
      } else {
        print('Image upload failed');
      }
    } catch (e) {
      print('Error during image processing: $e');
    }
  }

  Future<Null> up_photo_string() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? ren = preferences.getString('renTalSer');
    String? ser_user = preferences.getString('ser');
    String custno_ = cust_no_.toString();

    await Future.delayed(Duration(milliseconds: 500));

    String url =
        '${MyConstant().domain}/Test_UP_img_Custo.php?isAdd=true&ren=$ren&custno=$custno_&img=$fileName_Slip';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print(result);
      if (result.toString() == 'true') {
        print('true :-$custno_--> ${fileName_Slip}');
      }
    } catch (e) {
      // print(e);
    }
    await Future.delayed(Duration(milliseconds: 200));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
          backgroundColor: Colors.green,
          content: Text(' ทำรายการสำเร็จ... !',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: Font_.Fonts_T))),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.width / 3,
          child: Column(
            children: [
              StreamBuilder(
                  stream: Stream.periodic(const Duration(seconds: 3)),
                  builder: (context, snapshot) {
                    red_card();
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          red_card();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('อ่านบัตรประชาชน',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                softWrap: false,
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontFamily: FontWeight_.Fonts_T)),
                          ],
                        ),
                      ),
                    );
                  }),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    if (cerdModels.length != 0)
                      for (int index = 0; index < cerdModels.length; index++)
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height / 1.5,
                                child: ListView(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Divider(),
                                        Row(
                                          children: [
                                            Expanded(
                                              flex: 2,
                                              child: Text(
                                                'เลขบัตรประชาชน :',
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                softWrap: false,
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.black,
                                                    fontFamily: Font_.Fonts_T),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 4,
                                              child: Text(
                                                '${cerdModels[index].citizenNo}',
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.start,
                                                softWrap: false,
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.black,
                                                    fontFamily: Font_.Fonts_T),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              flex: 2,
                                              child: Text(
                                                'ชื่อ-สกุล : ',
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                softWrap: false,
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.black,
                                                    fontFamily: Font_.Fonts_T),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 4,
                                              child: Text(
                                                '${cerdModels[index].titleNameTh} ${cerdModels[index].firstNameTh} ${cerdModels[index].lastNameTh}',
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.start,
                                                softWrap: false,
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.black,
                                                    fontFamily: Font_.Fonts_T),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              flex: 2,
                                              child: Text(
                                                'เกิดวันที่ : ',
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                softWrap: false,
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.black,
                                                    fontFamily: Font_.Fonts_T),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 4,
                                              child: Text(
                                                '${DateFormat.yMMMd('th').format(DateTime.parse('${cerdModels[index].birthDate?.substring(0, 4)}-${cerdModels[index].birthDate?.substring(4, 6)}-${cerdModels[index].birthDate?.substring(6, 8)} 00:00:00'))} ',
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.start,
                                                softWrap: false,
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.black,
                                                    fontFamily: Font_.Fonts_T),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              flex: 2,
                                              child: Text(
                                                'เพศ : ',
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                softWrap: false,
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.black,
                                                    fontFamily: Font_.Fonts_T),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 4,
                                              child: Text(
                                                cerdModels[index].gender == '1'
                                                    ? 'ชาย'
                                                    : 'หญิง',
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.start,
                                                softWrap: false,
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.black,
                                                    fontFamily: Font_.Fonts_T),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              flex: 2,
                                              child: Text(
                                                'ที่อยู่ : ',
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                softWrap: false,
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.black,
                                                    fontFamily: Font_.Fonts_T),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 4,
                                              child: Text(
                                                '${cerdModels[index].homeNo} ${cerdModels[index].moo} ต.${cerdModels[index].tumbol} อ.${cerdModels[index].amphur} จ.${cerdModels[index].province}',
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.start,
                                                softWrap: false,
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.black,
                                                    fontFamily: Font_.Fonts_T),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              flex: 2,
                                              child: Text(
                                                'วันออกบัตร : ',
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                softWrap: false,
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.black,
                                                    fontFamily: Font_.Fonts_T),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 4,
                                              child: Text(
                                                '${DateFormat.yMMMd('th').format(DateTime.parse('${cerdModels[index].issueDate?.substring(0, 4)}-${cerdModels[index].issueDate?.substring(4, 6)}-${cerdModels[index].issueDate?.substring(6, 8)} 00:00:00'))} ',
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.start,
                                                softWrap: false,
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.black,
                                                    fontFamily: Font_.Fonts_T),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              flex: 2,
                                              child: Text(
                                                'วันบัตรหมดอายุ : ',
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                softWrap: false,
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.black,
                                                    fontFamily: Font_.Fonts_T),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 4,
                                              child: Text(
                                                '${DateFormat.yMMMd('th').format(DateTime.parse('${cerdModels[index].expiryDate?.substring(0, 4)}-${cerdModels[index].expiryDate?.substring(4, 6)}-${cerdModels[index].expiryDate?.substring(6, 8)} 00:00:00'))}',
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.start,
                                                softWrap: false,
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.black,
                                                    fontFamily: Font_.Fonts_T),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Divider(),
                                        Row(
                                          children: [
                                            Expanded(
                                              flex: 2,
                                              child: Text(
                                                'Identification Number :',
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                softWrap: false,
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.black,
                                                    fontFamily: Font_.Fonts_T),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 4,
                                              child: Text(
                                                '${cerdModels[index].citizenNo}',
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.start,
                                                softWrap: false,
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.black,
                                                    fontFamily: Font_.Fonts_T),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              flex: 2,
                                              child: Text(
                                                'Name-Last name  : ',
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                softWrap: false,
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.black,
                                                    fontFamily: Font_.Fonts_T),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 4,
                                              child: Text(
                                                '${cerdModels[index].titleNameEn} ${cerdModels[index].firstNameEn} ${cerdModels[index].lastNameEn}',
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.start,
                                                softWrap: false,
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.black,
                                                    fontFamily: Font_.Fonts_T),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              flex: 2,
                                              child: Text(
                                                'BirthDate : ',
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                softWrap: false,
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.black,
                                                    fontFamily: Font_.Fonts_T),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 4,
                                              child: Text(
                                                '${DateFormat.yMMMd('en_US').format(DateTime.parse('${(int.parse(cerdModels[index].birthDate!.substring(0, 4)) - 543).toString()}-${cerdModels[index].birthDate?.substring(4, 6)}-${cerdModels[index].birthDate?.substring(6, 8)} 00:00:00'))} ',
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.start,
                                                softWrap: false,
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.black,
                                                    fontFamily: Font_.Fonts_T),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              flex: 2,
                                              child: Text(
                                                'Gender : ',
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                softWrap: false,
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.black,
                                                    fontFamily: Font_.Fonts_T),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 4,
                                              child: Text(
                                                cerdModels[index].gender == '1'
                                                    ? 'Male'
                                                    : 'Femel',
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.start,
                                                softWrap: false,
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.black,
                                                    fontFamily: Font_.Fonts_T),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              flex: 2,
                                              child: Text(
                                                'Address : ',
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                softWrap: false,
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.black,
                                                    fontFamily: Font_.Fonts_T),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 4,
                                              child: Text(
                                                '${cerdModels[index].homeNo} ${cerdModels[index].moo} ต.${cerdModels[index].tumbol} อ.${cerdModels[index].amphur} จ.${cerdModels[index].province}',
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.start,
                                                softWrap: false,
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.black,
                                                    fontFamily: Font_.Fonts_T),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              flex: 2,
                                              child: Text(
                                                'Date of Issue : ',
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                softWrap: false,
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.black,
                                                    fontFamily: Font_.Fonts_T),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 4,
                                              child: Text(
                                                '${DateFormat.yMMMd('en_US').format(DateTime.parse('${cerdModels[index].issueDate?.substring(0, 4)}-${cerdModels[index].issueDate?.substring(4, 6)}-${cerdModels[index].issueDate?.substring(6, 8)} 00:00:00'))} ',
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.start,
                                                softWrap: false,
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.black,
                                                    fontFamily: Font_.Fonts_T),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              flex: 2,
                                              child: Text(
                                                'Date of Expiry : ',
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                softWrap: false,
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.black,
                                                    fontFamily: Font_.Fonts_T),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 4,
                                              child: Text(
                                                '${DateFormat.yMMMd('en_US').format(DateTime.parse('${cerdModels[index].expiryDate?.substring(0, 4)}-${cerdModels[index].expiryDate?.substring(4, 6)}-${cerdModels[index].expiryDate?.substring(6, 8)} 00:00:00'))}',
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.start,
                                                softWrap: false,
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.black,
                                                    fontFamily: Font_.Fonts_T),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height / 1.5,
                                child: ListView(
                                  children: [
                                    Form(
                                      key: _formKey,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                flex: 2,
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      'รูปผู้เช่า:',
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      softWrap: false,
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          color: Colors.black,
                                                          fontFamily:
                                                              Font_.Fonts_T),
                                                    ),
                                                    IconButton(
                                                      onPressed: () async {
                                                        convert_base64(
                                                            ImageSource
                                                                .gallery);
                                                      },
                                                      icon: const Icon(
                                                        Icons
                                                            .add_a_photo_outlined,
                                                        color: Colors.green,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                flex: 4,
                                                child: (base64_Image == null)
                                                    ? Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Container(
                                                            width: 80,
                                                            height: 80,
                                                            color: Colors.white,
                                                          ),
                                                        ],
                                                      )
                                                    : Image.memory(
                                                        base64Decode(
                                                            base64_Image
                                                                .toString()),
                                                        width: 100, height: 100,
                                                        // height: 200,
                                                        // fit: BoxFit.cover,
                                                      ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                flex: 4,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Container(
                                                      decoration: BoxDecoration(
                                                        color: Colors.white
                                                            .withOpacity(0.3),
                                                        borderRadius:
                                                            const BorderRadius
                                                                .only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  15),
                                                          topRight:
                                                              Radius.circular(
                                                                  15),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  15),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  15),
                                                        ),
                                                        border: Border.all(
                                                            color: Colors.grey,
                                                            width: 1),
                                                      ),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: StreamBuilder(
                                                          stream:
                                                              Stream.periodic(
                                                                  const Duration(
                                                                      seconds:
                                                                          0)),
                                                          builder: (context,
                                                              snapshot) {
                                                            return RadioGroup<
                                                                TypeModel>.builder(
                                                              direction: Axis
                                                                  .horizontal,
                                                              groupValue: typeModels
                                                                  .elementAt(
                                                                      Value_AreaSer_),
                                                              horizontalAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceAround,
                                                              onChanged:
                                                                  (value) {
                                                                Status4Form_nameshop
                                                                    .clear();
                                                                Status4Form_bussshop
                                                                    .clear();
                                                                Status4Form_bussscontact
                                                                    .clear();
                                                                setState(() {
                                                                  Value_AreaSer_ =
                                                                      int.parse(
                                                                              value!.ser!) -
                                                                          1;
                                                                  _verticalGroupValue =
                                                                      value
                                                                          .type!;
                                                                  _TransModels =
                                                                      [];
                                                                });
                                                                print(
                                                                    Value_AreaSer_);
                                                              },
                                                              items: typeModels,
                                                              textStyle:
                                                                  const TextStyle(
                                                                fontSize: 15,
                                                                color: PeopleChaoScreen_Color
                                                                    .Colors_Text2_,
                                                              ),
                                                              itemBuilder:
                                                                  (typeXModels) =>
                                                                      RadioButtonBuilder(
                                                                typeXModels
                                                                    .type!,
                                                              ),
                                                            );
                                                          })),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                flex: 4,
                                                child: Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                    // color: Colors.green,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(6),
                                                      topRight:
                                                          Radius.circular(6),
                                                      bottomLeft:
                                                          Radius.circular(6),
                                                      bottomRight:
                                                          Radius.circular(6),
                                                    ),
                                                    // border: Border.all(color: Colors.grey, width: 1),
                                                  ),
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: TextFormField(
                                                    controller:
                                                        Status4Form_nameshop,

                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return 'กรอกข้อมูลให้ครบถ้วน ';
                                                      }

                                                      return null;
                                                    },

                                                    cursorColor: Colors.green,
                                                    decoration: InputDecoration(
                                                        fillColor: Colors.white
                                                            .withOpacity(0.3),
                                                        filled: true,
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
                                                          borderSide:
                                                              BorderSide(
                                                            width: 1,
                                                            color: Colors.black,
                                                          ),
                                                        ),
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
                                                          borderSide:
                                                              BorderSide(
                                                            width: 1,
                                                            color: Colors.grey,
                                                          ),
                                                        ),
                                                        labelText:
                                                            'ชื่อร้านค้า',
                                                        labelStyle:
                                                            const TextStyle(
                                                          color:
                                                              PeopleChaoScreen_Color
                                                                  .Colors_Text2_,
                                                          // fontWeight: FontWeight.bold,
                                                          fontFamily:
                                                              Font_.Fonts_T,
                                                        )),
                                                    // inputFormatters: <TextInputFormatter>[
                                                    // for below version 2 use this
                                                    // FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                                    // // for version 2 and greater youcan also use this
                                                    // FilteringTextInputFormatter.digitsOnly
                                                    // ],
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 4,
                                                child: Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                    // color: Colors.green,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(6),
                                                      topRight:
                                                          Radius.circular(6),
                                                      bottomLeft:
                                                          Radius.circular(6),
                                                      bottomRight:
                                                          Radius.circular(6),
                                                    ),
                                                    // border: Border.all(color: Colors.grey, width: 1),
                                                  ),
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: TextFormField(
                                                    //keyboardType: TextInputType.none,
                                                    controller:
                                                        Status4Form_typeshop,
                                                    // onChanged: (value) =>
                                                    //     _Form_typeshop =
                                                    //         value.trim(),
                                                    //initialValue: _Form_typeshop,

                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return 'กรอกข้อมูลให้ครบถ้วน ';
                                                      }

                                                      return null;
                                                    },
                                                    cursorColor: Colors.green,
                                                    decoration: InputDecoration(
                                                        fillColor: Colors.white
                                                            .withOpacity(0.3),
                                                        filled: true,
                                                        // prefixIcon:
                                                        //     const Icon(Icons.person, color: Colors.black),
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
                                                          borderSide:
                                                              BorderSide(
                                                            width: 1,
                                                            color: Colors.black,
                                                          ),
                                                        ),
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
                                                          borderSide:
                                                              BorderSide(
                                                            width: 1,
                                                            color: Colors.grey,
                                                          ),
                                                        ),
                                                        labelText:
                                                            'ประเภทร้านค้า',
                                                        labelStyle:
                                                            const TextStyle(
                                                          color:
                                                              PeopleChaoScreen_Color
                                                                  .Colors_Text2_,
                                                          // fontWeight: FontWeight.bold,
                                                          fontFamily:
                                                              Font_.Fonts_T,
                                                        )),
                                                    // inputFormatters: <TextInputFormatter>[
                                                    //   // for below version 2 use this
                                                    //   FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                                    //   // for version 2 and greater youcan also use this
                                                    //   FilteringTextInputFormatter.digitsOnly
                                                    // ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                flex: 4,
                                                child: Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                    // color: Colors.green,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(6),
                                                      topRight:
                                                          Radius.circular(6),
                                                      bottomLeft:
                                                          Radius.circular(6),
                                                      bottomRight:
                                                          Radius.circular(6),
                                                    ),
                                                    // border: Border.all(color: Colors.grey, width: 1),
                                                  ),
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: TextFormField(
                                                    //keyboardType: TextInputType.none,
                                                    controller: (Value_AreaSer_ +
                                                                1) ==
                                                            1
                                                        ? Status4Form_bussshop
                                                        : Status4Form_bussscontact,
                                                    onChanged: (value) {
                                                      // Status4Form_nameshop.text = value.trim();
                                                      if ((Value_AreaSer_ +
                                                              1) ==
                                                          1) {
                                                        _Form_bussshop =
                                                            value.trim();
                                                      } else {
                                                        _Form_bussscontact =
                                                            value.trim();
                                                      }
                                                    },

                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return 'กรอกข้อมูลให้ครบถ้วน ';
                                                      }

                                                      return null;
                                                    },
                                                    cursorColor: Colors.green,
                                                    decoration: InputDecoration(
                                                        fillColor: Colors.white
                                                            .withOpacity(0.3),
                                                        filled: true,
                                                        // prefixIcon:
                                                        //     const Icon(Icons.person, color: Colors.black),
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
                                                          borderSide:
                                                              BorderSide(
                                                            width: 1,
                                                            color: Colors.black,
                                                          ),
                                                        ),
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
                                                          borderSide:
                                                              BorderSide(
                                                            width: 1,
                                                            color: Colors.grey,
                                                          ),
                                                        ),
                                                        labelText:
                                                            'ชื่อผู้เช่า/บริษัท',
                                                        labelStyle:
                                                            const TextStyle(
                                                          color:
                                                              PeopleChaoScreen_Color
                                                                  .Colors_Text2_,
                                                          // fontWeight: FontWeight.bold,
                                                          fontFamily:
                                                              Font_.Fonts_T,
                                                        )),
                                                    // inputFormatters: <TextInputFormatter>[
                                                    //   // for below version 2 use this
                                                    //   FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                                    //   // for version 2 and greater youcan also use this
                                                    //   FilteringTextInputFormatter.digitsOnly
                                                    // ],
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 4,
                                                child: Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                    // color: Colors.green,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(6),
                                                      topRight:
                                                          Radius.circular(6),
                                                      bottomLeft:
                                                          Radius.circular(6),
                                                      bottomRight:
                                                          Radius.circular(6),
                                                    ),
                                                    // border: Border.all(color: Colors.grey, width: 1),
                                                  ),
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: TextFormField(
                                                    //keyboardType: TextInputType.none,
                                                    controller:
                                                        Status4Form_bussshop,
                                                    onChanged: (value) {
                                                      if ((Value_AreaSer_ +
                                                              1) ==
                                                          1) {
                                                        Status4Form_nameshop
                                                                .text =
                                                            value.trim();
                                                      } else {}
                                                    },

                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return 'กรอกข้อมูลให้ครบถ้วน ';
                                                      }

                                                      return null;
                                                    },
                                                    cursorColor: Colors.green,
                                                    decoration: InputDecoration(
                                                        fillColor: Colors.white
                                                            .withOpacity(0.3),
                                                        filled: true,
                                                        // prefixIcon:
                                                        //     const Icon(Icons.person, color: Colors.black),
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
                                                          borderSide:
                                                              BorderSide(
                                                            width: 1,
                                                            color: Colors.black,
                                                          ),
                                                        ),
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
                                                          borderSide:
                                                              BorderSide(
                                                            width: 1,
                                                            color: Colors.grey,
                                                          ),
                                                        ),
                                                        labelText:
                                                            'บุคคลติดต่อ',
                                                        labelStyle:
                                                            const TextStyle(
                                                          color:
                                                              PeopleChaoScreen_Color
                                                                  .Colors_Text2_,
                                                          // fontWeight: FontWeight.bold,
                                                          fontFamily:
                                                              Font_.Fonts_T,
                                                        )),
                                                    // inputFormatters: <TextInputFormatter>[
                                                    //   // for below version 2 use this
                                                    //   FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                                    //   // for version 2 and greater youcan also use this
                                                    //   FilteringTextInputFormatter.digitsOnly
                                                    // ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                flex: 4,
                                                child: Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                    // color: Colors.green,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(6),
                                                      topRight:
                                                          Radius.circular(6),
                                                      bottomLeft:
                                                          Radius.circular(6),
                                                      bottomRight:
                                                          Radius.circular(6),
                                                    ),
                                                    // border: Border.all(color: Colors.grey, width: 1),
                                                  ),
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: TextFormField(
                                                    //keyboardType: TextInputType.none,
                                                    controller:
                                                        Status4Form_address,
                                                    // onChanged: (value) =>
                                                    //     _Form_address =
                                                    //         value.trim(),

                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return 'กรอกข้อมูลให้ครบถ้วน ';
                                                      }

                                                      return null;
                                                    },
                                                    maxLength: 2,
                                                    cursorColor: Colors.green,
                                                    decoration: InputDecoration(
                                                        fillColor: Colors.white
                                                            .withOpacity(0.3),
                                                        filled: true,
                                                        // prefixIcon:
                                                        //     const Icon(Icons.person, color: Colors.black),
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
                                                          borderSide:
                                                              BorderSide(
                                                            width: 1,
                                                            color: Colors.black,
                                                          ),
                                                        ),
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
                                                          borderSide:
                                                              BorderSide(
                                                            width: 1,
                                                            color: Colors.grey,
                                                          ),
                                                        ),
                                                        labelText: 'ที่อยู่',
                                                        labelStyle:
                                                            const TextStyle(
                                                          color:
                                                              PeopleChaoScreen_Color
                                                                  .Colors_Text2_,
                                                          // fontWeight: FontWeight.bold,
                                                          fontFamily:
                                                              Font_.Fonts_T,
                                                        )),
                                                    // inputFormatters: <TextInputFormatter>[
                                                    //   // for below version 2 use this
                                                    //   FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                                    //   // for version 2 and greater youcan also use this
                                                    //   FilteringTextInputFormatter.digitsOnly
                                                    // ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                flex: 4,
                                                child: Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                    // color: Colors.green,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(6),
                                                      topRight:
                                                          Radius.circular(6),
                                                      bottomLeft:
                                                          Radius.circular(6),
                                                      bottomRight:
                                                          Radius.circular(6),
                                                    ),
                                                    // border: Border.all(color: Colors.grey, width: 1),
                                                  ),
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: TextFormField(
                                                    //keyboardType: TextInputType.none,
                                                    controller: Status4Form_tel,
                                                    // onChanged: (value) =>
                                                    //     _Form_tel =
                                                    //         value.trim(),
                                                    //initialValue: _Form_tel,

                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return 'กรอกข้อมูลให้ครบถ้วน ';
                                                      }

                                                      return null;
                                                    },
                                                    cursorColor: Colors.green,
                                                    decoration: InputDecoration(
                                                        fillColor: Colors.white
                                                            .withOpacity(0.3),
                                                        filled: true,
                                                        // prefixIcon:
                                                        //     const Icon(Icons.person, color: Colors.black),
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
                                                          borderSide:
                                                              BorderSide(
                                                            width: 1,
                                                            color: Colors.black,
                                                          ),
                                                        ),
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
                                                          borderSide:
                                                              BorderSide(
                                                            width: 1,
                                                            color: Colors.grey,
                                                          ),
                                                        ),
                                                        labelText: 'เบอร์โทร',
                                                        labelStyle:
                                                            const TextStyle(
                                                          color:
                                                              PeopleChaoScreen_Color
                                                                  .Colors_Text2_,
                                                          // fontWeight: FontWeight.bold,
                                                          fontFamily:
                                                              Font_.Fonts_T,
                                                        )),
                                                    inputFormatters: <TextInputFormatter>[
                                                      // for below version 2 use this
                                                      FilteringTextInputFormatter
                                                          .allow(
                                                              RegExp(r'[0-9]')),
                                                      // for version 2 and greater youcan also use this
                                                      FilteringTextInputFormatter
                                                          .digitsOnly
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 4,
                                                child: Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                    // color: Colors.green,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(6),
                                                      topRight:
                                                          Radius.circular(6),
                                                      bottomLeft:
                                                          Radius.circular(6),
                                                      bottomRight:
                                                          Radius.circular(6),
                                                    ),
                                                    // border: Border.all(color: Colors.grey, width: 1),
                                                  ),
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: TextFormField(
                                                    //keyboardType: TextInputType.none,
                                                    controller:
                                                        Status4Form_email,
                                                    // onChanged: (value) =>
                                                    //     _Form_email =
                                                    //         value.trim(),
                                                    //initialValue: _Form_email,
                                                    // validator: (value) {
                                                    //   if (value == null || value.isEmpty) {
                                                    //     return 'กรอกข้อมูลให้ครบถ้วน ';
                                                    //   }
                                                    //   // if (int.parse(value.toString()) < 13) {
                                                    //   //   return '< 13';
                                                    //   // }
                                                    //   return null;
                                                    // },
                                                    // maxLength: 13,
                                                    cursorColor: Colors.green,
                                                    decoration: InputDecoration(
                                                        fillColor: Colors.white
                                                            .withOpacity(0.3),
                                                        filled: true,
                                                        // prefixIcon:
                                                        //     const Icon(Icons.person, color: Colors.black),
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
                                                          borderSide:
                                                              BorderSide(
                                                            width: 1,
                                                            color: Colors.black,
                                                          ),
                                                        ),
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
                                                          borderSide:
                                                              BorderSide(
                                                            width: 1,
                                                            color: Colors.grey,
                                                          ),
                                                        ),
                                                        labelText: 'อีเมล',
                                                        labelStyle:
                                                            const TextStyle(
                                                          color:
                                                              PeopleChaoScreen_Color
                                                                  .Colors_Text2_,
                                                          // fontWeight: FontWeight.bold,
                                                          fontFamily:
                                                              Font_.Fonts_T,
                                                        )),
                                                    // inputFormatters: <TextInputFormatter>[
                                                    //   // for below version 2 use this
                                                    //   FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                                    //   // for version 2 and greater youcan also use this
                                                    //   FilteringTextInputFormatter.digitsOnly
                                                    // ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                flex: 4,
                                                child: Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                    // color: Colors.green,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(6),
                                                      topRight:
                                                          Radius.circular(6),
                                                      bottomLeft:
                                                          Radius.circular(6),
                                                      bottomRight:
                                                          Radius.circular(6),
                                                    ),
                                                    // border: Border.all(color: Colors.grey, width: 1),
                                                  ),
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: TextFormField(
                                                    //keyboardType: TextInputType.none,
                                                    controller: Status4Form_tax,
                                                    // onChanged: (value) =>
                                                    //     _Form_tax =
                                                    //         value.trim(),
                                                    //initialValue: _Form_tax,
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return 'กรอกข้อมูลให้ครบถ้วน ';
                                                      }
                                                      // if (int.parse(value.toString()) < 13) {
                                                      //   return '< 13';
                                                      // }
                                                      return null;
                                                    },
                                                    // maxLength: 13,
                                                    cursorColor: Colors.green,
                                                    decoration: InputDecoration(
                                                        fillColor: Colors.white
                                                            .withOpacity(0.3),
                                                        filled: true,
                                                        // prefixIcon:
                                                        //     const Icon(Icons.person, color: Colors.black),
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
                                                          borderSide:
                                                              BorderSide(
                                                            width: 1,
                                                            color: Colors.black,
                                                          ),
                                                        ),
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
                                                          borderSide:
                                                              BorderSide(
                                                            width: 1,
                                                            color: Colors.grey,
                                                          ),
                                                        ),
                                                        labelText:
                                                            'ระบุID/TAX ID',
                                                        labelStyle:
                                                            const TextStyle(
                                                          color:
                                                              PeopleChaoScreen_Color
                                                                  .Colors_Text2_,
                                                          // fontWeight: FontWeight.bold,
                                                          fontFamily:
                                                              Font_.Fonts_T,
                                                        )),
                                                    // inputFormatters: <TextInputFormatter>[
                                                    //   // for below version 2 use this
                                                    //   FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                                    //   // for version 2 and greater youcan also use this
                                                    //   FilteringTextInputFormatter.digitsOnly
                                                    // ],
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 4,
                                                child: InkWell(
                                                  onTap: () async {
                                                    if (_formKey.currentState!
                                                        .validate()) {
                                                      print(
                                                          '---------------------------------->');
                                                      print(Value_AreaSer_);
                                                      print(
                                                          _verticalGroupValue);
                                                      print(
                                                          '${typeModels.elementAt(Value_AreaSer_).type}');

                                                      print(
                                                          '---------------------------------->');

                                                      print(Status4Form_nameshop
                                                          .text);
                                                      print(Status4Form_typeshop
                                                          .text);
                                                      print(Status4Form_nameshop
                                                          .text);
                                                      print(Status4Form_bussshop
                                                          .text);
                                                      print(
                                                          Status4Form_bussscontact
                                                              .text);

                                                      print(Status4Form_address
                                                          .text);
                                                      print(Status4Form_email
                                                          .text);
                                                      print(
                                                          Status4Form_tax.text);
                                                      print(
                                                          '----------------------------------');
                                                      // Value_AreaSer_ = int.parse(value!.ser!) - 1;
                                                      // _verticalGroupValue = value.type!;
                                                      SharedPreferences
                                                          preferences =
                                                          await SharedPreferences
                                                              .getInstance();
                                                      var ren =
                                                          preferences.getString(
                                                              'renTalSer');
                                                      var user = preferences
                                                          .getString('ser');

                                                      String? nameshop =
                                                          Status4Form_nameshop
                                                              .text
                                                              .toString();
                                                      String? typeshop =
                                                          Status4Form_typeshop
                                                              .text
                                                              .toString();
                                                      String? bussshop =
                                                          Status4Form_bussshop
                                                              .text
                                                              .toString();
                                                      String? bussscontact =
                                                          (_verticalGroupValue
                                                                      .toString()
                                                                      .trim() ==
                                                                  'ส่วนตัว/บุคคลธรรมดา')
                                                              ? Status4Form_bussshop
                                                                  .text
                                                                  .toString()
                                                              : Status4Form_bussscontact
                                                                  .text
                                                                  .toString();
                                                      String? address =
                                                          Status4Form_address
                                                              .text
                                                              .toString();
                                                      String? tel =
                                                          Status4Form_tel.text
                                                              .toString();
                                                      String? email =
                                                          Status4Form_email.text
                                                              .toString();
                                                      String? tax =
                                                          Status4Form_tax.text
                                                              .toString();

                                                      String url =
                                                          '${MyConstant().domain}/InC_CustoAdd_Bureau.php?isAdd=true&ren=$ren';

                                                      var response = await http
                                                          .post(Uri.parse(url),
                                                              body: {
                                                            'ciddoc': '',
                                                            'qutser': '',
                                                            'user': '',
                                                            'sumdis': '',
                                                            'sumdisp': '',
                                                            'dateY': '',
                                                            'dateY1': '',
                                                            'time': '',
                                                            'payment1': '',
                                                            'payment2': '',
                                                            'pSer1': '',
                                                            'pSer2': '',
                                                            'sum_whta': '',
                                                            'bill': '',
                                                            'fileNameSlip': '',
                                                            'areaSer': (typeModels
                                                                        .elementAt(
                                                                            Value_AreaSer_)
                                                                        .type
                                                                        .toString()
                                                                        .trim() ==
                                                                    'ส่วนตัว/บุคคลธรรมดา')
                                                                ? '1'
                                                                : '2',
                                                            'typeModels':
                                                                '${typeModels.elementAt(Value_AreaSer_).type}',
                                                            'typeshop':
                                                                Status4Form_typeshop
                                                                    .text
                                                                    .toString(),
                                                            'nameshop':
                                                                Status4Form_nameshop
                                                                    .text
                                                                    .toString(),
                                                            'bussshop':
                                                                Status4Form_bussshop
                                                                    .text
                                                                    .toString(),
                                                            'bussscontact': (Value_AreaSer_ +
                                                                        1) ==
                                                                    1
                                                                ? Status4Form_bussshop
                                                                    .text
                                                                    .toString()
                                                                : Status4Form_bussscontact
                                                                    .text
                                                                    .toString(),
                                                            'address':
                                                                Status4Form_address
                                                                    .text
                                                                    .toString(),
                                                            'tel':
                                                                Status4Form_tel
                                                                    .text
                                                                    .toString(),
                                                            'tax':
                                                                Status4Form_tax
                                                                    .text
                                                                    .toString(),
                                                            'email':
                                                                Status4Form_email
                                                                    .text
                                                                    .toString(),
                                                            'Serbool': '',
                                                            'area_rent_sum': '',
                                                            'comment': '',
                                                            'zser': ''
                                                                .trim()
                                                                .toString(),
                                                          }).then(
                                                              (value) async {
                                                        setState(() {
                                                          Status4Form_nameshop
                                                              .clear();
                                                          Status4Form_typeshop
                                                              .clear();
                                                          Status4Form_nameshop
                                                              .clear();
                                                          Status4Form_bussshop
                                                              .clear();
                                                          Status4Form_bussscontact
                                                              .clear();
                                                          Status4Form_address
                                                              .clear();
                                                          Status4Form_email
                                                              .clear();
                                                          Status4Form_tax
                                                              .clear();
                                                        });
                                                        // print('$value');
                                                        var result = json
                                                            .decode(value.body);
                                                        // print('$result ');
                                                        for (var map
                                                            in result) {
                                                          CustomerModel
                                                              CustomerModels =
                                                              CustomerModel
                                                                  .fromJson(
                                                                      map);
                                                          print(CustomerModels
                                                              .custno);
                                                          print(CustomerModels
                                                              .custno);
                                                          setState(() {
                                                            cust_no_ =
                                                                CustomerModels
                                                                    .custno!;
                                                          });
                                                          uploadImage();
                                                        }

                                                        setState(() {
                                                          Status4Form_nameshop
                                                              .clear();
                                                          Status4Form_typeshop
                                                              .clear();
                                                          Status4Form_nameshop
                                                              .clear();
                                                          Status4Form_bussshop
                                                              .clear();
                                                          Status4Form_bussscontact
                                                              .clear();
                                                          Status4Form_address
                                                              .clear();
                                                          Status4Form_email
                                                              .clear();
                                                          Status4Form_tax
                                                              .clear();
                                                        });
                                                      });
                                                    }
                                                  },
                                                  child: Container(
                                                    width: 150,
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    decoration: BoxDecoration(
                                                      color: Colors.green[900],
                                                      borderRadius:
                                                          BorderRadius.only(
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
                                                    ),
                                                    child: Text(
                                                      'บันทึก',
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      textAlign:
                                                          TextAlign.center,
                                                      softWrap: false,
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          color: Colors.white,
                                                          fontFamily:
                                                              Font_.Fonts_T),
                                                    ),
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
                              ),
                            ),
                          ],
                        )
                    else
                      read_card == null
                          ? SizedBox()
                          : Column(
                              children: [
                                read_card ==
                                        'ตรวจสอบ บัตรประชาชนเสียบแล้ว หรือไม่??'
                                    ? Row(
                                        children: [
                                          Expanded(
                                              child: Text('$read_card',
                                                  maxLines: 3,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.center,
                                                  softWrap: false,
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black,
                                                      fontFamily:
                                                          Font_.Fonts_T))),
                                        ],
                                      )
                                    : Column(
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                  child: Text('$read_card',
                                                      maxLines: 3,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      textAlign:
                                                          TextAlign.center,
                                                      softWrap: false,
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black,
                                                          fontFamily:
                                                              Font_.Fonts_T))),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                child: GestureDetector(
                                                  onTap: () async {
                                                    setState(() {
                                                      page_open = 1;
                                                    });
                                                    // // Open the file
                                                    // var bytes = await rootBundle.load(
                                                    //     'images/card/Smartdcard_Reader.exe');
                                                    // // Create a new anchor element
                                                    // var anchor = AnchorElement(
                                                    //     href: Url.createObjectUrlFromBlob(
                                                    //         Blob([
                                                    //   bytes.buffer.asUint8List()
                                                    // ], 'application/exe')))
                                                    //   ..setAttribute("download",
                                                    //       "Smartdcard_Reader.exe")
                                                    //   ..style.display = "none";
                                                    // // Add the anchor element to the body
                                                    // document.body!.append(anchor);
                                                    // // Click the anchor element to start the download
                                                    // anchor.click();
                                                    // // Remove the anchor element from the body
                                                    // anchor.remove();
                                                  },
                                                  child: Container(
                                                    color: page_open == 1
                                                        ? Colors.amber
                                                        : Colors.transparent,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text(
                                                          'โหลดโปรแกรม Smartdcard Reader',
                                                          maxLines: 3,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          textAlign:
                                                              TextAlign.center,
                                                          softWrap: false,
                                                          style: TextStyle(
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.blue,
                                                              fontFamily: Font_
                                                                  .Fonts_T)),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: GestureDetector(
                                                  onTap: () async {
                                                    setState(() {
                                                      page_open = 2;
                                                    });
                                                    // js.context.callMethod('open', [
                                                    //   'https://localhost:8182/thaiid/read.jsonp?&section1=true&section2a=true&section2b=true'
                                                    // ]);
                                                  },
                                                  child: Container(
                                                    color: page_open == 2
                                                        ? Colors.amber
                                                        : Colors.transparent,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text(
                                                          'เปิดใช้งาน Cors Unblock',
                                                          maxLines: 3,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          textAlign:
                                                              TextAlign.center,
                                                          softWrap: false,
                                                          style: TextStyle(
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.blue,
                                                              fontFamily: Font_
                                                                  .Fonts_T)),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          page_open == 0
                                              ? SizedBox()
                                              : page_open == 1
                                                  ? Container(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height /
                                                              2,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: ListView(
                                                          children: [
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    Text(
                                                                        'โหลดโปรแกรม คลิก >>',
                                                                        maxLines:
                                                                            3,
                                                                        overflow:
                                                                            TextOverflow
                                                                                .ellipsis,
                                                                        textAlign:
                                                                            TextAlign
                                                                                .start,
                                                                        softWrap:
                                                                            false,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                18,
                                                                            color:
                                                                                Colors.black,
                                                                            fontFamily: Font_.Fonts_T)),
                                                                    GestureDetector(
                                                                      onTap:
                                                                          () async {
                                                                        // Open the file
                                                                        var bytes =
                                                                            await rootBundle.load('images/card/smartcard_reader.rar');
                                                                        // Create a new anchor element
                                                                        var anchor = AnchorElement(
                                                                            href:
                                                                                Url.createObjectUrlFromBlob(Blob([
                                                                          bytes
                                                                              .buffer
                                                                              .asUint8List()
                                                                        ], 'application/exe')))
                                                                          ..setAttribute(
                                                                              "download",
                                                                              "smartcard_reader.rar")
                                                                          ..style.display =
                                                                              "none";
                                                                        // Add the anchor element to the body
                                                                        document
                                                                            .body!
                                                                            .append(anchor);
                                                                        // Click the anchor element to start the download
                                                                        anchor
                                                                            .click();
                                                                        // Remove the anchor element from the body
                                                                        anchor
                                                                            .remove();
                                                                      },
                                                                      child: Text(
                                                                          ' Download Now',
                                                                          maxLines:
                                                                              3,
                                                                          overflow: TextOverflow
                                                                              .ellipsis,
                                                                          textAlign: TextAlign
                                                                              .start,
                                                                          softWrap:
                                                                              false,
                                                                          style: TextStyle(
                                                                              decoration: TextDecoration.underline,
                                                                              fontSize: 18,
                                                                              color: Colors.blue,
                                                                              fontFamily: Font_.Fonts_T)),
                                                                    ),
                                                                  ],
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                        'หากดาวโหลดแล้วข้ามไปข้อ 3. ',
                                                                        maxLines:
                                                                            1,
                                                                        overflow:
                                                                            TextOverflow
                                                                                .ellipsis,
                                                                        textAlign:
                                                                            TextAlign
                                                                                .start,
                                                                        softWrap:
                                                                            false,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                14,
                                                                            color:
                                                                                Colors.red,
                                                                            fontFamily: Font_.Fonts_T)),
                                                                  ],
                                                                ),
                                                                SizedBox(
                                                                  height: 10,
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                        '1.แตกไฟล์ smartcard_reader.rar ที่ดาวโหลดมา คลิ๊กขวา กด Extract Here',
                                                                        maxLines:
                                                                            1,
                                                                        overflow:
                                                                            TextOverflow
                                                                                .ellipsis,
                                                                        textAlign:
                                                                            TextAlign
                                                                                .start,
                                                                        softWrap:
                                                                            false,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                18,
                                                                            color:
                                                                                Colors.black,
                                                                            fontFamily: Font_.Fonts_T)),
                                                                  ],
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Container(
                                                                      decoration:
                                                                          const BoxDecoration(
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                      child:
                                                                          const Image(
                                                                        image: AssetImage(
                                                                            'images/ssl10.png'),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                SizedBox(
                                                                  height: 10,
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                        '2.เปิดโฟร์เดอร์ที่แตกไฟล์ออกมา',
                                                                        maxLines:
                                                                            1,
                                                                        overflow:
                                                                            TextOverflow
                                                                                .ellipsis,
                                                                        textAlign:
                                                                            TextAlign
                                                                                .start,
                                                                        softWrap:
                                                                            false,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                18,
                                                                            color:
                                                                                Colors.black,
                                                                            fontFamily: Font_.Fonts_T)),
                                                                  ],
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Container(
                                                                      decoration:
                                                                          const BoxDecoration(
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                      child:
                                                                          const Image(
                                                                        image: AssetImage(
                                                                            'images/ssl9.png'),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                SizedBox(
                                                                  height: 10,
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                        '3.เปิดโปรแกรม Smartcard_Reader',
                                                                        maxLines:
                                                                            1,
                                                                        overflow:
                                                                            TextOverflow
                                                                                .ellipsis,
                                                                        textAlign:
                                                                            TextAlign
                                                                                .start,
                                                                        softWrap:
                                                                            false,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                18,
                                                                            color:
                                                                                Colors.black,
                                                                            fontFamily: Font_.Fonts_T)),
                                                                  ],
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Container(
                                                                      decoration:
                                                                          const BoxDecoration(
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                      child:
                                                                          const Image(
                                                                        image: AssetImage(
                                                                            'images/ssl8.png'),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                SizedBox(
                                                                  height: 10,
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                        '4.อนุญาติการใช้โปรแกรม Smartcard_Reader',
                                                                        maxLines:
                                                                            1,
                                                                        overflow:
                                                                            TextOverflow
                                                                                .ellipsis,
                                                                        textAlign:
                                                                            TextAlign
                                                                                .start,
                                                                        softWrap:
                                                                            false,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                18,
                                                                            color:
                                                                                Colors.black,
                                                                            fontFamily: Font_.Fonts_T)),
                                                                  ],
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Container(
                                                                      decoration:
                                                                          const BoxDecoration(
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                      child:
                                                                          const Image(
                                                                        image: AssetImage(
                                                                            'images/ssl7.png'),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                SizedBox(
                                                                  height: 10,
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                        '5.ตรวจสอบการใช้โปรแกรม Smartcard_Reader ที่มุมล่างขวา ** หากไม่มีกดเครื่องหมาย ^ เพื่อเรียกดู เสร็จสิ้น',
                                                                        maxLines:
                                                                            1,
                                                                        overflow:
                                                                            TextOverflow
                                                                                .ellipsis,
                                                                        textAlign:
                                                                            TextAlign
                                                                                .start,
                                                                        softWrap:
                                                                            false,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                18,
                                                                            color:
                                                                                Colors.black,
                                                                            fontFamily: Font_.Fonts_T)),
                                                                  ],
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Container(
                                                                      decoration:
                                                                          const BoxDecoration(
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                      child:
                                                                          const Image(
                                                                        image: AssetImage(
                                                                            'images/ssl4.png'),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                  : Container(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height /
                                                              2,
                                                      child: ListView(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    Text(
                                                                        '*** เปิดโปรแกรม Smartdcard Reader ก่อนทำการเปิดใช้งาน Cors Unblock ',
                                                                        maxLines:
                                                                            3,
                                                                        overflow:
                                                                            TextOverflow
                                                                                .ellipsis,
                                                                        textAlign:
                                                                            TextAlign
                                                                                .start,
                                                                        softWrap:
                                                                            false,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                18,
                                                                            color:
                                                                                Colors.red,
                                                                            fontFamily: Font_.Fonts_T)),
                                                                  ],
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    Text(
                                                                        '1.เปิดใช้งาน Cors Unblock คลิก >>',
                                                                        maxLines:
                                                                            3,
                                                                        overflow:
                                                                            TextOverflow
                                                                                .ellipsis,
                                                                        textAlign:
                                                                            TextAlign
                                                                                .start,
                                                                        softWrap:
                                                                            false,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                18,
                                                                            color:
                                                                                Colors.black,
                                                                            fontFamily: Font_.Fonts_T)),
                                                                    GestureDetector(
                                                                      onTap:
                                                                          () async {
                                                                        js.context.callMethod(
                                                                            'open',
                                                                            [
                                                                              'https://localhost:8182/thaiid/read.jsonp?&section1=true&section2a=true&section2b=true'
                                                                            ]);
                                                                      },
                                                                      child: Text(
                                                                          ' Open',
                                                                          maxLines:
                                                                              3,
                                                                          overflow: TextOverflow
                                                                              .ellipsis,
                                                                          textAlign: TextAlign
                                                                              .start,
                                                                          softWrap:
                                                                              false,
                                                                          style: TextStyle(
                                                                              decoration: TextDecoration.underline,
                                                                              fontSize: 18,
                                                                              color: Colors.blue,
                                                                              fontFamily: Font_.Fonts_T)),
                                                                    ),
                                                                  ],
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                        '2.กดปุ่ม Advanced',
                                                                        maxLines:
                                                                            1,
                                                                        overflow:
                                                                            TextOverflow
                                                                                .ellipsis,
                                                                        textAlign:
                                                                            TextAlign
                                                                                .start,
                                                                        softWrap:
                                                                            false,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                18,
                                                                            color:
                                                                                Colors.black,
                                                                            fontFamily: Font_.Fonts_T)),
                                                                  ],
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Container(
                                                                      decoration:
                                                                          const BoxDecoration(
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                      child:
                                                                          const Image(
                                                                        image: AssetImage(
                                                                            'images/ssl1.png'),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                        '3.กดปุ่ม Proceed to localhost (unsafe)',
                                                                        maxLines:
                                                                            1,
                                                                        overflow:
                                                                            TextOverflow
                                                                                .ellipsis,
                                                                        textAlign:
                                                                            TextAlign
                                                                                .start,
                                                                        softWrap:
                                                                            false,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                18,
                                                                            color:
                                                                                Colors.black,
                                                                            fontFamily: Font_.Fonts_T)),
                                                                  ],
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Container(
                                                                      decoration:
                                                                          const BoxDecoration(
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                      child:
                                                                          const Image(
                                                                        image: AssetImage(
                                                                            'images/ssl2.png'),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                        '4.ขึ้นตามรูป เสร็จสิ้นการเปิดใช้งาน ปิดแท็บ',
                                                                        maxLines:
                                                                            1,
                                                                        overflow:
                                                                            TextOverflow
                                                                                .ellipsis,
                                                                        textAlign:
                                                                            TextAlign
                                                                                .start,
                                                                        softWrap:
                                                                            false,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                18,
                                                                            color:
                                                                                Colors.black,
                                                                            fontFamily: Font_.Fonts_T)),
                                                                  ],
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Container(
                                                                      decoration:
                                                                          const BoxDecoration(
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                      child:
                                                                          const Image(
                                                                        image: AssetImage(
                                                                            'images/ssl5.png'),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                        ],
                                      ),
                              ],
                            ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
