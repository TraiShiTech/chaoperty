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
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Account/Account_Screen.dart';
import '../ChaoArea/ChaoArea_Screen.dart';
import '../Constant/Myconstant.dart';
import '../Home/Home_Screen.dart';
import '../INSERT_Log/Insert_log.dart';
import '../Manage/Manage_Screen.dart';
import '../Model/Count_area_model.dart';
import '../Model/GC_package_model.dart';
import '../Model/GetArea_Model.dart';
import '../Model/GetRenTal_Model.dart';
import '../Model/GetUser_Model.dart';
import '../Model/GetZone_Model.dart';
import '../PeopleChao/PeopleChao_Screen.dart';
import '../Report/Report_Screen.dart';
import '../Responsive/responsive.dart';
import '../Style/colors.dart';
import 'Access_Rights.dart';
import 'Bill_Document.dart';
import 'OtherScreen.dart';
import 'Payment.dart';
import 'Rental.dart';
import 'User_Information.dart';
import 'package:http/http.dart' as http;
import 'dart:html' as html;

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  var nFormat = NumberFormat("#,##0.00", "en_US");
  DateTime datex = DateTime.now();
  int Status_ = 1;
  //------------------------------------------------------>
  int Status_MenuZone = 1;
  String name_Zone = 'ทั้งหมด';
  int Ser_Zone = 0;
  ///////---------------------------------------------------->
  String tappedIndex_ = '';
  final _formKey = GlobalKey<FormState>();
  ///////---------------------------------------------------->
  List<ZoneModel> zoneModels = [];
  List<AreaModel> areaModels = [];
  List<RenTalModel> renTalModels = [];
  List<PackageModel> packageModels = [];
  ///////---------------------------------------------------->
  List Status = [
    'พื้นที่',
    'การเช่า',
    'เอกสาร',
    'การรับชำระ',
    'สิทธิการเข้าถึง',
    // 'ข้อมูลผู้ใช้งาน',
    // 'อื่นๆ',
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

  String? renTal_user, renTal_name, zone_ser, zone_name;
  String? rtname, type, typex, renname, pkname, ser_Zonex;
  int? pkqty, pkuser, countarae;
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
      img_logo;
  @override
  void initState() {
    super.initState();
    read_GC_rental();
    checkPreferance();
    read_GC_package();
    read_GC_zone();
    read_GC_area();
    read_GC_area_count();
  }

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
      packageModels.clear();
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
      renTalModels.clear();
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
          setState(() {
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
    });
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
    } catch (e) {}
  }

  Future<Null> read_GC_area() async {
    var start = DateTime.now();
    if (areaModels.length != 0) {
      areaModels.clear();
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var ren = preferences.getString('renTalSer');

    String url = (name_Zone.toString().trim() == 'ทั้งหมด')
        ? '${MyConstant().domain}/GC_areaAll.php?isAdd=true&ren=$ren'
        : '${MyConstant().domain}/GC_area.php?isAdd=true&ren=$ren&zone=$Ser_Zone';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);
      if (result != null) {
        for (var map in result) {
          AreaModel areaModel = AreaModel.fromJson(map);
          setState(() {
            areaModels.add(areaModel);
          });
        }
      } else {}
      setState(() {
        // _areaModels = areaModels;
        zone_ser = preferences.getString('zoneSer');
        zone_name = preferences.getString('zonesName');
      });
    } catch (e) {}
  }

  _searchBar() {
    return TextField(
      autofocus: false,
      keyboardType: TextInputType.text,
      style: const TextStyle(fontSize: 22.0, color: Colors.white),
      decoration: InputDecoration(
        filled: true,
        // fillColor: Colors.white,
        hintText: ' Search...',
        hintStyle: const TextStyle(fontSize: 20.0, color: Colors.white),
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
        setState(() {
          // serODMOdelss = serODMOdel.where((serODMOdels) {
          //   var notTitle = serODMOdels.email.toLowerCase();
          //   return notTitle.contains(text);
          // }).toList();

          // }
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
    // InsertFile_SQL(fileName, MixPath_);
    // Open the file picker and get the selected file
    final input = html.FileUploadInputElement();
    // input..accept = 'application/pdf';
    input.accept = 'image/jpeg,image/png,image/jpg';
    input.click();
    // deletedFile_('IDcard_LE000001_25-02-2023.pdf');
    await input.onChange.first;

    final file = input.files!.first;
    final reader = html.FileReader();
    reader.readAsArrayBuffer(file);
    await reader.onLoadEnd.first;
    String fileName_ = file.name;
    String extension = fileName_.split('.').last;
    print('File name: $fileName_');
    print('Extension: $extension');
    setState(() {
      base64_Imgmap = base64Encode(reader.result as Uint8List);
    });
    // print(base64_Imgmap);
    setState(() {
      extension_ = extension;
      file_ = file;
    });
    OKuploadFile_Imgmap(Path_, Zone_, Ser_);
  }

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
      // InsertFile_SQL(fileName, MixPath_, formattedTime1);
      // Create a new FormData object and add the file to it
      final formData = html.FormData();
      formData.appendBlob('file', file_, fileName);
      // Send the request
      final request = html.HttpRequest();
      request.open('POST',
          '${MyConstant().domain}/File_uploadSlip.php?name=$fileName&Foder=$foder&Pathfoder=$Path_foder');
      request.send(formData);

      print(formData);

      // Handle the response
      await request.onLoad.first;

      if (request.status == 200) {
        print('File uploaded successfully!');
        UpImg(context, fileName, Path_, Ser_);
        // try {
        //   UpImg(context, fileName, Path_, Ser_);
        // } catch (e) {
        //   print(e);
        // }
      } else {
        print('File upload failed with status code: ${request.status}');
      }
    } else {
      print('ยังไม่ได้เลือกรูปภาพ');
    }
  }

  double _scaleFactor = 1.0; // define the initial scale factor

  // void _zoomIn() {
  //   setState(() {
  //     _scaleFactor *= 1.2; // increase the scale factor by 20%
  //   });
  // }

  // void _zoomOut() {
  //   setState(() {
  //     _scaleFactor /= 1.2; // decrease the scale factor by 20%
  //   });
  // }

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
                child: const Center(
                  child: Text(
                    'ปิด',
                    style: TextStyle(
                      // fontSize: 15,
                      color: Colors.white,
                      fontFamily: Font_.Fonts_T,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
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
      child: Column(
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
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 8, 2, 0),
                child: Container(
                  width: 100,
                  decoration: BoxDecoration(
                    color: AppbackgroundColor.TiTile_Colors,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      AutoSizeText(
                        'ตั้งค่า',
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
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
            child: Container(
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
              child: Row(
                children: [
                  Expanded(
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
                            child: Row(children: [
                              for (int i = 0; i < Status.length; i++)
                                Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          Status_ = i + 1;
                                        });
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: (i + 1 == 1)
                                              ? Colors.green
                                              : (i + 1 == 2)
                                                  ? Colors.red
                                                  : (i + 1 == 3)
                                                      ? Colors.blue
                                                      : (i + 1 == 4)
                                                          ? Colors
                                                              .deepPurple[300]
                                                          : (i + 1 == 5)
                                                              ? Colors.orange
                                                              : (i + 1 == 6)
                                                                  ? Colors.pink
                                                                  : Colors.teal,
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10),
                                              bottomLeft: Radius.circular(10),
                                              bottomRight: Radius.circular(10)),
                                          border: (Status_ == i + 1)
                                              ? Border.all(
                                                  color: Colors.white, width: 1)
                                              : null,
                                        ),
                                        padding: const EdgeInsets.all(8.0),
                                        child: Center(
                                          child: Text(
                                            Status[i],
                                            style: TextStyle(
                                                color: (Status_ == i + 1)
                                                    ? Colors.white
                                                    : Colors.black,
                                                fontFamily:
                                                    FontWeight_.Fonts_T),
                                          ),
                                        ),
                                      ),
                                    )),
                            ])),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          Status_ = 6;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blueGrey,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
                          border: (Status_ == 6)
                              ? Border.all(color: Colors.white, width: 1)
                              : null,
                        ),
                        padding: const EdgeInsets.all(8.0),
                        width: 120,
                        // height: 30,
                        child: Center(
                          child: Text(
                            'ข้อมูลผู้ใช้งาน',
                            style: TextStyle(
                                color: (Status_ == 6)
                                    ? Colors.white
                                    : Colors.black,
                                fontFamily: FontWeight_.Fonts_T),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          (!Responsive.isDesktop(context)) ? BodyHome_mobile() : BodyHome_Web()
        ],
      ),
    );
  }

  Widget BodyHome_Web() {
    return Column(
      children: [
        (Status_ == 1)
            ? Status1_Web()
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
                                : Status7_Web()
      ],
    );
  }

  Widget Status1_Web() {
    double Width_ = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.white30,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(0),
                  topRight: Radius.circular(0),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
              // border: Border.all(color: Colors.white, width: 1),
            ),
            child: Column(
              children: [
                if (!Responsive.isDesktop(context))
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: 300,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text('แผนผัง',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 15,
                                  color: SettingScreen_Color.Colors_Text2_,
                                  fontFamily: Font_.Fonts_T
                                  // fontWeight: FontWeight.bold,
                                  )),
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
                            height: 100,
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
                                    fit: BoxFit.fill,
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
                                child: const Center(
                                  child: Text('ดูรูปแผนผัง',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: false,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          fontSize: 15,
                                          color:
                                              SettingScreen_Color.Colors_Text2_,
                                          fontFamily: Font_.Fonts_T
                                          // fontWeight: FontWeight.bold,
                                          )),
                                ),
                              ),
                              onTap: () {
                                if (img_ == null || img_.toString() == '') {
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
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10),
                                              bottomLeft: Radius.circular(10),
                                              bottomRight: Radius.circular(10)),
                                        ),
                                        padding: const EdgeInsets.all(8.0),
                                        child: const Text('1.ลักษณะพื้นที่เช่า',
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                            softWrap: false,
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: SettingScreen_Color
                                                    .Colors_Text2_,
                                                fontFamily: Font_.Fonts_T
                                                // fontWeight: FontWeight.bold,
                                                )),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SizedBox(
                                          width: 150,
                                          child: Column(
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.brown[100],
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
                                                ),
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Center(
                                                  child: Text('$typex',
                                                      maxLines: 3,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      softWrap: false,
                                                      style: const TextStyle(
                                                          fontSize: 15,
                                                          color:
                                                              SettingScreen_Color
                                                                  .Colors_Text2_,
                                                          fontFamily:
                                                              Font_.Fonts_T
                                                          // fontWeight: FontWeight.bold,
                                                          )),
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
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10),
                                              bottomLeft: Radius.circular(10),
                                              bottomRight: Radius.circular(10)),
                                        ),
                                        padding: const EdgeInsets.all(8.0),
                                        child: const Text('2.การคิดค่าเช่า',
                                            maxLines: 3,
                                            textAlign: TextAlign.start,
                                            overflow: TextOverflow.ellipsis,
                                            softWrap: false,
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: SettingScreen_Color
                                                    .Colors_Text2_,
                                                fontFamily: Font_.Fonts_T
                                                // fontWeight: FontWeight.bold,
                                                )),
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
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          // width: 150,
                                          decoration: BoxDecoration(
                                            color: Colors.brown[100],
                                            borderRadius: const BorderRadius
                                                    .only(
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(10),
                                                bottomLeft: Radius.circular(10),
                                                bottomRight:
                                                    Radius.circular(10)),
                                          ),
                                          padding: const EdgeInsets.all(8.0),
                                          child: Center(
                                            child: Text('$rtname',
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                                softWrap: false,
                                                style: const TextStyle(
                                                    fontSize: 15,
                                                    color: SettingScreen_Color
                                                        .Colors_Text2_,
                                                    fontFamily: Font_.Fonts_T
                                                    // fontWeight: FontWeight.bold,
                                                    )),
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
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10),
                                              bottomLeft: Radius.circular(10),
                                              bottomRight: Radius.circular(10)),
                                        ),
                                        padding: const EdgeInsets.all(8.0),
                                        child: const Text('3.การใช้งาน',
                                            textAlign: TextAlign.start,
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                            softWrap: false,
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: SettingScreen_Color
                                                    .Colors_Text2_,
                                                fontFamily: Font_.Fonts_T
                                                // fontWeight: FontWeight.bold,
                                                )),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          // width: 200,
                                          decoration: BoxDecoration(
                                            color: Colors.brown[100],
                                            borderRadius: const BorderRadius
                                                    .only(
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(10),
                                                bottomLeft: Radius.circular(10),
                                                bottomRight:
                                                    Radius.circular(10)),
                                          ),
                                          padding: const EdgeInsets.all(8.0),
                                          child: Center(
                                            child: Text('$type',
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                                softWrap: false,
                                                style: const TextStyle(
                                                    fontSize: 15,
                                                    color: SettingScreen_Color
                                                        .Colors_Text2_,
                                                    fontFamily: Font_.Fonts_T
                                                    // fontWeight: FontWeight.bold,
                                                    )),
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
                                  color: Colors.brown[100],
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10)),
                                ),
                                padding: const EdgeInsets.all(8.0),
                                child: (img_ == null || img_.toString() == '')
                                    ? SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
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
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10)),
                                    ),
                                    padding: const EdgeInsets.all(4.0),
                                    child: const Center(
                                      child: Text('ดูรูปแผนผัง',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: false,
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: SettingScreen_Color
                                                  .Colors_Text2_,
                                              fontFamily: Font_.Fonts_T
                                              // fontWeight: FontWeight.bold,
                                              )),
                                    ),
                                  ),
                                  onTap: () {
                                    if (img_ == null || img_.toString() == '') {
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
                    child: Row(
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
                            child: const Text('4.ชื่อสถานที่',
                                textAlign: TextAlign.start,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                softWrap: false,
                                style: TextStyle(
                                    fontSize: 15,
                                    color: SettingScreen_Color.Colors_Text2_,
                                    fontFamily: Font_.Fonts_T
                                    // fontWeight: FontWeight.bold,
                                    )),
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
                                      onFieldSubmitted: (value) async {
                                        SharedPreferences preferences =
                                            await SharedPreferences
                                                .getInstance();
                                        String? ren =
                                            preferences.getString('renTalSer');
                                        String? ser_user =
                                            preferences.getString('ser');

                                        String url =
                                            '${MyConstant().domain}/UpC_rentel_pn.php?isAdd=true&ren=$ren&value=$value&ser_user=$ser_user';

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
                                        focusedBorder: const OutlineInputBorder(
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
                                        enabledBorder: const OutlineInputBorder(
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
                                child: const Center(
                                  child: Text('เพิ่มรูป',
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: false,
                                      style: TextStyle(
                                          fontSize: 15,
                                          color:
                                              SettingScreen_Color.Colors_Text3_,
                                          fontFamily: Font_.Fonts_T
                                          // fontWeight: FontWeight.bold,
                                          )),
                                ),
                                itemBuilder: (BuildContext context) => [
                                  PopupMenuItem(
                                    child: InkWell(
                                        onTap: () async {
                                          if (img_logo == null ||
                                              img_logo.toString() == '') {
                                            uploadFile_Imgmap('logo', '', '');
                                          } else {
                                            showDialog<void>(
                                              context: context,
                                              barrierDismissible:
                                                  false, // user must tap button!
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  shape:
                                                      const RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius.circular(
                                                                      10.0))),
                                                  title: const Center(
                                                      child: Text(
                                                    'มีรูปโลโก้อยู่แล้ว',
                                                    style: TextStyle(
                                                        color:
                                                            SettingScreen_Color
                                                                .Colors_Text1_,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily: FontWeight_
                                                            .Fonts_T),
                                                  )),
                                                  content:
                                                      SingleChildScrollView(
                                                    child: ListBody(
                                                      children: const <Widget>[
                                                        Text(
                                                          'มีรูปโลโก้ หากต้องการอัพโหลดกรุณาลบรูปโลโก้ที่มีอยู่แล้วก่อน',
                                                          style: TextStyle(
                                                              color: SettingScreen_Color
                                                                  .Colors_Text2_,
                                                              fontFamily: Font_
                                                                  .Fonts_T),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  actions: <Widget>[
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: InkWell(
                                                            child: Container(
                                                                width: 50,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .red[600],
                                                                  borderRadius: const BorderRadius
                                                                          .only(
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
                                                                  // border: Border.all(color: Colors.white, width: 1),
                                                                ),
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child:
                                                                    const Center(
                                                                        child:
                                                                            Text(
                                                                  'ลบรูป',
                                                                  style: TextStyle(
                                                                      color: SettingScreen_Color
                                                                          .Colors_Text3_,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontFamily:
                                                                          Font_
                                                                              .Fonts_T),
                                                                ))),
                                                            onTap: () async {
                                                              String url =
                                                                  await '${MyConstant().domain}/files/$foder/logo/$img_logo';
                                                              deletedFile_(
                                                                  'logo',
                                                                  '$img_logo',
                                                                  '');
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          child: Row(
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: InkWell(
                                                                  child: Container(
                                                                      width: 50,
                                                                      decoration: BoxDecoration(
                                                                        color: Colors
                                                                            .green[600],
                                                                        borderRadius: const BorderRadius.only(
                                                                            topLeft:
                                                                                Radius.circular(10),
                                                                            topRight: Radius.circular(10),
                                                                            bottomLeft: Radius.circular(10),
                                                                            bottomRight: Radius.circular(10)),
                                                                        // border: Border.all(color: Colors.white, width: 1),
                                                                      ),
                                                                      padding: const EdgeInsets.all(8.0),
                                                                      child: const Center(
                                                                          child: Text(
                                                                        'ดูรูป',
                                                                        style: TextStyle(
                                                                            color:
                                                                                SettingScreen_Color.Colors_Text3_,
                                                                            fontWeight: FontWeight.bold,
                                                                            fontFamily: Font_.Fonts_T),
                                                                      ))),
                                                                  onTap:
                                                                      () async {
                                                                    String url =
                                                                        await '${MyConstant().domain}/files/$foder/logo/$img_logo';
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();

                                                                    _showMyDialogImg(
                                                                        url,
                                                                        'รูปโลโก้');
                                                                  },
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: InkWell(
                                                                  child: Container(
                                                                      width: 50,
                                                                      decoration: const BoxDecoration(
                                                                        color: Colors
                                                                            .black,
                                                                        borderRadius: BorderRadius.only(
                                                                            topLeft:
                                                                                Radius.circular(10),
                                                                            topRight: Radius.circular(10),
                                                                            bottomLeft: Radius.circular(10),
                                                                            bottomRight: Radius.circular(10)),
                                                                        // border: Border.all(color: Colors.white, width: 1),
                                                                      ),
                                                                      padding: const EdgeInsets.all(8.0),
                                                                      child: const Center(
                                                                          child: Text(
                                                                        'ปิด',
                                                                        style: TextStyle(
                                                                            color:
                                                                                SettingScreen_Color.Colors_Text3_,
                                                                            fontWeight: FontWeight.bold,
                                                                            fontFamily: Font_.Fonts_T),
                                                                      ))),
                                                                  onTap: () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  },
                                                                ),
                                                              ),
                                                            ],
                                                          ),
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
                                            padding: const EdgeInsets.all(10),
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: Row(
                                              children: [
                                                (img_logo == null ||
                                                        img_logo.toString() ==
                                                            '')
                                                    ? const Icon(
                                                        Icons.cancel,
                                                        color: Colors.red,
                                                      )
                                                    : const Icon(
                                                        Icons.check,
                                                        color: Colors.green,
                                                      ),
                                                Text(
                                                  ' รูปโลโก้',
                                                  style: TextStyle(
                                                      color: SettingScreen_Color
                                                          .Colors_Text1_,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily:
                                                          FontWeight_.Fonts_T),
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
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  shape:
                                                      const RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius.circular(
                                                                      10.0))),
                                                  title: const Center(
                                                      child: Text(
                                                    'มีรูปแผนผังอยู่แล้ว',
                                                    style: TextStyle(
                                                        color:
                                                            SettingScreen_Color
                                                                .Colors_Text1_,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily: FontWeight_
                                                            .Fonts_T),
                                                  )),
                                                  content:
                                                      SingleChildScrollView(
                                                    child: ListBody(
                                                      children: const <Widget>[
                                                        Text(
                                                          'มีรูปแผนผัง หากต้องการอัพโหลดกรุณาลบรูปแผนผังที่มีอยู่แล้วก่อน',
                                                          style: TextStyle(
                                                              color: SettingScreen_Color
                                                                  .Colors_Text2_,
                                                              fontFamily: Font_
                                                                  .Fonts_T),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  actions: <Widget>[
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: InkWell(
                                                            child: Container(
                                                                width: 50,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .red[600],
                                                                  borderRadius: const BorderRadius
                                                                          .only(
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
                                                                  // border: Border.all(color: Colors.white, width: 1),
                                                                ),
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child:
                                                                    const Center(
                                                                        child:
                                                                            Text(
                                                                  'ลบรูป',
                                                                  style: TextStyle(
                                                                      color: SettingScreen_Color
                                                                          .Colors_Text3_,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontFamily:
                                                                          Font_
                                                                              .Fonts_T),
                                                                ))),
                                                            onTap: () async {
                                                              String url =
                                                                  await '${MyConstant().domain}/files/$foder/contract/$img_';
                                                              deletedFile_(
                                                                  'contract',
                                                                  '',
                                                                  '');
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          child: Row(
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: InkWell(
                                                                  child: Container(
                                                                      width: 50,
                                                                      decoration: BoxDecoration(
                                                                        color: Colors
                                                                            .green[600],
                                                                        borderRadius: const BorderRadius.only(
                                                                            topLeft:
                                                                                Radius.circular(10),
                                                                            topRight: Radius.circular(10),
                                                                            bottomLeft: Radius.circular(10),
                                                                            bottomRight: Radius.circular(10)),
                                                                        // border: Border.all(color: Colors.white, width: 1),
                                                                      ),
                                                                      padding: const EdgeInsets.all(8.0),
                                                                      child: const Center(
                                                                          child: Text(
                                                                        'ดูรูป',
                                                                        style: TextStyle(
                                                                            color:
                                                                                SettingScreen_Color.Colors_Text3_,
                                                                            fontWeight: FontWeight.bold,
                                                                            fontFamily: Font_.Fonts_T),
                                                                      ))),
                                                                  onTap:
                                                                      () async {
                                                                    String url =
                                                                        await '${MyConstant().domain}/files/$foder/contract/$img_';
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();

                                                                    _showMyDialogImg(
                                                                        url,
                                                                        'รูปแผนผัง');
                                                                  },
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: InkWell(
                                                                  child: Container(
                                                                      width: 50,
                                                                      decoration: const BoxDecoration(
                                                                        color: Colors
                                                                            .black,
                                                                        borderRadius: BorderRadius.only(
                                                                            topLeft:
                                                                                Radius.circular(10),
                                                                            topRight: Radius.circular(10),
                                                                            bottomLeft: Radius.circular(10),
                                                                            bottomRight: Radius.circular(10)),
                                                                        // border: Border.all(color: Colors.white, width: 1),
                                                                      ),
                                                                      padding: const EdgeInsets.all(8.0),
                                                                      child: const Center(
                                                                          child: Text(
                                                                        'ปิด',
                                                                        style: TextStyle(
                                                                            color:
                                                                                SettingScreen_Color.Colors_Text3_,
                                                                            fontWeight: FontWeight.bold,
                                                                            fontFamily: Font_.Fonts_T),
                                                                      ))),
                                                                  onTap: () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  },
                                                                ),
                                                              ),
                                                            ],
                                                          ),
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
                                            padding: const EdgeInsets.all(10),
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: Row(
                                              children: [
                                                (img_ == null ||
                                                        img_.toString() == '')
                                                    ? const Icon(
                                                        Icons.cancel,
                                                        color: Colors.red,
                                                      )
                                                    : const Icon(
                                                        Icons.check,
                                                        color: Colors.green,
                                                      ),
                                                Text(
                                                  ' รูปแผนผัง',
                                                  style: TextStyle(
                                                      color: SettingScreen_Color
                                                          .Colors_Text1_,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily:
                                                          FontWeight_.Fonts_T),
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
                                            padding: const EdgeInsets.all(10),
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: Row(
                                              children: [
                                                (zoneModels[index].img ==
                                                            null ||
                                                        zoneModels[index]
                                                                .img
                                                                .toString() ==
                                                            '')
                                                    ? const Icon(
                                                        Icons.cancel,
                                                        color: Colors.red,
                                                      )
                                                    : const Icon(
                                                        Icons.check,
                                                        color: Colors.green,
                                                      ),
                                                Text(
                                                  ' รูปโซนพื้นที่(${zoneModels[index].zn})',
                                                  style: const TextStyle(
                                                      color: SettingScreen_Color
                                                          .Colors_Text1_,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily:
                                                          FontWeight_.Fonts_T),
                                                ),
                                              ],
                                            )),
                                        onTap: () async {
                                          if (zoneModels[index].img == null ||
                                              zoneModels[index]
                                                      .img
                                                      .toString() ==
                                                  '') {
                                            uploadFile_Imgmap(
                                                'zone',
                                                '${zoneModels[index].zn}',
                                                '${zoneModels[index].ser}');
                                            print('${zoneModels[index].ser}');
                                          } else {
                                            showDialog<void>(
                                              context: context,
                                              barrierDismissible:
                                                  false, // user must tap button!
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  shape:
                                                      const RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius.circular(
                                                                      10.0))),
                                                  title: Center(
                                                      child: Text(
                                                    'มีรูป(${zoneModels[index].zn})อยู่แล้ว',
                                                    style: TextStyle(
                                                        color:
                                                            SettingScreen_Color
                                                                .Colors_Text1_,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily: FontWeight_
                                                            .Fonts_T),
                                                  )),
                                                  content:
                                                      SingleChildScrollView(
                                                    child: ListBody(
                                                      children: <Widget>[
                                                        Text(
                                                          'มีรูป(${zoneModels[index].zn})อยู่แล้ว หากต้องการอัพโหลดกรุณาลบรูปที่มีอยู่แล้วก่อน',
                                                          style: TextStyle(
                                                              color: SettingScreen_Color
                                                                  .Colors_Text2_,
                                                              fontFamily: Font_
                                                                  .Fonts_T),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  actions: <Widget>[
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: InkWell(
                                                            child: Container(
                                                                width: 50,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .red[600],
                                                                  borderRadius: const BorderRadius
                                                                          .only(
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
                                                                  // border: Border.all(color: Colors.white, width: 1),
                                                                ),
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child:
                                                                    const Center(
                                                                        child:
                                                                            Text(
                                                                  'ลบรูป',
                                                                  style: TextStyle(
                                                                      color: SettingScreen_Color
                                                                          .Colors_Text3_,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontFamily:
                                                                          Font_
                                                                              .Fonts_T),
                                                                ))),
                                                            onTap: () async {
                                                              deletedFile_(
                                                                  'zone',
                                                                  '${zoneModels[index].img}',
                                                                  '${zoneModels[index].ser}');
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          child: Row(
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: InkWell(
                                                                  child: Container(
                                                                      width: 50,
                                                                      decoration: BoxDecoration(
                                                                        color: Colors
                                                                            .green[600],
                                                                        borderRadius: const BorderRadius.only(
                                                                            topLeft:
                                                                                Radius.circular(10),
                                                                            topRight: Radius.circular(10),
                                                                            bottomLeft: Radius.circular(10),
                                                                            bottomRight: Radius.circular(10)),
                                                                        // border: Border.all(color: Colors.white, width: 1),
                                                                      ),
                                                                      padding: const EdgeInsets.all(8.0),
                                                                      child: const Center(
                                                                          child: Text(
                                                                        'ดูรูป',
                                                                        style: TextStyle(
                                                                            color:
                                                                                SettingScreen_Color.Colors_Text3_,
                                                                            fontWeight: FontWeight.bold,
                                                                            fontFamily: Font_.Fonts_T),
                                                                      ))),
                                                                  onTap:
                                                                      () async {
                                                                    String url =
                                                                        await '${MyConstant().domain}/files/$foder/zone/${zoneModels[index].img}';
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();

                                                                    _showMyDialogImg(
                                                                        url,
                                                                        'รูปโซน(${zoneModels[index].zn})');
                                                                  },
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: InkWell(
                                                                  child: Container(
                                                                      width: 50,
                                                                      decoration: const BoxDecoration(
                                                                        color: Colors
                                                                            .black,
                                                                        borderRadius: BorderRadius.only(
                                                                            topLeft:
                                                                                Radius.circular(10),
                                                                            topRight: Radius.circular(10),
                                                                            bottomLeft: Radius.circular(10),
                                                                            bottomRight: Radius.circular(10)),
                                                                        // border: Border.all(color: Colors.white, width: 1),
                                                                      ),
                                                                      padding: const EdgeInsets.all(8.0),
                                                                      child: const Center(
                                                                          child: Text(
                                                                        'ปิด',
                                                                        style: TextStyle(
                                                                            color:
                                                                                SettingScreen_Color.Colors_Text3_,
                                                                            fontWeight: FontWeight.bold,
                                                                            fontFamily: Font_.Fonts_T),
                                                                      ))),
                                                                  onTap: () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  },
                                                                ),
                                                              ),
                                                            ],
                                                          ),
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
                        SizedBox(
                          width: (!Responsive.isDesktop(context))
                              ? MediaQuery.of(context).size.width * 0.5
                              : MediaQuery.of(context).size.width * 0.22,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              AutoSizeText(
                                minFontSize: 10,
                                maxFontSize: 18,
                                'Package $pkname : $pkqty ล็อค/แผง \n จำนวน $pkuser สิทธิผู้ใช้งาน',
                                textAlign: TextAlign.end,
                                style: const TextStyle(
                                    color: SettingScreen_Color.Colors_Text1_,
                                    fontFamily: Font_.Fonts_T),
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
                              child: const Text('ซื้อ Package',
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: false,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: SettingScreen_Color.Colors_Text3_,
                                      fontFamily: Font_.Fonts_T)),
                            ),
                            onTap: () {
                              showDialog<String>(
                                barrierDismissible: false,
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20.0))),
                                  title: Row(
                                    children: [
                                      const Expanded(child: SizedBox()),
                                      const Expanded(
                                        child: Center(
                                            child: Text(
                                          'Package',
                                          style: TextStyle(
                                            color: SettingScreen_Color
                                                .Colors_Text1_,
                                            fontFamily: FontWeight_.Fonts_T,
                                            fontWeight: FontWeight.bold,
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
                                                padding: EdgeInsets.all(8.0),
                                                child: Icon(Icons.highlight_off,
                                                    size: 35,
                                                    color: Colors.black),
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
                                      width: MediaQuery.of(context).size.width /
                                          1.2,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              2,
                                      decoration: const BoxDecoration(
                                        // color: Colors.grey[300],
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10)),
                                        // border: Border.all(color: Colors.white, width: 1),
                                      ),
                                      child: ScrollConfiguration(
                                        behavior: AppScrollBehavior(),
                                        child: GridView.builder(
                                          gridDelegate:
                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                            mainAxisSpacing: 2.0,
                                            crossAxisSpacing: 2.0,
                                            crossAxisCount: 1,
                                            childAspectRatio: 2,
                                          ),
                                          physics: const BouncingScrollPhysics(
                                              parent:
                                                  AlwaysScrollableScrollPhysics()),
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          itemCount: packageModels.length,
                                          itemBuilder: (context, index) {
                                            return Container(
                                              width: 50,
                                              decoration: const BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(30),
                                                    topRight:
                                                        Radius.circular(30),
                                                    bottomLeft:
                                                        Radius.circular(20),
                                                    bottomRight:
                                                        Radius.circular(20)),
                                                // border: Border.all(color: Colors.white, width: 1),
                                              ),
                                              child: Card(
                                                shape:
                                                    const RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topLeft: Radius
                                                              .circular(30),
                                                          topRight:
                                                              Radius.circular(
                                                                  30),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  20),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  20)),
                                                ),
                                                child: SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.5,
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        // width: MediaQuery.of(
                                                        //         context)
                                                        //     .size
                                                        //     .width,
                                                        // height: MediaQuery.of(
                                                        //             context)
                                                        //         .size
                                                        //         .width *
                                                        //     0.05,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors
                                                              .lime.shade400,
                                                          borderRadius: const BorderRadius
                                                                  .only(
                                                              topLeft: Radius
                                                                  .circular(30),
                                                              topRight: Radius
                                                                  .circular(30),
                                                              bottomLeft: Radius
                                                                  .circular(0),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          0)),
                                                          // border: Border.all(color: Colors.white, width: 1),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  AutoSizeText(
                                                                    minFontSize:
                                                                        20,
                                                                    maxFontSize:
                                                                        30,
                                                                    'Package ${packageModels[index].pk}',
                                                                    style: const TextStyle(
                                                                        color: PeopleChaoScreen_Color
                                                                            .Colors_Text1_,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        fontFamily:
                                                                            FontWeight_.Fonts_T),
                                                                  ),
                                                                ],
                                                              ),
                                                              const SizedBox(
                                                                height: 5,
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  AutoSizeText(
                                                                    minFontSize:
                                                                        10,
                                                                    maxFontSize:
                                                                        12,
                                                                    'จัดการสูงสุด ${packageModels[index].qty} ล็อค/แผงเช่า',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .grey
                                                                            .shade700,
                                                                        fontFamily:
                                                                            Font_.Fonts_T),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          AutoSizeText(
                                                            minFontSize: 10,
                                                            maxFontSize: 12,
                                                            'จากปกติ ราคาเดือนละ ${nFormat.format(double.parse(packageModels[index].rpri!))}.-',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .red
                                                                    .shade900,
                                                                fontFamily: Font_
                                                                    .Fonts_T),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: const [
                                                          AutoSizeText(
                                                            minFontSize: 10,
                                                            maxFontSize: 12,
                                                            'ราคาพิเศษ',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontFamily: Font_
                                                                    .Fonts_T),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          AutoSizeText(
                                                            minFontSize: 30,
                                                            maxFontSize: 50,
                                                            '  ${nFormat.format(double.parse(packageModels[index].spri!))}.-',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .lime
                                                                    .shade700,
                                                                fontFamily:
                                                                    FontWeight_
                                                                        .Fonts_T),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: const [
                                                          AutoSizeText(
                                                            minFontSize: 10,
                                                            maxFontSize: 12,
                                                            'บาทต่อเดือน',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontFamily: Font_
                                                                    .Fonts_T),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          AutoSizeText(
                                                            minFontSize: 10,
                                                            maxFontSize: 12,
                                                            '(ชำระรายปียอด ${nFormat.format(double.parse(packageModels[index].spri!) * 12)} บาท)',
                                                            style: const TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontFamily: Font_
                                                                    .Fonts_T),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      Divider(
                                                        height: 2,
                                                        color: Colors
                                                            .grey.shade600,
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: const [
                                                          AutoSizeText(
                                                            minFontSize: 10,
                                                            maxFontSize: 12,
                                                            'รายละเอียด',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontFamily: Font_
                                                                    .Fonts_T),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 8,
                                                                right: 8),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            const Icon(
                                                              Icons.check,
                                                              size: 15,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                            const SizedBox(
                                                              width: 5,
                                                            ),
                                                            AutoSizeText(
                                                              minFontSize: 10,
                                                              maxFontSize: 12,
                                                              '${packageModels[index].user} สิทธิผู้ใช้งาน',
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontFamily: Font_
                                                                      .Fonts_T),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 8,
                                                                right: 8),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            const Icon(
                                                              Icons.check,
                                                              size: 15,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                            const SizedBox(
                                                              width: 5,
                                                            ),
                                                            AutoSizeText(
                                                              minFontSize: 10,
                                                              maxFontSize: 12,
                                                              'จัดการพื้นที่ได้มากสุด ${packageModels[index].qty} แผง',
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontFamily: Font_
                                                                      .Fonts_T),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 8,
                                                                right: 8),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: const [
                                                            Icon(
                                                              Icons.check,
                                                              size: 15,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                            SizedBox(
                                                              width: 5,
                                                            ),
                                                            AutoSizeText(
                                                              minFontSize: 10,
                                                              maxFontSize: 12,
                                                              'ไม่จำกัดจำนวนทะเบียนลูกค้า',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontFamily: Font_
                                                                      .Fonts_T),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 8,
                                                                right: 8),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: const [
                                                            Icon(
                                                              Icons.check,
                                                              size: 15,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                            SizedBox(
                                                              width: 5,
                                                            ),
                                                            AutoSizeText(
                                                              minFontSize: 10,
                                                              maxFontSize: 12,
                                                              'ไม่จำกัดใบเสนอราคา',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontFamily: Font_
                                                                      .Fonts_T),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 8,
                                                                right: 8),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: const [
                                                            Icon(
                                                              Icons.check,
                                                              size: 15,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                            SizedBox(
                                                              width: 5,
                                                            ),
                                                            AutoSizeText(
                                                              minFontSize: 10,
                                                              maxFontSize: 12,
                                                              'ตั้งค่าพื้นที่',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontFamily: Font_
                                                                      .Fonts_T),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 8,
                                                                right: 8),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: const [
                                                            Icon(
                                                              Icons.check,
                                                              size: 15,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                            SizedBox(
                                                              width: 5,
                                                            ),
                                                            AutoSizeText(
                                                              minFontSize: 10,
                                                              maxFontSize: 12,
                                                              'ตั้งค่าประเภทค่าบริการ',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontFamily: Font_
                                                                      .Fonts_T),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 8,
                                                                right: 8),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: const [
                                                            Icon(
                                                              Icons.check,
                                                              size: 15,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                            SizedBox(
                                                              width: 5,
                                                            ),
                                                            AutoSizeText(
                                                              minFontSize: 10,
                                                              maxFontSize: 12,
                                                              'เรียกดูพื้นที่ว่างแบบ real time',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontFamily: Font_
                                                                      .Fonts_T),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 8,
                                                                right: 8),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: const [
                                                            Icon(
                                                              Icons.check,
                                                              size: 15,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                            SizedBox(
                                                              width: 5,
                                                            ),
                                                            AutoSizeText(
                                                              minFontSize: 10,
                                                              maxFontSize: 12,
                                                              'ทำสัญญา',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontFamily: Font_
                                                                      .Fonts_T),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 8,
                                                                right: 8),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: const [
                                                            Icon(
                                                              Icons.check,
                                                              size: 15,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                            SizedBox(
                                                              width: 5,
                                                            ),
                                                            AutoSizeText(
                                                              minFontSize: 10,
                                                              maxFontSize: 12,
                                                              'ตั้งหนี้ล่วงหน้า',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontFamily: Font_
                                                                      .Fonts_T),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 8,
                                                                right: 8),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: const [
                                                            Icon(
                                                              Icons.check,
                                                              size: 15,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                            SizedBox(
                                                              width: 5,
                                                            ),
                                                            AutoSizeText(
                                                              minFontSize: 10,
                                                              maxFontSize: 12,
                                                              'วางบิล',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontFamily: Font_
                                                                      .Fonts_T),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 8,
                                                                right: 8),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: const [
                                                            Icon(
                                                              Icons.check,
                                                              size: 15,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                            SizedBox(
                                                              width: 5,
                                                            ),
                                                            AutoSizeText(
                                                              minFontSize: 10,
                                                              maxFontSize: 12,
                                                              'รับชำระ พร้อม ออกบิล',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontFamily: Font_
                                                                      .Fonts_T),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 8,
                                                                right: 8),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: const [
                                                            Icon(
                                                              Icons.check,
                                                              size: 15,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                            SizedBox(
                                                              width: 5,
                                                            ),
                                                            AutoSizeText(
                                                              minFontSize: 10,
                                                              maxFontSize: 12,
                                                              'ประวัติการรับชำระ',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontFamily: Font_
                                                                      .Fonts_T),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 8,
                                                                right: 8),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: const [
                                                            Icon(
                                                              Icons.check,
                                                              size: 15,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                            SizedBox(
                                                              width: 5,
                                                            ),
                                                            AutoSizeText(
                                                              minFontSize: 10,
                                                              maxFontSize: 12,
                                                              'รายงานสรุป',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontFamily: Font_
                                                                      .Fonts_T),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 8,
                                                                right: 8),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: const [
                                                            Icon(
                                                              Icons.check,
                                                              size: 15,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                            SizedBox(
                                                              width: 5,
                                                            ),
                                                            AutoSizeText(
                                                              minFontSize: 10,
                                                              maxFontSize: 12,
                                                              'online training',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontFamily: Font_
                                                                      .Fonts_T),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 8,
                                                                right: 8),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Icon(
                                                              Icons.close,
                                                              size: 15,
                                                              color: Colors.grey
                                                                  .shade700,
                                                            ),
                                                            const SizedBox(
                                                              width: 5,
                                                            ),
                                                            AutoSizeText(
                                                              minFontSize: 10,
                                                              maxFontSize: 12,
                                                              'ค่า migrate ข้อมูล',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .grey
                                                                      .shade700,
                                                                  fontFamily: Font_
                                                                      .Fonts_T),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 8,
                                                                right: 8),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Icon(
                                                              Icons.close,
                                                              size: 15,
                                                              color: Colors.grey
                                                                  .shade700,
                                                            ),
                                                            const SizedBox(
                                                              width: 5,
                                                            ),
                                                            AutoSizeText(
                                                              minFontSize: 10,
                                                              maxFontSize: 12,
                                                              'customise ระบบ',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .grey
                                                                      .shade700,
                                                                  fontFamily: Font_
                                                                      .Fonts_T),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 8,
                                                                right: 8),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Icon(
                                                              Icons.close,
                                                              size: 15,
                                                              color: Colors.grey
                                                                  .shade700,
                                                            ),
                                                            const SizedBox(
                                                              width: 5,
                                                            ),
                                                            AutoSizeText(
                                                              minFontSize: 10,
                                                              maxFontSize: 12,
                                                              'ค่า hardware & อุปกรณ์',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .grey
                                                                      .shade700,
                                                                  fontFamily: Font_
                                                                      .Fonts_T),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      const Divider(
                                                        height: 2,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Container(
                                                              width: 150,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: int.parse(packageModels[index]
                                                                            .qty!) <
                                                                        countarae!
                                                                    ? Colors
                                                                        .grey
                                                                        .shade300
                                                                    : Colors
                                                                        .purple
                                                                        .shade600,
                                                                borderRadius: const BorderRadius
                                                                        .only(
                                                                    topLeft:
                                                                        Radius.circular(
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
                                                              ),
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: TextButton(
                                                                onPressed:
                                                                    () async {
                                                                  if (int.parse(
                                                                          packageModels[index]
                                                                              .qty!) <
                                                                      countarae!) {
                                                                  } else {
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
                                                                    String?
                                                                        ser_pk =
                                                                        packageModels[index]
                                                                            .ser;

                                                                    String?
                                                                        Package =
                                                                        'Package ${packageModels[index].pk}';

                                                                    String url =
                                                                        '${MyConstant().domain}/UpC_rental_pk.php?isAdd=true&ren=$ren&ser_pk=$ser_pk&ser_user=$ser_user';

                                                                    try {
                                                                      var response =
                                                                          await http
                                                                              .get(Uri.parse(url));

                                                                      var result =
                                                                          json.decode(
                                                                              response.body);
                                                                      print(
                                                                          result);
                                                                      if (result
                                                                              .toString() ==
                                                                          'true') {
                                                                        Insert_log.Insert_logs(
                                                                            'ตั้งค่า',
                                                                            'พื้นที่>>ซื้อPackkage(${Package.toString()})');
                                                                        setState(
                                                                            () {
                                                                          read_GC_rental();
                                                                          read_GC_zone();
                                                                          read_GC_area();
                                                                        });
                                                                      } else {}
                                                                    } catch (e) {}
                                                                    setState(
                                                                        () {
                                                                      read_GC_rental();
                                                                      read_GC_zone();
                                                                      read_GC_area();
                                                                    });
                                                                    Navigator.pop(
                                                                        context);
                                                                  }
                                                                },
                                                                child:
                                                                    const Text(
                                                                  'เลือก',
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
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
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
                            child: const Text('+เพิ่มโซนพื้นที่',
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                softWrap: false,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 15,
                                    color: SettingScreen_Color.Colors_Text3_,
                                    fontFamily: Font_.Fonts_T)),
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
                                    width:
                                        MediaQuery.of(context).size.width / 1.5,
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
                                          Row(
                                            children: const [
                                              Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text(
                                                  'ชื่อโซน',
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    color: SettingScreen_Color
                                                        .Colors_Text1_,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T,
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
                                                            Radius.circular(15),
                                                        topLeft:
                                                            Radius.circular(15),
                                                        bottomRight:
                                                            Radius.circular(15),
                                                        bottomLeft:
                                                            Radius.circular(15),
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
                                                            Radius.circular(15),
                                                        topLeft:
                                                            Radius.circular(15),
                                                        bottomRight:
                                                            Radius.circular(15),
                                                        bottomLeft:
                                                            Radius.circular(15),
                                                      ),
                                                      borderSide: BorderSide(
                                                        width: 1,
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                                    labelText: 'ชื่อโซน',
                                                    labelStyle: const TextStyle(
                                                      color: Colors.black54,
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
                                        ],
                                      ),
                                    ),
                                  ),
                                  actions: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              width: 100,
                                              decoration: const BoxDecoration(
                                                color: Colors.green,
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
                                              child: TextButton(
                                                onPressed: () async {
                                                  if (_formKey.currentState!
                                                      .validate()) {
                                                    SharedPreferences
                                                        preferences =
                                                        await SharedPreferences
                                                            .getInstance();
                                                    String? ren = preferences
                                                        .getString('renTalSer');
                                                    String? ser_user =
                                                        preferences
                                                            .getString('ser');

                                                    var zonename =
                                                        zone_text.text;

                                                    String url =
                                                        '${MyConstant().domain}/InC_zone_setring.php?isAdd=true&ren=$ren&ser_user=$ser_user&zonename=$zonename';

                                                    try {
                                                      var response = await http
                                                          .get(Uri.parse(url));

                                                      var result = json.decode(
                                                          response.body);
                                                      print(result);
                                                      if (result.toString() ==
                                                          'true') {
                                                        Insert_log.Insert_logs(
                                                            'ตั้งค่า',
                                                            'พื้นที่>>เพิ่มโซนพื้นที่(${zone_text.text.toString()})');
                                                        setState(() {
                                                          zone_text.clear();
                                                          read_GC_zone();
                                                          read_GC_area();
                                                          read_GC_area_count();
                                                        });

                                                        Navigator.pop(
                                                            context, 'OK');
                                                      }
                                                    } catch (e) {
                                                      print(e);
                                                    }
                                                  }
                                                },
                                                child: const Text(
                                                  'บันทึก',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T,
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
                                              child: TextButton(
                                                onPressed: () => Navigator.pop(
                                                    context, 'OK'),
                                                child: const Text(
                                                  'ยกเลิก',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T,
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
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: AppbackgroundColor.TiTile_Colors,
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
                  behavior:
                      ScrollConfiguration.of(context).copyWith(dragDevices: {
                    PointerDeviceKind.touch,
                    PointerDeviceKind.mouse,
                  }),
                  child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            for (int index = 0;
                                index < zoneModels.length;
                                index++)
                              Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: () async {
                                      setState(() {
                                        Status_MenuZone = index + 1;
                                        name_Zone =
                                            zoneModels[index].zn.toString();
                                        Ser_Zone = index;
                                        ser_Zonex =
                                            zoneModels[index].ser.toString();
                                      });
                                      print(index);
                                      read_GC_area();
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.brown[400],
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10)),
                                        border: (Status_MenuZone == index + 1)
                                            ? Border.all(
                                                color: Colors.white, width: 1)
                                            : null,
                                      ),
                                      padding: const EdgeInsets.all(8.0),
                                      child: Center(
                                        child: Text(
                                          zoneModels[index].zn.toString(),
                                          style: TextStyle(
                                              color:
                                                  (Status_MenuZone == index + 1)
                                                      ? Colors.white
                                                      : Colors.black,
                                              fontFamily: FontWeight_.Fonts_T),
                                        ),
                                      ),
                                    ),
                                  )),
                            Ser_Zone == 0
                                ? const SizedBox()
                                : areaModels.length != 0
                                    ? const SizedBox()
                                    : Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: InkWell(
                                          onTap: () async {
                                            SharedPreferences preferences =
                                                await SharedPreferences
                                                    .getInstance();
                                            String? ren = preferences
                                                .getString('renTalSer');
                                            String? ser_user =
                                                preferences.getString('ser');

                                            var zonename = ser_Zonex;

                                            String url =
                                                '${MyConstant().domain}/DeC_Zone.php?isAdd=true&ren=$ren&ser_user=$ser_user&zonename=$zonename';

                                            try {
                                              var response = await http
                                                  .get(Uri.parse(url));

                                              var result =
                                                  json.decode(response.body);
                                              print(result);
                                              if (result.toString() == 'true') {
                                                setState(() {
                                                  read_GC_zone();
                                                  read_GC_area();
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
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.red,
                                              borderRadius:
                                                  const BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(10),
                                                      topRight:
                                                          Radius.circular(10),
                                                      bottomLeft:
                                                          Radius.circular(10),
                                                      bottomRight:
                                                          Radius.circular(10)),
                                              border: Border.all(
                                                  color: Colors.black,
                                                  width: 1),
                                            ),
                                            padding: const EdgeInsets.all(8.0),
                                            child: Center(
                                              child: Text(
                                                'ลบ $name_Zone',
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T),
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
            height: 20,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('โซน/ชั้น',
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                        style: TextStyle(
                            fontSize: 15,
                            color: SettingScreen_Color.Colors_Text2_,
                            fontFamily: Font_.Fonts_T
                            // fontWeight: FontWeight.bold,
                            )),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(5),
                          topRight: Radius.circular(5),
                          bottomLeft: Radius.circular(5),
                          bottomRight: Radius.circular(5)),
                      border: Border.all(color: Colors.grey, width: 1),
                    ),
                    padding: const EdgeInsets.all(8.0),
                    child: Text('${name_Zone}',
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 15,
                            color: SettingScreen_Color.Colors_Text2_,
                            fontFamily: Font_.Fonts_T
                            // fontWeight: FontWeight.bold,
                            )),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('จำนวนพื้นที่ทั้งหมด ',
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                        style: TextStyle(
                            fontSize: 15,
                            color: SettingScreen_Color.Colors_Text2_,
                            fontFamily: Font_.Fonts_T
                            // fontWeight: FontWeight.bold,
                            )),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(5),
                          topRight: Radius.circular(5),
                          bottomLeft: Radius.circular(5),
                          bottomRight: Radius.circular(5)),
                      border: Border.all(color: Colors.grey, width: 1),
                    ),
                    padding: const EdgeInsets.all(8.0),
                    child: Text('${areaModels.length}',
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 15,
                            color: SettingScreen_Color.Colors_Text2_,
                            fontFamily: Font_.Fonts_T
                            // fontWeight: FontWeight.bold,
                            )),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('จำนวนพื้นที่คงเหลือ',
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                        style: TextStyle(
                            fontSize: 15,
                            color: SettingScreen_Color.Colors_Text2_,
                            fontFamily: Font_.Fonts_T
                            // fontWeight: FontWeight.bold,
                            )),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(5),
                          topRight: Radius.circular(5),
                          bottomLeft: Radius.circular(5),
                          bottomRight: Radius.circular(5)),
                      border: Border.all(color: Colors.grey, width: 1),
                    ),
                    padding: const EdgeInsets.all(8.0),
                    child: Text('${pkqty! - countarae!}',
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 15,
                            color: SettingScreen_Color.Colors_Text2_,
                            fontFamily: Font_.Fonts_T
                            // fontWeight: FontWeight.bold,
                            )),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  pkqty! - countarae! > 0
                      ? Ser_Zone == 0
                          ? const SizedBox()
                          : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () async {
                                  print('1111');
                                  showDialog<String>(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (BuildContext context) => Form(
                                      key: _formKey,
                                      child: AlertDialog(
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20.0))),
                                        title: const Center(
                                            child: Text(
                                          'เพิ่มพื้นที่',
                                          style: TextStyle(
                                            color: SettingScreen_Color
                                                .Colors_Text1_,
                                            fontFamily: FontWeight_.Fonts_T,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )),
                                        content: Container(
                                          // height: MediaQuery.of(context).size.height / 1.5,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              1.5,
                                          decoration: const BoxDecoration(
                                            // color: Colors.grey[300],
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(10),
                                                bottomLeft: Radius.circular(10),
                                                bottomRight:
                                                    Radius.circular(10)),
                                            // border: Border.all(color: Colors.white, width: 1),
                                          ),
                                          child: SingleChildScrollView(
                                            child: Column(
                                              // mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Row(
                                                  children: [
                                                    Expanded(
                                                        flex: 6,
                                                        child: Column(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Row(
                                                                children: const [
                                                                  Text(
                                                                    'รหัสพื้นที่',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    style:
                                                                        TextStyle(
                                                                      color: SettingScreen_Color
                                                                          .Colors_Text1_,
                                                                      fontFamily:
                                                                          FontWeight_
                                                                              .Fonts_T,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: SizedBox(
                                                                // width: 200,
                                                                child:
                                                                    TextFormField(
                                                                  controller:
                                                                      area_ser_text,
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
                                                                      Colors
                                                                          .green,
                                                                  decoration: InputDecoration(
                                                                      fillColor: Colors.white.withOpacity(0.3),
                                                                      filled: true,
                                                                      // prefixIcon:
                                                                      //     const Icon(Icons.person_pin, color: Colors.black),
                                                                      // suffixIcon: Icon(Icons.clear, color: Colors.black),
                                                                      focusedBorder: const OutlineInputBorder(
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
                                                                      enabledBorder: const OutlineInputBorder(
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
                                                                      labelText: 'รหัสพื้นที่',
                                                                      labelStyle: const TextStyle(
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
                                                          ],
                                                        )),
                                                    Expanded(
                                                        flex: 6,
                                                        child: Column(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Row(
                                                                children: const [
                                                                  Text(
                                                                    'ชื่อพื้นที่',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .start,
                                                                    style:
                                                                        TextStyle(
                                                                      color: SettingScreen_Color
                                                                          .Colors_Text1_,
                                                                      fontFamily:
                                                                          FontWeight_
                                                                              .Fonts_T,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: SizedBox(
                                                                // width: 200,
                                                                child:
                                                                    TextFormField(
                                                                  controller:
                                                                      area_name_text,
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
                                                                      Colors
                                                                          .green,
                                                                  decoration: InputDecoration(
                                                                      fillColor: Colors.white.withOpacity(0.3),
                                                                      filled: true,
                                                                      // prefixIcon:
                                                                      //     const Icon(Icons.person_pin, color: Colors.black),
                                                                      // suffixIcon: Icon(Icons.clear, color: Colors.black),
                                                                      focusedBorder: const OutlineInputBorder(
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
                                                                      enabledBorder: const OutlineInputBorder(
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
                                                                      labelText: 'ชื่อพื้นที่',
                                                                      labelStyle: const TextStyle(
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
                                                          ],
                                                        )),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                        flex: 6,
                                                        child: Column(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Row(
                                                                children: const [
                                                                  Text(
                                                                    'ขนาดพื้นที่(ต.ร.ม.)',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    style:
                                                                        TextStyle(
                                                                      color: SettingScreen_Color
                                                                          .Colors_Text1_,
                                                                      fontFamily:
                                                                          FontWeight_
                                                                              .Fonts_T,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: SizedBox(
                                                                // width: 200,
                                                                child:
                                                                    TextFormField(
                                                                  controller:
                                                                      area_qty_text,
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
                                                                      Colors
                                                                          .green,
                                                                  decoration: InputDecoration(
                                                                      fillColor: Colors.white.withOpacity(0.3),
                                                                      filled: true,
                                                                      // prefixIcon:
                                                                      //     const Icon(Icons.person_pin, color: Colors.black),
                                                                      // suffixIcon: Icon(Icons.clear, color: Colors.black),
                                                                      focusedBorder: const OutlineInputBorder(
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
                                                                      enabledBorder: const OutlineInputBorder(
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
                                                                      labelText: 'ขนาดพื้นที่(ต.ร.ม.)',
                                                                      labelStyle: const TextStyle(
                                                                        color: Colors
                                                                            .black54,
                                                                        fontFamily:
                                                                            FontWeight_.Fonts_T,
                                                                      )),
                                                                  inputFormatters: <
                                                                      TextInputFormatter>[
                                                                    FilteringTextInputFormatter
                                                                        .deny(RegExp(
                                                                            "[' ']")),
                                                                    // for below version 2 use this
                                                                    FilteringTextInputFormatter
                                                                        .allow(RegExp(
                                                                            r'[0-9 .]')),
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
                                                        flex: 6,
                                                        child: Column(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Row(
                                                                children: const [
                                                                  Text(
                                                                    'ค่าบริการหลัก(ต่องวด)',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .start,
                                                                    style:
                                                                        TextStyle(
                                                                      color: SettingScreen_Color
                                                                          .Colors_Text1_,
                                                                      fontFamily:
                                                                          FontWeight_
                                                                              .Fonts_T,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: SizedBox(
                                                                // width: 200,
                                                                child:
                                                                    TextFormField(
                                                                  controller:
                                                                      area_pri_text,
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
                                                                      Colors
                                                                          .green,
                                                                  decoration: InputDecoration(
                                                                      fillColor: Colors.white.withOpacity(0.3),
                                                                      filled: true,
                                                                      // prefixIcon:
                                                                      //     const Icon(Icons.person_pin, color: Colors.black),
                                                                      // suffixIcon: Icon(Icons.clear, color: Colors.black),
                                                                      focusedBorder: const OutlineInputBorder(
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
                                                                      enabledBorder: const OutlineInputBorder(
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
                                                                      labelText: 'ค่าบริการหลัก(ต่องวด)',
                                                                      labelStyle: const TextStyle(
                                                                        color: Colors
                                                                            .black54,
                                                                        fontFamily:
                                                                            FontWeight_.Fonts_T,
                                                                      )),
                                                                  inputFormatters: <
                                                                      TextInputFormatter>[
                                                                    FilteringTextInputFormatter
                                                                        .deny(RegExp(
                                                                            "[' ']")),
                                                                    // for below version 2 use this
                                                                    FilteringTextInputFormatter
                                                                        .allow(RegExp(
                                                                            r'[0-9 .]')),
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
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Container(
                                                    width: 100,
                                                    decoration:
                                                        const BoxDecoration(
                                                      color: Colors.green,
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
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: TextButton(
                                                      onPressed: () async {
                                                        if (_formKey
                                                            .currentState!
                                                            .validate()) {
                                                          SharedPreferences
                                                              preferences =
                                                              await SharedPreferences
                                                                  .getInstance();
                                                          String? ren = preferences
                                                              .getString(
                                                                  'renTalSer');
                                                          String? ser_user =
                                                              preferences
                                                                  .getString(
                                                                      'ser');

                                                          var zonename =
                                                              ser_Zonex;
                                                          var area_ser =
                                                              area_ser_text
                                                                  .text;
                                                          var area_name =
                                                              area_name_text
                                                                  .text;
                                                          var area_qty =
                                                              area_qty_text
                                                                  .text;
                                                          var area_pri =
                                                              area_pri_text
                                                                  .text;

                                                          String url =
                                                              '${MyConstant().domain}/InC_area_setring.php?isAdd=true&ren=$ren&ser_user=$ser_user&zonename=$zonename&area_ser=$area_ser&area_name=$area_name&area_qty=$area_qty&area_pri=$area_pri';

                                                          try {
                                                            var response =
                                                                await http.get(
                                                                    Uri.parse(
                                                                        url));

                                                            var result = json
                                                                .decode(response
                                                                    .body);
                                                            print(result);
                                                            if (result
                                                                    .toString() ==
                                                                'true') {
                                                              setState(() {
                                                                read_GC_zone();
                                                                read_GC_area();
                                                                read_GC_area_count();
                                                                area_ser_text
                                                                    .clear();
                                                                area_name_text
                                                                    .clear();
                                                                area_qty_text
                                                                    .clear();
                                                                area_pri_text
                                                                    .clear();
                                                              });
                                                              Navigator.pop(
                                                                  context,
                                                                  'OK');
                                                            }
                                                          } catch (e) {
                                                            print(e);
                                                          }
                                                        }
                                                      },
                                                      child: const Text(
                                                        'บันทึก',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontFamily:
                                                              FontWeight_
                                                                  .Fonts_T,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Container(
                                                    width: 100,
                                                    decoration:
                                                        const BoxDecoration(
                                                      color: Colors.black,
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
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: TextButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          area_ser_text.clear();
                                                          area_name_text
                                                              .clear();
                                                          area_qty_text.clear();
                                                          area_pri_text.clear();
                                                        });
                                                        Navigator.pop(
                                                            context, 'OK');
                                                      },
                                                      child: const Text(
                                                        'ยกเลิก',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontFamily:
                                                              FontWeight_
                                                                  .Fonts_T,
                                                          fontWeight:
                                                              FontWeight.bold,
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
                                  );
                                },
                                child: Container(
                                  width: 50,
                                  decoration: BoxDecoration(
                                      color: Colors.green.shade700,
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10)),
                                      border: Border.all(
                                          color: Colors.white, width: 1)),
                                  padding: const EdgeInsets.all(8.0),
                                  child: const Center(
                                    child: Text(
                                      'เพิ่ม',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: FontWeight_.Fonts_T),
                                    ),
                                  ),
                                ),
                              ))
                      : const SizedBox()
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
            child: Column(
              children: [
                ScrollConfiguration(
                  behavior:
                      ScrollConfiguration.of(context).copyWith(dragDevices: {
                    PointerDeviceKind.touch,
                    PointerDeviceKind.mouse,
                  }),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    dragStartBehavior: DragStartBehavior.start,
                    child: Row(
                      children: [
                        SizedBox(
                          width: (!Responsive.isDesktop(context))
                              ? 790
                              : MediaQuery.of(context).size.width * 0.84,
                          child: Column(
                            children: [
                              Container(
                                height: 50,
                                decoration: const BoxDecoration(
                                  color: AppbackgroundColor.TiTile_Colors,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(0),
                                      bottomRight: Radius.circular(0)),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Text('รหัสพื้นที่',
                                          textAlign: TextAlign.center,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: false,
                                          style: TextStyle(
                                              // fontSize: 15,
                                              color: SettingScreen_Color
                                                  .Colors_Text1_,
                                              fontFamily: FontWeight_.Fonts_T
                                              // fontWeight: FontWeight.bold,
                                              )),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Text('ชื้อพื้นที่เช่า',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: false,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              //fontSize: 15,
                                              color: SettingScreen_Color
                                                  .Colors_Text1_,
                                              fontFamily: FontWeight_.Fonts_T
                                              // fontWeight: FontWeight.bold,
                                              )),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Text('ขนาดพื้นที่(ต.ร.ม.)',
                                          textAlign: TextAlign.end,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: false,
                                          style: TextStyle(
                                              //fontSize: 15,
                                              color: SettingScreen_Color
                                                  .Colors_Text1_,
                                              fontFamily: FontWeight_.Fonts_T
                                              // fontWeight: FontWeight.bold,
                                              )),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Text('ค่าบริการหลัก(ต่องวด)',
                                          textAlign: TextAlign.end,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: false,
                                          style: TextStyle(
                                              // fontSize: 15,
                                              color: SettingScreen_Color
                                                  .Colors_Text1_,
                                              fontFamily: FontWeight_.Fonts_T
                                              // fontWeight: FontWeight.bold,
                                              )),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Text('ลบ',
                                          textAlign: TextAlign.center,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: false,
                                          style: TextStyle(
                                              //fontSize: 15,
                                              color: SettingScreen_Color
                                                  .Colors_Text1_,
                                              fontFamily: FontWeight_.Fonts_T
                                              // fontWeight: FontWeight.bold,
                                              )),
                                    ),
                                  ],
                                ),
                              ),
                              StreamBuilder(
                                  stream: Stream.periodic(
                                      const Duration(seconds: 0)),
                                  builder: (context, snapshot) {
                                    return Container(
                                      height: 350,
                                      decoration: const BoxDecoration(
                                        color:
                                            AppbackgroundColor.Sub_Abg_Colors,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(0),
                                          topRight: Radius.circular(0),
                                          bottomLeft: Radius.circular(0),
                                          bottomRight: Radius.circular(0),
                                        ),
                                        // border: Border.all(
                                        //     color: Colors.grey, width: 1),
                                      ),
                                      child: ListView.builder(
                                        controller: _scrollController1,
                                        // itemExtent: 50,
                                        physics:
                                            const AlwaysScrollableScrollPhysics(), //const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: areaModels.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return areaModels.isEmpty
                                              ? SizedBox(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      StreamBuilder(
                                                        stream: Stream.periodic(
                                                            const Duration(
                                                                milliseconds:
                                                                    5),
                                                            (i) => i),
                                                        builder: (context,
                                                            snapshot) {
                                                          if (!snapshot.hasData)
                                                            return Text('');
                                                          double elapsed = double
                                                                  .parse(snapshot
                                                                      .data
                                                                      .toString()) *
                                                              0.05;
                                                          return Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: (elapsed >
                                                                    3.00)
                                                                ? const Text(
                                                                    'ไม่พบข้อมูล',
                                                                    style: TextStyle(
                                                                        color: PeopleChaoScreen_Color
                                                                            .Colors_Text2_,
                                                                        fontFamily:
                                                                            Font_.Fonts_T
                                                                        //fontSize: 10.0
                                                                        ),
                                                                  )
                                                                : Column(
                                                                    children: const [
                                                                      CircularProgressIndicator(),
                                                                      // Text(
                                                                      //   'Time : ${elapsed.toStringAsFixed(2)} seconds',
                                                                      //   style: const TextStyle(
                                                                      //       color: PeopleChaoScreen_Color
                                                                      //           .Colors_Text2_,
                                                                      //       fontFamily:
                                                                      //           Font_
                                                                      //               .Fonts_T
                                                                      //       //fontSize: 10.0
                                                                      //       ),
                                                                      // ),
                                                                    ],
                                                                  ),
                                                          );
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              : areaModels[index].quantity ==
                                                      null
                                                  ? Container(
                                                      color: tappedIndex_ ==
                                                              index.toString()
                                                          ? Colors.grey.shade300
                                                          : null,
                                                      child: ListTile(
                                                          onTap: () {
                                                            setState(() {
                                                              tappedIndex_ = index
                                                                  .toString();
                                                            });
                                                          },
                                                          title: Row(
                                                            children: [
                                                              Expanded(
                                                                flex: 1,
                                                                child:
                                                                    TextFormField(
                                                                  textAlign:
                                                                      TextAlign
                                                                          .end,
                                                                  initialValue:
                                                                      areaModels[
                                                                              index]
                                                                          .ln,
                                                                  onFieldSubmitted:
                                                                      (value) async {
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
                                                                    var vser =
                                                                        areaModels[index]
                                                                            .ser;
                                                                    String url =
                                                                        '${MyConstant().domain}/UpC_area_ln.php?isAdd=true&ren=$ren&vser=$vser&value=$value&ser_user=$ser_user';

                                                                    try {
                                                                      var response =
                                                                          await http
                                                                              .get(Uri.parse(url));

                                                                      var result =
                                                                          json.decode(
                                                                              response.body);
                                                                      print(
                                                                          result);
                                                                      if (result
                                                                              .toString() ==
                                                                          'true') {
                                                                        setState(
                                                                            () {
                                                                          read_GC_area();
                                                                        });
                                                                      } else {}
                                                                    } catch (e) {}
                                                                  },
                                                                  // maxLength: 13,
                                                                  cursorColor:
                                                                      Colors
                                                                          .green,
                                                                  decoration:
                                                                      InputDecoration(
                                                                    fillColor: Colors
                                                                        .white
                                                                        .withOpacity(
                                                                            0.05),
                                                                    filled:
                                                                        true,
                                                                    // prefixIcon:
                                                                    //     const Icon(Icons.key, color: Colors.black),
                                                                    // suffixIcon: Icon(Icons.clear, color: Colors.black),
                                                                    focusedBorder:
                                                                        const OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .only(
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
                                                                        color: Colors
                                                                            .grey,
                                                                      ),
                                                                    ),
                                                                    enabledBorder:
                                                                        const OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .only(
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
                                                                        color: Colors
                                                                            .grey,
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
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child:
                                                                      TextFormField(
                                                                    textAlign:
                                                                        TextAlign
                                                                            .end,
                                                                    initialValue:
                                                                        areaModels[index]
                                                                            .lncode,
                                                                    onFieldSubmitted:
                                                                        (value) async {
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
                                                                      var vser =
                                                                          areaModels[index]
                                                                              .ser;
                                                                      String
                                                                          url =
                                                                          '${MyConstant().domain}/UpC_area_lncode.php?isAdd=true&ren=$ren&vser=$vser&value=$value&ser_user=$ser_user';

                                                                      try {
                                                                        var response =
                                                                            await http.get(Uri.parse(url));

                                                                        var result =
                                                                            json.decode(response.body);
                                                                        print(
                                                                            result);
                                                                        if (result.toString() ==
                                                                            'true') {
                                                                          setState(
                                                                              () {
                                                                            read_GC_area();
                                                                          });
                                                                        } else {}
                                                                      } catch (e) {}
                                                                    },
                                                                    // maxLength: 13,
                                                                    cursorColor:
                                                                        Colors
                                                                            .green,
                                                                    decoration:
                                                                        InputDecoration(
                                                                      fillColor: Colors
                                                                          .white
                                                                          .withOpacity(
                                                                              0.05),
                                                                      filled:
                                                                          true,
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
                                                                        borderSide:
                                                                            BorderSide(
                                                                          width:
                                                                              1,
                                                                          color:
                                                                              Colors.grey,
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
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .fromLTRB(
                                                                          8,
                                                                          8,
                                                                          0,
                                                                          8),
                                                                  child:
                                                                      TextFormField(
                                                                    textAlign:
                                                                        TextAlign
                                                                            .end,
                                                                    initialValue:
                                                                        areaModels[index]
                                                                            .area,
                                                                    onFieldSubmitted:
                                                                        (value) async {
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
                                                                      var vser =
                                                                          areaModels[index]
                                                                              .ser;
                                                                      String
                                                                          url =
                                                                          '${MyConstant().domain}/UpC_area_area.php?isAdd=true&ren=$ren&vser=$vser&value=$value&ser_user=$ser_user';

                                                                      try {
                                                                        var response =
                                                                            await http.get(Uri.parse(url));

                                                                        var result =
                                                                            json.decode(response.body);
                                                                        print(
                                                                            result);
                                                                        if (result.toString() ==
                                                                            'true') {
                                                                          setState(
                                                                              () {
                                                                            read_GC_area();
                                                                          });
                                                                        } else {}
                                                                      } catch (e) {}
                                                                    },
                                                                    // maxLength: 13,
                                                                    cursorColor:
                                                                        Colors
                                                                            .green,
                                                                    decoration:
                                                                        InputDecoration(
                                                                      fillColor: Colors
                                                                          .white
                                                                          .withOpacity(
                                                                              0.05),
                                                                      filled:
                                                                          true,
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
                                                                        borderSide:
                                                                            BorderSide(
                                                                          width:
                                                                              1,
                                                                          color:
                                                                              Colors.grey,
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
                                                                      // labelText: 'PASSWOED',
                                                                      labelStyle: const TextStyle(
                                                                          color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                          // fontWeight: FontWeight.bold,
                                                                          fontFamily: Font_.Fonts_T),
                                                                    ),
                                                                    inputFormatters: <
                                                                        TextInputFormatter>[
                                                                      // for below version 2 use this
                                                                      FilteringTextInputFormatter
                                                                          .allow(
                                                                              RegExp(r'[0-9 .]')),
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
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .fromLTRB(
                                                                          8,
                                                                          8,
                                                                          0,
                                                                          8),
                                                                  child:
                                                                      TextFormField(
                                                                    textAlign:
                                                                        TextAlign
                                                                            .end,
                                                                    initialValue:
                                                                        areaModels[index]
                                                                            .rent,
                                                                    onFieldSubmitted:
                                                                        (value) async {
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
                                                                      var vser =
                                                                          areaModels[index]
                                                                              .ser;
                                                                      String
                                                                          url =
                                                                          '${MyConstant().domain}/UpC_area_rent.php?isAdd=true&ren=$ren&vser=$vser&value=$value&ser_user=$ser_user';

                                                                      try {
                                                                        var response =
                                                                            await http.get(Uri.parse(url));

                                                                        var result =
                                                                            json.decode(response.body);
                                                                        print(
                                                                            result);
                                                                        if (result.toString() ==
                                                                            'true') {
                                                                          setState(
                                                                              () {
                                                                            read_GC_area();
                                                                          });
                                                                        } else {}
                                                                      } catch (e) {}
                                                                    },
                                                                    // maxLength: 13,
                                                                    cursorColor:
                                                                        Colors
                                                                            .green,
                                                                    decoration:
                                                                        InputDecoration(
                                                                      fillColor: Colors
                                                                          .white
                                                                          .withOpacity(
                                                                              0.05),
                                                                      filled:
                                                                          true,
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
                                                                        borderSide:
                                                                            BorderSide(
                                                                          width:
                                                                              1,
                                                                          color:
                                                                              Colors.grey,
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
                                                                      // labelText: 'PASSWOED',
                                                                      labelStyle: const TextStyle(
                                                                          color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                          // fontWeight: FontWeight.bold,
                                                                          fontFamily: Font_.Fonts_T),
                                                                    ),
                                                                    inputFormatters: <
                                                                        TextInputFormatter>[
                                                                      // for below version 2 use this
                                                                      FilteringTextInputFormatter
                                                                          .allow(
                                                                              RegExp(r'[0-9 .]')),
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
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  child:
                                                                      InkWell(
                                                                    child:
                                                                        Container(
                                                                      width:
                                                                          100,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: Colors
                                                                            .red[700],
                                                                        borderRadius:
                                                                            const BorderRadius.only(
                                                                          topLeft:
                                                                              Radius.circular(10),
                                                                          topRight:
                                                                              Radius.circular(10),
                                                                          bottomLeft:
                                                                              Radius.circular(10),
                                                                          bottomRight:
                                                                              Radius.circular(10),
                                                                        ),
                                                                        // border: Border.all(
                                                                        //     color: Colors.grey, width: 1),
                                                                      ),
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              8.0),
                                                                      child:
                                                                          const Text(
                                                                        'X',
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        maxLines:
                                                                            1,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.black,
                                                                            fontFamily: Font_.Fonts_T),
                                                                      ),
                                                                    ),
                                                                    onTap: () {
                                                                      print(
                                                                          'ลบ ${areaModels[index].ln}');
                                                                      showDialog(
                                                                          context:
                                                                              context,
                                                                          builder: (context) =>
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
                                                          )),
                                                    )
                                                  : Container(
                                                      color: tappedIndex_ ==
                                                              index.toString()
                                                          ? Colors.grey.shade300
                                                          : null,
                                                      child: ListTile(
                                                          onTap: () {
                                                            setState(() {
                                                              tappedIndex_ = index
                                                                  .toString();
                                                            });
                                                          },
                                                          title: Row(
                                                            children: [
                                                              Expanded(
                                                                flex: 1,
                                                                child: Text(
                                                                  '${areaModels[index].ln}',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: const TextStyle(
                                                                      color: SettingScreen_Color
                                                                          .Colors_Text2_,
                                                                      fontFamily:
                                                                          Font_
                                                                              .Fonts_T

                                                                      //fontSize: 10.0
                                                                      ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                flex: 1,
                                                                child: Text(
                                                                  '${areaModels[index].lncode}',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: const TextStyle(
                                                                      color: SettingScreen_Color
                                                                          .Colors_Text2_,
                                                                      fontFamily:
                                                                          Font_
                                                                              .Fonts_T

                                                                      //fontSize: 10.0
                                                                      ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                flex: 1,
                                                                child: Text(
                                                                  '${nFormat.format(double.parse(areaModels[index].area!))}',
                                                                  // '${areaModels[index].area}',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .end,
                                                                  style: const TextStyle(
                                                                      color: SettingScreen_Color
                                                                          .Colors_Text2_,
                                                                      fontFamily:
                                                                          Font_
                                                                              .Fonts_T

                                                                      //fontSize: 10.0
                                                                      ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                flex: 1,
                                                                child: Text(
                                                                  '${nFormat.format(double.parse(areaModels[index].rent!))}',
                                                                  // '${areaModels[index].rent}',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .end,
                                                                  style: const TextStyle(
                                                                      color: SettingScreen_Color
                                                                          .Colors_Text2_,
                                                                      fontFamily:
                                                                          Font_
                                                                              .Fonts_T

                                                                      //fontSize: 10.0
                                                                      ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                flex: 1,
                                                                child: Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  child:
                                                                      InkWell(
                                                                    child:
                                                                        Container(
                                                                      width:
                                                                          100,
                                                                      decoration:
                                                                          const BoxDecoration(
                                                                        // color: Colors
                                                                        //     .red[700],
                                                                        borderRadius:
                                                                            BorderRadius.only(
                                                                          topLeft:
                                                                              Radius.circular(10),
                                                                          topRight:
                                                                              Radius.circular(10),
                                                                          bottomLeft:
                                                                              Radius.circular(10),
                                                                          bottomRight:
                                                                              Radius.circular(10),
                                                                        ),
                                                                        // border: Border.all(
                                                                        //     color: Colors.grey, width: 1),
                                                                      ),
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              8.0),
                                                                      child:
                                                                          const Text(
                                                                        '',
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        maxLines:
                                                                            1,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        style: TextStyle(
                                                                            color:
                                                                                SettingScreen_Color.Colors_Text2_,
                                                                            fontFamily: Font_.Fonts_T),
                                                                      ),
                                                                    ),
                                                                    onTap: () {
                                                                      print(
                                                                          'ลบ ${areaModels[index].ln}');
                                                                    },
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          )),
                                                    );
                                        },
                                      ),
                                    );
                                  }),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                    width: (!Responsive.isDesktop(context))
                        ? MediaQuery.of(context).size.width
                        : MediaQuery.of(context).size.width * 0.84,
                    decoration: const BoxDecoration(
                      color: AppbackgroundColor.Sub_Abg_Colors,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(0),
                          topRight: Radius.circular(0),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: () {},
                                  child: Container(
                                      decoration: BoxDecoration(
                                        // color: AppbackgroundColor
                                        //     .TiTile_Colors,
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(6),
                                            topRight: Radius.circular(6),
                                            bottomLeft: Radius.circular(6),
                                            bottomRight: Radius.circular(8)),
                                        border: Border.all(
                                            color: Colors.grey, width: 1),
                                      ),
                                      padding: const EdgeInsets.all(3.0),
                                      child: const Text(
                                        'Top',
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 10.0,
                                            fontFamily: Font_.Fonts_T),
                                      )),
                                ),
                              ),
                              InkWell(
                                onTap: () {},
                                child: Container(
                                    decoration: BoxDecoration(
                                      // color: AppbackgroundColor
                                      //     .TiTile_Colors,
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(6),
                                          topRight: Radius.circular(6),
                                          bottomLeft: Radius.circular(6),
                                          bottomRight: Radius.circular(6)),
                                      border: Border.all(
                                          color: Colors.grey, width: 1),
                                    ),
                                    padding: const EdgeInsets.all(3.0),
                                    child: const Text(
                                      'Down',
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 10.0,
                                          fontFamily: Font_.Fonts_T),
                                    )),
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Row(
                            children: [
                              InkWell(
                                onTap: _moveUp1,
                                child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Icon(
                                        Icons.arrow_upward,
                                        color: Colors.grey,
                                      ),
                                    )),
                              ),
                              Container(
                                  decoration: BoxDecoration(
                                    // color: AppbackgroundColor
                                    //     .TiTile_Colors,
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(6),
                                        topRight: Radius.circular(6),
                                        bottomLeft: Radius.circular(6),
                                        bottomRight: Radius.circular(6)),
                                    border: Border.all(
                                        color: Colors.grey, width: 1),
                                  ),
                                  padding: const EdgeInsets.all(3.0),
                                  child: const Text(
                                    'Scroll',
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 10.0,
                                        fontFamily: Font_.Fonts_T),
                                  )),
                              InkWell(
                                onTap: _moveDown1,
                                child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Icon(
                                        Icons.arrow_downward,
                                        color: Colors.grey,
                                      ),
                                    )),
                              ),
                            ],
                          ),
                        )
                      ],
                    )),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
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
    return const USerInformation();
  }

  Widget Status7_Web() {
    return const OtherScreen();
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
                                ? const USerInformation()
                                : const OtherScreen()
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
