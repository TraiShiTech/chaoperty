// ignore_for_file: unused_import, unused_local_variable, unnecessary_null_comparison, unused_field, override_on_non_overriding_member, duplicate_import, must_be_immutable, body_might_complete_normally_nullable
import 'dart:convert';
import 'dart:html';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Account/Account_Screen.dart';
import '../Canvas/generated_nodes.dart';
import '../ChaoArea/ChaoArea_Screen.dart';
import '../Constant/Myconstant.dart';
import '../Home/Home_Screen.dart';
import '../INSERT_Log/Insert_log.dart';
import '../Manage/Manage_Screen.dart';
import '../Model/Count_area_model.dart';
import '../Model/GC_package_model.dart';
import '../Model/GetArea_Model.dart';
import '../Model/GetContract_Rownum_Model.dart';
import '../Model/GetRenTal_Model.dart';
import '../Model/GetUser_Model.dart';
import '../Model/GetZone_Model.dart';
import '../PeopleChao/PeopleChao_Screen.dart';
import '../Responsive/responsive.dart';
import '../Setting_NainaService/Web_view_NainaSetting.dart';
import '../Style/Translate.dart';
import '../Style/colors.dart';
import '../Style/downloadImage.dart';
import '../Style/view_pagenow.dart';
import 'Access_Rights.dart';
import 'Advance_Setting.dart';
import 'Bill_Document.dart';
import 'Draginto_example.dart';
import 'Edit_web.dart';
import 'OtherScreen.dart';
import 'Payment.dart';
import 'Rental.dart';
import 'Rownum_example.dart';
import 'User_Information.dart';
import 'package:http/http.dart' as http;
import 'dart:html' as html;
import 'package:drag_and_drop_lists/drag_and_drop_list_interface.dart';
import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';

import 'Webview.dart';
import 'edit_zone_amt.dart';
import 'handheld.dart';
import 'web_user.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  var nFormat = NumberFormat("#,##0.00", "en_US");
  final ScrollController _scrollController = ScrollController();
  List<DragAndDropList> _contents = <DragAndDropList>[];
  DateTime datex = DateTime.now();
  int Status_ = 1;
  int Status_area_ = 1;
  int renTal_lavel = 0;
  final qrImageKey = GlobalKey();
  //------------------------------------------------------>
  int Status_MenuZone = 1;
  String name_Zone = 'ทั้งหมด';
  String Ser_nowpage = '7';
  int Ser_Zone = 0, row_num = 0;
  int Advance_ser = 0, open_set = 0, open_set_date = 0;
  ///////---------------------------------------------------->
  String tappedIndex_ = '';
  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  ///////---------------------------------------------------->
  List<ZoneModel> zoneModels = [];
  List<AreaModel> areaModels = [];
  List<AreaModel> _areaModels = <AreaModel>[];
  List<RenTalModel> renTalModels = [];
  List<PackageModel> packageModels = [];
  List<ContractRownumModel> contractRownumModels = [];
  ///////---------------------------------------------------->
  List Status = [
    'พื้นที่',
    'การเช่า',
    'เอกสาร',
    'การรับชำระ',
    'สิทธิการเข้าถึง',
    'ตั้งค่า เว็บMarket',
    'ตั้งค่า Handheld',
    'ตั้งค่า ข่าวสารเว็บ',
    'ค่าบริการตามโซน',
    // '📍ติดต่อเรา',
  ];
  List Status_2 = [
    'พื้นที่',
    'การเช่า',
    'เอกสาร',
    'การรับชำระ',
    'สิทธิการเข้าถึง',
    'ตั้งค่า เว็บMarket',
    'ตั้งค่า Handheld',
    'ตั้งค่า ข่าวสารเว็บ',
    'ค่าบริการตามโซน',
    'ตั้งค่าพิเศษ',
    // 'ข้อมูลผู้ใช้งาน',
    // '📍ติดต่อเรา',
  ];
  List Style_Area_thi = [
    'คอมมูนิตี้มอลล์',
    'ออฟฟิศให้เช่า',
    'ตลาดนัด',
    // 'อื่นๆ',
  ];
  List Style_Area_eng = [
    'COMMUNITY MALL',
    'OFFICE BUILDING',
    'FLEA MARKET',
    // 'อื่นๆ',
  ];
  List Howto_Rental = [
    'รายวัน',
    'รายเดือน',
    'รายปี',
  ];
  List buttonview_ = [
    'ข้อมูลการเช่า',
    'มิเตอร์น้ำไฟฟ้า',
    'ตั้งหนี้/วางบิล',
    'รับชำระ',
    'ประวัติบิล',
  ];
  List Status_area = [
    'ข้อมูลทั่วไป',
    'แผนผังพื้นที่',
  ];
  String? renTal_user, renTal_name, renTal_ser, zone_ser, zone_name;
  String? rtname, type, typex, renname, pkname, ser_Zonex;
  int? pkqty, pkuser, countarae, mass_on;
  String? base64_Imgmap, foder;
  String? ser_user,
      position_user,
      fname_user,
      lname_user,
      email_user,
      utype_user,
      permission_user,
      tel_user,
      img_,
      img_logo,
      acc_2,
      lineqr;
  @override
  void initState() {
    super.initState();
    read_GC_rental();
    checkPreferance();
    read_GC_package();
    read_GC_zone();
    read_GC_area();

    read_GC_area_count();
    read_GC_rownum().then((value) => con_row());
  }

  List<DragAndDropList> con_row() {
    return _contents = List.generate(1, (index) {
      return DragAndDropList(
        contentsWhenEmpty: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(
            "$name_Zone",
            style: TextStyle(color: Colors.grey),
          ),
        ),
        lastTarget: Text(
          "$name_Zone",
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
                        '$name_Zone',
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
          for (int indexc = 0; indexc < contractRownumModels.length; indexc++)
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
    });
  }

  final _formKeyZone = GlobalKey<FormState>();
  final Form_Zone_text = TextEditingController();
  Future<Null> read_GC_area_count() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var ren = preferences.getString('renTalSer');

    String url = '${MyConstant().domain}/GC_areaCount.php?isAdd=true&ren=$ren';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);
      if (result != null) {
        for (var map in result) {
          AreaCountModel areaCountModel = AreaCountModel.fromJson(map);
          var c = int.parse(areaCountModel.counta!);
          setState(() {
            countarae = c;
          });
        }
      } else {}
    } catch (e) {}
  }

  Future<Null> read_GC_package() async {
    if (packageModels.isNotEmpty) {
      setState(() {
        packageModels.clear();
      });
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    String url = '${MyConstant().domain}/GC_package.php?isAdd=true&ren=$ren';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print(result);
      if (result != null) {
        for (var map in result) {
          PackageModel packageModel = PackageModel.fromJson(map);

          setState(() {
            packageModels.add(packageModel);
          });
        }
      } else {}
    } catch (e) {}
    print('name>>>>>  $renname');
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
          var open_setx = int.parse(renTalModel.open_set!);
          var open_set_datex = int.parse(renTalModel.open_set_date!);
          var mass_onx = int.parse(renTalModel.mass_on!);
          var imglineqrx = renTalModel.imglineqr;
          setState(() {
            renTal_ser = ren!;
            acc_2 = renTalModel.acc2!;
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
            open_set = open_setx;
            open_set_date = open_set_datex == 0 ? 30 : open_set_datex;
            mass_on = mass_onx;
            lineqr = imglineqrx;
            renTalModels.add(renTalModel);
          });
        }
      } else {}
    } catch (e) {}
    print('name>>>>>  $renname');
  }

  Future<Null> checkPreferance() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      renTal_user = preferences.getString('renTalSer');
      renTal_name = preferences.getString('renTalName');
      renTal_lavel = int.parse(preferences.getString('lavel').toString());
    });
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
      print(result);
      Map<String, dynamic> map = Map();
      map['ser'] = '0';
      map['rser'] = '0';
      map['zn'] = 'ทั้งหมด';
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
        if (a.zn == 'ทั้งหมด') {
          return -1; // 'all' should come before other elements
        } else if (b.zn == 'ทั้งหมด') {
          return 1; // 'all' should come after other elements
        } else {
          return a.zn!
              .compareTo(b.zn!); // sort other elements in ascending order
        }
      });
    } catch (e) {}
  }

  Future<Null> read_GC_area() async {
    var start = DateTime.now();
    if (areaModels.length != 0) {
      setState(() {
        areaModels.clear();
      });
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var ren = preferences.getString('renTalSer');

    String url = (name_Zone.toString().trim() == 'ทั้งหมด')
        ? '${MyConstant().domain}/GC_areaAll.php?isAdd=true&ren=$ren'
        : '${MyConstant().domain}/GC_area.php?isAdd=true&ren=$ren&zone=$ser_Zonex';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);
      if (result != null) {
        if (areaModels.length != 0) {
          areaModels.clear();
        }
        for (var map in result) {
          AreaModel areaModel = AreaModel.fromJson(map);
          setState(() {
            areaModels.add(areaModel);
          });
        }
      } else {}
      setState(() {
        _areaModels = areaModels;
        zone_ser = preferences.getString('zoneSer');
        zone_name = preferences.getString('zonesName');
      });
    } catch (e) {}
  }

  Future<Null> read_GC_rownum() async {
    if (contractRownumModels.length != 0) {
      setState(() {
        contractRownumModels.clear();
      });
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var ren = preferences.getString('renTalSer');

    String url = (name_Zone.toString().trim() == 'ทั้งหมด')
        ? '${MyConstant().domain}/GC_areaAll_rownum.php?isAdd=true&ren=$ren&zone=0'
        : '${MyConstant().domain}/GC_areaAll_rownum.php?isAdd=true&ren=$ren&zone=$ser_Zonex';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);
      if (result != null) {
        if (areaModels.length != 0) {
          areaModels.clear();
        }
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

  _searchBar() {
    return TextField(
      autofocus: false,
      keyboardType: TextInputType.text,
      style: TextStyle(fontSize: 22.0, color: Colors.grey[700]),
      decoration: InputDecoration(
        filled: true,
        // fillColor: Colors.white,
        hintText: ' Search...',
        hintStyle: TextStyle(fontSize: 20.0, color: Colors.grey[700]),
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
          areaModels = _areaModels.where((areaModelss) {
            var notTitle = areaModelss.ln.toString().toLowerCase();
            var notTitle2 = areaModelss.lncode.toString().toLowerCase();
            // var notTitle3 = areaModelss.area.toString().toLowerCase();
            // var notTitle4 = areaModelss.rent.toString().toLowerCase();
            // var notTitle5 = areaModels.cname.toString().toLowerCase();
            return notTitle.contains(text) || notTitle2.contains(text);
          }).toList();
        });
      },
    );
  }

  ScrollController _scrollController1 = ScrollController();
  ScrollController _scrollController2 = ScrollController();
  final zone_text = TextEditingController();

  final area_ser_text = TextEditingController();

  final area_name_text = TextEditingController();
  final area_qty_text = TextEditingController();

  final area_pri_text = TextEditingController();

  final Add_totalnew_area_text = TextEditingController();
  final Add_Number_area_text = TextEditingController();
  final Add_Number_area_ = TextEditingController();
  final Add_name_area_text = TextEditingController();
  final Add_name_area_ = TextEditingController();
  final Add_qty_area_text = TextEditingController();
  final Add_pri_area_text = TextEditingController();
  final key_text = TextEditingController();

  List<dynamic> Start_number = [for (int i = 1; i <= 1000; i++) i++];

  ///----------------->
  _moveUp1() {
    _scrollController1.animateTo(_scrollController1.offset - 200,
        curve: Curves.linear, duration: const Duration(milliseconds: 500));
  }

  _moveDown1() {
    _scrollController1.animateTo(_scrollController1.offset + 200,
        curve: Curves.linear, duration: const Duration(milliseconds: 500));
  }

  ///----------------->
  _moveUp2() {
    _scrollController2.animateTo(_scrollController2.offset - 200,
        curve: Curves.linear, duration: const Duration(milliseconds: 500));
  }

  _moveDown2() {
    _scrollController2.animateTo(_scrollController2.offset + 200,
        curve: Curves.linear, duration: const Duration(milliseconds: 500));
  }

////--------------------------------------------------------------------->
  var extension_;
  var file_;

  Future<void> UpImg(context, fileName, Path_, Ser_) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var ren = preferences.getString('renTalSer');

    // String url = (Path_.toString() == 'contract')
    //     ? '${MyConstant().domain}/Up_imgMap.php?isAdd=true&ren=$ren&value=$fileName&ser_user=$ren'
    //     : (Path_.toString() == 'logo')
    //         ? '${MyConstant().domain}/Up_imglogo.php?isAdd=true&ren=$ren&value=$fileName&ser_user=$ren'
    //         : '${MyConstant().domain}/Up_imgZone.php?isAdd=true&ren=$ren&value=$fileName&ser=$Ser_';

    if (Path_.toString() == 'contract') {
      String url =
          '${MyConstant().domain}/Up_imgMap.php?isAdd=true&ren=$ren&value=$fileName&ser_user=$ren';
      var response = await http.get(Uri.parse(url));
      var result = json.decode(response.body);
      print(result.toString());
      checkPreferance();
      read_GC_rental();
      read_GC_package();
      read_GC_zone();
      read_GC_area();
      read_GC_area_count();
      Navigator.of(context).pop();
    } else if (Path_.toString() == 'logo') {
      String url =
          '${MyConstant().domain}/Up_imglogo.php?isAdd=true&ren=$ren&value=$fileName&ser_user=$ren';
      var response = await http.get(Uri.parse(url));
      var result = json.decode(response.body);
      print(result.toString());
      checkPreferance();
      read_GC_rental();
      read_GC_package();
      read_GC_zone();
      read_GC_area();
      read_GC_area_count();
      Navigator.of(context).pop();
    } else {
      String url =
          '${MyConstant().domain}/Up_imgZone.php?isAdd=true&ren=$ren&value=$fileName&ser=$Ser_';
      var response = await http.get(Uri.parse(url));
      var result = json.decode(response.body);
      print(result.toString());
      checkPreferance();
      read_GC_rental();
      read_GC_package();
      read_GC_zone();
      read_GC_area();
      read_GC_area_count();
      Navigator.of(context).pop();
    }
  }

  Future<void> deletedFile_(String Path_, String Namefile, String Ser_) async {
    // String Path_foder = 'contract';

    final deleteRequest = html.HttpRequest();
    if (Path_.toString() == 'contract') {
      deleteRequest.open('POST',
          '${MyConstant().domain}/File_Deleted_imgMap.php?Foder=$foder&name=$img_');
      deleteRequest.send();
      Insert_log.Insert_logs('ตั้งค่า', 'พื้นที่>>ลบรูป(แผนผัง)');
    } else if (Path_.toString() == 'logo') {
      deleteRequest.open('POST',
          '${MyConstant().domain}/File_Deleted_logo.php?Foder=$foder&name=$Namefile');
      deleteRequest.send();
      Insert_log.Insert_logs('ตั้งค่า', 'พื้นที่>>ลบรูป(โลโก้)');
    } else {
      deleteRequest.open('POST',
          '${MyConstant().domain}/File_Deleted_Zone.php?Foder=$foder&name=$Namefile');
      deleteRequest.send();
      Insert_log.Insert_logs('ตั้งค่า', 'พื้นที่>>ลบรูป(โซน)');
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var ren = preferences.getString('renTalSer');

    String url = (Path_.toString() == 'contract')
        ? '${MyConstant().domain}/Up_imgMap.php?isAdd=true&ren=$ren&value='
            '&ser_user=$ren'
        : (Path_.toString() == 'logo')
            ? '${MyConstant().domain}/Up_imglogo.php?isAdd=true&ren=$ren&value='
                '&ser_user=$ren'
            : '${MyConstant().domain}/Up_imgZone.php?isAdd=true&ren=$ren&value='
                '&ser=$Ser_';
    var response = await http.get(Uri.parse(url));
    var result = json.decode(response.body);
    print(result.toString());
    read_GC_rental();
    checkPreferance();
    read_GC_package();
    read_GC_zone();
    read_GC_area();
    read_GC_area_count();
    // Handle the response
    await deleteRequest.onLoad.first;
    if (deleteRequest.status == 200) {
      final response = deleteRequest.response;
      if (response == 'File deleted successfully.') {
        print('File deleted successfully!');
      } else {
        print('Failed to delete file: $response');
      }
    } else {
      print('Failed to delete file!');
    }
  }

  Future<void> uploadFile_Imgmap(
      String Path_, String Zone_, String Ser_) async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.getImage(source: ImageSource.gallery);

    if (pickedFile == null) {
      print('User canceled image selection');
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
        base64_Imgmap = base64Image;
      });
      // print( base64_Imgmap );
      setState(() {
        extension_ = 'png';
        // file_ = file;
      });
      print(extension_);
      print(extension_);
      OKuploadFile_Imgmap(Path_, Zone_, Ser_);
    }
  } //-----------File_upload_img_setting

  // Future<void> uploadFile_Imgmap(
  //     String Path_, String Zone_, String Ser_) async {
  //   // InsertFile_SQL(fileName, MixPath_);
  //   // Open the file picker and get the selected file
  //   final input = html.FileUploadInputElement();
  //   // input..accept = 'application/pdf';
  //   input.accept = 'image/jpeg,image/png,image/jpg';
  //   input.click();
  //   // deletedFile_('IDcard_LE000001_25-02-2023.pdf');
  //   await input.onChange.first;

  //   final file = input.files!.first;
  //   final reader = html.FileReader();
  //   reader.readAsArrayBuffer(file);
  //   await reader.onLoadEnd.first;
  //   String fileName_ = file.name;
  //   String extension = fileName_.split('.').last;
  //   print('File name: $fileName_');
  //   print('Extension: $extension');
  //   setState(() {
  //     base64_Imgmap = base64Encode(reader.result as Uint8List);
  //   });
  //   // print(base64_Imgmap);
  //   setState(() {
  //     extension_ = extension;
  //     file_ = file;
  //   });
  //   OKuploadFile_Imgmap(Path_, Zone_, Ser_);
  // }
  Future<void> OKuploadFile_Imgmap(
      String Path_, String Zone_, String Ser_) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    if (base64_Imgmap != null) {
      String Path_foder = Path_;
      String dateTimeNow = DateTime.now().toString();
      String date = DateFormat('ddMMyyyy')
          .format(DateTime.parse('${dateTimeNow}'))
          .toString();
      final dateTimeNow2 = DateTime.now().toUtc().add(const Duration(hours: 7));
      final formatter2 = DateFormat('HHmmss');
      final formattedTime2 = formatter2.format(dateTimeNow2);
      String Time_ = formattedTime2.toString();

      String fileName = '';
      if (Path_.toString() == 'contract') {
        setState(() {
          fileName = 'Map${ren}_${date}_$Time_.$extension_';
        });
        Insert_log.Insert_logs('ตั้งค่า', 'พื้นที่>>เพิ่มรูป(แผนผัง)');
      } else if (Path_.toString() == 'logo') {
        setState(() {
          fileName = 'logo${ren}_${date}_$Time_.$extension_';
        });
        Insert_log.Insert_logs('ตั้งค่า', 'พื้นที่>>เพิ่มรูป(โลโก้)');
      } else {
        setState(() {
          fileName = 'zone${Zone_}_${date}_$Time_.$extension_';
        });
        Insert_log.Insert_logs('ตั้งค่า', 'พื้นที่>>เพิ่มรูป(โซน$Zone_)');
      }

      try {
        final url =
            '${MyConstant().domain}/File_upload_img_setting.php?name=$fileName&Foder=$foder&extension=$extension_&Path=$Path_foder';

        final response = await http.post(
          Uri.parse(url),
          body: {
            'image': base64_Imgmap,
            'Foder': foder,
            'name': fileName,
            'ex': extension_.toString(),
            'Path': Path_foder
          },
        );

        if (response.statusCode == 200) {
          print('Image uploaded successfully');
          UpImg(context, fileName, Path_, Ser_);
        } else {
          print('Image upload failed');
        }
      } catch (e) {
        print('Error during image processing: $e');
      }
    }
  }

  // Future<void> OKuploadFile_Imgmap(
  //     String Path_, String Zone_, String Ser_) async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   var ren = preferences.getString('renTalSer');
  //   if (base64_Imgmap != null) {
  //     String Path_foder = Path_;
  //     String dateTimeNow = DateTime.now().toString();
  //     String date = DateFormat('ddMMyyyy')
  //         .format(DateTime.parse('${dateTimeNow}'))
  //         .toString();
  //     final dateTimeNow2 = DateTime.now().toUtc().add(const Duration(hours: 7));
  //     final formatter2 = DateFormat('HHmmss');
  //     final formattedTime2 = formatter2.format(dateTimeNow2);
  //     String Time_ = formattedTime2.toString();

  //     String fileName = '';
  //     if (Path_.toString() == 'contract') {
  //       setState(() {
  //         fileName = 'Map${ren}_${date}_$Time_.$extension_';
  //       });
  //       Insert_log.Insert_logs('ตั้งค่า', 'พื้นที่>>เพิ่มรูป(แผนผัง)');
  //     } else if (Path_.toString() == 'logo') {
  //       setState(() {
  //         fileName = 'logo${ren}_${date}_$Time_.$extension_';
  //       });
  //       Insert_log.Insert_logs('ตั้งค่า', 'พื้นที่>>เพิ่มรูป(โลโก้)');
  //     } else {
  //       setState(() {
  //         fileName = 'zone${Zone_}_${date}_$Time_.$extension_';
  //       });
  //       Insert_log.Insert_logs('ตั้งค่า', 'พื้นที่>>เพิ่มรูป(โซน$Zone_)');
  //     }
  //     // InsertFile_SQL(fileName, MixPath_, formattedTime1);
  //     // Create a new FormData object and add the file to it
  //     final formData = html.FormData();
  //     formData.appendBlob('file', file_, fileName);
  //     // Send the request
  //     final request = html.HttpRequest();
  //     request.open('POST',
  //         '${MyConstant().domain}/File_uploadSlip.php?name=$fileName&Foder=$foder&Pathfoder=$Path_foder');
  //     request.send(formData);

  //     print(formData);

  //     // Handle the response
  //     await request.onLoad.first;

  //     if (request.status == 200) {
  //       print('File uploaded successfully!');
  //       UpImg(context, fileName, Path_, Ser_);
  //       // try {
  //       //   UpImg(context, fileName, Path_, Ser_);
  //       // } catch (e) {
  //       //   print(e);
  //       // }
  //     } else {
  //       print('File upload failed with status code: ${request.status}');
  //     }
  //   } else {
  //     print('ยังไม่ได้เลือกรูปภาพ');
  //   }
  // }

  double _scaleFactor = 1.0; // define the initial scale factor

  void _zoomIn() {
    setState(() {
      _scaleFactor *= 1.2; // increase the scale factor by 20%
    });
  }

  void _zoomOut() {
    setState(() {
      _scaleFactor /= 1.2; // decrease the scale factor by 20%
    });
  }

////--------------------------------------------------------------------->
  Future<void> _showMyDialogImg(String Url, String title_) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: Center(
              child: Text(
            title_.toString(),
            style: const TextStyle(
              // fontSize: 15,
              color: Colors.black,
              fontFamily: Font_.Fonts_T,
              fontWeight: FontWeight.bold,
            ),
          )),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                InteractiveViewer(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.brown[100],
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    padding: const EdgeInsets.all(8.0),
                    child: (Url == null || Url.toString() == '')
                        ? const Center(
                            child: Icon(
                              Icons.image_not_supported,
                              color: Colors.black,
                            ),
                          )
                        : Image.network(
                            '$Url',
                            fit: BoxFit.contain,
                          ),
                  ),
                  scaleEnabled: true,
                  minScale: 0.5,
                  maxScale: 5.0,
                  transformationController: TransformationController()
                    ..value =
                        Matrix4.diagonal3Values(_scaleFactor, _scaleFactor, 1),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            // StreamBuilder(
            //     stream: Stream.periodic(const Duration(milliseconds: 0)),
            //     builder: (
            //       context,
            //       snapshot,
            //     ) {
            //       return SizedBox(
            //         child: Row(
            //           children: [
            //             IconButton(
            //               icon: Icon(Icons.add),
            //               onPressed: _zoomIn,
            //             ),
            //             IconButton(
            //               icon: Icon(Icons.remove),
            //               onPressed: _zoomOut,
            //             ),
            //           ],
            //         ),
            //       );
            //     }),
            InkWell(
              child: Container(
                width: 150,
                decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                padding: const EdgeInsets.all(4.0),
                child: Center(
                  child: Translate.TranslateAndSetText(
                      'ปิด',
                      SettingScreen_Color.Colors_Text3_,
                      TextAlign.start,
                      null,
                      Font_.Fonts_T,
                      14,
                      1),
                ),
              ),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: renTal_lavel <= 4
          ? Container(
              height: 500,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Translate.TranslateAndSetText(
                      'Level ของคุณไม่สามารถเข้าถึงได้',
                      SettingScreen_Color.Colors_Text1_,
                      TextAlign.center,
                      FontWeight.bold,
                      FontWeight_.Fonts_T,
                      16,
                      1),
                ),
              ),
            )
          : Column(
              children: [
                // Padding(
                //   padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                //   child: Container(
                //     height: 20,
                //     width: MediaQuery.of(context).size.width,
                //     decoration: const BoxDecoration(
                //       color: AppbackgroundColor.TiTile_Colors,
                //       borderRadius: BorderRadius.only(
                //           topLeft: Radius.circular(10),
                //           topRight: Radius.circular(10),
                //           bottomLeft: Radius.circular(0),
                //           bottomRight: Radius.circular(0)),
                //       // border: Border.all(color: Colors.white, width: 1),
                //     ),
                //     // padding: const EdgeInsets.all(8.0),
                //   ),
                // ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 8, 2, 0),
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
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Translate.TranslateAndSet_TextAutoSize(
                                      'การตั้งค่า',
                                      SettingScreen_Color.Colors_Text1_,
                                      TextAlign.center,
                                      FontWeight.bold,
                                      FontWeight_.Fonts_T,
                                      8,
                                      20,
                                      1),
                                  // const AutoSizeText(
                                  //   'ตั้งค่า',
                                  //   overflow: TextOverflow.ellipsis,
                                  //   minFontSize: 8,
                                  //   maxFontSize: 20,
                                  //   style: TextStyle(
                                  //     ตั้งค่า
                                  //     color: ReportScreen_Color.Colors_Text1_,
                                  //     fontWeight: FontWeight.bold,
                                  //     fontFamily: FontWeight_.Fonts_T,
                                  //   ),
                                  // ),
                                  const AutoSizeText(
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
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: InkWell(
                    //     onTap: () {
                    //       setState(() {
                    //         Status_ = 8;
                    //       });
                    //     },
                    //     child: Container(
                    //       decoration: BoxDecoration(
                    //         color: Colors.tealAccent[700],
                    //         borderRadius: const BorderRadius.only(
                    //           topLeft: Radius.circular(10),
                    //           topRight: Radius.circular(10),
                    //           bottomLeft: Radius.circular(10),
                    //           bottomRight: Radius.circular(10),
                    //         ),
                    //         border: Border.all(color: Colors.white, width: 2),
                    //       ),
                    //       padding: const EdgeInsets.all(8.0),
                    //       width: 120,
                    //       // height: 30,
                    //       child: Row(
                    //         mainAxisAlignment: MainAxisAlignment.center,
                    //         children: [
                    //           const Text(
                    //             '🔰 ',
                    //             style: TextStyle(
                    //                 // color:
                    //                 //     (Status_ == 7) ? Colors.black : Colors.black,
                    //                 fontFamily: FontWeight_.Fonts_T),
                    //           ),
                    //           Text(
                    //             'ติดต่อผู้ดูแล',
                    //             style: TextStyle(
                    //                 // decoration: TextDecoration.underline,
                    //                 color:
                    //                     (Status_ == 8) ? Colors.black : Colors.black,
                    //                 fontFamily: FontWeight_.Fonts_T),
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // )
                  ],
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.end,
                //   children: [
                //     Align(
                //       alignment: Alignment.topLeft,
                //       child: viewpage(context, '$Ser_nowpage'),
                //     ),
                //   ],
                // ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      color: AppbackgroundColor.TiTile_Box,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                      // border: Border.all(color: Colors.grey, width: 1),
                    ),
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: ScrollConfiguration(
                              behavior: ScrollConfiguration.of(context)
                                  .copyWith(dragDevices: {
                                PointerDeviceKind.touch,
                                PointerDeviceKind.mouse,
                              }),
                              child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: (acc_2! == '1')
                                      ? Row(children: [
                                          for (int i = 0;
                                              i < Status_2.length;
                                              i++)
                                            Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        8, 4, 4, 2),
                                                child: InkWell(
                                                  onTap: () {
                                                    print(i);
                                                    setState(() {
                                                      Status_ = i + 1;
                                                    });
                                                    // if (i == 6) {
                                                    //   setState(() {
                                                    //     Status_ = 9;
                                                    //   });
                                                    // } else {
                                                    //   setState(() {
                                                    //     Status_ = i + 1;
                                                    //   });
                                                    // }
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: (i + 1 == 1)
                                                          ? (Status_ == i + 1)
                                                              ? Colors.grey[700]
                                                              : Colors.grey[300]
                                                          : (i + 1 == 2)
                                                              ? (Status_ ==
                                                                      i + 1)
                                                                  ? Colors
                                                                      .red[700]
                                                                  : Colors
                                                                      .red[200]
                                                              : (i + 1 == 3)
                                                                  ? (Status_ ==
                                                                          i + 1)
                                                                      ? Colors.green[
                                                                          700]
                                                                      : Colors.green[
                                                                          200]
                                                                  : (i + 1 == 4)
                                                                      ? (Status_ ==
                                                                              i +
                                                                                  1)
                                                                          ? Colors.blue[
                                                                              700]
                                                                          : Colors.blue[
                                                                              200]
                                                                      : (i + 1 ==
                                                                              5)
                                                                          ? (Status_ == i + 1)
                                                                              ? Colors.orange[700]
                                                                              : Colors.orange[200]
                                                                          : (i + 1 == 6)
                                                                              ? (Status_ == i + 1)
                                                                                  ? Colors.blueGrey
                                                                                  : Colors.blueGrey[200]
                                                                              : (i + 1 == 7)
                                                                                  ? (Status_ == i + 1)
                                                                                      ? Colors.deepPurple
                                                                                      : Colors.deepPurple[200]
                                                                                  : (i + 1 == 8)
                                                                                      ? (Status_ == i + 1)
                                                                                          ? Colors.brown
                                                                                          : Colors.brown[200]
                                                                                      : (i + 1 == 9)
                                                                                          ? (Status_ == i + 1)
                                                                                              ? Colors.pink
                                                                                              : Colors.pink[200]
                                                                                          : (Status_ == i + 1)
                                                                                              ? Colors.yellow[600]
                                                                                              : Colors.yellow[200],
                                                      //     ? Colors.green
                                                      //     : (i + 1 == 2)
                                                      //         ? Colors.blue
                                                      //         : (i + 1 == 3)
                                                      //             ? Colors
                                                      //                 .deepPurple[300]
                                                      //             : (i + 1 == 4)
                                                      //                 ? Colors.red
                                                      //                 : (i + 1 == 5)
                                                      //                     ? Colors
                                                      //                         .orange
                                                      //                     : (i + 1 ==
                                                      //                             7)
                                                      //                         ? Colors
                                                      //                             .pink
                                                      //                         : (i + 1 ==
                                                      //                                 8)
                                                      //                             ? Colors.green
                                                      //                             : Colors.teal,
                                                      borderRadius:
                                                          const BorderRadius
                                                                  .only(
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
                                                      border: (Status_ == i + 1)
                                                          ? Border.all(
                                                              color:
                                                                  Colors.white,
                                                              width: 1)
                                                          : null,
                                                    ),
                                                    padding:
                                                        const EdgeInsets.all(
                                                            6.0),
                                                    child: Center(
                                                      child: Translate
                                                          .TranslateAndSetText(
                                                              '${Status_2[i]}',
                                                              (Status_ == i + 1)
                                                                  ? Colors.white
                                                                  : Colors
                                                                      .black,
                                                              TextAlign.center,
                                                              FontWeight.bold,
                                                              FontWeight_
                                                                  .Fonts_T,
                                                              14,
                                                              1),
                                                      // Text(
                                                      //   '${Status_2[i]}',
                                                      //   style: TextStyle(
                                                      //       color: (Status_ ==
                                                      //               i + 1)
                                                      //           ? Colors.white
                                                      //           : Colors.black,
                                                      //       fontFamily:
                                                      //           FontWeight_
                                                      //               .Fonts_T),
                                                      // ),
                                                    ),
                                                  ),
                                                )),
                                        ])
                                      : Row(children: [
                                          for (int i = 0;
                                              i < Status.length;
                                              i++)
                                            Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        8, 4, 4, 2),
                                                child: InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      Status_ = i + 1;
                                                    });
                                                    // setState(() {
                                                    //   if (i + 1 > 5) {
                                                    //     Status_ = i + 2;
                                                    //   } else {
                                                    //     Status_ = i + 1;
                                                    //   }
                                                    // });
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: (i + 1 == 1)
                                                          ? (Status_ == i + 1)
                                                              ? Colors.grey[700]
                                                              : Colors.grey[300]
                                                          : (i + 1 == 2)
                                                              ? (Status_ ==
                                                                      i + 1)
                                                                  ? Colors
                                                                      .red[700]
                                                                  : Colors
                                                                      .red[200]
                                                              : (i + 1 == 3)
                                                                  ? (Status_ ==
                                                                          i + 1)
                                                                      ? Colors.green[
                                                                          700]
                                                                      : Colors.green[
                                                                          200]
                                                                  : (i + 1 == 4)
                                                                      ? (Status_ ==
                                                                              i +
                                                                                  1)
                                                                          ? Colors.blue[
                                                                              700]
                                                                          : Colors.blue[
                                                                              200]
                                                                      : (i + 1 ==
                                                                              5)
                                                                          ? (Status_ == i + 1)
                                                                              ? Colors.orange[700]
                                                                              : Colors.orange[200]
                                                                          : (i + 1 == 6)
                                                                              ? (Status_ == i + 1)
                                                                                  ? Colors.blueGrey
                                                                                  : Colors.blueGrey[200]
                                                                              : (i + 1 == 7)
                                                                                  ? (Status_ == i + 1)
                                                                                      ? Colors.deepPurple
                                                                                      : Colors.deepPurple[200]
                                                                                  : (i + 1 == 8)
                                                                                      ? (Status_ == i + 1)
                                                                                          ? Colors.brown
                                                                                          : Colors.brown[200]
                                                                                      : (i + 1 == 9)
                                                                                          ? (Status_ == i + 1)
                                                                                              ? Colors.pink
                                                                                              : Colors.pink[200]
                                                                                          : (Status_ == i + 1)
                                                                                              ? Colors.yellow[600]
                                                                                              : Colors.yellow[200],
                                                      // ? Colors.green
                                                      // : (i + 1 == 2)
                                                      //     ? Colors.blue
                                                      //     : (i + 1 == 3)
                                                      //         ? Colors
                                                      //             .deepPurple[300]
                                                      //         : (i + 1 == 4)
                                                      //             ? Colors.red
                                                      //             : (i + 1 == 5)
                                                      //                 ? Colors
                                                      //                     .orange
                                                      //                 : (i + 1 ==
                                                      //                         7)
                                                      //                     ? Colors
                                                      //                         .green
                                                      //                     : (i + 1 ==
                                                      //                             8)
                                                      //                         ? Colors.lime.shade800
                                                      //                         : Colors.teal,
                                                      borderRadius:
                                                          const BorderRadius
                                                                  .only(
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
                                                      border: (Status_ == i + 1)
                                                          ? Border.all(
                                                              color:
                                                                  Colors.white,
                                                              width: 1)
                                                          : null,
                                                    ),
                                                    padding:
                                                        const EdgeInsets.all(
                                                            6.0),
                                                    child: Center(
                                                      child: Translate
                                                          .TranslateAndSetText(
                                                              '${Status[i]}',
                                                              (Status_ == i + 1)
                                                                  ? Colors.white
                                                                  : Colors
                                                                      .black,
                                                              TextAlign.center,
                                                              FontWeight.bold,
                                                              FontWeight_
                                                                  .Fonts_T,
                                                              14,
                                                              1),
                                                    ),
                                                  ),
                                                )),
                                        ])),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                (!Responsive.isDesktop(context))
                    ? BodyHome_mobile()
                    : BodyHome_Web()
              ],
            ),
    );
  }

  Widget BodyHome_Web() {
    return Column(
      children: [
        (Status_ == 1)
            ? Column(
                children: [
                  Row(
                    children: [
                      for (int i = 0; i < Status_area.length; i++)
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 4, 4, 2),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                Status_area_ = i + 1;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: (Status_area_ == i + 1)
                                    ? Colors.grey[700]
                                    : Colors.grey[300],
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10)),
                                border: (Status_area_ == i + 1)
                                    ? Border.all(color: Colors.white, width: 1)
                                    : null,
                              ),
                              padding: const EdgeInsets.all(6.0),
                              child: Center(
                                child: Translate.TranslateAndSetText(
                                    '${Status_area[i]}',
                                    (Status_area_ == i + 1)
                                        ? Colors.white
                                        : Colors.black,
                                    TextAlign.center,
                                    FontWeight.bold,
                                    FontWeight_.Fonts_T,
                                    14,
                                    1),
                                //  Text(
                                //   '${Status_area[i]}',
                                //   style: TextStyle(
                                //       color: (Status_area_ == i + 1)
                                //           ? Colors.white
                                //           : Colors.black,
                                //       fontFamily: FontWeight_.Fonts_T),
                                // ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  (Status_area_ == 1) ? Status1_Web() : GeneratedNodes(),
                ],
              )
            : (Status_ == 2)
                ? Status2_Web()
                : (Status_ == 3)
                    ? Status3_Web()
                    : (Status_ == 4)
                        ? Status4_Web()
                        : (Status_ == 5)
                            ? Status5_Web()
                            : (Status_ == 6)
                                ? Status6_Web()
                                : (Status_ == 7)
                                    ? Status7_Web()
                                    : (Status_ == 8)
                                        ? Status8_Web()
                                        : (Status_ == 9)
                                            ? open_set == 1
                                                ? EditZoneAmt()
                                                : Center(
                                                    child:
                                                        Text('Coming soon...'),
                                                  )
                                            : AdvanceSetting()
      ],
    );
  }

  Widget Status1_Web() {
    double Width_ = MediaQuery.of(context).size.width;
    return StreamBuilder(
        stream: Stream.periodic(const Duration(seconds: 30)),
        builder: (context, snapshot) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  // height:
                  // MediaQuery.of(context).size.height * 0.9,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      colorFilter: new ColorFilter.mode(
                          Colors.black.withOpacity(0.05), BlendMode.dstATop),
                      image: AssetImage("images/BG_im.png"),
                      fit: BoxFit.cover,
                    ),
                    color: Colors.white30,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                    // border: Border.all(color: Colors.white, width: 1),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (!Responsive.isDesktop(context))
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            width: 300,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Translate.TranslateAndSetText(
                                    'แผนผัง',
                                    SettingScreen_Color.Colors_Text2_,
                                    TextAlign.center,
                                    FontWeight.bold,
                                    Font_.Fonts_T,
                                    14,
                                    1),
                              ],
                            ),
                          ),
                        ),
                      if (!Responsive.isDesktop(context))
                        Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Stack(
                              children: [
                                Container(
                                  width: 300,
                                  height: 150,
                                  decoration: BoxDecoration(
                                    color: Colors.brown[100],
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10)),
                                  ),
                                  padding: const EdgeInsets.all(8.0),
                                  child: (img_ == null || img_.toString() == '')
                                      ? const Center(
                                          child: Icon(
                                          Icons.image_not_supported,
                                          color: Colors.black,
                                        ))
                                      : Image.network(
                                          '${MyConstant().domain}/files/$foder/contract/$img_',
                                          fit: BoxFit.cover,
                                        ),
                                ),
                                Positioned(
                                  right: 15,
                                  top: 15,
                                  child: InkWell(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.red[100],
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10)),
                                      ),
                                      padding: const EdgeInsets.all(4.0),
                                      child: Center(
                                        child: Translate.TranslateAndSetText(
                                            'ดูรูปแผนผัง',
                                            SettingScreen_Color.Colors_Text2_,
                                            TextAlign.center,
                                            FontWeight.bold,
                                            Font_.Fonts_T,
                                            14,
                                            1),
                                      ),
                                    ),
                                    onTap: () {
                                      if (img_ == null ||
                                          img_.toString() == '') {
                                      } else {
                                        String url =
                                            '${MyConstant().domain}/files/$foder/contract/$img_';
                                        _showMyDialogImg(url, 'รูปแผนผัง');
                                      }
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      SizedBox(
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: SizedBox(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              width: 150,
                                              decoration: const BoxDecoration(
                                                // color: Colors.yellow[200],
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(10),
                                                    topRight:
                                                        Radius.circular(10),
                                                    bottomLeft:
                                                        Radius.circular(10),
                                                    bottomRight:
                                                        Radius.circular(10)),
                                              ),
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Translate.TranslateAndSetText(
                                                  '1.ลักษณะ/ประเภทพื้นที่เช่า',
                                                  SettingScreen_Color
                                                      .Colors_Text2_,
                                                  TextAlign.start,
                                                  null,
                                                  Font_.Fonts_T,
                                                  14,
                                                  3),
                                              // const Text(
                                              //     '1.ลักษณะพื้นที่เช่า',
                                              //     maxLines: 3,
                                              //     overflow:
                                              //         TextOverflow.ellipsis,
                                              //     softWrap: false,
                                              //     textAlign: TextAlign.start,
                                              //     style: TextStyle(
                                              //         fontSize: 15,
                                              //         color: SettingScreen_Color
                                              //             .Colors_Text2_,
                                              //         fontFamily: Font_.Fonts_T
                                              //         // fontWeight: FontWeight.bold,
                                              //         )),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: SizedBox(
                                                width: 150,
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        // color:
                                                        //     Colors.brown[100],
                                                        borderRadius: const BorderRadius
                                                                .only(
                                                            topLeft: Radius
                                                                .circular(10),
                                                            topRight:
                                                                Radius.circular(
                                                                    10),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    10),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    10)),
                                                        border: Border.all(
                                                            color: Colors
                                                                .grey.shade800,
                                                            width: 1.2),
                                                      ),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Center(
                                                        child: Translate
                                                            .TranslateAndSetText(
                                                                '$typex',
                                                                SettingScreen_Color
                                                                    .Colors_Text2_,
                                                                TextAlign
                                                                    .center,
                                                                null,
                                                                Font_.Fonts_T,
                                                                14,
                                                                3),
                                                        //  Text('$typex',
                                                        //     maxLines: 3,
                                                        //     overflow:
                                                        //         TextOverflow
                                                        //             .ellipsis,
                                                        //     softWrap: false,
                                                        //     style: const TextStyle(
                                                        //         fontSize: 15,
                                                        //         color: SettingScreen_Color
                                                        //             .Colors_Text2_,
                                                        //         fontFamily:
                                                        //             Font_
                                                        //                 .Fonts_T
                                                        //         // fontWeight: FontWeight.bold,
                                                        //         )),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              // width: 150,
                                              decoration: const BoxDecoration(
                                                // color: Colors.yellow[200],
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(10),
                                                    topRight:
                                                        Radius.circular(10),
                                                    bottomLeft:
                                                        Radius.circular(10),
                                                    bottomRight:
                                                        Radius.circular(10)),
                                              ),
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child:
                                                  Translate.TranslateAndSetText(
                                                      '2.การคิดค่าเช่า',
                                                      SettingScreen_Color
                                                          .Colors_Text2_,
                                                      TextAlign.start,
                                                      null,
                                                      Font_.Fonts_T,
                                                      14,
                                                      3),
                                              // const Text(
                                              //     '2.การคิดค่าเช่า',
                                              //     maxLines: 3,
                                              //     textAlign: TextAlign.start,
                                              //     overflow:
                                              //         TextOverflow.ellipsis,
                                              //     softWrap: false,
                                              //     style: TextStyle(
                                              //         fontSize: 15,
                                              //         color: SettingScreen_Color
                                              //             .Colors_Text2_,
                                              //         fontFamily: Font_.Fonts_T
                                              //         // fontWeight: FontWeight.bold,
                                              //         )),
                                            ),
                                          ),
                                        ),
                                        // for (int index = 0;
                                        //     index < Howto_Rental.length;
                                        //     index++)
                                        Expanded(
                                          flex: 1,
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                // width: 150,
                                                decoration: BoxDecoration(
                                                  // color: Colors.brown[100],
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  10),
                                                          topRight:
                                                              Radius.circular(
                                                                  10),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  10),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  10)),
                                                  border: Border.all(
                                                      color:
                                                          Colors.grey.shade800,
                                                      width: 1.2),
                                                ),
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Center(
                                                  child: Translate
                                                      .TranslateAndSetText(
                                                          '$rtname',
                                                          SettingScreen_Color
                                                              .Colors_Text2_,
                                                          TextAlign.center,
                                                          null,
                                                          Font_.Fonts_T,
                                                          14,
                                                          3),
                                                  // Text('$rtname',
                                                  //     maxLines: 3,
                                                  //     overflow:
                                                  //         TextOverflow.ellipsis,
                                                  //     softWrap: false,
                                                  //     style: const TextStyle(
                                                  //         fontSize: 15,
                                                  //         color:
                                                  //             SettingScreen_Color
                                                  //                 .Colors_Text2_,
                                                  //         fontFamily:
                                                  //             Font_.Fonts_T
                                                  //         // fontWeight: FontWeight.bold,
                                                  //         )),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              width: 150,
                                              decoration: const BoxDecoration(
                                                // color: Colors.yellow[200],
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(10),
                                                    topRight:
                                                        Radius.circular(10),
                                                    bottomLeft:
                                                        Radius.circular(10),
                                                    bottomRight:
                                                        Radius.circular(10)),
                                              ),
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child:
                                                  Translate.TranslateAndSetText(
                                                      '3.ลักษณะการใช้งาน',
                                                      SettingScreen_Color
                                                          .Colors_Text2_,
                                                      TextAlign.start,
                                                      null,
                                                      Font_.Fonts_T,
                                                      14,
                                                      3),
                                              //  const Text('3.การใช้งาน',
                                              //     textAlign: TextAlign.start,
                                              //     maxLines: 3,
                                              //     overflow:
                                              //         TextOverflow.ellipsis,
                                              //     softWrap: false,
                                              //     style: TextStyle(
                                              //         fontSize: 15,
                                              //         color: SettingScreen_Color
                                              //             .Colors_Text2_,
                                              //         fontFamily: Font_.Fonts_T
                                              //         // fontWeight: FontWeight.bold,
                                              //         )),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                // width: 200,
                                                decoration: BoxDecoration(
                                                  // color: Colors.brown[100],
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  10),
                                                          topRight:
                                                              Radius.circular(
                                                                  10),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  10),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  10)),
                                                  border: Border.all(
                                                      color:
                                                          Colors.grey.shade800,
                                                      width: 1.2),
                                                ),
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Center(
                                                  child: Translate
                                                      .TranslateAndSetText(
                                                          '$type',
                                                          SettingScreen_Color
                                                              .Colors_Text2_,
                                                          TextAlign.center,
                                                          null,
                                                          Font_.Fonts_T,
                                                          14,
                                                          3),
                                                  // Text('$type',
                                                  //     maxLines: 3,
                                                  //     overflow:
                                                  //         TextOverflow.ellipsis,
                                                  //     softWrap: false,
                                                  //     style: const TextStyle(
                                                  //         fontSize: 15,
                                                  //         color:
                                                  //             SettingScreen_Color
                                                  //                 .Colors_Text2_,
                                                  //         fontFamily:
                                                  //             Font_.Fonts_T
                                                  //         // fontWeight: FontWeight.bold,
                                                  //         )),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            if (Responsive.isDesktop(context))
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Stack(
                                  children: [
                                    // Expanded(
                                    //   flex: 1,
                                    // child:
                                    Container(
                                      // width:
                                      //     MediaQuery.of(context).size.width * 0.3,
                                      height: 200,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[100],
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10)),
                                        border: Border.all(
                                            color: Colors.grey.shade800,
                                            width: 0.5),
                                      ),
                                      padding: const EdgeInsets.all(8.0),
                                      child: (img_ == null ||
                                              img_.toString() == '')
                                          ? SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.3,
                                              child: const Center(
                                                  child: Icon(
                                                Icons.image_not_supported,
                                                color: Colors.black,
                                              )),
                                            )
                                          : Image.network(
                                              '${MyConstant().domain}/files/$foder/contract/$img_',
                                              fit: BoxFit.fill,
                                            ),
                                    ),
                                    // ),
                                    Positioned(
                                      right: 15,
                                      top: 15,
                                      child: InkWell(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.red[100],
                                            borderRadius: const BorderRadius
                                                    .only(
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(10),
                                                bottomLeft: Radius.circular(10),
                                                bottomRight:
                                                    Radius.circular(10)),
                                          ),
                                          padding: const EdgeInsets.all(4.0),
                                          child: Center(
                                            child:
                                                Translate.TranslateAndSetText(
                                                    'ดูรูปแผนผัง',
                                                    SettingScreen_Color
                                                        .Colors_Text2_,
                                                    TextAlign.start,
                                                    null,
                                                    Font_.Fonts_T,
                                                    14,
                                                    1),
                                            // Text('ดูรูปแผนผัง',
                                            //     maxLines: 1,
                                            //     overflow: TextOverflow.ellipsis,
                                            //     softWrap: false,
                                            //     textAlign: TextAlign.start,
                                            //     style: TextStyle(
                                            //         fontSize: 15,
                                            //         color: SettingScreen_Color
                                            //             .Colors_Text2_,
                                            //         fontFamily: Font_.Fonts_T
                                            //         // fontWeight: FontWeight.bold,
                                            //         )),
                                          ),
                                        ),
                                        onTap: () {
                                          if (img_ == null ||
                                              img_.toString() == '') {
                                          } else {
                                            String url =
                                                '${MyConstant().domain}/files/$foder/contract/$img_';
                                            _showMyDialogImg(url, 'รูปแผนผัง');
                                          }
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              )
                          ],
                        ),
                      ),
                      // Container(
                      //   width: MediaQuery.of(context).size.width,
                      //   child: SingleChildScrollView(
                      //     scrollDirection: Axis.horizontal,
                      //     child: Row(
                      //       children: [
                      //         Padding(
                      //           padding: const EdgeInsets.all(8.0),
                      //           child: Container(
                      //             width: 150,
                      //             decoration: const BoxDecoration(
                      //               // color: Colors.yellow[200],
                      //               borderRadius: BorderRadius.only(
                      //                   topLeft: Radius.circular(10),
                      //                   topRight: Radius.circular(10),
                      //                   bottomLeft: Radius.circular(10),
                      //                   bottomRight: Radius.circular(10)),
                      //             ),
                      //             padding: const EdgeInsets.all(8.0),
                      //             child: const Text('1.ลักษณะพื้นที่เช่า',
                      //                 maxLines: 3,
                      //                 overflow: TextOverflow.ellipsis,
                      //                 softWrap: false,
                      //                 textAlign: TextAlign.start,
                      //                 style: TextStyle(
                      //                     fontSize: 15,
                      //                     color: SettingScreen_Color.Colors_Text2_,
                      //                     fontFamily: Font_.Fonts_T
                      //                     // fontWeight: FontWeight.bold,
                      //                     )),
                      //           ),
                      //         ),
                      //         Padding(
                      //           padding: const EdgeInsets.all(8.0),
                      //           child: SizedBox(
                      //             width: 150,
                      //             child: Column(
                      //               children: [
                      //                 Container(
                      //                   decoration: BoxDecoration(
                      //                     color: Colors.brown[100],
                      //                     borderRadius: const BorderRadius.only(
                      //                         topLeft: Radius.circular(10),
                      //                         topRight: Radius.circular(10),
                      //                         bottomLeft: Radius.circular(10),
                      //                         bottomRight: Radius.circular(10)),
                      //                   ),
                      //                   padding: const EdgeInsets.all(8.0),
                      //                   child: Center(
                      //                     child: Text('$typex',
                      //                         maxLines: 3,
                      //                         overflow: TextOverflow.ellipsis,
                      //                         softWrap: false,
                      //                         style: const TextStyle(
                      //                             fontSize: 15,
                      //                             color: SettingScreen_Color
                      //                                 .Colors_Text2_,
                      //                             fontFamily: Font_.Fonts_T
                      //                             // fontWeight: FontWeight.bold,
                      //                             )),
                      //                   ),
                      //                 ),
                      //               ],
                      //             ),
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      // Container(
                      //   width: MediaQuery.of(context).size.width,
                      //   child: SingleChildScrollView(
                      //     scrollDirection: Axis.horizontal,
                      //     child: Row(
                      //       children: [
                      //         Padding(
                      //           padding: const EdgeInsets.all(8.0),
                      //           child: Container(
                      //             width: 150,
                      //             decoration: const BoxDecoration(
                      //               // color: Colors.yellow[200],
                      //               borderRadius: BorderRadius.only(
                      //                   topLeft: Radius.circular(10),
                      //                   topRight: Radius.circular(10),
                      //                   bottomLeft: Radius.circular(10),
                      //                   bottomRight: Radius.circular(10)),
                      //             ),
                      //             padding: const EdgeInsets.all(8.0),
                      //             child: const Text('2.การคิดค่าเช่า',
                      //                 maxLines: 3,
                      //                 textAlign: TextAlign.start,
                      //                 overflow: TextOverflow.ellipsis,
                      //                 softWrap: false,
                      //                 style: TextStyle(
                      //                     fontSize: 15,
                      //                     color: SettingScreen_Color.Colors_Text2_,
                      //                     fontFamily: Font_.Fonts_T
                      //                     // fontWeight: FontWeight.bold,
                      //                     )),
                      //           ),
                      //         ),
                      //         // for (int index = 0;
                      //         //     index < Howto_Rental.length;
                      //         //     index++)
                      //         Padding(
                      //           padding: const EdgeInsets.all(8.0),
                      //           child: Container(
                      //             width: 150,
                      //             decoration: BoxDecoration(
                      //               color: Colors.brown[100],
                      //               borderRadius: const BorderRadius.only(
                      //                   topLeft: Radius.circular(10),
                      //                   topRight: Radius.circular(10),
                      //                   bottomLeft: Radius.circular(10),
                      //                   bottomRight: Radius.circular(10)),
                      //             ),
                      //             padding: const EdgeInsets.all(8.0),
                      //             child: Center(
                      //               child: Text('$rtname',
                      //                   maxLines: 3,
                      //                   overflow: TextOverflow.ellipsis,
                      //                   softWrap: false,
                      //                   style: const TextStyle(
                      //                       fontSize: 15,
                      //                       color: SettingScreen_Color.Colors_Text2_,
                      //                       fontFamily: Font_.Fonts_T
                      //                       // fontWeight: FontWeight.bold,
                      //                       )),
                      //             ),
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      // Container(
                      //   width: MediaQuery.of(context).size.width,
                      //   child: SingleChildScrollView(
                      //     scrollDirection: Axis.horizontal,
                      //     child: Row(
                      //       children: [
                      //         Padding(
                      //           padding: const EdgeInsets.all(8.0),
                      //           child: Container(
                      //             width: 150,
                      //             decoration: const BoxDecoration(
                      //               // color: Colors.yellow[200],
                      //               borderRadius: BorderRadius.only(
                      //                   topLeft: Radius.circular(10),
                      //                   topRight: Radius.circular(10),
                      //                   bottomLeft: Radius.circular(10),
                      //                   bottomRight: Radius.circular(10)),
                      //             ),
                      //             padding: const EdgeInsets.all(8.0),
                      //             child: const Text('3.การใช้งาน',
                      //                 textAlign: TextAlign.start,
                      //                 maxLines: 3,
                      //                 overflow: TextOverflow.ellipsis,
                      //                 softWrap: false,
                      //                 style: TextStyle(
                      //                     fontSize: 15,
                      //                     color: SettingScreen_Color.Colors_Text2_,
                      //                     fontFamily: Font_.Fonts_T
                      //                     // fontWeight: FontWeight.bold,
                      //                     )),
                      //           ),
                      //         ),
                      //         Padding(
                      //           padding: const EdgeInsets.all(8.0),
                      //           child: Container(
                      //             width: 200,
                      //             decoration: BoxDecoration(
                      //               color: Colors.brown[100],
                      //               borderRadius: const BorderRadius.only(
                      //                   topLeft: Radius.circular(10),
                      //                   topRight: Radius.circular(10),
                      //                   bottomLeft: Radius.circular(10),
                      //                   bottomRight: Radius.circular(10)),
                      //             ),
                      //             padding: const EdgeInsets.all(8.0),
                      //             child: Center(
                      //               child: Text('$type',
                      //                   maxLines: 3,
                      //                   overflow: TextOverflow.ellipsis,
                      //                   softWrap: false,
                      //                   style: const TextStyle(
                      //                       fontSize: 15,
                      //                       color: SettingScreen_Color.Colors_Text2_,
                      //                       fontFamily: Font_.Fonts_T
                      //                       // fontWeight: FontWeight.bold,
                      //                       )),
                      //             ),
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: 150,
                                      decoration: const BoxDecoration(
                                        // color: Colors.yellow[200],
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10)),
                                      ),
                                      padding: const EdgeInsets.all(8.0),
                                      child: Translate.TranslateAndSetText(
                                          '4.ชื่อสถานที่',
                                          SettingScreen_Color.Colors_Text2_,
                                          TextAlign.start,
                                          null,
                                          Font_.Fonts_T,
                                          14,
                                          1),
                                      // Text('4.ชื่อสถานที่',
                                      //     textAlign: TextAlign.start,
                                      //     maxLines: 3,
                                      //     overflow: TextOverflow.ellipsis,
                                      //     softWrap: false,
                                      //     style: TextStyle(
                                      //         fontSize: 15,
                                      //         color: SettingScreen_Color
                                      //             .Colors_Text2_,
                                      //         fontFamily: Font_.Fonts_T
                                      //         // fontWeight: FontWeight.bold,
                                      //         )),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: 200,
                                      decoration: const BoxDecoration(
                                        // color: Colors.blue.shade100,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10)),
                                        // border: Border.all(color: Colors.grey, width: 1),
                                      ),
                                      padding: const EdgeInsets.all(8.0),
                                      child: Center(
                                        child: StreamBuilder(
                                            stream: Stream.periodic(
                                                const Duration(seconds: 0)),
                                            builder: (context, snapshot) {
                                              return TextFormField(
                                                initialValue: renname!.trim(),
                                                onFieldSubmitted:
                                                    (value) async {
                                                  SharedPreferences
                                                      preferences =
                                                      await SharedPreferences
                                                          .getInstance();
                                                  String? ren = preferences
                                                      .getString('renTalSer');
                                                  String? ser_user = preferences
                                                      .getString('ser');

                                                  String url =
                                                      '${MyConstant().domain}/UpC_rentel_pn.php?isAdd=true&ren=$ren&value=$value&ser_user=$ser_user';

                                                  try {
                                                    var response = await http
                                                        .get(Uri.parse(url));

                                                    var result = json
                                                        .decode(response.body);
                                                    print(result);
                                                    if (result.toString() ==
                                                        'true') {
                                                      setState(() {
                                                        read_GC_rental();
                                                      });
                                                    } else {}
                                                  } catch (e) {}
                                                },
                                                // maxLength: 13,
                                                cursorColor: Colors.green,
                                                decoration: InputDecoration(
                                                  fillColor: Colors.white
                                                      .withOpacity(0.05),
                                                  filled: true,
                                                  // prefixIcon:
                                                  //     const Icon(Icons.key, color: Colors.black),
                                                  // suffixIcon: Icon(Icons.clear, color: Colors.black),
                                                  focusedBorder:
                                                      const OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topRight:
                                                          Radius.circular(15),
                                                      topLeft:
                                                          Radius.circular(15),
                                                      bottomRight:
                                                          Radius.circular(15),
                                                      bottomLeft:
                                                          Radius.circular(15),
                                                    ),
                                                    // borderSide: BorderSide(
                                                    //   width: 1,
                                                    //   color: Colors.grey,
                                                    // ),
                                                  ),
                                                  enabledBorder:
                                                      const OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topRight:
                                                          Radius.circular(15),
                                                      topLeft:
                                                          Radius.circular(15),
                                                      bottomRight:
                                                          Radius.circular(15),
                                                      bottomLeft:
                                                          Radius.circular(15),
                                                    ),
                                                    // borderSide: BorderSide(
                                                    //   width: 1,
                                                    //   color: Colors.black,
                                                    // ),
                                                  ),
                                                  // labelText: 'PASSWOED',
                                                  labelStyle: const TextStyle(
                                                      color:
                                                          PeopleChaoScreen_Color
                                                              .Colors_Text2_,
                                                      // fontWeight: FontWeight.bold,
                                                      fontFamily:
                                                          Font_.Fonts_T),
                                                ),
                                              );
                                            }),
                                        // Text('${renTal_name}',
                                        //     maxLines: 3,
                                        //     overflow: TextOverflow.ellipsis,
                                        //     softWrap: false,
                                        //     style: TextStyle(
                                        //         fontSize: 15,
                                        //         color: SettingScreen_Color.Colors_Text2_,
                                        //         fontFamily: Font_.Fonts_T
                                        //         // fontWeight: FontWeight.bold,
                                        //         )),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: InkWell(
                                      child: Container(
                                        width: 150,
                                        decoration: BoxDecoration(
                                          color: Colors.teal[600],
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10),
                                              bottomLeft: Radius.circular(10),
                                              bottomRight: Radius.circular(10)),
                                        ),
                                        padding: const EdgeInsets.all(8.0),
                                        child: PopupMenuButton(
                                          child: Center(
                                            child:
                                                Translate.TranslateAndSetText(
                                                    'เพิ่มรูปภาพ',
                                                    SettingScreen_Color
                                                        .Colors_Text3_,
                                                    TextAlign.start,
                                                    null,
                                                    Font_.Fonts_T,
                                                    14,
                                                    1),
                                            // Text('เพิ่มรูป',
                                            //     maxLines: 3,
                                            //     overflow: TextOverflow.ellipsis,
                                            //     softWrap: false,
                                            //     style: TextStyle(
                                            //         fontSize: 15,
                                            //         color: SettingScreen_Color
                                            //             .Colors_Text3_,
                                            //         fontFamily: Font_.Fonts_T
                                            //         // fontWeight: FontWeight.bold,
                                            //         )),
                                          ),
                                          itemBuilder: (BuildContext context) =>
                                              [
                                            PopupMenuItem(
                                              child: InkWell(
                                                  onTap: () async {
                                                    if (img_logo == null ||
                                                        img_logo.toString() ==
                                                            '') {
                                                      uploadFile_Imgmap(
                                                          'logo', '', '');
                                                    } else {
                                                      showDialog<void>(
                                                        context: context,
                                                        barrierDismissible:
                                                            false, // user must tap button!
                                                        builder: (BuildContext
                                                            context) {
                                                          return AlertDialog(
                                                            shape: const RoundedRectangleBorder(
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            10.0))),
                                                            title: Center(
                                                              child: Translate.TranslateAndSetText(
                                                                  'มีรูปโลโก้อยู่แล้ว',
                                                                  SettingScreen_Color
                                                                      .Colors_Text1_,
                                                                  TextAlign
                                                                      .start,
                                                                  null,
                                                                  Font_.Fonts_T,
                                                                  14,
                                                                  1),
                                                            ),
                                                            content:
                                                                SingleChildScrollView(
                                                              child: ListBody(
                                                                children: <Widget>[
                                                                  Translate.TranslateAndSetText(
                                                                      'มีรูปโลโก้ หากต้องการอัพโหลดกรุณาลบรูปโลโก้ที่มีอยู่แล้วก่อน',
                                                                      SettingScreen_Color
                                                                          .Colors_Text1_,
                                                                      TextAlign
                                                                          .start,
                                                                      null,
                                                                      Font_
                                                                          .Fonts_T,
                                                                      14,
                                                                      1),
                                                                ],
                                                              ),
                                                            ),
                                                            actions: <Widget>[
                                                              Column(
                                                                children: [
                                                                  const SizedBox(
                                                                    height: 5.0,
                                                                  ),
                                                                  const Divider(
                                                                    color: Colors
                                                                        .grey,
                                                                    height: 4.0,
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 5.0,
                                                                  ),
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(8.0),
                                                                        child:
                                                                            InkWell(
                                                                          child: Container(
                                                                              width: 50,
                                                                              decoration: BoxDecoration(
                                                                                color: Colors.red[600],
                                                                                borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                                                                                // border: Border.all(color: Colors.white, width: 1),
                                                                              ),
                                                                              padding: const EdgeInsets.all(8.0),
                                                                              child: Center(
                                                                                child: Translate.TranslateAndSetText('ลบรูป', SettingScreen_Color.Colors_Text3_, TextAlign.start, null, Font_.Fonts_T, 14, 1),
                                                                              )),
                                                                          onTap:
                                                                              () async {
                                                                            String
                                                                                url =
                                                                                await '${MyConstant().domain}/files/$foder/logo/$img_logo';
                                                                            deletedFile_(
                                                                                'logo',
                                                                                '$img_logo',
                                                                                '');
                                                                            Navigator.of(context).pop();
                                                                            Navigator.of(context).pop();
                                                                          },
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        child:
                                                                            Row(
                                                                          children: [
                                                                            Padding(
                                                                              padding: const EdgeInsets.all(8.0),
                                                                              child: InkWell(
                                                                                child: Container(
                                                                                    width: 50,
                                                                                    decoration: BoxDecoration(
                                                                                      color: Colors.green[600],
                                                                                      borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                                                                                      // border: Border.all(color: Colors.white, width: 1),
                                                                                    ),
                                                                                    padding: const EdgeInsets.all(8.0),
                                                                                    child: Center(
                                                                                      child: Translate.TranslateAndSetText('ดูรูป', SettingScreen_Color.Colors_Text3_, TextAlign.start, null, Font_.Fonts_T, 14, 1),
                                                                                    )),
                                                                                onTap: () async {
                                                                                  String url = await '${MyConstant().domain}/files/$foder/logo/$img_logo';
                                                                                  Navigator.of(context).pop();
                                                                                  Navigator.of(context).pop();

                                                                                  _showMyDialogImg(url, 'รูปโลโก้');
                                                                                },
                                                                              ),
                                                                            ),
                                                                            Padding(
                                                                              padding: const EdgeInsets.all(8.0),
                                                                              child: InkWell(
                                                                                child: Container(
                                                                                    width: 50,
                                                                                    decoration: const BoxDecoration(
                                                                                      color: Colors.black,
                                                                                      borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                                                                                      // border: Border.all(color: Colors.white, width: 1),
                                                                                    ),
                                                                                    padding: const EdgeInsets.all(8.0),
                                                                                    child: Center(
                                                                                      child: Translate.TranslateAndSetText('ปิด', SettingScreen_Color.Colors_Text3_, TextAlign.start, null, Font_.Fonts_T, 14, 1),
                                                                                    )),
                                                                                onTap: () {
                                                                                  Navigator.of(context).pop();
                                                                                  Navigator.of(context).pop();
                                                                                },
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
                                                          );
                                                        },
                                                      );
                                                    }

                                                    // Navigator.pop(context);
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
                                                          (img_logo == null ||
                                                                  img_logo.toString() ==
                                                                      '')
                                                              ? const Icon(
                                                                  Icons.cancel,
                                                                  color: Colors
                                                                      .red,
                                                                )
                                                              : const Icon(
                                                                  Icons.check,
                                                                  color: Colors
                                                                      .green,
                                                                ),
                                                          const Expanded(
                                                            child: Text(
                                                              ' รูปโลโก้',
                                                              style: TextStyle(
                                                                  color: SettingScreen_Color
                                                                      .Colors_Text1_,
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontFamily:
                                                                      FontWeight_
                                                                          .Fonts_T),
                                                            ),
                                                          ),
                                                        ],
                                                      ))),
                                            ),
                                            PopupMenuItem(
                                              child: InkWell(
                                                  onTap: () async {
                                                    if (img_ == null ||
                                                        img_.toString() == '') {
                                                      uploadFile_Imgmap(
                                                          'contract', '', '');
                                                    } else {
                                                      showDialog<void>(
                                                        context: context,
                                                        barrierDismissible:
                                                            false, // user must tap button!
                                                        builder: (BuildContext
                                                            context) {
                                                          return AlertDialog(
                                                            shape: const RoundedRectangleBorder(
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            10.0))),
                                                            title: const Center(
                                                                child: Text(
                                                              'มีรูปแผนผังอยู่แล้ว',
                                                              style: TextStyle(
                                                                  color: SettingScreen_Color
                                                                      .Colors_Text1_,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontFamily:
                                                                      FontWeight_
                                                                          .Fonts_T),
                                                            )),
                                                            content:
                                                                const SingleChildScrollView(
                                                              child: ListBody(
                                                                children: <Widget>[
                                                                  Text(
                                                                    'มีรูปแผนผัง หากต้องการอัพโหลดกรุณาลบรูปแผนผังที่มีอยู่แล้วก่อน',
                                                                    style: TextStyle(
                                                                        color: SettingScreen_Color
                                                                            .Colors_Text2_,
                                                                        fontFamily:
                                                                            Font_.Fonts_T),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            actions: <Widget>[
                                                              Column(
                                                                children: [
                                                                  const SizedBox(
                                                                    height: 5.0,
                                                                  ),
                                                                  const Divider(
                                                                    color: Colors
                                                                        .grey,
                                                                    height: 4.0,
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 5.0,
                                                                  ),
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(8.0),
                                                                        child:
                                                                            InkWell(
                                                                          child: Container(
                                                                              width: 50,
                                                                              decoration: BoxDecoration(
                                                                                color: Colors.red[600],
                                                                                borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                                                                                // border: Border.all(color: Colors.white, width: 1),
                                                                              ),
                                                                              padding: const EdgeInsets.all(8.0),
                                                                              child: const Center(
                                                                                  child: Text(
                                                                                'ลบรูป',
                                                                                style: TextStyle(color: SettingScreen_Color.Colors_Text3_, fontWeight: FontWeight.bold, fontFamily: Font_.Fonts_T),
                                                                              ))),
                                                                          onTap:
                                                                              () async {
                                                                            String
                                                                                url =
                                                                                await '${MyConstant().domain}/files/$foder/contract/$img_';
                                                                            deletedFile_(
                                                                                'contract',
                                                                                '',
                                                                                '');
                                                                            Navigator.of(context).pop();
                                                                            Navigator.of(context).pop();
                                                                          },
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        child:
                                                                            Row(
                                                                          children: [
                                                                            Padding(
                                                                              padding: const EdgeInsets.all(8.0),
                                                                              child: InkWell(
                                                                                child: Container(
                                                                                    width: 50,
                                                                                    decoration: BoxDecoration(
                                                                                      color: Colors.green[600],
                                                                                      borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                                                                                      // border: Border.all(color: Colors.white, width: 1),
                                                                                    ),
                                                                                    padding: const EdgeInsets.all(8.0),
                                                                                    child: const Center(
                                                                                        child: Text(
                                                                                      'ดูรูป',
                                                                                      style: TextStyle(color: SettingScreen_Color.Colors_Text3_, fontWeight: FontWeight.bold, fontFamily: Font_.Fonts_T),
                                                                                    ))),
                                                                                onTap: () async {
                                                                                  String url = await '${MyConstant().domain}/files/$foder/contract/$img_';
                                                                                  Navigator.of(context).pop();
                                                                                  Navigator.of(context).pop();

                                                                                  _showMyDialogImg(url, 'รูปแผนผัง');
                                                                                },
                                                                              ),
                                                                            ),
                                                                            Padding(
                                                                              padding: const EdgeInsets.all(8.0),
                                                                              child: InkWell(
                                                                                child: Container(
                                                                                    width: 50,
                                                                                    decoration: const BoxDecoration(
                                                                                      color: Colors.black,
                                                                                      borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                                                                                      // border: Border.all(color: Colors.white, width: 1),
                                                                                    ),
                                                                                    padding: const EdgeInsets.all(8.0),
                                                                                    child: const Center(
                                                                                        child: Text(
                                                                                      'ปิด',
                                                                                      style: TextStyle(color: SettingScreen_Color.Colors_Text3_, fontWeight: FontWeight.bold, fontFamily: Font_.Fonts_T),
                                                                                    ))),
                                                                                onTap: () {
                                                                                  Navigator.of(context).pop();
                                                                                  Navigator.of(context).pop();
                                                                                },
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
                                                          );
                                                        },
                                                      );
                                                    }

                                                    // Navigator.pop(context);
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
                                                          (img_ == null ||
                                                                  img_.toString() ==
                                                                      '')
                                                              ? const Icon(
                                                                  Icons.cancel,
                                                                  color: Colors
                                                                      .red,
                                                                )
                                                              : const Icon(
                                                                  Icons.check,
                                                                  color: Colors
                                                                      .green,
                                                                ),
                                                          Expanded(
                                                            child: Translate.TranslateAndSetText(
                                                                ' รูปแผนผังพื้นที่',
                                                                SettingScreen_Color
                                                                    .Colors_Text1_,
                                                                TextAlign.start,
                                                                FontWeight.bold,
                                                                FontWeight_
                                                                    .Fonts_T,
                                                                14,
                                                                1),
                                                          ),
                                                        ],
                                                      ))),
                                            ),
                                            for (int index = 1;
                                                index < zoneModels.length;
                                                index++)
                                              PopupMenuItem(
                                                child: InkWell(
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
                                                          (zoneModels[index]
                                                                          .img ==
                                                                      null ||
                                                                  zoneModels[index]
                                                                          .img
                                                                          .toString() ==
                                                                      '')
                                                              ? const Icon(
                                                                  Icons.cancel,
                                                                  color: Colors
                                                                      .red,
                                                                )
                                                              : const Icon(
                                                                  Icons.check,
                                                                  color: Colors
                                                                      .green,
                                                                ),
                                                          Expanded(
                                                            child: Text(
                                                              '${zoneModels[index].zn}',
                                                              style: const TextStyle(
                                                                  color: SettingScreen_Color
                                                                      .Colors_Text1_,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 14,
                                                                  fontFamily:
                                                                      FontWeight_
                                                                          .Fonts_T),
                                                            ),
                                                          ),
                                                        ],
                                                      )),
                                                  onTap: () async {
                                                    if (zoneModels[index].img ==
                                                            null ||
                                                        zoneModels[index]
                                                                .img
                                                                .toString() ==
                                                            '') {
                                                      uploadFile_Imgmap(
                                                          'zone',
                                                          '${zoneModels[index].zn}',
                                                          '${zoneModels[index].ser}');
                                                      print(
                                                          '${zoneModels[index].ser}');
                                                    } else {
                                                      showDialog<void>(
                                                        context: context,
                                                        barrierDismissible:
                                                            false, // user must tap button!
                                                        builder: (BuildContext
                                                            context) {
                                                          return AlertDialog(
                                                            shape: const RoundedRectangleBorder(
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            10.0))),
                                                            title: Center(
                                                                child: Text(
                                                              'มีรูป(${zoneModels[index].zn})อยู่แล้ว',
                                                              style: const TextStyle(
                                                                  color: SettingScreen_Color
                                                                      .Colors_Text1_,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontFamily:
                                                                      FontWeight_
                                                                          .Fonts_T),
                                                            )),
                                                            content:
                                                                SingleChildScrollView(
                                                              child: ListBody(
                                                                children: <Widget>[
                                                                  Text(
                                                                    'มีรูป(${zoneModels[index].zn})อยู่แล้ว หากต้องการอัพโหลดกรุณาลบรูปที่มีอยู่แล้วก่อน',
                                                                    style: const TextStyle(
                                                                        color: SettingScreen_Color
                                                                            .Colors_Text2_,
                                                                        fontFamily:
                                                                            Font_.Fonts_T),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            actions: <Widget>[
                                                              Column(
                                                                children: [
                                                                  const SizedBox(
                                                                    height: 5.0,
                                                                  ),
                                                                  const Divider(
                                                                    color: Colors
                                                                        .grey,
                                                                    height: 4.0,
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 5.0,
                                                                  ),
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(8.0),
                                                                        child:
                                                                            InkWell(
                                                                          child: Container(
                                                                              width: 50,
                                                                              decoration: BoxDecoration(
                                                                                color: Colors.red[600],
                                                                                borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                                                                                // border: Border.all(color: Colors.white, width: 1),
                                                                              ),
                                                                              padding: const EdgeInsets.all(8.0),
                                                                              child: const Center(
                                                                                  child: Text(
                                                                                'ลบรูป',
                                                                                style: TextStyle(color: SettingScreen_Color.Colors_Text3_, fontWeight: FontWeight.bold, fontFamily: Font_.Fonts_T),
                                                                              ))),
                                                                          onTap:
                                                                              () async {
                                                                            deletedFile_(
                                                                                'zone',
                                                                                '${zoneModels[index].img}',
                                                                                '${zoneModels[index].ser}');
                                                                            Navigator.of(context).pop();
                                                                            Navigator.of(context).pop();
                                                                          },
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        child:
                                                                            Row(
                                                                          children: [
                                                                            Padding(
                                                                              padding: const EdgeInsets.all(8.0),
                                                                              child: InkWell(
                                                                                child: Container(
                                                                                    width: 50,
                                                                                    decoration: BoxDecoration(
                                                                                      color: Colors.green[600],
                                                                                      borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                                                                                      // border: Border.all(color: Colors.white, width: 1),
                                                                                    ),
                                                                                    padding: const EdgeInsets.all(8.0),
                                                                                    child: const Center(
                                                                                        child: Text(
                                                                                      'ดูรูป',
                                                                                      style: TextStyle(color: SettingScreen_Color.Colors_Text3_, fontWeight: FontWeight.bold, fontFamily: Font_.Fonts_T),
                                                                                    ))),
                                                                                onTap: () async {
                                                                                  String url = await '${MyConstant().domain}/files/$foder/zone/${zoneModels[index].img}';
                                                                                  Navigator.of(context).pop();
                                                                                  Navigator.of(context).pop();

                                                                                  _showMyDialogImg(url, 'รูปโซน(${zoneModels[index].zn})');
                                                                                },
                                                                              ),
                                                                            ),
                                                                            Padding(
                                                                              padding: const EdgeInsets.all(8.0),
                                                                              child: InkWell(
                                                                                child: Container(
                                                                                    width: 50,
                                                                                    decoration: const BoxDecoration(
                                                                                      color: Colors.black,
                                                                                      borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                                                                                      // border: Border.all(color: Colors.white, width: 1),
                                                                                    ),
                                                                                    padding: const EdgeInsets.all(8.0),
                                                                                    child: const Center(
                                                                                        child: Text(
                                                                                      'ปิด',
                                                                                      style: TextStyle(color: SettingScreen_Color.Colors_Text3_, fontWeight: FontWeight.bold, fontFamily: Font_.Fonts_T),
                                                                                    ))),
                                                                                onTap: () {
                                                                                  Navigator.of(context).pop();
                                                                                  Navigator.of(context).pop();
                                                                                },
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
                                                          );
                                                        },
                                                      );

                                                      // String url =
                                                      //     '${MyConstant().domain}/files/$foder/contract/$img_';
                                                      // _showMyDialog(url);
                                                    }
                                                  },
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    // width: 230,
                                    width: (!Responsive.isDesktop(context))
                                        ? MediaQuery.of(context).size.width *
                                            0.5
                                        : MediaQuery.of(context).size.width *
                                            0.22,

                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          decoration: const BoxDecoration(
                                            // color: Colors.purple.shade600,
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(10),
                                                bottomLeft: Radius.circular(10),
                                                bottomRight:
                                                    Radius.circular(10)),
                                          ),
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              Translate
                                                  .TranslateAndSet_TextAutoSize(
                                                      'Package $pkname : $pkqty ล็อค/แผง ',
                                                      SettingScreen_Color
                                                          .Colors_Text1_,
                                                      TextAlign.center,
                                                      FontWeight.bold,
                                                      FontWeight_.Fonts_T,
                                                      10,
                                                      18,
                                                      2),
                                              Translate
                                                  .TranslateAndSet_TextAutoSize(
                                                      'จำนวน $pkuser สิทธิผู้ใช้งาน',
                                                      SettingScreen_Color
                                                          .Colors_Text1_,
                                                      TextAlign.center,
                                                      FontWeight.bold,
                                                      FontWeight_.Fonts_T,
                                                      10,
                                                      18,
                                                      2),
                                            ],
                                          ),

                                          //  AutoSizeText(
                                          //   minFontSize: 10,
                                          //   maxFontSize: 18,
                                          //   'Package $pkname : $pkqty ล็อค/แผง \n จำนวน $pkuser สิทธิผู้ใช้งาน',
                                          //   textAlign: TextAlign.end,
                                          //   style: const TextStyle(
                                          //       color: SettingScreen_Color
                                          //           .Colors_Text1_,
                                          //       fontFamily: Font_.Fonts_T),
                                          // ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: InkWell(
                                      child: Container(
                                        width: 150,
                                        decoration: BoxDecoration(
                                          color: Colors.purple.shade600,
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10),
                                              bottomLeft: Radius.circular(10),
                                              bottomRight: Radius.circular(10)),
                                        ),
                                        padding: const EdgeInsets.all(8.0),
                                        child: const Text('Licensekey',
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                            softWrap: false,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: SettingScreen_Color
                                                    .Colors_Text3_,
                                                fontFamily: Font_.Fonts_T)),
                                      ),
                                      onTap: () {
                                        showDialog<String>(
                                          barrierDismissible: false,
                                          context: context,
                                          builder: (BuildContext context) =>
                                              AlertDialog(
                                            shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20.0))),
                                            title: Row(
                                              children: [
                                                const Expanded(
                                                    child: SizedBox()),
                                                const Expanded(
                                                  child: Center(
                                                      child: Text(
                                                    'Licensekey',
                                                    style: TextStyle(
                                                      color: SettingScreen_Color
                                                          .Colors_Text1_,
                                                      fontFamily:
                                                          FontWeight_.Fonts_T,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  )),
                                                ),
                                                Expanded(
                                                    child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    InkWell(
                                                      onTap: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: const Center(
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  8.0),
                                                          child: Icon(
                                                              Icons
                                                                  .highlight_off,
                                                              size: 35,
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                )),
                                              ],
                                            ),
                                            content: SingleChildScrollView(
                                              child: Container(
                                                // height: MediaQuery.of(context).size.height / 1.5,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.1,

                                                decoration: const BoxDecoration(
                                                  // color: Colors.grey[300],
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topLeft: Radius
                                                              .circular(10),
                                                          topRight:
                                                              Radius.circular(
                                                                  10),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  10),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  10)),
                                                  // border: Border.all(color: Colors.white, width: 1),
                                                ),
                                                child: ScrollConfiguration(
                                                  behavior: AppScrollBehavior(),
                                                  child: Form(
                                                    key: _formKey,
                                                    child: Column(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: SizedBox(
                                                            // width: 200,
                                                            child:
                                                                TextFormField(
                                                              controller:
                                                                  key_text,
                                                              validator:
                                                                  (value) {
                                                                if (value ==
                                                                        null ||
                                                                    value
                                                                        .isEmpty) {
                                                                  return 'ใส่ข้อมูลให้ครบถ้วน ';
                                                                }
                                                                // if (int.parse(value.toString()) < 13) {
                                                                //   return '< 13';
                                                                // }
                                                                return null;
                                                              },
                                                              // maxLength: 13,
                                                              cursorColor:
                                                                  Colors.green,
                                                              decoration:
                                                                  InputDecoration(
                                                                      fillColor: Colors
                                                                          .white
                                                                          .withOpacity(
                                                                              0.3),
                                                                      filled:
                                                                          true,
                                                                      // prefixIcon:
                                                                      //     const Icon(Icons.person_pin, color: Colors.black),
                                                                      // suffixIcon: Icon(Icons.clear, color: Colors.black),
                                                                      focusedBorder:
                                                                          const OutlineInputBorder(
                                                                        borderRadius:
                                                                            BorderRadius.only(
                                                                          topRight:
                                                                              Radius.circular(15),
                                                                          topLeft:
                                                                              Radius.circular(15),
                                                                          bottomRight:
                                                                              Radius.circular(15),
                                                                          bottomLeft:
                                                                              Radius.circular(15),
                                                                        ),
                                                                        borderSide:
                                                                            BorderSide(
                                                                          width:
                                                                              1,
                                                                          color:
                                                                              Colors.black,
                                                                        ),
                                                                      ),
                                                                      enabledBorder:
                                                                          const OutlineInputBorder(
                                                                        borderRadius:
                                                                            BorderRadius.only(
                                                                          topRight:
                                                                              Radius.circular(15),
                                                                          topLeft:
                                                                              Radius.circular(15),
                                                                          bottomRight:
                                                                              Radius.circular(15),
                                                                          bottomLeft:
                                                                              Radius.circular(15),
                                                                        ),
                                                                        borderSide:
                                                                            BorderSide(
                                                                          width:
                                                                              1,
                                                                          color:
                                                                              Colors.grey,
                                                                        ),
                                                                      ),
                                                                      labelText:
                                                                          'Key',
                                                                      labelStyle:
                                                                          const TextStyle(
                                                                        color: Colors
                                                                            .black54,
                                                                        fontFamily:
                                                                            FontWeight_.Fonts_T,
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
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .end,
                                                            children: [
                                                              Container(
                                                                width: 100,
                                                                decoration:
                                                                    const BoxDecoration(
                                                                  color: Colors
                                                                      .black,
                                                                  borderRadius: BorderRadius.only(
                                                                      topLeft:
                                                                          Radius.circular(
                                                                              10),
                                                                      topRight:
                                                                          Radius.circular(
                                                                              10),
                                                                      bottomLeft:
                                                                          Radius.circular(
                                                                              10),
                                                                      bottomRight:
                                                                          Radius.circular(
                                                                              10)),
                                                                ),
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child:
                                                                    TextButton(
                                                                  onPressed:
                                                                      () async {
                                                                    if (_formKey
                                                                        .currentState!
                                                                        .validate()) {
                                                                      SharedPreferences
                                                                          preferences =
                                                                          await SharedPreferences
                                                                              .getInstance();
                                                                      String?
                                                                          ren =
                                                                          preferences
                                                                              .getString('renTalSer');
                                                                      String?
                                                                          ser_user =
                                                                          preferences
                                                                              .getString('ser');

                                                                      var keyname =
                                                                          key_text
                                                                              .text;

                                                                      String
                                                                          url =
                                                                          '${MyConstant().domain}/UDC_Rental.php?isAdd=true&ren=$ren&ser_user=$ser_user&keyname=$keyname';

                                                                      try {
                                                                        var response =
                                                                            await http.get(Uri.parse(url));

                                                                        var result =
                                                                            json.decode(response.body);
                                                                        print(
                                                                            '---------------อัปเดท KEY------------------');
                                                                        print(
                                                                            result);
                                                                        Insert_log.Insert_logs(
                                                                            'ตั้งค่า',
                                                                            'พื้นที่>>อัปเดท KEY');
                                                                        if (result.toString() ==
                                                                            'true') {
                                                                          setState(
                                                                              () {
                                                                            key_text.clear();
                                                                            read_GC_rental();
                                                                            read_GC_zone();
                                                                            read_GC_area();
                                                                            read_GC_area_count();
                                                                          });

                                                                          Navigator.pop(
                                                                              context,
                                                                              'OK');
                                                                        } else {
                                                                          ScaffoldMessenger.of(context)
                                                                              .showSnackBar(
                                                                            SnackBar(content: Text('Key ถูกใช้งานแล้ว หรือ Key ไม่ถูกต้องกรุณาลองใหม่!', style: TextStyle(color: Colors.white, fontFamily: Font_.Fonts_T))),
                                                                          );
                                                                          setState(
                                                                              () {
                                                                            key_text.clear();
                                                                          });
                                                                          Navigator.pop(
                                                                              context,
                                                                              'OK');
                                                                        }
                                                                      } catch (e) {
                                                                        print(
                                                                            e);
                                                                      }
                                                                    }
                                                                  },
                                                                  child:
                                                                      const Text(
                                                                    'Submit',
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontFamily:
                                                                          FontWeight_
                                                                              .Fonts_T,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
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
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  InkWell(
                                    child: Container(
                                      width: 150,
                                      decoration: const BoxDecoration(
                                        color: Colors.orange,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10)),
                                      ),
                                      padding: const EdgeInsets.all(8.0),
                                      child: Translate.TranslateAndSetText(
                                          '+เพิ่มโซนพื้นที่',
                                          SettingScreen_Color.Colors_Text3_,
                                          TextAlign.center,
                                          FontWeight.bold,
                                          FontWeight_.Fonts_T,
                                          14,
                                          1),
                                    ),
                                    onTap: () {
                                      showDialog<String>(
                                        barrierDismissible: false,
                                        context: context,
                                        builder: (BuildContext context) => Form(
                                          key: _formKey,
                                          child: AlertDialog(
                                            shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20.0))),
                                            title: Center(
                                              child:
                                                  Translate.TranslateAndSetText(
                                                      'เพิ่มโซนพื้นที่',
                                                      SettingScreen_Color
                                                          .Colors_Text1_,
                                                      TextAlign.left,
                                                      FontWeight.bold,
                                                      FontWeight_.Fonts_T,
                                                      14,
                                                      1),
                                            ),
                                            content: Container(
                                              // height: MediaQuery.of(context).size.height / 1.5,
                                              width: (!Responsive.isDesktop(
                                                      context))
                                                  ? MediaQuery.of(context)
                                                      .size
                                                      .width
                                                  : MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.5,
                                              decoration: const BoxDecoration(
                                                // color: Colors.grey[300],
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(10),
                                                    topRight:
                                                        Radius.circular(10),
                                                    bottomLeft:
                                                        Radius.circular(10),
                                                    bottomRight:
                                                        Radius.circular(10)),
                                                // border: Border.all(color: Colors.white, width: 1),
                                              ),
                                              child: SingleChildScrollView(
                                                child: Column(
                                                  // mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    StreamBuilder(
                                                        stream: Stream.periodic(
                                                            const Duration(
                                                                seconds: 0)),
                                                        builder: (context,
                                                            snapshot) {
                                                          return (zone_text
                                                                      .text ==
                                                                  '')
                                                              ? SizedBox()
                                                              : Column(
                                                                  children: [
                                                                    Row(
                                                                      children: [
                                                                        Translate.TranslateAndSetText(
                                                                            '# ชื่อโซนที่ใกล้เครียง : ',
                                                                            SettingScreen_Color.Colors_Text1_,
                                                                            TextAlign.left,
                                                                            FontWeight.bold,
                                                                            FontWeight_.Fonts_T,
                                                                            14,
                                                                            1),
                                                                        Expanded(
                                                                            flex:
                                                                                1,
                                                                            child:
                                                                                ScrollConfiguration(
                                                                              behavior: ScrollConfiguration.of(context).copyWith(dragDevices: {
                                                                                PointerDeviceKind.touch,
                                                                                PointerDeviceKind.mouse,
                                                                              }),
                                                                              child: SingleChildScrollView(
                                                                                scrollDirection: Axis.horizontal,
                                                                                child: Row(
                                                                                  children: [
                                                                                    Text(
                                                                                      '${zoneModels.where((zoneModelss) {
                                                                                            var notTitle = zoneModelss.zn.toString().trim().toLowerCase();
                                                                                            var notTitle2 = zoneModelss.zn.toString().trim();

                                                                                            return notTitle.contains(zone_text.text.toString().trim()) || notTitle2.contains(zone_text.text.toString().trim());
                                                                                          }).map((model) => model.zn).join(' , ')}',
                                                                                      textAlign: TextAlign.left,
                                                                                      style: TextStyle(
                                                                                        color: Colors.red,
                                                                                        fontFamily: Font_.Fonts_T,
                                                                                        // fontWeight: FontWeight.bold,
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            )),
                                                                      ],
                                                                    ),
                                                                    Divider(
                                                                      color: Colors
                                                                              .grey[
                                                                          300],
                                                                      height:
                                                                          4.0,
                                                                    ),
                                                                  ],
                                                                );
                                                        }),
                                                    Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  8.0),
                                                          child: Translate
                                                              .TranslateAndSetText(
                                                                  'ชื่อโซน',
                                                                  SettingScreen_Color
                                                                      .Colors_Text1_,
                                                                  TextAlign
                                                                      .center,
                                                                  FontWeight
                                                                      .bold,
                                                                  FontWeight_
                                                                      .Fonts_T,
                                                                  14,
                                                                  1),
                                                        ),
                                                      ],
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: SizedBox(
                                                        // width: 200,
                                                        child: TextFormField(
                                                          controller: zone_text,
                                                          validator: (value) {
                                                            if (value == null ||
                                                                value.isEmpty) {
                                                              return 'ใส่ข้อมูลให้ครบถ้วน ';
                                                            }
                                                            // if (int.parse(value.toString()) < 13) {
                                                            //   return '< 13';
                                                            // }
                                                            return null;
                                                          },
                                                          // maxLength: 13,
                                                          cursorColor:
                                                              Colors.green,
                                                          decoration:
                                                              InputDecoration(
                                                                  fillColor: Colors
                                                                      .white
                                                                      .withOpacity(
                                                                          0.3),
                                                                  filled: true,
                                                                  // prefixIcon:
                                                                  //     const Icon(Icons.person_pin, color: Colors.black),
                                                                  // suffixIcon: Icon(Icons.clear, color: Colors.black),
                                                                  focusedBorder:
                                                                      const OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .only(
                                                                      topRight:
                                                                          Radius.circular(
                                                                              15),
                                                                      topLeft: Radius
                                                                          .circular(
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
                                                                      color: Colors
                                                                          .black,
                                                                    ),
                                                                  ),
                                                                  enabledBorder:
                                                                      const OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .only(
                                                                      topRight:
                                                                          Radius.circular(
                                                                              15),
                                                                      topLeft: Radius
                                                                          .circular(
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
                                                                      color: Colors
                                                                          .grey,
                                                                    ),
                                                                  ),
                                                                  labelText:
                                                                      'ชื่อโซน',
                                                                  labelStyle:
                                                                      const TextStyle(
                                                                    color: Colors
                                                                        .black54,
                                                                    fontFamily:
                                                                        FontWeight_
                                                                            .Fonts_T,
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
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: StreamBuilder(
                                                              stream: Stream.periodic(
                                                                  const Duration(
                                                                      seconds:
                                                                          10)),
                                                              builder: (context,
                                                                  snapshot) {
                                                                return Container(
                                                                  width: 100,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: (zoneModels.any(
                                                                                (zoneModelss) {
                                                                              return zoneModelss.zn.toString().trim() == '${zone_text.text}';
                                                                            }) ==
                                                                            true)
                                                                        ? Colors
                                                                            .grey
                                                                        : Colors
                                                                            .green,
                                                                    borderRadius: BorderRadius.only(
                                                                        topLeft:
                                                                            Radius.circular(
                                                                                10),
                                                                        topRight:
                                                                            Radius.circular(
                                                                                10),
                                                                        bottomLeft:
                                                                            Radius.circular(
                                                                                10),
                                                                        bottomRight:
                                                                            Radius.circular(10)),
                                                                  ),
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child:
                                                                      TextButton(
                                                                    onPressed: (zoneModels.any((zoneModelss) {
                                                                              return zoneModelss.zn.toString().trim() == '${zone_text.text}';
                                                                            }) ==
                                                                            true)
                                                                        ? null
                                                                        : () async {
                                                                            if (_formKey.currentState!.validate()) {
                                                                              SharedPreferences preferences = await SharedPreferences.getInstance();
                                                                              String? ren = preferences.getString('renTalSer');
                                                                              String? ser_user = preferences.getString('ser');

                                                                              var zonename = zone_text.text;

                                                                              String url = '${MyConstant().domain}/InC_zone_setring.php?isAdd=true&ren=$ren&ser_user=$ser_user&zonename=$zonename';

                                                                              try {
                                                                                var response = await http.get(Uri.parse(url));

                                                                                var result = json.decode(response.body);
                                                                                print(result);
                                                                                Insert_log.Insert_logs('ตั้งค่า', 'พื้นที่>>เพิ่มโซนพื้นที่(${zone_text.text.toString()})');
                                                                                if (result.toString() == 'true') {
                                                                                  setState(() {
                                                                                    zone_text.clear();
                                                                                    read_GC_zone();
                                                                                    read_GC_area();
                                                                                    read_GC_area_count();
                                                                                  });

                                                                                  Navigator.pop(context, 'OK');
                                                                                }
                                                                              } catch (e) {
                                                                                print(e);
                                                                              }
                                                                            }
                                                                          },
                                                                    child: Translate.TranslateAndSetText(
                                                                        'บันทึก',
                                                                        Colors
                                                                            .white,
                                                                        TextAlign
                                                                            .center,
                                                                        FontWeight
                                                                            .bold,
                                                                        FontWeight_
                                                                            .Fonts_T,
                                                                        14,
                                                                        1),
                                                                  ),
                                                                );
                                                              }),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Container(
                                                            width: 100,
                                                            decoration:
                                                                const BoxDecoration(
                                                              color:
                                                                  Colors.black,
                                                              borderRadius: BorderRadius.only(
                                                                  topLeft: Radius
                                                                      .circular(
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
                                                            ),
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: TextButton(
                                                              onPressed: () =>
                                                                  Navigator.pop(
                                                                      context,
                                                                      'OK'),
                                                              child: Translate
                                                                  .TranslateAndSetText(
                                                                      'ยกเลิก',
                                                                      Colors
                                                                          .white,
                                                                      TextAlign
                                                                          .center,
                                                                      FontWeight
                                                                          .bold,
                                                                      FontWeight_
                                                                          .Fonts_T,
                                                                      14,
                                                                      1),
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
                                    },
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: 250,
                                      decoration: const BoxDecoration(
                                        // color: Colors.yellow[200],
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10)),
                                      ),
                                      padding: const EdgeInsets.all(8.0),
                                      child: Translate.TranslateAndSetText(
                                          '5.ระยะเวลาแจ้งใกล้หมดสัญญา',
                                          SettingScreen_Color.Colors_Text2_,
                                          TextAlign.start,
                                          null,
                                          Font_.Fonts_T,
                                          14,
                                          1),
                                      //  const Text(
                                      //     '5.ระยะเวลาแจ้งใกล้หมดสัญญา',
                                      //     textAlign: TextAlign.start,
                                      //     maxLines: 3,
                                      //     overflow: TextOverflow.ellipsis,
                                      //     softWrap: false,
                                      //     style: TextStyle(
                                      //         fontSize: 15,
                                      //         color: SettingScreen_Color
                                      //             .Colors_Text2_,
                                      //         fontFamily: Font_.Fonts_T
                                      //         // fontWeight: FontWeight.bold,
                                      //         )),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: 100,
                                      decoration: const BoxDecoration(
                                        // color: Colors.blue.shade100,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10)),
                                        // border: Border.all(color: Colors.grey, width: 1),
                                      ),
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        initialValue:
                                            open_set_date.toString().trim(),
                                        onFieldSubmitted: (value) async {
                                          SharedPreferences preferences =
                                              await SharedPreferences
                                                  .getInstance();
                                          String? ren = preferences
                                              .getString('renTalSer');
                                          String? ser_user =
                                              preferences.getString('ser');

                                          String url =
                                              '${MyConstant().domain}/UpC_rentel_open_set_date.php?isAdd=true&ren=$ren&value=$value&ser_user=$ser_user';

                                          try {
                                            var response =
                                                await http.get(Uri.parse(url));

                                            var result =
                                                json.decode(response.body);
                                            print(result);
                                            if (result.toString() == 'true') {
                                              setState(() {
                                                read_GC_rental();
                                              });
                                            } else {}
                                          } catch (e) {}
                                        },
                                        // maxLength: 13,
                                        cursorColor: Colors.green,
                                        decoration: InputDecoration(
                                          fillColor:
                                              Colors.white.withOpacity(0.05),
                                          filled: true,
                                          // prefixIcon:
                                          //     const Icon(Icons.key, color: Colors.black),
                                          // suffixIcon: Icon(Icons.clear, color: Colors.black),
                                          focusedBorder:
                                              const OutlineInputBorder(
                                            borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(15),
                                              topLeft: Radius.circular(15),
                                              bottomRight: Radius.circular(15),
                                              bottomLeft: Radius.circular(15),
                                            ),
                                            // borderSide: BorderSide(
                                            //   width: 1,
                                            //   color: Colors.grey,
                                            // ),
                                          ),
                                          enabledBorder:
                                              const OutlineInputBorder(
                                            borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(15),
                                              topLeft: Radius.circular(15),
                                              bottomRight: Radius.circular(15),
                                              bottomLeft: Radius.circular(15),
                                            ),
                                            // borderSide: BorderSide(
                                            //   width: 1,
                                            //   color: Colors.black,
                                            // ),
                                          ),
                                          // labelText: 'PASSWOED',
                                          labelStyle: const TextStyle(
                                              color: PeopleChaoScreen_Color
                                                  .Colors_Text2_,
                                              // fontWeight: FontWeight.bold,
                                              fontFamily: Font_.Fonts_T),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: 50,
                                      decoration: const BoxDecoration(
                                        // color: Colors.yellow[200],
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10)),
                                      ),
                                      padding: const EdgeInsets.all(8.0),
                                      child: Translate.TranslateAndSetText(
                                          'วัน',
                                          SettingScreen_Color.Colors_Text2_,
                                          TextAlign.start,
                                          null,
                                          Font_.Fonts_T,
                                          14,
                                          1),
                                      // Text('วัน',
                                      //     textAlign: TextAlign.start,
                                      //     maxLines: 3,
                                      //     overflow: TextOverflow.ellipsis,
                                      //     softWrap: false,
                                      //     style: TextStyle(
                                      //         fontSize: 15,
                                      //         color: SettingScreen_Color
                                      //             .Colors_Text2_,
                                      //         fontFamily: Font_.Fonts_T
                                      //         // fontWeight: FontWeight.bold,
                                      //         )),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: (Responsive.isDesktop(context))
                                          ? 300
                                          : 200,
                                      decoration: const BoxDecoration(
                                        // color: Colors.yellow[200],
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10)),
                                      ),
                                      padding: const EdgeInsets.all(8.0),
                                      child: Translate.TranslateAndSetText(
                                          '6.เปิดแจ้งผ่านไลน์ (อาจมีค่าใช้จ่ายเพิ่มเติม)',
                                          SettingScreen_Color.Colors_Text2_,
                                          TextAlign.start,
                                          null,
                                          Font_.Fonts_T,
                                          14,
                                          1),
                                      //    const Text(
                                      //       '6.เปิดแจ้งผ่านไลน์ (อาจมีค่าใช้จ่ายเพิ่มเติม)',
                                      //       textAlign: TextAlign.start,
                                      //       maxLines: 3,
                                      //       overflow: TextOverflow.ellipsis,
                                      //       softWrap: false,
                                      //       style: TextStyle(
                                      //           fontSize: 15,
                                      //           color: SettingScreen_Color
                                      //               .Colors_Text2_,
                                      //           fontFamily: Font_.Fonts_T
                                      //           // fontWeight: FontWeight.bold,
                                      //           )),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: 50,
                                      decoration: const BoxDecoration(
                                        // color: Colors.yellow[200],
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10)),
                                      ),
                                      padding: const EdgeInsets.all(8.0),
                                      child: GestureDetector(
                                        onTap: () async {
                                          SharedPreferences preferences =
                                              await SharedPreferences
                                                  .getInstance();
                                          String? ren = preferences
                                              .getString('renTalSer');
                                          String? ser_user =
                                              preferences.getString('ser');
                                          var value = mass_on == 1 ? '0' : '1';
                                          String url =
                                              '${MyConstant().domain}/UpC_rentel_mass_on.php?isAdd=true&ren=$ren&value=$value&ser_user=$ser_user';

                                          try {
                                            var response =
                                                await http.get(Uri.parse(url));

                                            var result =
                                                json.decode(response.body);
                                            print(result);
                                            if (result.toString() == 'true') {
                                              setState(() {
                                                read_GC_rental();
                                              });
                                            } else {}
                                          } catch (e) {}
                                        },
                                        child: Icon(
                                          mass_on == 1
                                              ? Icons.toggle_on
                                              : Icons.toggle_off,
                                          size: 50,
                                          color: mass_on == 1
                                              ? Colors.green
                                              : Colors.red,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Translate.TranslateAndSetText(
                                        mass_on == 1 ? 'เปิดอยู่' : 'ปิดอยู่',
                                        SettingScreen_Color.Colors_Text2_,
                                        TextAlign.start,
                                        null,
                                        Font_.Fonts_T,
                                        14,
                                        1),
                                    // Text(
                                    //   mass_on == 1 ? 'เปิดอยู่' : 'ปิดอยู่',
                                    //   style: const TextStyle(
                                    //       fontWeight: FontWeight.bold),
                                    // ),
                                  ),
                                ],
                              ),
                            ),
                            if (Responsive.isDesktop(context))
                              lineqr == ''
                                  ? const SizedBox()
                                  : Expanded(
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Column(
                                          children: [
                                            RepaintBoundary(
                                              key: qrImageKey,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topLeft: Radius
                                                              .circular(10),
                                                          topRight:
                                                              Radius.circular(
                                                                  10),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  10),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  10)),
                                                  border: Border.all(
                                                      color: Colors.grey,
                                                      width: 1),
                                                ),
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: Container(
                                                  width: 150,
                                                  height: 150,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    10),
                                                            topRight:
                                                                Radius.circular(
                                                                    10),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    10),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    10)),
                                                    // image: DecorationImage(
                                                    //   image:
                                                    //       NetworkImage(lineqr!),
                                                    //   fit: BoxFit.fitHeight,
                                                    // ),
                                                  ),
                                                  child: PrettyQr(
                                                    // typeNumber: 3,
                                                    // image: AssetImage(
                                                    //   "images/Icon-chao.png",
                                                    // ),
                                                    size: 120,
                                                    data:
                                                        lineqr!, // 'https://lin.ee/CZv8lAr',
                                                    // 'https://qr-official.line.me/gs/M_218wysoe_BW.png?oat_content=qr',
                                                    errorCorrectLevel:
                                                        QrErrorCorrectLevel.M,
                                                    roundEdges: true,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 150,
                                              child: Align(
                                                alignment: Alignment.center,
                                                child: Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      const Text(
                                                        'LINE QR ADD',
                                                        style: TextStyle(
                                                            fontFamily:
                                                                FontWeight_
                                                                    .Fonts_T,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      InkWell(
                                                          onTap: () {
                                                            Future.delayed(
                                                                const Duration(
                                                                    milliseconds:
                                                                        300),
                                                                () async {
                                                              captureAndConvertToBase64(
                                                                  qrImageKey,
                                                                  'QR_LINE_');
                                                            });
                                                          },
                                                          child: Icon(
                                                            Icons.download,
                                                            color: Colors.green,
                                                          ))
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                            // Row(
                            //   children: [
                            //     lineqr == ''
                            //         ? const SizedBox()
                            //         :
                            // Column(
                            //             children: [
                            //               Container(
                            //                 width: MediaQuery.of(context)
                            //                     .size
                            //                     .width,
                            //                 height: 150,
                            //                 decoration: BoxDecoration(
                            //                   image: DecorationImage(
                            //                     image:
                            //                         NetworkImage(lineqr!),
                            //                     fit: BoxFit.fitHeight,
                            //                   ),
                            //                 ),
                            //                 child: const SizedBox(
                            //                   width: 200,
                            //                   height: 200,
                            //                 ),
                            //               ),
                            //               const Padding(
                            //                 padding: EdgeInsets.all(8.0),
                            //                 child: Text(
                            //                   'LINE QR ADD',
                            //                   style: TextStyle(
                            //                       fontFamily:
                            //                           FontWeight_.Fonts_T,
                            //                       fontWeight:
                            //                           FontWeight.bold),
                            //                 ),
                            //               )
                            //             ],
                            //           ),
                            //   ],
                            // ),
                          ],
                        ),
                      ),
                      if (!Responsive.isDesktop(context))
                        Align(
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              RepaintBoundary(
                                key: qrImageKey,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10)),
                                    border: Border.all(
                                        color: Colors.grey, width: 1),
                                  ),
                                  padding: const EdgeInsets.all(4.0),
                                  child: Container(
                                    width: 150,
                                    height: 150,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10)),
                                      image: DecorationImage(
                                        image: NetworkImage(lineqr!),
                                        fit: BoxFit.fitHeight,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 150,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                          'LINE QR ADD',
                                          style: TextStyle(
                                              fontFamily: FontWeight_.Fonts_T,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        InkWell(
                                            onTap: () {
                                              Future.delayed(
                                                  const Duration(
                                                      milliseconds: 300),
                                                  () async {
                                                captureAndConvertToBase64(
                                                    qrImageKey, 'QR_LINE_');
                                              });
                                            },
                                            child: Icon(
                                              Icons.download,
                                              color: Colors.green,
                                            ))
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
                (renTal_ser == '114')
                    ? Padding(
                        padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: const BoxDecoration(
                            color: AppbackgroundColor.TiTile_Box,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10)),
                            // border: Border.all(color: Colors.grey, width: 1),
                          ),
                          padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Translate.TranslateAndSetText(
                                    'ตั้งค่าพื้นที่ - Nainaservice',
                                    SettingScreen_Color.Colors_Text2_,
                                    TextAlign.start,
                                    FontWeight.bold,
                                    FontWeight_.Fonts_T,
                                    14,
                                    1),
                                // Text(
                                // Text(
                                //   'ตั้งค่าพื้นที่ - Nainaservice',
                                //   style: const TextStyle(
                                //     fontFamily: FontWeight_.Fonts_T,
                                //     fontSize: 20.0,
                                //     fontWeight: FontWeight.bold,
                                //     color: Colors.black,
                                //     decoration: TextDecoration.underline,
                                //     // textBaseline:TextBaseline.alphabetic
                                //   ),
                                // ),
                              ),
                              CircleAvatar(
                                backgroundColor:
                                    AppBarColors.hexColor.withOpacity(0.9),
                                child: IconButton(
                                  onPressed: () async {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            WebView_NainaSetting(),
                                      ),
                                    );
                                  },
                                  icon: Icon(
                                    Icons.arrow_right_alt_outlined,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ))
                    : Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: const BoxDecoration(
                                color: AppbackgroundColor.TiTile_Box,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10)),
                                // border: Border.all(color: Colors.grey, width: 1),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: ScrollConfiguration(
                                  behavior: ScrollConfiguration.of(context)
                                      .copyWith(dragDevices: {
                                    PointerDeviceKind.touch,
                                    PointerDeviceKind.mouse,
                                  }),
                                  child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            for (int index = 0;
                                                index < zoneModels.length;
                                                index++)
                                              Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: InkWell(
                                                    onTap: () async {
                                                      setState(() {
                                                        Status_MenuZone =
                                                            index + 1;
                                                        name_Zone =
                                                            zoneModels[index]
                                                                .zn
                                                                .toString();
                                                        Form_Zone_text.text =
                                                            zoneModels[index]
                                                                .zn
                                                                .toString();

                                                        Ser_Zone = index;
                                                        ser_Zonex =
                                                            zoneModels[index]
                                                                .ser
                                                                .toString();
                                                        read_GC_area();
                                                        read_GC_rownum().then(
                                                            (value) =>
                                                                con_row());
                                                      });
                                                      print(
                                                          '$index >>>>Zone $ser_Zonex');
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color:
                                                            (Status_MenuZone ==
                                                                    index + 1)
                                                                ? Colors
                                                                    .brown[400]
                                                                : Colors
                                                                    .brown[200],
                                                        borderRadius: const BorderRadius
                                                                .only(
                                                            topLeft: Radius
                                                                .circular(10),
                                                            topRight:
                                                                Radius.circular(
                                                                    10),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    10),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    10)),
                                                        border:
                                                            (Status_MenuZone ==
                                                                    index + 1)
                                                                ? Border.all(
                                                                    color: Colors
                                                                        .white,
                                                                    width: 1)
                                                                : null,
                                                      ),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Center(
                                                        child: Text(
                                                          zoneModels[index]
                                                              .zn
                                                              .toString(),
                                                          style: TextStyle(
                                                              color:
                                                                  (Status_MenuZone ==
                                                                          index +
                                                                              1)
                                                                      ? Colors
                                                                          .white
                                                                      : Colors
                                                                          .black,
                                                              fontFamily:
                                                                  FontWeight_
                                                                      .Fonts_T),
                                                        ),
                                                      ),
                                                    ),
                                                  )),
                                            Ser_Zone == 0
                                                ? const SizedBox()
                                                : areaModels.length != 0
                                                    ? const SizedBox()
                                                    : Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: InkWell(
                                                          onTap: () async {
                                                            showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) =>
                                                                        StatefulBuilder(
                                                                          builder: (context, setState) =>
                                                                              AlertDialog(
                                                                            shape:
                                                                                RoundedRectangleBorder(
                                                                              borderRadius: BorderRadius.circular(20),
                                                                            ),
                                                                            title:
                                                                                Column(
                                                                              children: [
                                                                                Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                                  children: [
                                                                                    Container(
                                                                                      alignment: Alignment.center,
                                                                                      width: MediaQuery.of(context).size.width * 0.2,
                                                                                      child: Text(
                                                                                        '$name_Zone ??????',
                                                                                        style: TextStyle(
                                                                                          fontSize: 20.0,
                                                                                          fontWeight: FontWeight.bold,
                                                                                          color: Colors.black,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                                const SizedBox(
                                                                                  height: 10,
                                                                                ),
                                                                                Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                                  children: [
                                                                                    Container(
                                                                                      alignment: Alignment.center,
                                                                                      width: MediaQuery.of(context).size.width * 0.2,
                                                                                      child: Translate.TranslateAndSetText('ต้องการลบโซนพื้นที่ใช่หรือไม่ ??', SettingScreen_Color.Colors_Text2_, TextAlign.start, FontWeight.bold, Font_.Fonts_T, 14, 1),
                                                                                      // Text(
                                                                                      //   'ต้องการลบโซนพื้นที่ใช่หรือไม่ ??',
                                                                                      //   style: const TextStyle(
                                                                                      //     fontSize: 16.0,
                                                                                      //     fontWeight: FontWeight.bold,
                                                                                      //     color: Colors.red,
                                                                                      //   ),
                                                                                      // ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ],
                                                                            ), //AppBarColors2.Colors(),
                                                                            content:
                                                                                Column(
                                                                              mainAxisSize: MainAxisSize.min,
                                                                              children: [
                                                                                Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                                  children: [
                                                                                    Container(
                                                                                      width: 130,
                                                                                      height: 40,
                                                                                      // ignore: deprecated_member_use
                                                                                      child: ElevatedButton(
                                                                                        style: ElevatedButton.styleFrom(
                                                                                          backgroundColor: Colors.green,
                                                                                        ),
                                                                                        onPressed: () async {
                                                                                          SharedPreferences preferences = await SharedPreferences.getInstance();
                                                                                          String? ren = preferences.getString('renTalSer');
                                                                                          String? ser_user = preferences.getString('ser');

                                                                                          var zonename = ser_Zonex;

                                                                                          String url = '${MyConstant().domain}/DeC_Zone.php?isAdd=true&ren=$ren&ser_user=$ser_user&zonename=$zonename';
                                                                                          Insert_log.Insert_logs('ตั้งค่า', 'พื้นที่: ยันยันลบโซน $name_Zone <--> $zonename ( areaModels.length  : ${areaModels.length})');
                                                                                          try {
                                                                                            var response = await http.get(Uri.parse(url));

                                                                                            var result = json.decode(response.body);
                                                                                            print(result);
                                                                                            if (result.toString() == 'true') {
                                                                                              setState(() {
                                                                                                read_GC_zone();
                                                                                                read_GC_area();
                                                                                                read_GC_rownum().then((value) => con_row());
                                                                                                read_GC_area_count();
                                                                                                Ser_Zone = 0;
                                                                                                ser_Zonex = null;
                                                                                                name_Zone = 'ทั้งหมด';
                                                                                              });
                                                                                            }
                                                                                          } catch (e) {
                                                                                            print(e);
                                                                                          }
                                                                                        },
                                                                                        child: Translate.TranslateAndSetText('ยันยัน', Colors.white, TextAlign.start, null, Font_.Fonts_T, 14, 1),
                                                                                        // const Text(
                                                                                        //   'ยันยัน',
                                                                                        //   style: TextStyle(
                                                                                        //     // fontSize: 20.0,
                                                                                        //     // fontWeight: FontWeight.bold,
                                                                                        //     color: Colors.white,
                                                                                        //   ),
                                                                                        // ),
                                                                                        // color: Colors.orange[900],
                                                                                      ),
                                                                                    ),
                                                                                    Container(
                                                                                      width: 150,
                                                                                      height: 40,
                                                                                      // ignore: deprecated_member_use
                                                                                      child: ElevatedButton(
                                                                                        style: ElevatedButton.styleFrom(
                                                                                          backgroundColor: Colors.black,
                                                                                        ),
                                                                                        onPressed: () => Navigator.pop(context),
                                                                                        child: Translate.TranslateAndSetText('ยันยัน', Colors.white, TextAlign.start, null, Font_.Fonts_T, 14, 1),
                                                                                        // const Text(
                                                                                        //   'ยกเลิก',
                                                                                        //   style: TextStyle(
                                                                                        //     // fontSize: 20.0,
                                                                                        //     // fontWeight: FontWeight.bold,
                                                                                        //     color: Colors.white,
                                                                                        //   ),
                                                                                        // ),
                                                                                        // color: Colors.black,
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                )
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ));
                                                            // SharedPreferences preferences =
                                                            //     await SharedPreferences
                                                            //         .getInstance();
                                                            // String? ren = preferences
                                                            //     .getString('renTalSer');
                                                            // String? ser_user =
                                                            //     preferences.getString('ser');

                                                            // var zonename = ser_Zonex;

                                                            // String url =
                                                            //     '${MyConstant().domain}/DeC_Zone.php?isAdd=true&ren=$ren&ser_user=$ser_user&zonename=$zonename';

                                                            // try {
                                                            //   var response = await http
                                                            //       .get(Uri.parse(url));

                                                            //   var result =
                                                            //       json.decode(response.body);
                                                            //   print(result);
                                                            //   if (result.toString() == 'true') {
                                                            //       Insert_log.Insert_logs('ตั้งค่า',
                                                            //     'พื้นที่: ลบโซน$zonename ');
                                                            //     setState(() {
                                                            //       read_GC_zone();
                                                            //       read_GC_area();
                                                            //       read_GC_rownum().then(
                                                            //           (value) => con_row());
                                                            //       read_GC_area_count();
                                                            //       Ser_Zone = 0;
                                                            //       ser_Zonex = null;
                                                            //       name_Zone = 'ทั้งหมด';
                                                            //     });
                                                            //   }
                                                            // } catch (e) {
                                                            //   print(e);
                                                            // }
                                                          },
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Colors.red,
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
                                                              border: Border.all(
                                                                  color: Colors
                                                                      .black,
                                                                  width: 1),
                                                            ),
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Center(
                                                              child: Text(
                                                                'ลบ $name_Zone',
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontFamily:
                                                                        FontWeight_
                                                                            .Fonts_T),
                                                              ),
                                                            ),
                                                          ),
                                                        )),
                                          ])),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                              color: Colors.white60,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10)),
                            ),
                            width: MediaQuery.of(context).size.width,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: InkWell(
                                        onTap: () async {
                                          setState(() {
                                            if (row_num == 1) {
                                              row_num = 0;
                                            } else {
                                              row_num = 1;
                                            }
                                            read_GC_area();
                                            read_GC_rownum()
                                                .then((value) => con_row());
                                          });
                                        },
                                        child: Container(
                                          width: 150,
                                          decoration: BoxDecoration(
                                            color: Colors.blue,
                                            borderRadius: const BorderRadius
                                                    .only(
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(10),
                                                bottomLeft: Radius.circular(10),
                                                bottomRight:
                                                    Radius.circular(10)),
                                            // border: Border.all(color: Colors.black, width: 1),
                                          ),
                                          padding: const EdgeInsets.all(8.0),
                                          child: Center(
                                            child:
                                                Translate.TranslateAndSetText(
                                                    'จัดลำดับ',
                                                    Colors.white,
                                                    TextAlign.start,
                                                    FontWeight.bold,
                                                    FontWeight_.Fonts_T,
                                                    14,
                                                    1),
                                            // Text(
                                            //   'จัดลำดับ',
                                            //   style: const TextStyle(
                                            //       color: Colors.white,
                                            //       fontFamily:
                                            //           FontWeight_.Fonts_T),
                                            // ),
                                          ),
                                        ),
                                      )),
                                  Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: InkWell(
                                        onTap: () async {
                                          setState(() {
                                            if (row_num == 2) {
                                              row_num = 0;
                                            } else {
                                              row_num = 2;
                                            }
                                            read_GC_area();
                                            read_GC_rownum()
                                                .then((value) => con_row());
                                          });
                                        },
                                        child: Container(
                                          width: 150,
                                          decoration: BoxDecoration(
                                            color: Colors.purpleAccent.shade700,
                                            borderRadius: const BorderRadius
                                                    .only(
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(10),
                                                bottomLeft: Radius.circular(10),
                                                bottomRight:
                                                    Radius.circular(10)),
                                            // border: Border.all(color: Colors.black, width: 1),
                                          ),
                                          padding: const EdgeInsets.all(8.0),
                                          child: Center(
                                            child:
                                                Translate.TranslateAndSetText(
                                                    'จัดหมวดโซนใหญ่',
                                                    Colors.white,
                                                    TextAlign.start,
                                                    FontWeight.bold,
                                                    FontWeight_.Fonts_T,
                                                    14,
                                                    1),
                                            // Text(
                                            //   'จัดหมวดโซนใหญ่',
                                            //   style: const TextStyle(
                                            //       color: Colors.white,
                                            //       fontFamily:
                                            //           FontWeight_.Fonts_T),
                                            // ),
                                          ),
                                        ),
                                      )),
                                  row_num == 1
                                      ? SizedBox()
                                      : Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Translate.TranslateAndSetText(
                                              'โซน/ชั้น',
                                              SettingScreen_Color.Colors_Text2_,
                                              TextAlign.start,
                                              null,
                                              Font_.Fonts_T,
                                              14,
                                              1),
                                          //  Text('โซน/ชั้น',
                                          //     textAlign: TextAlign.center,
                                          //     maxLines: 2,
                                          //     overflow: TextOverflow.ellipsis,
                                          //     softWrap: false,
                                          //     style: TextStyle(
                                          //         fontSize: 15,
                                          //         color: SettingScreen_Color
                                          //             .Colors_Text2_,
                                          //         fontFamily: Font_.Fonts_T
                                          //         // fontWeight: FontWeight.bold,
                                          //         )),
                                        ),
                                  row_num == 1
                                      ? SizedBox()
                                      : Container(
                                          width: 100,
                                          decoration: (Form_Zone_text.text ==
                                                      'null' ||
                                                  Form_Zone_text == null ||
                                                  name_Zone.toString() ==
                                                      'ทั้งหมด')
                                              ? BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  5),
                                                          topRight:
                                                              Radius.circular(
                                                                  5),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  5),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  5)),
                                                  border: Border.all(
                                                      color: Colors.grey,
                                                      width: 1),
                                                )
                                              : null,
                                          padding:
                                              (Form_Zone_text.text == 'null' ||
                                                      Form_Zone_text == null ||
                                                      name_Zone.toString() ==
                                                          'ทั้งหมด')
                                                  ? const EdgeInsets.all(8.0)
                                                  : null,
                                          child: (Form_Zone_text.text ==
                                                      'null' ||
                                                  Form_Zone_text == null ||
                                                  name_Zone.toString() ==
                                                      'ทั้งหมด')
                                              ? Translate.TranslateAndSetText(
                                                  '${name_Zone}',
                                                  SettingScreen_Color
                                                      .Colors_Text2_,
                                                  TextAlign.start,
                                                  null,
                                                  Font_.Fonts_T,
                                                  14,
                                                  1)
                                              // Text('${name_Zone}',
                                              //     maxLines: 3,
                                              //     overflow:
                                              //         TextOverflow.ellipsis,
                                              //     softWrap: false,
                                              //     textAlign: TextAlign.center,
                                              //     style: const TextStyle(
                                              //         fontSize: 15,
                                              //         color: SettingScreen_Color
                                              //             .Colors_Text2_,
                                              //         fontFamily: Font_.Fonts_T
                                              //         // fontWeight: FontWeight.bold,
                                              //         ))
                                              : TextFormField(
                                                  keyboardType:
                                                      TextInputType.number,
                                                  controller: Form_Zone_text,
                                                  readOnly: (Form_Zone_text.text ==
                                                              'null' ||
                                                          Form_Zone_text ==
                                                              null ||
                                                          name_Zone
                                                                  .toString() ==
                                                              'ทั้งหมด')
                                                      ? true
                                                      : false,
                                                  // validator: (value) {
                                                  //   if (value == null || value.isEmpty) {
                                                  //     return 'ใส่ข้อมูลให้ครบถ้วน ';
                                                  //   }
                                                  //   // if (int.parse(value.toString()) < 13) {
                                                  //   //   return '< 13';
                                                  //   // }
                                                  //   return null;
                                                  // },
                                                  // maxLength: 13,
                                                  onFieldSubmitted:
                                                      (value) async {
                                                    SharedPreferences
                                                        preferences =
                                                        await SharedPreferences
                                                            .getInstance();
                                                    String? ren = preferences
                                                        .getString('renTalSer');
                                                    String? ser_user =
                                                        preferences
                                                            .getString('ser');

                                                    String url =
                                                        '${MyConstant().domain}/UpC_Zone_setting.php?isAdd=true&ren=$ren&zser=$ser_Zonex&value=$value&ser_user=$ser_user';

                                                    try {
                                                      var response = await http
                                                          .get(Uri.parse(url));

                                                      var result = json.decode(
                                                          response.body);
                                                      print(result);
                                                      if (result.toString() ==
                                                          'true') {
                                                        setState(() {
                                                          read_GC_rental();
                                                          checkPreferance();
                                                          read_GC_package();
                                                          read_GC_zone();
                                                          read_GC_area();
                                                          read_GC_area_count();
                                                        });
                                                      } else {}
                                                    } catch (e) {}
                                                  },
                                                  cursorColor: Colors.green,
                                                  decoration: InputDecoration(
                                                      fillColor: Colors.white
                                                          .withOpacity(0.3),
                                                      filled: true,
                                                      // prefixIcon:
                                                      //     const Icon(Icons.person_pin, color: Colors.black),
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
                                                          color: Colors.grey,
                                                        ),
                                                      ),
                                                      // labelText: '${Form_Zone_text.text}',
                                                      labelStyle: const TextStyle(
                                                          color:
                                                              SettingScreen_Color
                                                                  .Colors_Text2_,
                                                          fontFamily:
                                                              Font_.Fonts_T)),
                                                  inputFormatters: <TextInputFormatter>[
                                                    FilteringTextInputFormatter
                                                        .deny(RegExp("[' ']")),
                                                    // for below version 2 use this
                                                    // FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                                    // for version 2 and greater youcan also use this
                                                    // FilteringTextInputFormatter.digitsOnly
                                                  ],
                                                ),
                                        ),
                                  row_num == 1
                                      ? SizedBox()
                                      : Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Translate.TranslateAndSetText(
                                              'พื้นที่ทั้งหมด ',
                                              SettingScreen_Color.Colors_Text2_,
                                              TextAlign.start,
                                              null,
                                              Font_.Fonts_T,
                                              14,
                                              1)
                                          // Text('จำนวนพื้นที่ทั้งหมด ',
                                          //     maxLines: 3,
                                          //     overflow: TextOverflow.ellipsis,
                                          //     softWrap: false,
                                          //     style: TextStyle(
                                          //         fontSize: 15,
                                          //         color: SettingScreen_Color
                                          //             .Colors_Text2_,
                                          //         fontFamily: Font_.Fonts_T
                                          //         // fontWeight: FontWeight.bold,
                                          //         )),
                                          ),
                                  row_num == 1
                                      ? SizedBox()
                                      : Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                const BorderRadius.only(
                                                    topLeft: Radius.circular(5),
                                                    topRight:
                                                        Radius.circular(5),
                                                    bottomLeft:
                                                        Radius.circular(5),
                                                    bottomRight:
                                                        Radius.circular(5)),
                                            border: Border.all(
                                                color: Colors.grey, width: 1),
                                          ),
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text('${areaModels.length}',
                                              maxLines: 3,
                                              overflow: TextOverflow.ellipsis,
                                              softWrap: false,
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  color: SettingScreen_Color
                                                      .Colors_Text2_,
                                                  fontFamily: Font_.Fonts_T
                                                  // fontWeight: FontWeight.bold,
                                                  )),
                                        ),
                                  row_num == 1
                                      ? SizedBox()
                                      : Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Translate.TranslateAndSetText(
                                              'พื้นที่คงเหลือ',
                                              SettingScreen_Color.Colors_Text2_,
                                              TextAlign.start,
                                              null,
                                              Font_.Fonts_T,
                                              14,
                                              1),
                                          // Text('จำนวนพื้นที่คงเหลือ',
                                          //     maxLines: 3,
                                          //     overflow: TextOverflow.ellipsis,
                                          //     softWrap: false,
                                          //     style: TextStyle(
                                          //         fontSize: 15,
                                          //         color: SettingScreen_Color
                                          //             .Colors_Text2_,
                                          //         fontFamily: Font_.Fonts_T
                                          //         // fontWeight: FontWeight.bold,
                                          //         )),
                                        ),
                                  row_num == 1
                                      ? SizedBox()
                                      : Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                const BorderRadius.only(
                                                    topLeft: Radius.circular(5),
                                                    topRight:
                                                        Radius.circular(5),
                                                    bottomLeft:
                                                        Radius.circular(5),
                                                    bottomRight:
                                                        Radius.circular(5)),
                                            border: Border.all(
                                                color: Colors.grey, width: 1),
                                          ),
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text('${pkqty! - countarae!}',
                                              maxLines: 3,
                                              overflow: TextOverflow.ellipsis,
                                              softWrap: false,
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  color: SettingScreen_Color
                                                      .Colors_Text2_,
                                                  fontFamily: Font_.Fonts_T
                                                  // fontWeight: FontWeight.bold,
                                                  )),
                                        ),
                                  row_num == 1
                                      ? SizedBox()
                                      : SizedBox(
                                          width: 10,
                                        ),
                                  row_num == 1
                                      ? SizedBox()
                                      : pkqty! - countarae! > 0
                                          ? Ser_Zone == 0
                                              ? const SizedBox()
                                              : Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: InkWell(
                                                    onTap: () async {
                                                      // List<AreaModel> areaModels_Check =
                                                      //     [];
                                                      // print('1111');
                                                      showDialog<String>(
                                                        barrierDismissible:
                                                            false,
                                                        context: context,
                                                        builder: (BuildContext
                                                                context) =>
                                                            Form(
                                                          key: _formKey,
                                                          child: AlertDialog(
                                                            shape: const RoundedRectangleBorder(
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            20.0))),
                                                            title: Center(
                                                                child: Text(
                                                              '$name_Zone',
                                                              style: TextStyle(
                                                                color: SettingScreen_Color
                                                                    .Colors_Text1_,
                                                                fontFamily:
                                                                    FontWeight_
                                                                        .Fonts_T,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            )),
                                                            content: Container(
                                                              // height: MediaQuery.of(context).size.height / 1.5,
                                                              width: (!Responsive
                                                                      .isDesktop(
                                                                          context))
                                                                  ? MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width
                                                                  : MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.5,
                                                              decoration:
                                                                  const BoxDecoration(
                                                                // color: Colors.grey[300],
                                                                borderRadius: BorderRadius.only(
                                                                    topLeft: Radius
                                                                        .circular(
                                                                            10),
                                                                    topRight: Radius
                                                                        .circular(
                                                                            10),
                                                                    bottomLeft:
                                                                        Radius.circular(
                                                                            10),
                                                                    bottomRight:
                                                                        Radius.circular(
                                                                            10)),
                                                                // border: Border.all(color: Colors.white, width: 1),
                                                              ),
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child:
                                                                  SingleChildScrollView(
                                                                child: Column(
                                                                  // mainAxisAlignment: MainAxisAlignment.center,areaModels
                                                                  children: [
                                                                    StreamBuilder(
                                                                        stream: Stream.periodic(const Duration(
                                                                            seconds:
                                                                                0)),
                                                                        builder:
                                                                            (context,
                                                                                snapshot) {
                                                                          return (area_ser_text.text == '')
                                                                              ? SizedBox()
                                                                              : Column(
                                                                                  children: [
                                                                                    Row(
                                                                                      children: [
                                                                                        Translate.TranslateAndSetText('# รหัสพื้นที่ใกล้เครียง : ', SettingScreen_Color.Colors_Text2_, TextAlign.start, null, Font_.Fonts_T, 14, 1),
                                                                                        // Text(
                                                                                        //   '# รหัสพื้นที่ใกล้เครียง : ',
                                                                                        //   textAlign: TextAlign.left,
                                                                                        //   style: TextStyle(
                                                                                        //     color: SettingScreen_Color.Colors_Text1_,
                                                                                        //     fontFamily: FontWeight_.Fonts_T,
                                                                                        //     fontWeight: FontWeight.bold,
                                                                                        //   ),
                                                                                        // ),
                                                                                        Expanded(
                                                                                            flex: 1,
                                                                                            child: ScrollConfiguration(
                                                                                              behavior: ScrollConfiguration.of(context).copyWith(dragDevices: {
                                                                                                PointerDeviceKind.touch,
                                                                                                PointerDeviceKind.mouse,
                                                                                              }),
                                                                                              child: SingleChildScrollView(
                                                                                                scrollDirection: Axis.horizontal,
                                                                                                child: Row(
                                                                                                  children: [
                                                                                                    Text(
                                                                                                      '${_areaModels.where((areaModelss) {
                                                                                                            var notTitle = areaModelss.ln.toString().trim().toLowerCase();
                                                                                                            var notTitle2 = areaModelss.ln.toString().trim();

                                                                                                            return notTitle.contains(area_ser_text.text.toString().trim()) || notTitle2.contains(area_ser_text.text.toString().trim());
                                                                                                          }).map((model) => model.ln).join(', ')}',
                                                                                                      textAlign: TextAlign.left,
                                                                                                      style: TextStyle(
                                                                                                        color: Colors.red,
                                                                                                        fontFamily: Font_.Fonts_T,
                                                                                                        // fontWeight: FontWeight.bold,
                                                                                                      ),
                                                                                                    ),
                                                                                                  ],
                                                                                                ),
                                                                                              ),
                                                                                            )),
                                                                                      ],
                                                                                    ),
                                                                                    Divider(
                                                                                      color: Colors.grey[300],
                                                                                      height: 4.0,
                                                                                    ),
                                                                                  ],
                                                                                );
                                                                        }),
                                                                    StreamBuilder(
                                                                        stream: Stream.periodic(const Duration(
                                                                            seconds:
                                                                                0)),
                                                                        builder:
                                                                            (context,
                                                                                snapshot) {
                                                                          return (area_name_text.text == '')
                                                                              ? SizedBox()
                                                                              : Column(
                                                                                  children: [
                                                                                    Row(
                                                                                      children: [
                                                                                        Translate.TranslateAndSetText('# ชื่อพื้นที่ใกล้เครียง : ', SettingScreen_Color.Colors_Text2_, TextAlign.start, null, Font_.Fonts_T, 14, 1),
                                                                                        // Text(
                                                                                        //   '# ชื่อพื้นที่ใกล้เครียง : ',
                                                                                        //   textAlign: TextAlign.left,
                                                                                        //   style: TextStyle(
                                                                                        //     color: SettingScreen_Color.Colors_Text1_,
                                                                                        //     fontFamily: FontWeight_.Fonts_T,
                                                                                        //     fontWeight: FontWeight.bold,
                                                                                        //   ),
                                                                                        // ),
                                                                                        Expanded(
                                                                                            flex: 1,
                                                                                            child: ScrollConfiguration(
                                                                                              behavior: ScrollConfiguration.of(context).copyWith(dragDevices: {
                                                                                                PointerDeviceKind.touch,
                                                                                                PointerDeviceKind.mouse,
                                                                                              }),
                                                                                              child: SingleChildScrollView(
                                                                                                scrollDirection: Axis.horizontal,
                                                                                                child: Row(
                                                                                                  children: [
                                                                                                    Text(
                                                                                                      '${_areaModels.where((areaModelss) {
                                                                                                            var notTitle = areaModelss.lncode.toString().trim().toLowerCase();
                                                                                                            var notTitle2 = areaModelss.lncode.toString().trim();

                                                                                                            return notTitle.contains(area_name_text.text.toString().trim()) || notTitle2.contains(area_name_text.text.toString().trim());
                                                                                                          }).map((model) => model.lncode).join(', ')}',
                                                                                                      textAlign: TextAlign.left,
                                                                                                      style: TextStyle(
                                                                                                        color: Colors.red,
                                                                                                        fontFamily: Font_.Fonts_T,
                                                                                                        // fontWeight: FontWeight.bold,
                                                                                                      ),
                                                                                                    ),
                                                                                                  ],
                                                                                                ),
                                                                                              ),
                                                                                            )),
                                                                                      ],
                                                                                    ),
                                                                                    Divider(
                                                                                      color: Colors.grey[300],
                                                                                      height: 4.0,
                                                                                    ),
                                                                                  ],
                                                                                );
                                                                        }),
                                                                    Row(
                                                                      children: [
                                                                        Expanded(
                                                                            flex:
                                                                                6,
                                                                            child:
                                                                                Column(
                                                                              children: [
                                                                                Padding(
                                                                                  padding: EdgeInsets.all(8.0),
                                                                                  child: Row(
                                                                                    children: [
                                                                                      Translate.TranslateAndSetText('รหัสพื้นที่', SettingScreen_Color.Colors_Text2_, TextAlign.start, null, Font_.Fonts_T, 14, 1),
                                                                                      // Text(
                                                                                      //   'รหัสพื้นที่',
                                                                                      //   textAlign: TextAlign.left,
                                                                                      //   style: TextStyle(
                                                                                      //     color: SettingScreen_Color.Colors_Text1_,
                                                                                      //     fontFamily: FontWeight_.Fonts_T,
                                                                                      //     fontWeight: FontWeight.bold,
                                                                                      //   ),
                                                                                      // ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                                Padding(
                                                                                  padding: const EdgeInsets.all(8.0),
                                                                                  child: SizedBox(
                                                                                    // width: 200, areaModels
                                                                                    child: TextFormField(
                                                                                      controller: area_ser_text,
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
                                                                                          labelText: 'รหัสพื้นที่',
                                                                                          labelStyle: const TextStyle(
                                                                                            fontSize: 14,
                                                                                            color: Colors.black54,
                                                                                            fontFamily: FontWeight_.Fonts_T,
                                                                                          )),
                                                                                      inputFormatters: <TextInputFormatter>[
                                                                                        FilteringTextInputFormatter.deny(RegExp("[' ']")),
                                                                                        // for below version 2 use this
                                                                                        // FilteringTextInputFormatter
                                                                                        //     .allow(RegExp(
                                                                                        //         r'[a-z A-Z 1-9]')),
                                                                                        // for version 2 and greater youcan also use this
                                                                                        // FilteringTextInputFormatter
                                                                                        //     .digitsOnly
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            )),
                                                                        Expanded(
                                                                            flex:
                                                                                6,
                                                                            child:
                                                                                Column(
                                                                              children: [
                                                                                Padding(
                                                                                  padding: EdgeInsets.all(8.0),
                                                                                  child: Row(
                                                                                    children: [
                                                                                      Translate.TranslateAndSetText('ชื่อพื้นที่', SettingScreen_Color.Colors_Text2_, TextAlign.start, null, Font_.Fonts_T, 14, 1),
                                                                                      // Text(
                                                                                      //   'ชื่อพื้นที่',
                                                                                      //   textAlign: TextAlign.start,
                                                                                      //   style: TextStyle(
                                                                                      //     color: SettingScreen_Color.Colors_Text1_,
                                                                                      //     fontFamily: FontWeight_.Fonts_T,
                                                                                      //     fontWeight: FontWeight.bold,
                                                                                      //   ),
                                                                                      // ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                                Padding(
                                                                                  padding: const EdgeInsets.all(8.0),
                                                                                  child: SizedBox(
                                                                                    // width: 200,
                                                                                    child: TextFormField(
                                                                                      controller: area_name_text,
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
                                                                                          labelText: 'ชื่อพื้นที่',
                                                                                          labelStyle: const TextStyle(
                                                                                            fontSize: 14,
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
                                                                            )),
                                                                      ],
                                                                    ),
                                                                    Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .topLeft,
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            EdgeInsets.all(8.0),
                                                                        child:
                                                                            Row(
                                                                          children: [
                                                                            Translate.TranslateAndSetText(
                                                                                'ขนาดพื้นที่-ค่าบริการหลัก',
                                                                                SettingScreen_Color.Colors_Text2_,
                                                                                TextAlign.start,
                                                                                null,
                                                                                Font_.Fonts_T,
                                                                                14,
                                                                                1),
                                                                            // Text(
                                                                            //   'ขนาดพื้นที่-ค่าบริการหลัก',
                                                                            //   textAlign: TextAlign.left,
                                                                            //   style: TextStyle(
                                                                            //     color: SettingScreen_Color.Colors_Text1_,
                                                                            //     fontFamily: FontWeight_.Fonts_T,
                                                                            //     fontWeight: FontWeight.bold,
                                                                            //   ),
                                                                            // ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Row(
                                                                      children: [
                                                                        Expanded(
                                                                            flex:
                                                                                6,
                                                                            child:
                                                                                Column(
                                                                              children: [
                                                                                Padding(
                                                                                  padding: const EdgeInsets.all(8.0),
                                                                                  child: SizedBox(
                                                                                    // width: 200,
                                                                                    child: TextFormField(
                                                                                      controller: area_qty_text,
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
                                                                                          labelText: 'ขนาดพื้นที่(ต.ร.ม.)',
                                                                                          labelStyle: const TextStyle(
                                                                                            fontSize: 14,
                                                                                            color: Colors.black54,
                                                                                            fontFamily: FontWeight_.Fonts_T,
                                                                                          )),
                                                                                      inputFormatters: <TextInputFormatter>[
                                                                                        FilteringTextInputFormatter.deny(RegExp("[' ']")),
                                                                                        // for below version 2 use this
                                                                                        FilteringTextInputFormatter.allow(RegExp(r'[0-9 .]')),
                                                                                        // for version 2 and greater youcan also use this
                                                                                        // FilteringTextInputFormatter
                                                                                        //     .digitsOnly
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            )),
                                                                        Expanded(
                                                                            flex:
                                                                                6,
                                                                            child:
                                                                                Column(
                                                                              children: [
                                                                                Padding(
                                                                                  padding: const EdgeInsets.all(8.0),
                                                                                  child: SizedBox(
                                                                                    // width: 200,
                                                                                    child: TextFormField(
                                                                                      controller: area_pri_text,
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
                                                                                          labelText: 'ค่าบริการหลัก(ต่องวด)',
                                                                                          labelStyle: const TextStyle(
                                                                                            fontSize: 14,
                                                                                            color: Colors.black54,
                                                                                            fontFamily: FontWeight_.Fonts_T,
                                                                                          )),
                                                                                      inputFormatters: <TextInputFormatter>[
                                                                                        FilteringTextInputFormatter.deny(RegExp("[' ']")),
                                                                                        // for below version 2 use this
                                                                                        FilteringTextInputFormatter.allow(RegExp(r'[0-9 .]')),
                                                                                        // for version 2 and greater youcan also use this
                                                                                        // FilteringTextInputFormatter
                                                                                        //     .digitsOnly
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            )),
                                                                      ],
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
                                                                    color: Colors
                                                                        .grey,
                                                                    height: 4.0,
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 5.0,
                                                                  ),
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            8.0),
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(8.0),
                                                                          child: StreamBuilder(
                                                                              stream: Stream.periodic(const Duration(seconds: 0)),
                                                                              builder: (context, snapshot) {
                                                                                return Container(
                                                                                  width: 100,
                                                                                  decoration: BoxDecoration(
                                                                                    color: (areaModels.any((areaModelss) {
                                                                                                  return areaModelss.ln.toString().trim() == '${area_ser_text.text}';
                                                                                                }) ==
                                                                                                true ||
                                                                                            areaModels.any((areaModelss) {
                                                                                                  return areaModelss.lncode.toString().trim() == '${area_name_text.text}';
                                                                                                }) ==
                                                                                                true)
                                                                                        ? Colors.grey
                                                                                        : Colors.green,
                                                                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                                                                                  ),
                                                                                  padding: const EdgeInsets.all(8.0),
                                                                                  child: TextButton(
                                                                                    onPressed: (areaModels.any((areaModelss) {
                                                                                                  return areaModelss.ln.toString().trim() == '${area_ser_text.text}';
                                                                                                }) ==
                                                                                                true ||
                                                                                            areaModels.any((areaModelss) {
                                                                                                  return areaModelss.lncode.toString().trim() == '${area_name_text.text}';
                                                                                                }) ==
                                                                                                true)
                                                                                        ? null
                                                                                        : () async {
                                                                                            if (_formKey.currentState!.validate()) {
                                                                                              SharedPreferences preferences = await SharedPreferences.getInstance();
                                                                                              String? ren = preferences.getString('renTalSer');
                                                                                              String? ser_user = preferences.getString('ser');

                                                                                              var zonename = ser_Zonex;
                                                                                              var area_ser = area_ser_text.text;
                                                                                              var area_name = area_name_text.text;
                                                                                              var area_qty = area_qty_text.text;
                                                                                              var area_pri = area_pri_text.text;

                                                                                              String url = '${MyConstant().domain}/InC_area_setring.php?isAdd=true&ren=$ren&ser_user=$ser_user&zonename=$zonename&area_ser=$area_ser&area_name=$area_name&area_qty=$area_qty&area_pri=$area_pri';

                                                                                              try {
                                                                                                var response = await http.get(Uri.parse(url));

                                                                                                var result = json.decode(response.body);
                                                                                                print(result);
                                                                                                if (result.toString() == 'true') {
                                                                                                  setState(() {
                                                                                                    read_GC_zone();
                                                                                                    read_GC_area();
                                                                                                    read_GC_area_count();
                                                                                                    area_ser_text.clear();
                                                                                                    area_name_text.clear();
                                                                                                    area_qty_text.clear();
                                                                                                    area_pri_text.clear();
                                                                                                  });
                                                                                                  Navigator.pop(context, 'OK');
                                                                                                }
                                                                                              } catch (e) {
                                                                                                print(e);
                                                                                              }
                                                                                            }
                                                                                          },
                                                                                    child: Translate.TranslateAndSetText('บันทึก', Colors.white, TextAlign.start, null, Font_.Fonts_T, 14, 1),
                                                                                    // const Text(
                                                                                    //   'บันทึก',
                                                                                    //   style: TextStyle(
                                                                                    //     color: Colors.white,
                                                                                    //     fontFamily: FontWeight_.Fonts_T,
                                                                                    //     fontWeight: FontWeight.bold,
                                                                                    //   ),
                                                                                    // ),
                                                                                  ),
                                                                                );
                                                                              }),
                                                                        ),
                                                                        Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(8.0),
                                                                          child:
                                                                              Container(
                                                                            width:
                                                                                100,
                                                                            decoration:
                                                                                const BoxDecoration(
                                                                              color: Colors.black,
                                                                              borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                                                                            ),
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
                                                                            child:
                                                                                TextButton(
                                                                              onPressed: () {
                                                                                setState(() {
                                                                                  area_ser_text.clear();
                                                                                  area_name_text.clear();
                                                                                  area_qty_text.clear();
                                                                                  area_pri_text.clear();
                                                                                });
                                                                                Navigator.pop(context, 'OK');
                                                                              },
                                                                              child: Translate.TranslateAndSetText('ยกเลิก', Colors.white, TextAlign.start, null, Font_.Fonts_T, 14, 1),
                                                                              //  const Text(
                                                                              //   'ยกเลิก',
                                                                              //   style: TextStyle(
                                                                              //     color: Colors.white,
                                                                              //     fontFamily: FontWeight_.Fonts_T,
                                                                              //     fontWeight: FontWeight.bold,
                                                                              //   ),
                                                                              // ),
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
                                                    },
                                                    child: Container(
                                                      width: 50,
                                                      decoration: BoxDecoration(
                                                          color: Colors
                                                              .green.shade700,
                                                          borderRadius: const BorderRadius.only(
                                                              topLeft: Radius
                                                                  .circular(10),
                                                              topRight: Radius
                                                                  .circular(10),
                                                              bottomLeft: Radius
                                                                  .circular(10),
                                                              bottomRight:
                                                                  Radius.circular(
                                                                      10)),
                                                          border: Border.all(
                                                              color:
                                                                  Colors.white,
                                                              width: 1)),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Center(
                                                        child: Translate
                                                            .TranslateAndSetText(
                                                                'เพิ่ม',
                                                                Colors.white,
                                                                TextAlign.start,
                                                                null,
                                                                Font_.Fonts_T,
                                                                14,
                                                                1),
                                                        // Text(
                                                        //   'เพิ่ม',
                                                        //   style: TextStyle(
                                                        //       color:
                                                        //           Colors.white,
                                                        //       fontFamily:
                                                        //           FontWeight_
                                                        //               .Fonts_T),
                                                        // ),
                                                      ),
                                                    ),
                                                  ))
                                          : const SizedBox(),
                                  row_num == 1
                                      ? SizedBox()
                                      : pkqty! - countarae! > 0
                                          ? (renTal_user! ==
                                                  '106') // (Ser_Zone == 0 || areaModels.length != 0)
                                              ? const SizedBox()
                                              : InkWell(
                                                  child: Container(
                                                    width: 130,
                                                    decoration: BoxDecoration(
                                                        color: Colors
                                                            .orange.shade700,
                                                        borderRadius: const BorderRadius
                                                                .only(
                                                            topLeft: Radius
                                                                .circular(10),
                                                            topRight:
                                                                Radius.circular(
                                                                    10),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    10),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    10)),
                                                        border: Border.all(
                                                            color: Colors.white,
                                                            width: 1)),
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Center(
                                                      child: Translate
                                                          .TranslateAndSetText(
                                                              'เพิ่มแบบAuto',
                                                              Colors.white,
                                                              TextAlign.start,
                                                              null,
                                                              Font_.Fonts_T,
                                                              14,
                                                              1),
                                                      //  Text(
                                                      //   'เพิ่มแบบAuto',
                                                      //   style: TextStyle(
                                                      //       color: Colors.white,
                                                      //       fontFamily:
                                                      //           FontWeight_
                                                      //               .Fonts_T),
                                                      // ),
                                                    ),
                                                  ),
                                                  onTap: () {
                                                    setState(() {
                                                      Add_Number_area_.text =
                                                          '1';
                                                      Add_name_area_.text = '1';
                                                    });

                                                    showDialog<String>(
                                                      barrierDismissible: false,
                                                      context: context,
                                                      builder: (BuildContext
                                                              context) =>
                                                          Form(
                                                        key: _formKey2,
                                                        child: AlertDialog(
                                                          shape: const RoundedRectangleBorder(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          20.0))),
                                                          title: Center(
                                                              child: Text(
                                                            '$name_Zone',
                                                            style: TextStyle(
                                                              color: SettingScreen_Color
                                                                  .Colors_Text1_,
                                                              fontFamily:
                                                                  FontWeight_
                                                                      .Fonts_T,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          )),
                                                          content: Container(
                                                            // height: MediaQuery.of(context).size.height / 1.5,
                                                            width: (!Responsive
                                                                    .isDesktop(
                                                                        context))
                                                                ? MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width
                                                                : MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.5,
                                                            decoration:
                                                                const BoxDecoration(
                                                              // color: Colors.grey[300],
                                                              borderRadius: BorderRadius.only(
                                                                  topLeft: Radius
                                                                      .circular(
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
                                                              // border: Border.all(color: Colors.white, width: 1),
                                                            ),
                                                            child:
                                                                SingleChildScrollView(
                                                              child: Column(
                                                                // mainAxisAlignment: MainAxisAlignment.center,
                                                                children: [
                                                                  Row(
                                                                    children: [
                                                                      Padding(
                                                                        padding:
                                                                            EdgeInsets.all(8.0),
                                                                        child: Translate.TranslateAndSetText(
                                                                            'จำนวนที่ต้องการเพิ่ม',
                                                                            SettingScreen_Color.Colors_Text1_,
                                                                            TextAlign.start,
                                                                            FontWeight.bold,
                                                                            FontWeight_.Fonts_T,
                                                                            14,
                                                                            1),
                                                                        //     Text(
                                                                        //   'จำนวนที่ต้องการเพิ่ม',
                                                                        //   textAlign:
                                                                        //       TextAlign.left,
                                                                        //   style:
                                                                        //       TextStyle(
                                                                        //     color:
                                                                        //         SettingScreen_Color.Colors_Text1_,
                                                                        //     fontFamily:
                                                                        //         FontWeight_.Fonts_T,
                                                                        //     fontWeight:
                                                                        //         FontWeight.bold,
                                                                        //   ),
                                                                        // ),
                                                                      ),
                                                                      Expanded(
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(8.0),
                                                                          child:
                                                                              SizedBox(
                                                                            // width: 200,
                                                                            child:
                                                                                TextFormField(
                                                                              keyboardType: TextInputType.number,
                                                                              controller: Add_totalnew_area_text,
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
                                                                                  labelText: 'จำนวน',
                                                                                  labelStyle: const TextStyle(
                                                                                    fontSize: 12,
                                                                                    color: Colors.black54,
                                                                                    fontFamily: FontWeight_.Fonts_T,
                                                                                  )),
                                                                              inputFormatters: [
                                                                                FilteringTextInputFormatter.deny(RegExp(r'\s')),
                                                                                FilteringTextInputFormatter.deny(RegExp(r'^0')),
                                                                                FilteringTextInputFormatter.allow(RegExp(r'[0-9 .]')),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .topLeft,
                                                                    child:
                                                                        Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              8.0),
                                                                      child:
                                                                          Text(
                                                                        (areaModels.length ==
                                                                                0)
                                                                            ? 'รหัสพื้นที่ '
                                                                            : 'รหัสพื้นที่ (รหัสล่าสุดคือ : ${areaModels[areaModels.length - 1].ln})',
                                                                        textAlign:
                                                                            TextAlign.left,
                                                                        style:
                                                                            const TextStyle(
                                                                          color:
                                                                              SettingScreen_Color.Colors_Text1_,
                                                                          fontFamily:
                                                                              FontWeight_.Fonts_T,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .topLeft,
                                                                    child:
                                                                        Padding(
                                                                      padding: EdgeInsets
                                                                          .fromLTRB(
                                                                              10,
                                                                              4,
                                                                              4,
                                                                              4),
                                                                      child: Translate.TranslateAndSetText(
                                                                          '**เหตุ : หากต้องการเพิ่มรหัสพื้นที่ คือ A1 ให้ใส่ที่ช่องตัวอักษร เท่ากับ A และให้ใส่ที่ช่องตัวเลข เท่ากับ 1',
                                                                          Colors
                                                                              .red,
                                                                          TextAlign
                                                                              .start,
                                                                          null,
                                                                          Font_
                                                                              .Fonts_T,
                                                                          12,
                                                                          1),
                                                                      //     Text(
                                                                      //   '**เหตุ : หากต้องการเพิ่มรหัสพื้นที่ คือ A1 ให้ใส่ที่ช่องตัวอักษร เท่ากับ A และให้ใส่ที่ช่องตัวเลข เท่ากับ 1',
                                                                      //   textAlign:
                                                                      //       TextAlign.left,
                                                                      //   style: TextStyle(
                                                                      //       color:
                                                                      //           Colors.red,
                                                                      //       fontFamily: FontWeight_.Fonts_T,
                                                                      //       fontSize: 12),
                                                                      // ),
                                                                    ),
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      Expanded(
                                                                          flex:
                                                                              6,
                                                                          child:
                                                                              Column(
                                                                            children: [
                                                                              Padding(
                                                                                padding: const EdgeInsets.all(8.0),
                                                                                child: SizedBox(
                                                                                  // width: 200,
                                                                                  child: TextFormField(
                                                                                    controller: Add_Number_area_text,
                                                                                    // validator:
                                                                                    //     (value) {
                                                                                    //   if (value ==
                                                                                    //           null ||
                                                                                    //       value
                                                                                    //           .isEmpty) {
                                                                                    //     return 'ใส่ข้อมูลให้ครบถ้วน ';
                                                                                    //   }

                                                                                    //   return null;
                                                                                    // },
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
                                                                                        labelText: 'ตัวอักษร',
                                                                                        labelStyle: const TextStyle(
                                                                                          fontSize: 12,
                                                                                          color: Colors.black54,
                                                                                          fontFamily: FontWeight_.Fonts_T,
                                                                                        )),
                                                                                    inputFormatters: [
                                                                                      FilteringTextInputFormatter.deny(RegExp(r'\s')),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          )),
                                                                      Expanded(
                                                                          flex:
                                                                              6,
                                                                          child:
                                                                              Column(
                                                                            children: [
                                                                              Padding(
                                                                                padding: const EdgeInsets.all(8.0),
                                                                                child: SizedBox(
                                                                                  // width: 200,
                                                                                  child: TextFormField(
                                                                                    controller: Add_Number_area_,
                                                                                    validator: (value) {
                                                                                      if (value == null || value.isEmpty) {
                                                                                        return 'ใส่ข้อมูลให้ครบถ้วน ';
                                                                                      }
                                                                                      // if (int.parse(value.toString()) < 13) {
                                                                                      //   return '< 13';
                                                                                      // }
                                                                                      return null;
                                                                                    },
                                                                                    // maxLength: 4,
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
                                                                                        labelText: 'เลขเรื่มต้น 1-xxx',
                                                                                        labelStyle: const TextStyle(
                                                                                          fontSize: 12,
                                                                                          color: Colors.black54,
                                                                                          fontFamily: FontWeight_.Fonts_T,
                                                                                        )),
                                                                                    inputFormatters: [
                                                                                      FilteringTextInputFormatter.deny(RegExp(r'\s')),
                                                                                      FilteringTextInputFormatter.deny(RegExp(r'^0')),
                                                                                      FilteringTextInputFormatter.allow(RegExp(r'[0-9 .]')),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          )),
                                                                    ],
                                                                  ),
                                                                  Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .topLeft,
                                                                    child:
                                                                        Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              8.0),
                                                                      child:
                                                                          Text(
                                                                        (areaModels.length ==
                                                                                0)
                                                                            ? 'ชื่อพื้นที่เช่า '
                                                                            : 'ชื่อพื้นที่เช่า(ชื่อล่าสุดคือ : ${areaModels[areaModels.length - 1].lncode})',
                                                                        textAlign:
                                                                            TextAlign.left,
                                                                        style:
                                                                            const TextStyle(
                                                                          color:
                                                                              SettingScreen_Color.Colors_Text1_,
                                                                          fontFamily:
                                                                              FontWeight_.Fonts_T,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .topLeft,
                                                                    child:
                                                                        Padding(
                                                                      padding: EdgeInsets
                                                                          .fromLTRB(
                                                                              10,
                                                                              4,
                                                                              4,
                                                                              4),
                                                                      child: Translate.TranslateAndSetText(
                                                                          '**เหตุ : หากต้องการเพิ่มชื่อพื้นที่ คือ A1 ให้ใส่ที่ช่องตัวอักษร เท่ากับ A และให้ใส่ที่ช่องตัวเลข เท่ากับ 1',
                                                                          Colors
                                                                              .red,
                                                                          TextAlign
                                                                              .start,
                                                                          null,
                                                                          Font_
                                                                              .Fonts_T,
                                                                          12,
                                                                          1),
                                                                      //     Text(
                                                                      //   '**เหตุ : หากต้องการเพิ่มชื่อพื้นที่ คือ A1 ให้ใส่ที่ช่องตัวอักษร เท่ากับ A และให้ใส่ที่ช่องตัวเลข เท่ากับ 1',
                                                                      //   textAlign:
                                                                      //       TextAlign.left,
                                                                      //   style: TextStyle(
                                                                      //       color:
                                                                      //           Colors.red,
                                                                      //       fontFamily: FontWeight_.Fonts_T,
                                                                      //       fontSize: 12),
                                                                      // ),
                                                                    ),
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      Expanded(
                                                                          flex:
                                                                              6,
                                                                          child:
                                                                              Column(
                                                                            children: [
                                                                              Padding(
                                                                                padding: const EdgeInsets.all(8.0),
                                                                                child: SizedBox(
                                                                                  // width: 200,
                                                                                  child: TextFormField(
                                                                                    controller: Add_name_area_text,
                                                                                    // validator:
                                                                                    //     (value) {
                                                                                    //   if (value ==
                                                                                    //           null ||
                                                                                    //       value
                                                                                    //           .isEmpty) {
                                                                                    //     return 'ใส่ข้อมูลให้ครบถ้วน ';
                                                                                    //   }
                                                                                    //   // if (int.parse(value.toString()) < 13) {
                                                                                    //   //   return '< 13';
                                                                                    //   // }
                                                                                    //   return null;
                                                                                    // },
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
                                                                                        labelText: 'ตัวอักษร',
                                                                                        labelStyle: const TextStyle(
                                                                                          fontSize: 12,
                                                                                          color: Colors.black54,
                                                                                          fontFamily: FontWeight_.Fonts_T,
                                                                                        )),
                                                                                    inputFormatters: [
                                                                                      FilteringTextInputFormatter.deny(RegExp(r'\s')),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          )),
                                                                      Expanded(
                                                                          flex:
                                                                              6,
                                                                          child:
                                                                              Column(
                                                                            children: [
                                                                              Padding(
                                                                                padding: const EdgeInsets.all(8.0),
                                                                                child: SizedBox(
                                                                                  // width: 200,
                                                                                  child: TextFormField(
                                                                                    controller: Add_name_area_,
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
                                                                                        labelText: 'เลขเรื่มต้น 1-xxx',
                                                                                        labelStyle: const TextStyle(
                                                                                          fontSize: 12,
                                                                                          color: Colors.black54,
                                                                                          fontFamily: FontWeight_.Fonts_T,
                                                                                        )),
                                                                                    inputFormatters: [
                                                                                      FilteringTextInputFormatter.deny(RegExp(r'\s')),
                                                                                      FilteringTextInputFormatter.deny(RegExp(r'^0')),
                                                                                      FilteringTextInputFormatter.allow(RegExp(r'[0-9 .]')),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          )),
                                                                    ],
                                                                  ),
                                                                  Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .topLeft,
                                                                    child:
                                                                        Padding(
                                                                      padding: EdgeInsets
                                                                          .fromLTRB(
                                                                              10,
                                                                              4,
                                                                              4,
                                                                              4),
                                                                      child: Translate.TranslateAndSetText(
                                                                          'ขนาดพื้นที่ - ค่าบริการหลัก',
                                                                          SettingScreen_Color
                                                                              .Colors_Text1_,
                                                                          TextAlign
                                                                              .start,
                                                                          FontWeight
                                                                              .bold,
                                                                          FontWeight_
                                                                              .Fonts_T,
                                                                          14,
                                                                          1),
                                                                      //     Text(
                                                                      //   'ขนาดพื้นที่ - ค่าบริการหลัก',
                                                                      //   textAlign:
                                                                      //       TextAlign.left,
                                                                      //   style:
                                                                      //       TextStyle(
                                                                      //     color:
                                                                      //         SettingScreen_Color.Colors_Text1_,
                                                                      //     fontFamily:
                                                                      //         FontWeight_.Fonts_T,
                                                                      //     fontWeight:
                                                                      //         FontWeight.bold,
                                                                      //   ),
                                                                      // ),
                                                                    ),
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      Expanded(
                                                                          flex:
                                                                              6,
                                                                          child:
                                                                              Column(
                                                                            children: [
                                                                              Padding(
                                                                                padding: const EdgeInsets.all(8.0),
                                                                                child: SizedBox(
                                                                                  // width: 200,
                                                                                  child: TextFormField(
                                                                                    controller: Add_qty_area_text,
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
                                                                                        labelText: 'ขนาดพื้นที่(ต.ร.ม.)',
                                                                                        labelStyle: const TextStyle(
                                                                                          fontSize: 12,
                                                                                          color: Colors.black54,
                                                                                          fontFamily: FontWeight_.Fonts_T,
                                                                                        )),
                                                                                    inputFormatters: <TextInputFormatter>[
                                                                                      FilteringTextInputFormatter.deny(RegExp("[' ']")),
                                                                                      // for below version 2 use this
                                                                                      FilteringTextInputFormatter.allow(RegExp(r'[0-9 .]')),
                                                                                      // for version 2 and greater youcan also use this
                                                                                      // FilteringTextInputFormatter
                                                                                      //     .digitsOnly
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          )),
                                                                      Expanded(
                                                                          flex:
                                                                              6,
                                                                          child:
                                                                              Column(
                                                                            children: [
                                                                              Padding(
                                                                                padding: const EdgeInsets.all(8.0),
                                                                                child: SizedBox(
                                                                                  // width: 200,
                                                                                  child: TextFormField(
                                                                                    controller: Add_pri_area_text,
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
                                                                                        labelText: 'ค่าบริการหลัก(ต่องวด)',
                                                                                        labelStyle: const TextStyle(
                                                                                          fontSize: 12,
                                                                                          color: Colors.black54,
                                                                                          fontFamily: FontWeight_.Fonts_T,
                                                                                        )),
                                                                                    inputFormatters: <TextInputFormatter>[
                                                                                      FilteringTextInputFormatter.deny(RegExp("[' ']")),
                                                                                      // for below version 2 use this
                                                                                      FilteringTextInputFormatter.allow(RegExp(r'[0-9 .]')),
                                                                                      // for version 2 and greater youcan also use this
                                                                                      // FilteringTextInputFormatter
                                                                                      //     .digitsOnly
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          )),
                                                                    ],
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
                                                                  color: Colors
                                                                      .grey,
                                                                  height: 4.0,
                                                                ),
                                                                const SizedBox(
                                                                  height: 5.0,
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(8.0),
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              100,
                                                                          decoration:
                                                                              const BoxDecoration(
                                                                            color:
                                                                                Colors.green,
                                                                            borderRadius: BorderRadius.only(
                                                                                topLeft: Radius.circular(10),
                                                                                topRight: Radius.circular(10),
                                                                                bottomLeft: Radius.circular(10),
                                                                                bottomRight: Radius.circular(10)),
                                                                          ),
                                                                          padding:
                                                                              const EdgeInsets.all(8.0),
                                                                          child:
                                                                              TextButton(
                                                                            onPressed:
                                                                                () async {
                                                                              if (_formKey2.currentState!.validate()) {
                                                                                Insert_log.Insert_logs('ตั้งค่า', 'พื้นที่>>เพิ่มพื้นที่แบบAuto>>จำนวน:${Add_totalnew_area_text.text}');
                                                                                SharedPreferences preferences = await SharedPreferences.getInstance();
                                                                                String? ren = preferences.getString('renTalSer');
                                                                                String? ser_user = preferences.getString('ser');
                                                                                print('*******  ${Add_totalnew_area_text.text}');

                                                                                var zonename = ser_Zonex;

                                                                                var area_qty = '${Add_qty_area_text.text}';
                                                                                var area_pri = '${Add_pri_area_text.text}';
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
                                                                                for (int index = 0; index < int.parse('${Add_totalnew_area_text.text}'); index++) {
                                                                                  // var area_ser =
                                                                                  //     'ADD_Auto${index + 1}';

                                                                                  // var area_name =
                                                                                  //     'ADD_AutoName${index + 1}';

                                                                                  var Add_Number_area_New = (index == 0) ? int.parse('${Add_Number_area_.text}') : int.parse('${Add_Number_area_.text}') + (index);

                                                                                  var Add_name_area__New = (index == 0) ? int.parse('${Add_name_area_.text}') : int.parse('${Add_name_area_.text}') + (index);

                                                                                  String url = '${MyConstant().domain}/InC_area_setring.php?isAdd=true&ren=$ren&ser_user=$ser_user&zonename=$zonename&area_ser=${Add_Number_area_text.text}${Add_Number_area_New}&area_name=${Add_name_area_text.text}${Add_name_area__New}&area_qty=$area_qty&area_pri=$area_pri';

                                                                                  try {
                                                                                    var response = await http.get(Uri.parse(url));

                                                                                    var result = json.decode(response.body);
                                                                                    // print(result);
                                                                                    if (result.toString() == 'true') {
                                                                                      print('${Add_Number_area_New} // ${Add_name_area__New}');
                                                                                      if (index + 1 == int.parse(Add_totalnew_area_text.text)) {
                                                                                        setState(() {
                                                                                          read_GC_zone();
                                                                                          read_GC_area();
                                                                                          read_GC_area_count();

                                                                                          Add_totalnew_area_text.clear();

                                                                                          Add_Number_area_text.clear();
                                                                                          Add_Number_area_.clear();

                                                                                          Add_name_area_text.clear();
                                                                                          Add_name_area_.clear();

                                                                                          Add_qty_area_text.clear();

                                                                                          Add_pri_area_text.clear();
                                                                                        });
                                                                                        Navigator.pop(context, 'OK');

                                                                                        Navigator.pop(context, 'OK');
                                                                                      } else {
                                                                                        print('ADD_Auto${index + 1}');
                                                                                      }
                                                                                    }
                                                                                  } catch (e) {
                                                                                    print(e);
                                                                                  }
                                                                                }
                                                                              }
                                                                            },
                                                                            child: Translate.TranslateAndSetText(
                                                                                'บันทึก',
                                                                                Colors.white,
                                                                                TextAlign.start,
                                                                                FontWeight.bold,
                                                                                FontWeight_.Fonts_T,
                                                                                14,
                                                                                1),
                                                                            //     const Text(
                                                                            //   'บันทึก',
                                                                            //   style: TextStyle(
                                                                            //     color: Colors.white,
                                                                            //     fontFamily: FontWeight_.Fonts_T,
                                                                            //     fontWeight: FontWeight.bold,
                                                                            //   ),
                                                                            // ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(8.0),
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              100,
                                                                          decoration:
                                                                              const BoxDecoration(
                                                                            color:
                                                                                Colors.black,
                                                                            borderRadius: BorderRadius.only(
                                                                                topLeft: Radius.circular(10),
                                                                                topRight: Radius.circular(10),
                                                                                bottomLeft: Radius.circular(10),
                                                                                bottomRight: Radius.circular(10)),
                                                                          ),
                                                                          padding:
                                                                              const EdgeInsets.all(8.0),
                                                                          child:
                                                                              TextButton(
                                                                            onPressed:
                                                                                () async {
                                                                              setState(() {
                                                                                Add_totalnew_area_text.clear();

                                                                                Add_Number_area_text.clear();
                                                                                Add_Number_area_.clear();

                                                                                Add_name_area_text.clear();
                                                                                Add_name_area_.clear();

                                                                                Add_qty_area_text.clear();

                                                                                Add_pri_area_text.clear();
                                                                              });
                                                                              Navigator.pop(context, 'OK');
                                                                            },
                                                                            child: Translate.TranslateAndSetText(
                                                                                'ยกเลิก',
                                                                                Colors.white,
                                                                                TextAlign.start,
                                                                                FontWeight.bold,
                                                                                FontWeight_.Fonts_T,
                                                                                14,
                                                                                1),
                                                                            //     const Text(
                                                                            //   'ยกเลิก',
                                                                            //   style: TextStyle(
                                                                            //     color: Colors.white,
                                                                            //     fontFamily: FontWeight_.Fonts_T,
                                                                            //     fontWeight: FontWeight.bold,
                                                                            //   ),
                                                                            // ),
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
                                                  },
                                                )
                                          : const SizedBox(),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                            child: row_num == 0
                                ? Column(
                                    children: [
                                      ScrollConfiguration(
                                        behavior:
                                            ScrollConfiguration.of(context)
                                                .copyWith(dragDevices: {
                                          PointerDeviceKind.touch,
                                          PointerDeviceKind.mouse,
                                        }),
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          dragStartBehavior:
                                              DragStartBehavior.start,
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: (!Responsive.isDesktop(
                                                        context))
                                                    ? 790
                                                    : MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        0.84,
                                                child: Column(
                                                  children: [
                                                    // Container(
                                                    //   decoration: const BoxDecoration(
                                                    //     color: AppbackgroundColor.TiTile_Colors,
                                                    //     borderRadius: BorderRadius.only(
                                                    //         topLeft: Radius.circular(10),
                                                    //         topRight: Radius.circular(10),
                                                    //         bottomLeft: Radius.circular(0),
                                                    //         bottomRight: Radius.circular(0)),
                                                    //   ),
                                                    //   child: Row(
                                                    //     children: [
                                                    //       Padding(
                                                    //         padding: EdgeInsets.all(8.0),
                                                    //         child: Text(
                                                    //           'ค้นหา:',
                                                    //           textAlign: TextAlign.end,
                                                    //           style: TextStyle(
                                                    //               color: PeopleChaoScreen_Color
                                                    //                   .Colors_Text1_,
                                                    //               fontWeight: FontWeight.bold,
                                                    //               fontFamily: FontWeight_.Fonts_T),
                                                    //         ),
                                                    //       ),
                                                    //       Expanded(
                                                    //         // flex: MediaQuery.of(context)
                                                    //         //             .size
                                                    //         //             .shortestSide <
                                                    //         //         MediaQuery.of(context)
                                                    //         //                 .size
                                                    //         //                 .width *
                                                    //         //             1
                                                    //         //     ? 8
                                                    //         //     : 6,
                                                    //         child: Padding(
                                                    //           padding: const EdgeInsets.all(8.0),
                                                    //           child: Container(
                                                    //             decoration: BoxDecoration(
                                                    //               color: AppbackgroundColor
                                                    //                   .Sub_Abg_Colors,
                                                    //               borderRadius: const BorderRadius
                                                    //                       .only(
                                                    //                   topLeft: Radius.circular(10),
                                                    //                   topRight: Radius.circular(10),
                                                    //                   bottomLeft: Radius.circular(10),
                                                    //                   bottomRight:
                                                    //                       Radius.circular(10)),
                                                    //               border: Border.all(
                                                    //                   color: Colors.grey, width: 1),
                                                    //             ),
                                                    //             // width: 120,
                                                    //             // height: 35,
                                                    //             child: _searchBar(),
                                                    //           ),
                                                    //         ),
                                                    //       ),
                                                    //     ],
                                                    //   ),
                                                    // ),
                                                    Container(
                                                      height: 50,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            AppbackgroundColor
                                                                .TiTile_Colors,
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        10),
                                                                topRight:
                                                                    Radius
                                                                        .circular(
                                                                            10),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        0),
                                                                bottomRight:
                                                                    Radius
                                                                        .circular(
                                                                            0)),
                                                      ),
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Expanded(
                                                            flex: 1,
                                                            child: Translate
                                                                .TranslateAndSetText(
                                                                    'รหัสพื้นที่',
                                                                    SettingScreen_Color
                                                                        .Colors_Text1_,
                                                                    TextAlign
                                                                        .center,
                                                                    FontWeight
                                                                        .bold,
                                                                    FontWeight_
                                                                        .Fonts_T,
                                                                    14,
                                                                    1),
                                                            //  Text(
                                                            //     'รหัสพื้นที่',
                                                            //     textAlign:
                                                            //         TextAlign
                                                            //             .center,
                                                            //     maxLines: 2,
                                                            //     overflow:
                                                            //         TextOverflow
                                                            //             .ellipsis,
                                                            //     softWrap: false,
                                                            //     style: TextStyle(
                                                            //         // fontSize: 15,
                                                            //         color: SettingScreen_Color.Colors_Text1_,
                                                            //         fontFamily: FontWeight_.Fonts_T
                                                            //         // fontWeight: FontWeight.bold,
                                                            //         )),
                                                          ),
                                                          Expanded(
                                                            flex: 1,
                                                            child: Translate.TranslateAndSetText(
                                                                'ชื่อพื้นที่เช่า',
                                                                SettingScreen_Color
                                                                    .Colors_Text1_,
                                                                TextAlign
                                                                    .center,
                                                                FontWeight.bold,
                                                                FontWeight_
                                                                    .Fonts_T,
                                                                14,
                                                                1),
                                                          ),
                                                          Expanded(
                                                            flex: 1,
                                                            child: Translate.TranslateAndSetText(
                                                                'ขนาดพื้นที่(ตร.ม.)',
                                                                SettingScreen_Color
                                                                    .Colors_Text1_,
                                                                TextAlign.end,
                                                                FontWeight.bold,
                                                                FontWeight_
                                                                    .Fonts_T,
                                                                14,
                                                                1),
                                                          ),
                                                          Expanded(
                                                            flex: 1,
                                                            child: Translate.TranslateAndSetText(
                                                                'ค่าบริการหลัก(ต่องวด)',
                                                                SettingScreen_Color
                                                                    .Colors_Text1_,
                                                                TextAlign.end,
                                                                FontWeight.bold,
                                                                FontWeight_
                                                                    .Fonts_T,
                                                                14,
                                                                1),
                                                          ),
                                                          Expanded(
                                                            flex: 1,
                                                            child:
                                                                GestureDetector(
                                                              onTap: () {
                                                                showDialog(
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (context) =>
                                                                            StatefulBuilder(
                                                                              builder: (context, setState) => AlertDialog(
                                                                                shape: RoundedRectangleBorder(
                                                                                  borderRadius: BorderRadius.circular(20),
                                                                                ),
                                                                                title: Column(
                                                                                  children: [
                                                                                    Row(
                                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                                      children: [
                                                                                        Container(
                                                                                          alignment: Alignment.center,
                                                                                          width: MediaQuery.of(context).size.width * 0.2,
                                                                                          child: Translate.TranslateAndSetText('ลบพื้นที่ว่างทั้งหมด', Colors.red, TextAlign.start, FontWeight.bold, FontWeight_.Fonts_T, 14, 1),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                    const SizedBox(
                                                                                      height: 10,
                                                                                    ),
                                                                                    // Row(
                                                                                    //   mainAxisAlignment:
                                                                                    //       MainAxisAlignment
                                                                                    //           .center,
                                                                                    //   children: [
                                                                                    //     Container(
                                                                                    //         alignment: Alignment
                                                                                    //             .center,
                                                                                    //         width: MediaQuery.of(context).size.width *
                                                                                    //             0.2,
                                                                                    //         child:
                                                                                    //             Text(
                                                                                    //           'รหัสพื้นที่ ${areaModels[index].lncode} : ชื่อพื้นที่ ${areaModels[index].ln}',
                                                                                    //           style: const TextStyle(
                                                                                    //             fontSize: 16.0,
                                                                                    //             fontWeight: FontWeight.bold,
                                                                                    //             color: Colors.black,
                                                                                    //           ),
                                                                                    //         )),
                                                                                    //   ],
                                                                                    // ),
                                                                                  ],
                                                                                ), //AppBarColors2.Colors(),
                                                                                content: Column(
                                                                                  mainAxisSize: MainAxisSize.min,
                                                                                  children: [
                                                                                    Row(
                                                                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                                      children: [
                                                                                        Container(
                                                                                          width: 130,
                                                                                          height: 40,
                                                                                          // ignore: deprecated_member_use
                                                                                          child: ElevatedButton(
                                                                                            style: ElevatedButton.styleFrom(
                                                                                              backgroundColor: Colors.green,
                                                                                            ),
                                                                                            onPressed: () async {
                                                                                              SharedPreferences preferences = await SharedPreferences.getInstance();
                                                                                              String? ren = preferences.getString('renTalSer');
                                                                                              String? ser_user = preferences.getString('ser');
                                                                                              for (var index = 0; index < areaModels.length; index++) {
                                                                                                if (areaModels[index].quantity == null) {
                                                                                                  var vser = areaModels[index].ser;
                                                                                                  String url = '${MyConstant().domain}/DeC_area.php?isAdd=true&ren=$ren&vser=$vser&ser_user=$ser_user';

                                                                                                  try {
                                                                                                    var response = await http.get(Uri.parse(url));

                                                                                                    var result = json.decode(response.body);
                                                                                                    print(result);
                                                                                                    if (result.toString() == 'true') {
                                                                                                      Insert_log.Insert_logs('ตั้งค่า', 'พื้นที่>>ลบ(${areaModels[index].lncode} : ${areaModels[index].ln})');
                                                                                                      // setState(() {
                                                                                                      //   Navigator.pop(context);
                                                                                                      //   read_GC_area();
                                                                                                      //   read_GC_zone();
                                                                                                      //   read_GC_area();
                                                                                                      //   read_GC_area_count();
                                                                                                      // });
                                                                                                    } else {}
                                                                                                  } catch (e) {}
                                                                                                }
                                                                                              }
                                                                                              setState(() {
                                                                                                Navigator.pop(context);
                                                                                                read_GC_area();
                                                                                                read_GC_zone();
                                                                                                read_GC_area();
                                                                                                read_GC_area_count();
                                                                                              });
                                                                                            },
                                                                                            child: Translate.TranslateAndSetText('ยันยัน', Colors.white, TextAlign.start, FontWeight.bold, FontWeight_.Fonts_T, 14, 1),

                                                                                            // color: Colors.orange[900],
                                                                                          ),
                                                                                        ),
                                                                                        Container(
                                                                                          width: 150,
                                                                                          height: 40,
                                                                                          // ignore: deprecated_member_use
                                                                                          child: ElevatedButton(
                                                                                            style: ElevatedButton.styleFrom(
                                                                                              backgroundColor: Colors.black,
                                                                                            ),
                                                                                            onPressed: () => Navigator.pop(context),
                                                                                            child: Translate.TranslateAndSetText('ยกเลิก', Colors.white, TextAlign.start, FontWeight.bold, FontWeight_.Fonts_T, 14, 1),

                                                                                            // color: Colors.black,
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    )
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ));
                                                              },
                                                              child: Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            8.0),
                                                                child: Translate.TranslateAndSetText(
                                                                    'ลบ',
                                                                    SettingScreen_Color
                                                                        .Colors_Text1_,
                                                                    TextAlign
                                                                        .center,
                                                                    FontWeight
                                                                        .bold,
                                                                    FontWeight_
                                                                        .Fonts_T,
                                                                    14,
                                                                    1),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      width: (!Responsive
                                                              .isDesktop(
                                                                  context))
                                                          ? 790
                                                          : MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.84,
                                                      height: 350,
                                                      decoration:
                                                          const BoxDecoration(
                                                        color:
                                                            AppbackgroundColor
                                                                .Sub_Abg_Colors,
                                                        borderRadius:
                                                            BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  0),
                                                          topRight:
                                                              Radius.circular(
                                                                  0),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  0),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  0),
                                                        ),
                                                        // border: Border.all(
                                                        //     color: Colors.grey, width: 1),
                                                      ),
                                                      child: areaModels.isEmpty
                                                          ? SizedBox(
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  const CircularProgressIndicator(),
                                                                  StreamBuilder(
                                                                    stream: Stream.periodic(
                                                                        const Duration(
                                                                            milliseconds:
                                                                                25),
                                                                        (i) =>
                                                                            i),
                                                                    builder:
                                                                        (context,
                                                                            snapshot) {
                                                                      if (!snapshot
                                                                          .hasData)
                                                                        return const Text(
                                                                            '');
                                                                      double
                                                                          elapsed =
                                                                          double.parse(snapshot.data.toString()) *
                                                                              0.05;
                                                                      return Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(8.0),
                                                                        child: (elapsed >
                                                                                8.00)
                                                                            ? const Text(
                                                                                'ไม่พบข้อมูล',
                                                                                style: TextStyle(color: PeopleChaoScreen_Color.Colors_Text2_, fontFamily: Font_.Fonts_T
                                                                                    //fontSize: 10.0
                                                                                    ),
                                                                              )
                                                                            : Text(
                                                                                'ดาวน์โหลด : ${elapsed.toStringAsFixed(2)} s.',
                                                                                // 'Time : ${elapsed.toStringAsFixed(2)} seconds',
                                                                                style: const TextStyle(color: PeopleChaoScreen_Color.Colors_Text2_, fontFamily: Font_.Fonts_T
                                                                                    //fontSize: 10.0
                                                                                    ),
                                                                              ),
                                                                      );
                                                                    },
                                                                  ),
                                                                ],
                                                              ),
                                                            )
                                                          : ListView.builder(
                                                              controller:
                                                                  _scrollController1,
                                                              // itemExtent: 50,
                                                              physics:
                                                                  const AlwaysScrollableScrollPhysics(), //const NeverScrollableScrollPhysics(),
                                                              shrinkWrap: true,
                                                              itemCount:
                                                                  areaModels
                                                                      .length,
                                                              itemBuilder:
                                                                  (BuildContext
                                                                          context,
                                                                      int index) {
                                                                return areaModels[index]
                                                                            .quantity ==
                                                                        null
                                                                    ? Material(
                                                                        color: tappedIndex_ ==
                                                                                index.toString()
                                                                            ? tappedIndex_Color.tappedIndex_Colors
                                                                            : AppbackgroundColor.Sub_Abg_Colors,
                                                                        child:
                                                                            Container(
                                                                          // color: tappedIndex_ ==
                                                                          //         index.toString()
                                                                          //     ? Colors.grey.shade300
                                                                          //     : null,
                                                                          child: ListTile(
                                                                              onTap: () {
                                                                                setState(() {
                                                                                  tappedIndex_ = index.toString();
                                                                                });
                                                                              },
                                                                              title: Container(
                                                                                decoration: BoxDecoration(
                                                                                  // color: Colors.green[100]!
                                                                                  //     .withOpacity(0.5),
                                                                                  border: Border(
                                                                                    bottom: BorderSide(
                                                                                      color: Colors.black12,
                                                                                      width: 1,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                child: Row(
                                                                                  children: [
                                                                                    Expanded(
                                                                                      flex: 1,
                                                                                      child: TextFormField(
                                                                                        textAlign: TextAlign.end,
                                                                                        initialValue: areaModels[index].ln,
                                                                                        onFieldSubmitted: (value) async {
                                                                                          SharedPreferences preferences = await SharedPreferences.getInstance();
                                                                                          String? ren = preferences.getString('renTalSer');
                                                                                          String? ser_user = preferences.getString('ser');
                                                                                          var vser = areaModels[index].ser;
                                                                                          String url = '${MyConstant().domain}/UpC_area_ln.php?isAdd=true&ren=$ren&vser=$vser&value=$value&ser_user=$ser_user';

                                                                                          try {
                                                                                            var response = await http.get(Uri.parse(url));

                                                                                            var result = json.decode(response.body);
                                                                                            print(result);
                                                                                            if (result.toString() == 'true') {
                                                                                              setState(() {
                                                                                                read_GC_area();
                                                                                              });
                                                                                            } else {}
                                                                                          } catch (e) {}
                                                                                        },
                                                                                        // maxLength: 13,
                                                                                        cursorColor: Colors.green,
                                                                                        decoration: InputDecoration(
                                                                                          fillColor: Colors.white.withOpacity(0.05),
                                                                                          filled: true,
                                                                                          // prefixIcon:
                                                                                          //     const Icon(Icons.key, color: Colors.black),
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
                                                                                              color: Colors.grey,
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
                                                                                          // labelText: 'PASSWOED',
                                                                                          labelStyle: const TextStyle(
                                                                                              color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                                              // fontWeight: FontWeight.bold,
                                                                                              fontFamily: Font_.Fonts_T),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    Expanded(
                                                                                      flex: 1,
                                                                                      child: Padding(
                                                                                        padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                                                                                        child: TextFormField(
                                                                                          textAlign: TextAlign.end,
                                                                                          initialValue: areaModels[index].lncode,
                                                                                          onFieldSubmitted: (value) async {
                                                                                            SharedPreferences preferences = await SharedPreferences.getInstance();
                                                                                            String? ren = preferences.getString('renTalSer');
                                                                                            String? ser_user = preferences.getString('ser');
                                                                                            var vser = areaModels[index].ser;
                                                                                            String url = '${MyConstant().domain}/UpC_area_lncode.php?isAdd=true&ren=$ren&vser=$vser&value=$value&ser_user=$ser_user';

                                                                                            try {
                                                                                              var response = await http.get(Uri.parse(url));

                                                                                              var result = json.decode(response.body);
                                                                                              print(result);
                                                                                              if (result.toString() == 'true') {
                                                                                                setState(() {
                                                                                                  read_GC_area();
                                                                                                });
                                                                                              } else {}
                                                                                            } catch (e) {}
                                                                                          },
                                                                                          // maxLength: 13,
                                                                                          cursorColor: Colors.green,
                                                                                          decoration: InputDecoration(
                                                                                            fillColor: Colors.white.withOpacity(0.05),
                                                                                            filled: true,
                                                                                            // prefixIcon:
                                                                                            //     const Icon(Icons.key, color: Colors.black),
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
                                                                                                color: Colors.grey,
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
                                                                                            // labelText: 'PASSWOED',
                                                                                            labelStyle: const TextStyle(
                                                                                                color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                                                // fontWeight: FontWeight.bold,
                                                                                                fontFamily: Font_.Fonts_T),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    Expanded(
                                                                                      flex: 1,
                                                                                      child: Padding(
                                                                                        padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                                                                                        child: TextFormField(
                                                                                          textAlign: TextAlign.end,
                                                                                          initialValue: areaModels[index].area,
                                                                                          onFieldSubmitted: (value) async {
                                                                                            SharedPreferences preferences = await SharedPreferences.getInstance();
                                                                                            String? ren = preferences.getString('renTalSer');
                                                                                            String? ser_user = preferences.getString('ser');
                                                                                            var vser = areaModels[index].ser;
                                                                                            String url = '${MyConstant().domain}/UpC_area_area.php?isAdd=true&ren=$ren&vser=$vser&value=$value&ser_user=$ser_user';

                                                                                            try {
                                                                                              var response = await http.get(Uri.parse(url));

                                                                                              var result = json.decode(response.body);
                                                                                              print(result);
                                                                                              if (result.toString() == 'true') {
                                                                                                setState(() {
                                                                                                  read_GC_area();
                                                                                                });
                                                                                              } else {}
                                                                                            } catch (e) {}
                                                                                          },
                                                                                          // maxLength: 13,
                                                                                          cursorColor: Colors.green,
                                                                                          decoration: InputDecoration(
                                                                                            fillColor: Colors.white.withOpacity(0.05),
                                                                                            filled: true,
                                                                                            // prefixIcon:
                                                                                            //     const Icon(Icons.key, color: Colors.black),
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
                                                                                                color: Colors.grey,
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
                                                                                            // labelText: 'PASSWOED',
                                                                                            labelStyle: const TextStyle(
                                                                                                color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                                                // fontWeight: FontWeight.bold,
                                                                                                fontFamily: Font_.Fonts_T),
                                                                                          ),
                                                                                          inputFormatters: <TextInputFormatter>[
                                                                                            // for below version 2 use this
                                                                                            FilteringTextInputFormatter.allow(RegExp(r'[0-9 .]')),
                                                                                            // for version 2 and greater youcan also use this
                                                                                            // FilteringTextInputFormatter
                                                                                            //     .digitsOnly
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    Expanded(
                                                                                      flex: 1,
                                                                                      child: Padding(
                                                                                        padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                                                                                        child: TextFormField(
                                                                                          textAlign: TextAlign.end,
                                                                                          initialValue: areaModels[index].rent,
                                                                                          onFieldSubmitted: (value) async {
                                                                                            SharedPreferences preferences = await SharedPreferences.getInstance();
                                                                                            String? ren = preferences.getString('renTalSer');
                                                                                            String? ser_user = preferences.getString('ser');
                                                                                            var vser = areaModels[index].ser;
                                                                                            String url = '${MyConstant().domain}/UpC_area_rent.php?isAdd=true&ren=$ren&vser=$vser&value=$value&ser_user=$ser_user';

                                                                                            try {
                                                                                              var response = await http.get(Uri.parse(url));

                                                                                              var result = json.decode(response.body);
                                                                                              print(result);
                                                                                              if (result.toString() == 'true') {
                                                                                                setState(() {
                                                                                                  read_GC_area();
                                                                                                });
                                                                                              } else {}
                                                                                            } catch (e) {}
                                                                                          },
                                                                                          // maxLength: 13,
                                                                                          cursorColor: Colors.green,
                                                                                          decoration: InputDecoration(
                                                                                            fillColor: Colors.white.withOpacity(0.05),
                                                                                            filled: true,
                                                                                            // prefixIcon:
                                                                                            //     const Icon(Icons.key, color: Colors.black),
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
                                                                                                color: Colors.grey,
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
                                                                                            // labelText: 'PASSWOED',
                                                                                            labelStyle: const TextStyle(
                                                                                                color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                                                // fontWeight: FontWeight.bold,
                                                                                                fontFamily: Font_.Fonts_T),
                                                                                          ),
                                                                                          inputFormatters: <TextInputFormatter>[
                                                                                            // for below version 2 use this
                                                                                            FilteringTextInputFormatter.allow(RegExp(r'[0-9 .]')),
                                                                                            // for version 2 and greater youcan also use this
                                                                                            // FilteringTextInputFormatter
                                                                                            //     .digitsOnly
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    Expanded(
                                                                                      flex: 1,
                                                                                      child: Align(
                                                                                        alignment: Alignment.center,
                                                                                        child: InkWell(
                                                                                          child: Container(
                                                                                            width: 100,
                                                                                            decoration: BoxDecoration(
                                                                                              color: Colors.red[700],
                                                                                              borderRadius: const BorderRadius.only(
                                                                                                topLeft: Radius.circular(10),
                                                                                                topRight: Radius.circular(10),
                                                                                                bottomLeft: Radius.circular(10),
                                                                                                bottomRight: Radius.circular(10),
                                                                                              ),
                                                                                              // border: Border.all(
                                                                                              //     color: Colors.grey, width: 1),
                                                                                            ),
                                                                                            padding: const EdgeInsets.all(8.0),
                                                                                            child: const Text(
                                                                                              'X',
                                                                                              textAlign: TextAlign.center,
                                                                                              maxLines: 1,
                                                                                              overflow: TextOverflow.ellipsis,
                                                                                              style: TextStyle(color: Colors.black, fontFamily: Font_.Fonts_T),
                                                                                            ),
                                                                                          ),
                                                                                          onTap: () {
                                                                                            print('ลบ ${areaModels[index].ln}');
                                                                                            showDialog(
                                                                                                context: context,
                                                                                                builder: (context) => StatefulBuilder(
                                                                                                      builder: (context, setState) => AlertDialog(
                                                                                                        shape: RoundedRectangleBorder(
                                                                                                          borderRadius: BorderRadius.circular(20),
                                                                                                        ),
                                                                                                        title: Column(
                                                                                                          children: [
                                                                                                            Row(
                                                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                                                              children: [
                                                                                                                Container(
                                                                                                                    alignment: Alignment.center,
                                                                                                                    width: MediaQuery.of(context).size.width * 0.2,
                                                                                                                    child: const Text(
                                                                                                                      'ลบพื้นที่',
                                                                                                                      style: TextStyle(
                                                                                                                        fontSize: 20.0,
                                                                                                                        fontWeight: FontWeight.bold,
                                                                                                                        color: Colors.red,
                                                                                                                      ),
                                                                                                                    )),
                                                                                                              ],
                                                                                                            ),
                                                                                                            const SizedBox(
                                                                                                              height: 10,
                                                                                                            ),
                                                                                                            Row(
                                                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                                                              children: [
                                                                                                                Container(
                                                                                                                    alignment: Alignment.center,
                                                                                                                    width: MediaQuery.of(context).size.width * 0.2,
                                                                                                                    child: Text(
                                                                                                                      'รหัสพื้นที่ ${areaModels[index].lncode} : ชื่อพื้นที่ ${areaModels[index].ln}',
                                                                                                                      style: const TextStyle(
                                                                                                                        fontSize: 16.0,
                                                                                                                        fontWeight: FontWeight.bold,
                                                                                                                        color: Colors.black,
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
                                                                                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                                                              children: [
                                                                                                                Container(
                                                                                                                  width: 130,
                                                                                                                  height: 40,
                                                                                                                  // ignore: deprecated_member_use
                                                                                                                  child: ElevatedButton(
                                                                                                                    style: ElevatedButton.styleFrom(
                                                                                                                      backgroundColor: Colors.green,
                                                                                                                    ),
                                                                                                                    onPressed: () async {
                                                                                                                      SharedPreferences preferences = await SharedPreferences.getInstance();
                                                                                                                      String? ren = preferences.getString('renTalSer');
                                                                                                                      String? ser_user = preferences.getString('ser');
                                                                                                                      var vser = areaModels[index].ser;
                                                                                                                      String url = '${MyConstant().domain}/DeC_area.php?isAdd=true&ren=$ren&vser=$vser&ser_user=$ser_user';

                                                                                                                      try {
                                                                                                                        var response = await http.get(Uri.parse(url));

                                                                                                                        var result = json.decode(response.body);
                                                                                                                        print(result);
                                                                                                                        if (result.toString() == 'true') {
                                                                                                                          Insert_log.Insert_logs('ตั้งค่า', 'พื้นที่>>ลบ(${areaModels[index].lncode} : ${areaModels[index].ln})');
                                                                                                                          setState(() {
                                                                                                                            Navigator.pop(context);
                                                                                                                            read_GC_area();
                                                                                                                            read_GC_zone();
                                                                                                                            read_GC_area();
                                                                                                                            read_GC_area_count();
                                                                                                                          });
                                                                                                                        } else {}
                                                                                                                      } catch (e) {}
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
                                                                                                                    style: ElevatedButton.styleFrom(
                                                                                                                      backgroundColor: Colors.black,
                                                                                                                    ),
                                                                                                                    onPressed: () => Navigator.pop(context),
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
                                                                                                    ));
                                                                                          },
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              )),
                                                                        ),
                                                                      )
                                                                    : Material(
                                                                        color: tappedIndex_ ==
                                                                                index.toString()
                                                                            ? tappedIndex_Color.tappedIndex_Colors
                                                                            : AppbackgroundColor.Sub_Abg_Colors,
                                                                        child:
                                                                            Container(
                                                                          // color: tappedIndex_ ==
                                                                          //         index.toString()
                                                                          //     ? Colors.grey.shade300
                                                                          //     : null,
                                                                          child: ListTile(
                                                                              onTap: () {
                                                                                setState(() {
                                                                                  tappedIndex_ = index.toString();
                                                                                });
                                                                              },
                                                                              title: Container(
                                                                                decoration: BoxDecoration(
                                                                                  // color: Colors.green[100]!
                                                                                  //     .withOpacity(0.5),
                                                                                  border: Border(
                                                                                    bottom: BorderSide(
                                                                                      color: Colors.black12,
                                                                                      width: 1,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                child: Row(
                                                                                  children: [
                                                                                    Expanded(
                                                                                      flex: 1,
                                                                                      child: Text(
                                                                                        '${areaModels[index].ln}',
                                                                                        textAlign: TextAlign.center,
                                                                                        style: const TextStyle(color: SettingScreen_Color.Colors_Text2_, fontFamily: Font_.Fonts_T

                                                                                            //fontSize: 10.0
                                                                                            ),
                                                                                      ),
                                                                                    ),
                                                                                    Expanded(
                                                                                      flex: 1,
                                                                                      child: Text(
                                                                                        '${areaModels[index].lncode}',
                                                                                        textAlign: TextAlign.center,
                                                                                        style: const TextStyle(color: SettingScreen_Color.Colors_Text2_, fontFamily: Font_.Fonts_T

                                                                                            //fontSize: 10.0
                                                                                            ),
                                                                                      ),
                                                                                    ),
                                                                                    Expanded(
                                                                                      flex: 1,
                                                                                      child: Text(
                                                                                        '${nFormat.format(double.parse(areaModels[index].area!))}',
                                                                                        // '${areaModels[index].area}',
                                                                                        textAlign: TextAlign.end,
                                                                                        style: const TextStyle(color: SettingScreen_Color.Colors_Text2_, fontFamily: Font_.Fonts_T

                                                                                            //fontSize: 10.0
                                                                                            ),
                                                                                      ),
                                                                                    ),
                                                                                    Expanded(
                                                                                      flex: 1,
                                                                                      child: Text(
                                                                                        '${nFormat.format(double.parse(areaModels[index].rent!))}',
                                                                                        // '${areaModels[index].rent}',
                                                                                        textAlign: TextAlign.end,
                                                                                        style: const TextStyle(color: SettingScreen_Color.Colors_Text2_, fontFamily: Font_.Fonts_T

                                                                                            //fontSize: 10.0
                                                                                            ),
                                                                                      ),
                                                                                    ),
                                                                                    Expanded(
                                                                                      flex: 1,
                                                                                      child: Align(
                                                                                        alignment: Alignment.center,
                                                                                        child: InkWell(
                                                                                          child: Container(
                                                                                            width: 100,
                                                                                            decoration: const BoxDecoration(
                                                                                              // color: Colors
                                                                                              //     .red[700],
                                                                                              borderRadius: BorderRadius.only(
                                                                                                topLeft: Radius.circular(10),
                                                                                                topRight: Radius.circular(10),
                                                                                                bottomLeft: Radius.circular(10),
                                                                                                bottomRight: Radius.circular(10),
                                                                                              ),
                                                                                              // border: Border.all(
                                                                                              //     color: Colors.grey, width: 1),
                                                                                            ),
                                                                                            padding: const EdgeInsets.all(8.0),
                                                                                            child: const Text(
                                                                                              '',
                                                                                              textAlign: TextAlign.center,
                                                                                              maxLines: 1,
                                                                                              overflow: TextOverflow.ellipsis,
                                                                                              style: TextStyle(color: SettingScreen_Color.Colors_Text2_, fontFamily: Font_.Fonts_T),
                                                                                            ),
                                                                                          ),
                                                                                          onTap: () {
                                                                                            print('ลบ ${areaModels[index].ln}');
                                                                                          },
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              )),
                                                                        ),
                                                                      );
                                                              },
                                                            ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                          width:
                                              (!Responsive.isDesktop(context))
                                                  ? MediaQuery.of(context)
                                                      .size
                                                      .width
                                                  : MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.84,
                                          decoration: const BoxDecoration(
                                            color: AppbackgroundColor
                                                .Sub_Abg_Colors,
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(0),
                                                topRight: Radius.circular(0),
                                                bottomLeft: Radius.circular(10),
                                                bottomRight:
                                                    Radius.circular(10)),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: InkWell(
                                                        onTap: () {},
                                                        child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              // color: AppbackgroundColor
                                                              //     .TiTile_Colors,
                                                              borderRadius: const BorderRadius
                                                                      .only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          6),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          6),
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          6),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          8)),
                                                              border: Border.all(
                                                                  color: Colors
                                                                      .grey,
                                                                  width: 1),
                                                            ),
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(3.0),
                                                            child: const Text(
                                                              'Top',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                  fontSize:
                                                                      10.0,
                                                                  fontFamily: Font_
                                                                      .Fonts_T),
                                                            )),
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap: () {},
                                                      child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            // color: AppbackgroundColor
                                                            //     .TiTile_Colors,
                                                            borderRadius: const BorderRadius
                                                                    .only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        6),
                                                                topRight: Radius
                                                                    .circular(
                                                                        6),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        6),
                                                                bottomRight:
                                                                    Radius
                                                                        .circular(
                                                                            6)),
                                                            border: Border.all(
                                                                color:
                                                                    Colors.grey,
                                                                width: 1),
                                                          ),
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(3.0),
                                                          child: const Text(
                                                            'Down',
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.grey,
                                                                fontSize: 10.0,
                                                                fontFamily: Font_
                                                                    .Fonts_T),
                                                          )),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Row(
                                                  children: [
                                                    InkWell(
                                                      onTap: _moveUp1,
                                                      child: const Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  8.0),
                                                          child: Align(
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            child: Icon(
                                                              Icons
                                                                  .arrow_upward,
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                          )),
                                                    ),
                                                    Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          // color: AppbackgroundColor
                                                          //     .TiTile_Colors,
                                                          borderRadius: const BorderRadius
                                                                  .only(
                                                              topLeft: Radius
                                                                  .circular(6),
                                                              topRight: Radius
                                                                  .circular(6),
                                                              bottomLeft: Radius
                                                                  .circular(6),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          6)),
                                                          border: Border.all(
                                                              color:
                                                                  Colors.grey,
                                                              width: 1),
                                                        ),
                                                        padding:
                                                            const EdgeInsets
                                                                .all(3.0),
                                                        child: const Text(
                                                          'Scroll',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                              fontSize: 10.0,
                                                              fontFamily: Font_
                                                                  .Fonts_T),
                                                        )),
                                                    InkWell(
                                                      onTap: _moveDown1,
                                                      child: const Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  8.0),
                                                          child: Align(
                                                            alignment: Alignment
                                                                .centerRight,
                                                            child: Icon(
                                                              Icons
                                                                  .arrow_downward,
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                          )),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          )),
                                    ],
                                  )
                                : row_num == 1
                                    ?
                                    // Padding(
                                    //     padding: const EdgeInsets.all(8.0),
                                    //     child: Column(
                                    //       children: [
                                    //         Container(
                                    //           color: Colors.white,
                                    //           child:  RownumExample(Get_name_Zone: name_Zone,
                                    //     Get_ser_Zonex: ser_Zonex,),
                                    //         ),
                                    //       ],
                                    //     ),
                                    //   )
                                    Column(
                                        children: [
                                          ScrollConfiguration(
                                            behavior:
                                                ScrollConfiguration.of(context)
                                                    .copyWith(dragDevices: {
                                              PointerDeviceKind.touch,
                                              PointerDeviceKind.mouse,
                                            }),
                                            child: SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              dragStartBehavior:
                                                  DragStartBehavior.start,
                                              child: Row(
                                                children: [
                                                  SizedBox(
                                                    width: (!Responsive
                                                            .isDesktop(context))
                                                        ? 790
                                                        : MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.84,
                                                    child: Column(
                                                      children: [
                                                        Container(
                                                          height: 50,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: AppbackgroundColor
                                                                .TiTile_Colors,
                                                            borderRadius: BorderRadius.only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        10),
                                                                topRight: Radius
                                                                    .circular(
                                                                        10),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        0),
                                                                bottomRight:
                                                                    Radius
                                                                        .circular(
                                                                            0)),
                                                          ),
                                                          child: Row(
                                                            children: [
                                                              Expanded(
                                                                flex: 1,
                                                                child:
                                                                    AutoSizeText(
                                                                  minFontSize:
                                                                      10,
                                                                  maxFontSize:
                                                                      25,
                                                                  maxLines: 1,
                                                                  'ลำดับ',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: TextStyle(
                                                                      color: PeopleChaoScreen_Color
                                                                          .Colors_Text2_,
                                                                      fontFamily:
                                                                          FontWeight_
                                                                              .Fonts_T),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                flex: 4,
                                                                child:
                                                                    AutoSizeText(
                                                                  minFontSize:
                                                                      10,
                                                                  maxFontSize:
                                                                      25,
                                                                  maxLines: 1,
                                                                  'รหัสพื้นที่',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: TextStyle(
                                                                      color: PeopleChaoScreen_Color
                                                                          .Colors_Text2_,
                                                                      fontFamily:
                                                                          FontWeight_
                                                                              .Fonts_T),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                flex: 4,
                                                                child:
                                                                    AutoSizeText(
                                                                  minFontSize:
                                                                      10,
                                                                  maxFontSize:
                                                                      25,
                                                                  maxLines: 1,
                                                                  'ชื่อผู้เช่า',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: TextStyle(
                                                                      color: PeopleChaoScreen_Color
                                                                          .Colors_Text2_,
                                                                      fontFamily:
                                                                          FontWeight_
                                                                              .Fonts_T),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                flex: 4,
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          5.0),
                                                                  child:
                                                                      Container(
                                                                    width: 100,
                                                                    decoration:
                                                                        const BoxDecoration(
                                                                      color: Colors
                                                                          .green,
                                                                      borderRadius: BorderRadius.only(
                                                                          topLeft: Radius.circular(
                                                                              10),
                                                                          topRight: Radius.circular(
                                                                              10),
                                                                          bottomLeft: Radius.circular(
                                                                              10),
                                                                          bottomRight:
                                                                              Radius.circular(10)),
                                                                    ),
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            8.0),
                                                                    child:
                                                                        TextButton(
                                                                      onPressed:
                                                                          () async {
                                                                        for (int index =
                                                                                0;
                                                                            index <
                                                                                _contents.length;
                                                                            index++) {
                                                                          // var Order =
                                                                          //     _contents[index]
                                                                          //         .lastTarget
                                                                          //         .toString()
                                                                          //         .indexOf('"');
                                                                          // var Order2 =
                                                                          //     _contents[index]
                                                                          //         .lastTarget
                                                                          //         .toString()
                                                                          //         .substring(
                                                                          //             Order +
                                                                          //                 1);
                                                                          // var Order22 =
                                                                          //     Order2.toString()
                                                                          //         .indexOf('"');
                                                                          // var sub_zone =
                                                                          //     Order2.toString()
                                                                          //         .substring(0,
                                                                          //             Order22);
                                                                          var sub_zone =
                                                                              (_contents[index].lastTarget as Text).data;
                                                                          print(
                                                                              'sub_zone $sub_zone');
                                                                          List<DragAndDropItem>
                                                                              reverseOrder =
                                                                              _contents[index].children;

                                                                          for (int i = 0;
                                                                              i < reverseOrder.length;
                                                                              i++) {
                                                                            // var reverse =
                                                                            //     reverseOrder[i]
                                                                            //         .feedbackWidget
                                                                            //         .toString()
                                                                            //         .indexOf(
                                                                            //             '"');
                                                                            // var reverse2 =
                                                                            //     reverseOrder[i]
                                                                            //         .feedbackWidget
                                                                            //         .toString()
                                                                            //         .substring(
                                                                            //             reverse +
                                                                            //                 1);
                                                                            // var zone = reverse2
                                                                            //     .toString()
                                                                            //     .substring(
                                                                            //         0,
                                                                            //         reverse2.length -
                                                                            //             2);
                                                                            var zone =
                                                                                (reverseOrder[i].feedbackWidget as Text).data;
                                                                            print('zone $zone');
                                                                            edit_SW(i,
                                                                                zone!);
                                                                          }
                                                                        }
                                                                        setState(
                                                                            () {
                                                                          read_GC_rownum().then((value) =>
                                                                              con_row());
                                                                        });
                                                                      },
                                                                      child:
                                                                          const Text(
                                                                        'บันทึก',
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Colors.white,
                                                                          fontFamily:
                                                                              FontWeight_.Fonts_T,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        StreamBuilder(
                                                          stream:
                                                              Stream.periodic(
                                                                  const Duration(
                                                                      seconds:
                                                                          0)),
                                                          builder: (context,
                                                              snapshot) {
                                                            return Container(
                                                              height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.35,
                                                              width:
                                                                  MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width,
                                                              decoration:
                                                                  const BoxDecoration(
                                                                color: AppbackgroundColor
                                                                    .Sub_Abg_Colors,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          0),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          0),
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          0),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          0),
                                                                ),
                                                                // border: Border.all(
                                                                //     color: Colors.grey, width: 1),
                                                              ),
                                                              child:
                                                                  DragAndDropLists(
                                                                children:
                                                                    _contents,
                                                                onItemReorder:
                                                                    _onItemReorder,
                                                                onListReorder:
                                                                    _onListReorder,
                                                                scrollController:
                                                                    _scrollController,
                                                                axis: Axis
                                                                    .horizontal,
                                                                listWidth: Responsive
                                                                        .isDesktop(
                                                                            context)
                                                                    ? MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        0.8
                                                                    : MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        0.8,
                                                                listDraggingWidth: Responsive
                                                                        .isDesktop(
                                                                            context)
                                                                    ? MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        0.8
                                                                    : MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        0.8,
                                                                listPadding:
                                                                    const EdgeInsets
                                                                            .symmetric(
                                                                        horizontal:
                                                                            15,
                                                                        vertical:
                                                                            10),
                                                                itemDivider:
                                                                    Divider(
                                                                  thickness: 2,
                                                                  height: 2,
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          243,
                                                                          242,
                                                                          248),
                                                                ),
                                                                itemDecorationWhileDragging:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  boxShadow: [
                                                                    BoxShadow(
                                                                      color: Colors
                                                                          .grey
                                                                          .withOpacity(
                                                                              0.5),
                                                                      spreadRadius:
                                                                          2,
                                                                      blurRadius:
                                                                          3,
                                                                      offset: const Offset(
                                                                          0,
                                                                          0), // changes position of shadow
                                                                    ),
                                                                  ],
                                                                ),
                                                                listInnerDecoration:
                                                                    BoxDecoration(
                                                                  color: Theme.of(
                                                                          context)
                                                                      .canvasColor,
                                                                  borderRadius: const BorderRadius
                                                                          .all(
                                                                      Radius.circular(
                                                                          8.0)),
                                                                ),
                                                                lastItemTargetHeight:
                                                                    8,
                                                                addLastItemTargetHeightToTop:
                                                                    true,
                                                                lastListTargetSize:
                                                                    40,
                                                                listDragHandle:
                                                                    const DragHandle(
                                                                  verticalAlignment:
                                                                      DragHandleVerticalAlignment
                                                                          .top,
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsets.only(
                                                                        right:
                                                                            10),
                                                                    child: Icon(
                                                                      Icons
                                                                          .menu,
                                                                      color: Colors
                                                                          .black26,
                                                                    ),
                                                                  ),
                                                                ),
                                                                itemDragHandle:
                                                                    const DragHandle(
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsets.only(
                                                                        right:
                                                                            10),
                                                                    child: Icon(
                                                                      Icons
                                                                          .menu,
                                                                      color: Colors
                                                                          .blueGrey,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              // ListView.builder(
                                                              //   // controller: _scrollController1,
                                                              //   // itemExtent: 50,
                                                              //   physics:
                                                              //       const AlwaysScrollableScrollPhysics(), //const NeverScrollableScrollPhysics(),
                                                              //   shrinkWrap: true,
                                                              //   itemCount:
                                                              //       contractRownumModels.length,
                                                              //   itemBuilder:
                                                              //       (BuildContext context,
                                                              //           int index) {
                                                              //     return Row(
                                                              //       children: [
                                                              //         Expanded(
                                                              //           flex: 1,
                                                              //           child: Padding(
                                                              //             padding:
                                                              //                 const EdgeInsets
                                                              //                     .fromLTRB(
                                                              //                     8, 8, 0, 8),
                                                              //             child: TextFormField(
                                                              //               textAlign:
                                                              //                   TextAlign.end,
                                                              //               initialValue:
                                                              //                   contractRownumModels[
                                                              //                           index]
                                                              //                       .sw,
                                                              //               onChanged:
                                                              //                   (value) async {
                                                              //                 SharedPreferences
                                                              //                     preferences =
                                                              //                     await SharedPreferences
                                                              //                         .getInstance();
                                                              //                 String? ren =
                                                              //                     preferences
                                                              //                         .getString(
                                                              //                             'renTalSer');
                                                              //                 String? ser_user =
                                                              //                     preferences
                                                              //                         .getString(
                                                              //                             'ser');
                                                              //                 var vser =
                                                              //                     contractRownumModels[
                                                              //                             index]
                                                              //                         .ser;
                                                              //                 String url =
                                                              //                     '${MyConstant().domain}/UpC_rownum.php?isAdd=true&ren=$ren&vser=$vser&value=$value&ser_user=$ser_user';

                                                              //                 try {
                                                              //                   var response =
                                                              //                       await http.get(
                                                              //                           Uri.parse(
                                                              //                               url));

                                                              //                   var result =
                                                              //                       json.decode(
                                                              //                           response
                                                              //                               .body);
                                                              //                   print(result);
                                                              //                   if (result
                                                              //                           .toString() ==
                                                              //                       'true') {
                                                              //                     // setState(() {
                                                              //                     //   read_GC_rownum();
                                                              //                     // });
                                                              //                   } else {}
                                                              //                 } catch (e) {}
                                                              //               },
                                                              //               onFieldSubmitted:
                                                              //                   (value) async {
                                                              //                 setState(() {
                                                              //                   read_GC_rownum();
                                                              //                   read_GC_area();
                                                              //                 });
                                                              //               },
                                                              //               // maxLength: 13,
                                                              //               cursorColor:
                                                              //                   Colors.green,
                                                              //               decoration:
                                                              //                   InputDecoration(
                                                              //                 fillColor: Colors
                                                              //                     .white
                                                              //                     .withOpacity(
                                                              //                         0.05),
                                                              //                 filled: true,
                                                              //                 // prefixIcon:
                                                              //                 //     const Icon(Icons.key, color: Colors.black),
                                                              //                 // suffixIcon: Icon(Icons.clear, color: Colors.black),
                                                              //                 focusedBorder:
                                                              //                     const OutlineInputBorder(
                                                              //                   borderRadius:
                                                              //                       BorderRadius
                                                              //                           .only(
                                                              //                     topRight: Radius
                                                              //                         .circular(
                                                              //                             15),
                                                              //                     topLeft: Radius
                                                              //                         .circular(
                                                              //                             15),
                                                              //                     bottomRight: Radius
                                                              //                         .circular(
                                                              //                             15),
                                                              //                     bottomLeft: Radius
                                                              //                         .circular(
                                                              //                             15),
                                                              //                   ),
                                                              //                   borderSide:
                                                              //                       BorderSide(
                                                              //                     width: 1,
                                                              //                     color: Colors
                                                              //                         .grey,
                                                              //                   ),
                                                              //                 ),
                                                              //                 enabledBorder:
                                                              //                     const OutlineInputBorder(
                                                              //                   borderRadius:
                                                              //                       BorderRadius
                                                              //                           .only(
                                                              //                     topRight: Radius
                                                              //                         .circular(
                                                              //                             15),
                                                              //                     topLeft: Radius
                                                              //                         .circular(
                                                              //                             15),
                                                              //                     bottomRight: Radius
                                                              //                         .circular(
                                                              //                             15),
                                                              //                     bottomLeft: Radius
                                                              //                         .circular(
                                                              //                             15),
                                                              //                   ),
                                                              //                   borderSide:
                                                              //                       BorderSide(
                                                              //                     width: 1,
                                                              //                     color: Colors
                                                              //                         .grey,
                                                              //                   ),
                                                              //                 ),
                                                              //                 // labelText: 'PASSWOED',
                                                              //                 labelStyle:
                                                              //                     const TextStyle(
                                                              //                         color: PeopleChaoScreen_Color
                                                              //                             .Colors_Text2_,
                                                              //                         // fontWeight: FontWeight.bold,
                                                              //                         fontFamily:
                                                              //                             Font_
                                                              //                                 .Fonts_T),
                                                              //               ),
                                                              //               inputFormatters: <TextInputFormatter>[
                                                              //                 // for below version 2 use this
                                                              //                 FilteringTextInputFormatter
                                                              //                     .allow(RegExp(
                                                              //                         r'[0-9]')),
                                                              //                 // for version 2 and greater youcan also use this
                                                              //                 // FilteringTextInputFormatter
                                                              //                 //     .digitsOnly
                                                              //               ],
                                                              //             ),
                                                              //           ),
                                                              //           // AutoSizeText(
                                                              //           //   minFontSize: 10,
                                                              //           //   maxFontSize: 25,
                                                              //           //   maxLines: 1,
                                                              //           //   '${contractRownumModels[index].sw}',
                                                              //           //   textAlign:
                                                              //           //       TextAlign.center,
                                                              //           //   style: TextStyle(
                                                              //           //       color:
                                                              //           //           PeopleChaoScreen_Color
                                                              //           //               .Colors_Text2_,
                                                              //           //       fontFamily:
                                                              //           //           FontWeight_
                                                              //           //               .Fonts_T),
                                                              //           // ),
                                                              //         ),
                                                              //         Expanded(
                                                              //           flex: 4,
                                                              //           child: Container(
                                                              //             padding:
                                                              //                 const EdgeInsets
                                                              //                     .fromLTRB(
                                                              //                     8, 8, 0, 8),
                                                              //             child: AutoSizeText(
                                                              //               minFontSize: 10,
                                                              //               maxFontSize: 25,
                                                              //               maxLines: 1,
                                                              //               '${contractRownumModels[index].ln}',
                                                              //               textAlign:
                                                              //                   TextAlign.start,
                                                              //               style: TextStyle(
                                                              //                   color: PeopleChaoScreen_Color
                                                              //                       .Colors_Text2_,
                                                              //                   fontFamily: Font_
                                                              //                       .Fonts_T),
                                                              //             ),
                                                              //           ),
                                                              //         ),
                                                              //         Expanded(
                                                              //           flex: 4,
                                                              //           child: Container(
                                                              //             padding:
                                                              //                 const EdgeInsets
                                                              //                     .fromLTRB(
                                                              //                     8, 8, 0, 8),
                                                              //             child: AutoSizeText(
                                                              //               minFontSize: 10,
                                                              //               maxFontSize: 25,
                                                              //               maxLines: 1,
                                                              //               '${contractRownumModels[index].sname}',
                                                              //               textAlign:
                                                              //                   TextAlign.start,
                                                              //               style: TextStyle(
                                                              //                   color: PeopleChaoScreen_Color
                                                              //                       .Colors_Text2_,
                                                              //                   fontFamily: Font_
                                                              //                       .Fonts_T),
                                                              //             ),
                                                              //           ),
                                                              //         )
                                                              //       ],
                                                              //     );
                                                              //   },
                                                              // ),
                                                            );
                                                          },
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
                                    : Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Container(
                                              color: Colors.white,
                                              child:
                                                  const DragIntoListExample(),
                                            ),
                                          ],
                                        ),
                                      ),
                          ),
                        ],
                      ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          );
        });
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

  Widget Status2_Web() {
    return const Rental();
  }

  Widget Status3_Web() {
    return const BillDocument();
  }

  Widget Status4_Web() {
    return const Payment();
  }

  Widget Status5_Web() {
    return const Accessrights();
  }

  Widget Status6_Web() {
    return const EditwebScreen();
    // return const OtherScreen();
  }

  Widget Status7_Web() {
    return const HandHeld(); // USerInformation();
  }

  Widget Status8_Web() {
    return WebUser(); // const WebViewXPage();
    // return const OtherScreen();
  }

  Widget Status9_Web() {
    return const AdvanceSetting();
    // return const OtherScreen();
  }

  Widget BodyHome_mobile() {
    return Column(
      children: [
        (Status_ == 1)
            ? Status1_Web()
            : (Status_ == 2)
                ? Status2_Web()
                : (Status_ == 3)
                    ? const BillDocument()
                    : (Status_ == 4)
                        ? const Payment()
                        : (Status_ == 5)
                            ? const Accessrights()
                            : (Status_ == 6)
                                ? const EditwebScreen()
                                : (Status_ == 7)
                                    ? const HandHeld() // USerInformation()
                                    : (Status_ == 8)
                                        ? const WebUser() // WebViewXPage()
                                        : (Status_ == 9)
                                            ? open_set == 1
                                                ? EditZoneAmt()
                                                : Center(
                                                    child:
                                                        Text('Coming soon...'),
                                                  )
                                            : AdvanceSetting()
      ],
    );
  }
}

class AppScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
