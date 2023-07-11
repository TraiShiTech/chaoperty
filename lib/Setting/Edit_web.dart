// ignore_for_file: unused_import, unused_local_variable, unnecessary_null_comparison, unused_field, override_on_non_overriding_member, duplicate_import, must_be_immutable, body_might_complete_normally_nullable
import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import 'dart:html' as html;
import '../Constant/Myconstant.dart';
import '../INSERT_Log/Insert_log.dart';
import '../Model/GetArea_Model.dart';
import '../Model/GetC_rantaldata_Model.dart';
import '../Model/GetPerMission_Model.dart';
import '../Model/GetRenTal_Model.dart';
import '../Model/GetRenTalimg_Model.dart';
import '../Model/GetUser_Model.dart';
import '../Responsive/responsive.dart';
import '../Style/colors.dart';

class EditwebScreen extends StatefulWidget {
  const EditwebScreen({super.key});

  @override
  State<EditwebScreen> createState() => _EditwebScreenState();
}

class _EditwebScreenState extends State<EditwebScreen> {
  var Provincename_;
  List<String> provinceNamesTh = [
    // 'ทั้งหมด',
    'กรุงเทพมหานคร',
    'กระบี่',
    'กาญจนบุรี',
    'กาฬสินธุ์',
    'กำแพงเพชร',
    'ขอนแก่น',
    'จันทบุรี',
    'ฉะเชิงเทรา',
    'ชลบุรี',
    'ชัยนาท',
    'ชัยภูมิ',
    'ชุมพร',
    'เชียงราย',
    'เชียงใหม่',
    'ตรัง',
    'ตราด',
    'ตาก',
    'นครนายก',
    'นครปฐม',
    'นครพนม',
    'นครราชสีมา',
    'นครศรีธรรมราช',
    'นครสวรรค์',
    'นนทบุรี',
    'นราธิวาส',
    'น่าน',
    'บึงกาฬ',
    'บุรีรัมย์',
    'ปทุมธานี',
    'ประจวบคีรีขันธ์',
    'ปราจีนบุรี',
    'ปัตตานี',
    'พระนครศรีอยุธยา',
    'พังงา',
    'พัทลุง',
    'พิจิตร',
    'พิษณุโลก',
    'เพชรบุรี',
    'เพชรบูรณ์',
    'แพร่',
    'พะเยา',
    'ภูเก็ต',
    'มหาสารคาม',
    'มุกดาหาร',
    'แม่ฮ่องสอน',
    'ยโสธร',
    'ยะลา',
    'ร้อยเอ็ด',
    'ระนอง',
    'ระยอง',
    'ราชบุรี',
    'ลพบุรี',
    'ลำปาง',
    'ลำพูน',
    'เลย',
    'ศรีสะเกษ',
    'สกลนคร',
    'สงขลา',
    'สตูล',
    'สมุทรปราการ',
    'สมุทรสงคราม',
    'สมุทรสาคร',
    'สระแก้ว',
    'สระบุรี',
    'สิงห์บุรี',
    'สุโขทัย',
    'สุพรรณบุรี',
    'สุราษฎร์ธานี',
    'สุรินทร์',
    'หนองคาย',
    'หนองบัวลำภู',
    'อ่างทอง',
    'อำนาจเจริญ',
    'อุดรธานี',
    'อุตรดิตถ์',
    'อุทัยธานี',
    'อุบลราชธานี',
  ];

  List<RenTalModel> renTalModels = [];
  List<PerMissionModel> perMissionModels = [];
  List<RenTaldataModel> renTaldataModels = [];
  List<AreaModel> areaModels = [];
  List<RenTalimgModel> renTalimgModels = [];
  List<dynamic> facilities = [];
  List<dynamic> nearby_places = [];
  String? ser_user,
      position_user,
      fname_user,
      lname_user,
      email_user,
      utype_user,
      permission_user,
      renTal_user,
      tel_user,
      foder;
  String? renTal_name,
      renTal_addr,
      renTal_Porvi,
      type,
      typex,
      man_img_,
      qr_img_,
      n_places_,
      f_lities,
      renTal_statusweb;

  final rental_name_text = TextEditingController();
  final rental_Line_text = TextEditingController();
  final rental_Facebook_text = TextEditingController();
  final rental_UrlYoutube_text = TextEditingController();
  final Stimeinput = TextEditingController();
  final ltimeinput = TextEditingController();
  final rental_Urladdr_text = TextEditingController();
  final rental_Facilities_text = TextEditingController();
  final rental_Nearbyplaces_text = TextEditingController();
  final rental_Abount_text = TextEditingController();

  @override
  void initState() {
    signInThread();
    read_GC_rental();
    read_GC_area();
    read_GC_rentaldata();
    read_GC_rental_img();
    super.initState();
  }

  void _launchURL() async {
    final String url = 'https://www.dzentric.com/chaoperty_market/#/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<Null> signInThread() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    String? _seruser = preferences.getString('ser');
    String url =
        '${MyConstant().domain}/GC_userHome.php?isAdd=true&ser=$_seruser';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);
      for (var map in result) {
        UserModel userModel = UserModel.fromJson(map);
        setState(() {
          position_user = userModel.position;
          fname_user = userModel.fname;
          lname_user = userModel.lname;
          email_user = userModel.email;
          utype_user = userModel.utype;
          tel_user = userModel.tel;
          permission_user = userModel.permission;
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

    String url = '${MyConstant().domain}/GC_areaAll.php?isAdd=true&ren=$ren';

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
            type = typexs;
            typex = typexx;
            renTal_name = renTalModel.pn;

            renTal_addr = renTalModel.bill_addr;

            foder = renTalModel.dbn.toString();
            renTalModels.add(renTalModel);
            renTalModels.add(renTalModel);
          });
        }
      } else {}
    } catch (e) {}
  }

  Future<Null> read_GC_rentaldata() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    var seruser = preferences.getString('ser');
    var utype = preferences.getString('utype');
    print('**$ren***ren****ren**renrenren***ren*******${ren}');
    String url = '${MyConstant().domain}/GC_rentaldata.php?isAdd=true&ser=$ren';
    if (renTaldataModels.length != 0) {
      renTaldataModels.clear();
      setState(() {
        facilities = [];
        nearby_places = [];
      });
    }
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print(result);
      for (var map in result) {
        RenTaldataModel renTaldataModel = RenTaldataModel.fromJson(map);

        setState(() {
          n_places_ = renTaldataModel.n_Places.toString();
          f_lities = renTaldataModel.f_Lities.toString();
          rental_Facebook_text.text = renTaldataModel.r_Facebook.toString();
          rental_Line_text.text = renTaldataModel.r_Line.toString();
          rental_UrlYoutube_text.text = renTaldataModel.url_You.toString();
          rental_Urladdr_text.text = renTaldataModel.url_Map.toString();
          rental_Abount_text.text = renTaldataModel.a_About.toString();
          Stimeinput.text = renTaldataModel.stime.toString();
          ltimeinput.text = renTaldataModel.ltime.toString();
          rental_name_text.text = renTaldataModel.pn.toString();
          renTal_Porvi = renTaldataModel.province.toString();
          renTal_statusweb = renTaldataModel.status_Web.toString();
          man_img_ = renTaldataModel.man_Image.toString();
          qr_img_ = renTaldataModel.qr_Image.toString();
          renTaldataModels.add(renTaldataModel);
        });
      }
      for (int index = 0; index < renTaldataModels.length; index++) {
        String nearbyPlacesStr = n_places_.toString();
        List<String> nearbyPlacesList = nearbyPlacesStr.split(",");
        List<dynamic> nearbyPlaces = nearbyPlacesList
            .map((place) => place.trim())
            .where((place) => place.isNotEmpty)
            .toList();
        //////////----------------------------------
        String facilities_ = f_lities.toString();
        List<String> facilitiesList = facilities_.split(",");
        // List<dynamic> faciliTies =
        //     facilitiesList.map((place) => place.trim()).toList();
        List<dynamic> faciliTies = facilitiesList
            .map((faci) => faci.trim())
            .where((faci) => faci.isNotEmpty)
            .toList();
        setState(() {
          nearby_places = nearbyPlaces;
          facilities = faciliTies;
        });
      }
    } catch (e) {}
  }

  Future<Null> read_GC_rental_img() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    var seruser = preferences.getString('ser');
    var utype = preferences.getString('utype');
    String url = '${MyConstant().domain}/GC_rental_img.php?isAdd=true&ser=$ren';
    if (renTalimgModels.length != 0) {
      renTalimgModels.clear();
    }
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print(result);
      for (var map in result) {
        RenTalimgModel renTalimgModel = RenTalimgModel.fromJson(map);

        setState(() {
          renTalimgModels.add(renTalimgModel);
        });
      }
    } catch (e) {}
  }

  String? base64_Imgman;
  var extension_;
  var file_;

  Future<void> deletedFile_(String Path_, String Namefile) async {
    // String Path_foder = 'contract';

    final deleteRequest = html.HttpRequest();
    if (Path_.toString() == 'abountimg') {
      deleteRequest.open('POST',
          '${MyConstant().domain}/File_Deleted_webfont_img.php?Foder=$foder&name=$Namefile&Pathfoder=$Path_');
      deleteRequest.send();
      Insert_log.Insert_logs('ตั้งค่า', 'ตั้งค่าหน้าเว็ป>>ลบรูป(ทั่วไป)');
    } else if (Path_.toString() == 'manimg') {
      deleteRequest.open('POST',
          '${MyConstant().domain}/File_Deleted_webfont_img.php?Foder=$foder&name=$Namefile&Pathfoder=$Path_');
      deleteRequest.send();
      Insert_log.Insert_logs('ตั้งค่า', 'ตั้งค่าหน้าเว็ป>>ลบรูป(หน้าปก)');
    } else if (Path_.toString() == 'qrimg') {
      deleteRequest.open('POST',
          '${MyConstant().domain}/File_Deleted_webfont_img.php?Foder=$foder&name=$Namefile&Pathfoder=$Path_');
      deleteRequest.send();
      Insert_log.Insert_logs('ตั้งค่า', 'ตั้งค่าหน้าเว็ป>>ลบรูป(QR)');
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var ren = preferences.getString('renTalSer');

    String url = '';

    if (Path_.toString() == 'abountimg') {
      setState(() {
        url =
            '${MyConstant().domain}/UpC_rental_dataimg_editweb.php?isAdd=true&ren=${ren}&Value=${Namefile}&typevalue=2';
      });
    } else if (Path_.toString() == 'manimg') {
      setState(() {
        url =
            '${MyConstant().domain}/UpC_rental_data_editweb.php?isAdd=true&ren=$ren&value='
            '&typevalue=6';
      });
    } else if (Path_.toString() == 'qrimg') {
      setState(() {
        url =
            '${MyConstant().domain}/UpC_rental_data_editweb.php?isAdd=true&ren=$ren&value='
            '&typevalue=5';
      });
    }

    var response = await http.get(Uri.parse(url));
    var result = json.decode(response.body);
    print(result.toString());
    setState(() {
      signInThread();
      read_GC_rental();
      read_GC_area();
      read_GC_rentaldata();
      read_GC_rental_img();
    });
    // Handle the response
    await deleteRequest.onLoad.first;

    if (deleteRequest.status == 200) {
      setState(() {
        signInThread();
        read_GC_rental();
        read_GC_area();
        read_GC_rentaldata();
        read_GC_rental_img();
      });
      final response = deleteRequest.response;
      if (response == 'File deleted successfully.') {
        print('File deleted successfully!');
      } else {
        print('Failed to delete file: $response');
      }
    } else {
      setState(() {
        signInThread();
        read_GC_rental();
        read_GC_area();
        read_GC_rentaldata();
        read_GC_rental_img();
      });
      print('Failed to delete file!');
    }
    setState(() {
      signInThread();
      read_GC_rental();
      read_GC_area();
      read_GC_rentaldata();
      read_GC_rental_img();
    });
  }

  Future<void> uploadFile_Imgman(String Path_) async {
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
      base64_Imgman = base64Encode(reader.result as Uint8List);
    });
    // print(base64_Imgmap);
    setState(() {
      extension_ = extension;
      file_ = file;
    });
    OKuploadFile_Imgmap(Path_);
  }

  Future<void> OKuploadFile_Imgmap(String Path_) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');

    String? _seruser = preferences.getString('ser');
    if (base64_Imgman != null) {
      String Path_foder = Path_;
      String dateTimeNow = DateTime.now().toString();
      String date = DateFormat('ddMMyyyy')
          .format(DateTime.parse('${dateTimeNow}'))
          .toString();
      String date2 = DateFormat('yyyyMMdd')
          .format(DateTime.parse('${dateTimeNow}'))
          .toString();
      final dateTimeNow2 = DateTime.now().toUtc().add(const Duration(hours: 7));
      final formatter2 = DateFormat('HHmmss');

      final formattedTime2 = formatter2.format(dateTimeNow2);

      String Time_ = formattedTime2.toString();
      DateTime time = DateTime.now(); // Replace with your time value

      String formattedTime = DateFormat('HH:mm:ss').format(time);
      String fileName = '';
      String url = '';
      if (Path_.toString() == 'abountimg') {
        setState(() {
          fileName = 'Abountimg${ren}_${date}_$Time_.$extension_';
        });
        Insert_log.Insert_logs('ตั้งค่า', 'ตั้งค่าหน้าเว็ป>>เพิ่มรูป(ทั่วไป)');
        //UpC_rental_dataimg_editweb
        url =
            '${MyConstant().domain}/UpC_rental_dataimg_editweb.php?isAdd=true&ren=${ren}&seruser=${_seruser}&datexImg=${date2}&timexImg=${formattedTime}&imgImg=${fileName}&typevalue=1';
      } else if (Path_.toString() == 'manimg') {
        setState(() {
          fileName = 'Manimg${ren}_${date}_$Time_.$extension_';
          url =
              '${MyConstant().domain}/UpC_rental_data_editweb.php?isAdd=true&ren=$ren&ser=$ser_user&value=$fileName&typevalue=6';
        });
        Insert_log.Insert_logs('ตั้งค่า', 'ตั้งค่าหน้าเว็ป>>เพิ่มรูป(หน้าปก)');
      } else if (Path_.toString() == 'qrimg') {
        setState(() {
          fileName = 'QRimg${ren}_${date}_$Time_.$extension_';
          url =
              '${MyConstant().domain}/UpC_rental_data_editweb.php?isAdd=true&ren=$ren&ser=$ser_user&value=$fileName&typevalue=5';
        });
        Insert_log.Insert_logs('ตั้งค่า', 'ตั้งค่าหน้าเว็ป>>เพิ่มรูป(QR)');
      }
      // InsertFile_SQL(fileName, MixPath_, formattedTime1);
      // Create a new FormData object and add the file to it
      final formData = html.FormData();
      formData.appendBlob('file', file_, fileName);
      // Send the request
      final request = html.HttpRequest();
      request.open('POST',
          '${MyConstant().domain}/File_upload_webfont_img.php?name=$fileName&Foder=$foder&Pathfoder=$Path_foder');
      request.send(formData);

      print(formData);

      // Handle the response
      await request.onLoad.first;

      if (request.status == 200) {
        print('File uploaded successfully!');
        SharedPreferences preferences = await SharedPreferences.getInstance();
        String? ren = preferences.getString('renTalSer');
        String? ser_user = preferences.getString('ser');
        //UpC_rental_data_editweb

        try {
          var response = await http.get(Uri.parse(url));

          var result = await json.decode(response.body);

          if (result.toString() == 'true') {
            setState(() {
              signInThread();
              read_GC_rental();
              read_GC_area();
              read_GC_rentaldata();
              read_GC_rental_img();
            });
          } else {}
        } catch (e) {
          print(e);
        }
        // UpImg(context, fileName, Path_, Ser_);
      } else {
        print('File upload failed with status code: ${request.status}');
      }
    } else {
      print('ยังไม่ได้เลือกรูปภาพ');
    }
  }

  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
            child: Container(
              height: 20,
              decoration: const BoxDecoration(
                color: Colors.white30,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(0),
                    topRight: Radius.circular(0),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                // border: Border.all(color: Colors.white, width: 1),
              ),
            ),
          ),
          Container(
            width: (!Responsive.isDesktop(context))
                ? 800
                : MediaQuery.of(context).size.width * 0.84,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              color: AppbackgroundColor.Sub_Abg_Colors,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(0),
                topRight: Radius.circular(0),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              // border: Border.all(
              //     color: Colors.grey, width: 1),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'ตั้งค่าหน้าเว็ป ',
                              style: const TextStyle(
                                color: SettingScreen_Color.Colors_Text1_,
                                fontFamily: FontWeight_.Fonts_T,
                                fontWeight: FontWeight.bold,
                                //fontSize: 10.0
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () => _launchURL(),
                          child: Container(
                            padding: const EdgeInsets.all(4.0),
                            decoration: const BoxDecoration(
                              color: Colors.brown,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  topRight: Radius.circular(8),
                                  bottomLeft: Radius.circular(8),
                                  bottomRight: Radius.circular(8)),
                              // border: Border.all(
                              //     color: Colors.grey, width: 3),
                            ),
                            child: Center(
                              child: Text(
                                '🌍 เปิดเว็ปไซต์ $foder',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: FontWeight_.Fonts_T,
                                  fontWeight: FontWeight.bold,
                                  //fontSize: 10.0
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  ScrollConfiguration(
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
                            width: (!Responsive.isDesktop(context))
                                ? 800
                                : MediaQuery.of(context).size.width * 0.84,
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: renTal_statusweb == '1'
                                            ? Colors.grey[100]!.withOpacity(0.5)
                                            : Colors.red[100]!.withOpacity(0.5),
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(0),
                                          topRight: Radius.circular(0),
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10),
                                        ),
                                        border: Border.all(
                                            color: Colors.grey, width: 1),
                                      ),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.green[100]!
                                                    .withOpacity(0.5),
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  topLeft: Radius.circular(10),
                                                  topRight: Radius.circular(10),
                                                  bottomLeft:
                                                      Radius.circular(10),
                                                  bottomRight:
                                                      Radius.circular(10),
                                                ),
                                                border: Border.all(
                                                    color: Colors.grey,
                                                    width: 1),
                                              ),
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Row(
                                                children: [
                                                  const Text(
                                                    'ปิดร้าน',
                                                    style: TextStyle(
                                                      color: SettingScreen_Color
                                                          .Colors_Text1_,
                                                      fontFamily: Font_.Fonts_T,
                                                      // fontWeight: FontWeight.bold,
                                                      //fontSize: 10.0
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: () async {
                                                      SharedPreferences
                                                          preferences =
                                                          await SharedPreferences
                                                              .getInstance();
                                                      String? ren =
                                                          preferences.getString(
                                                              'renTalSer');
                                                      String? ser_user =
                                                          preferences
                                                              .getString('ser');
                                                      var open =
                                                          renTal_statusweb ==
                                                                  '1'
                                                              ? '0'
                                                              : '1';
                                                      var vser =
                                                          renTal_statusweb;

                                                      ///-------------------------------->

                                                      String value_ = '${open}';

                                                      ///-------------------------------->

                                                      //
                                                      String url =
                                                          '${MyConstant().domain}/UpC_rental_data_editweb.php?isAdd=true&ren=$ren&ser=$ser_user&value=$value_&typevalue=7';

                                                      try {
                                                        var response =
                                                            await http.get(
                                                                Uri.parse(url));

                                                        var result =
                                                            await json.decode(
                                                                response.body);

                                                        if (result.toString() ==
                                                            'true') {
                                                          setState(() {
                                                            signInThread();
                                                            read_GC_rental();
                                                            read_GC_area();
                                                            read_GC_rentaldata();
                                                            read_GC_rental_img();
                                                          });
                                                        } else {}
                                                      } catch (e) {
                                                        print(e);
                                                      }
                                                    },
                                                    child: renTal_statusweb ==
                                                            '1'
                                                        ? const Icon(
                                                            Icons.toggle_on,
                                                            color: Colors.green,
                                                            size: 35.0,
                                                          )
                                                        : const Icon(
                                                            Icons.toggle_off,
                                                            size: 35.0,
                                                          ),
                                                  ),
                                                  Text(
                                                    'เปิดร้าน',
                                                    style: TextStyle(
                                                      color: SettingScreen_Color
                                                          .Colors_Text1_,
                                                      fontFamily: Font_.Fonts_T,
                                                      // fontWeight: FontWeight.bold,
                                                      //fontSize: 10.0
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: 220,
                                            height: 130,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(3.0),
                                              child: ClipRRect(
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  topLeft: Radius.circular(8.0),
                                                  topRight:
                                                      Radius.circular(8.0),
                                                  bottomLeft:
                                                      Radius.circular(8.0),
                                                  bottomRight:
                                                      Radius.circular(8.0),
                                                ),
                                                child: (man_img_ == null ||
                                                        man_img_ == '')
                                                    ? Icon(Icons
                                                        .image_not_supported)
                                                    : Image.network(
                                                        '${MyConstant().domain}/files/$foder/webfont/manimg/$man_img_',
                                                        fit: BoxFit.fill),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              width: 200,
                                              padding:
                                                  const EdgeInsets.all(3.0),
                                              child: Text(
                                                '${renTal_name}',
                                                overflow: TextOverflow.ellipsis,
                                                // minFontSize: 5,
                                                // maxFontSize: 15,
                                                maxLines: 1,
                                                textAlign: TextAlign.left,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle1
                                                    ?.copyWith(
                                                      fontSize: 18.0,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                8, 0, 0, 0),
                                            child: Container(
                                              width: 220,
                                              child: Row(
                                                children: [
                                                  const Align(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: Icon(
                                                      Icons
                                                          .location_on_outlined,
                                                      color: Colors.red,
                                                      size: 15,
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      renTal_Porvi.toString(),
                                                      // minFontSize: 1,
                                                      // maxFontSize: 12,
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      textAlign: TextAlign.left,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .subtitle1
                                                          ?.copyWith(
                                                            fontSize: 12.0,
                                                            // fontWeight:
                                                            //     FontWeight.w700,
                                                          ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                8, 2, 0, 0),
                                            child: Container(
                                              width: 220,
                                              child: Column(
                                                children: [
                                                  Text(
                                                    'พบ ${areaModels.length} พื้นที่พร้อมให้เช่า',

                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    // minFontSize: 1,
                                                    // maxFontSize: 12,
                                                    maxLines: 1,
                                                    textAlign: TextAlign.left,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .subtitle1
                                                        ?.copyWith(
                                                          fontSize: 15.0,
                                                          // fontWeight:
                                                          //     FontWeight.w700,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: 220,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Container(
                                                  width: 110,
                                                  child: Divider(
                                                    color: const Color.fromARGB(
                                                            255, 23, 82, 129)
                                                        .withOpacity(0.5),
                                                    height: 10.0,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                8, 8, 0, 8),
                                            child: Container(
                                              width: 220,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      color:
                                                          const Color.fromARGB(
                                                                  255,
                                                                  138,
                                                                  216,
                                                                  115)
                                                              .withOpacity(0.5),
                                                      borderRadius:
                                                          const BorderRadius
                                                              .only(
                                                        topLeft:
                                                            Radius.circular(5),
                                                        topRight:
                                                            Radius.circular(5),
                                                        bottomLeft:
                                                            Radius.circular(5),
                                                        bottomRight:
                                                            Radius.circular(5),
                                                      ),
                                                    ),
                                                    padding:
                                                        const EdgeInsets.all(
                                                            2.0),
                                                    child: Text(
                                                      '$typex',
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      // minFontSize: 1,
                                                      // maxFontSize: 12,
                                                      maxLines: 1,
                                                      textAlign: TextAlign.left,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .subtitle1
                                                          ?.copyWith(
                                                            fontSize: 15.0,
                                                            // fontWeight:
                                                            //     FontWeight.w700,
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
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(8, 8, 8, 8),
                                    child: Container(
                                      // color: Colors.green,
                                      width: 200,
                                      height: 280,
                                      child: Column(
                                        children: [
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              'แก้ไขรูปภาพหน้าปก',
                                              overflow: TextOverflow.ellipsis,
                                              // minFontSize: 1,
                                              // maxFontSize: 12,
                                              maxLines: 1,
                                              textAlign: TextAlign.left,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle1
                                                  ?.copyWith(
                                                    fontSize: 15.0,
                                                    // fontWeight:
                                                    //     FontWeight.w700,
                                                  ),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: InkWell(
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(4.0),
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Colors.green,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    8),
                                                            topRight:
                                                                Radius.circular(
                                                                    8),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    8),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    8)),
                                                    // border: Border.all(
                                                    //     color: Colors.grey, width: 3),
                                                  ),
                                                  width: 150,
                                                  child: Center(
                                                    child: Text(
                                                      (man_img_ == null ||
                                                              man_img_ == '')
                                                          ? 'เพิ่ม'
                                                          : 'แก้ไข',
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontFamily:
                                                            FontWeight_.Fonts_T,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        //fontSize: 10.0
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                onTap: () async {
                                                  if (man_img_ == null ||
                                                      man_img_.toString() ==
                                                          '') {
                                                    uploadFile_Imgman('manimg');
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
                                                            'มีรูปหน้าปกอยู่แล้ว ',
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
                                                              SingleChildScrollView(
                                                            child: ListBody(
                                                              children: const <
                                                                  Widget>[
                                                                Text(
                                                                  'มีหน้าปก หากต้องการอัพโหลดกรุณาลบรูปหน้าปกที่มีอยู่แล้วก่อน',
                                                                  style: TextStyle(
                                                                      color: SettingScreen_Color
                                                                          .Colors_Text2_,
                                                                      fontFamily:
                                                                          Font_
                                                                              .Fonts_T),
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
                                                                          const EdgeInsets.all(
                                                                              8.0),
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
                                                                          // String url =
                                                                          //     await '${MyConstant().domain}/files/$foder/logo/$img_logo';
                                                                          deletedFile_(
                                                                            'manimg',
                                                                            '$man_img_',
                                                                          );

                                                                          Navigator.of(context)
                                                                              .pop();
                                                                        },
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
                                                                            child:
                                                                                InkWell(
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
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              'แก้ไขชื่อ',
                                              overflow: TextOverflow.ellipsis,
                                              // minFontSize: 1,
                                              // maxFontSize: 12,
                                              maxLines: 1,
                                              textAlign: TextAlign.left,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle1
                                                  ?.copyWith(
                                                    fontSize: 15.0,
                                                    // fontWeight:
                                                    //     FontWeight.w700,
                                                  ),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: SizedBox(
                                                // width: 200,
                                                child: TextFormField(
                                                  // keyboardType: TextInputType.number,
                                                  controller: rental_name_text,

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
                                                      labelStyle:
                                                          const TextStyle(
                                                        color: Colors.black54,
                                                        fontFamily:
                                                            FontWeight_.Fonts_T,
                                                      )),
                                                  // inputFormatters: <TextInputFormatter>[
                                                  //   // for below version 2 use this
                                                  //   // FilteringTextInputFormatter.allow(
                                                  //   //     RegExp(r'[0-9]')),
                                                  //   // for version 2 and greater youcan also use this
                                                  //   FilteringTextInputFormatter.digitsOnly
                                                  // ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: InkWell(
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            4.0),
                                                    decoration:
                                                        const BoxDecoration(
                                                      color: Colors.green,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topLeft: Radius
                                                                  .circular(8),
                                                              topRight: Radius
                                                                  .circular(8),
                                                              bottomLeft: Radius
                                                                  .circular(8),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          8)),
                                                      // border: Border.all(
                                                      //     color: Colors.grey, width: 3),
                                                    ),
                                                    width: 150,
                                                    child: const Center(
                                                      child: Text(
                                                        'บันทึก',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontFamily:
                                                              FontWeight_
                                                                  .Fonts_T,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          //fontSize: 10.0
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  onTap: () async {
                                                    ///-------------------------------->

                                                    String value_ =
                                                        '${rental_name_text.text}';

                                                    ///-------------------------------->
                                                    SharedPreferences
                                                        preferences =
                                                        await SharedPreferences
                                                            .getInstance();
                                                    String? ren = preferences
                                                        .getString('renTalSer');
                                                    String? ser_user =
                                                        preferences
                                                            .getString('ser');
                                                    //UpC_rental_data_editweb
                                                    String url =
                                                        '${MyConstant().domain}/UpC_rental_data_editweb.php?isAdd=true&ren=$ren&ser=$ser_user&value=$value_&typevalue=8';

                                                    try {
                                                      var response = await http
                                                          .get(Uri.parse(url));

                                                      var result =
                                                          await json.decode(
                                                              response.body);

                                                      if (result.toString() ==
                                                          'true') {
                                                        setState(() {
                                                          signInThread();
                                                          read_GC_rental();
                                                          read_GC_area();
                                                          read_GC_rentaldata();
                                                          read_GC_rental_img();
                                                        });
                                                      } else {}
                                                    } catch (e) {
                                                      print(e);
                                                    }
                                                  },
                                                )),
                                          ),
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              'แก้ไขจังหวัด',
                                              overflow: TextOverflow.ellipsis,
                                              // minFontSize: 1,
                                              // maxFontSize: 12,
                                              maxLines: 1,
                                              textAlign: TextAlign.left,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle1
                                                  ?.copyWith(
                                                    fontSize: 15.0,
                                                    // fontWeight:
                                                    //     FontWeight.w700,
                                                  ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  topLeft: Radius.circular(10),
                                                  topRight: Radius.circular(10),
                                                  bottomLeft:
                                                      Radius.circular(10),
                                                  bottomRight:
                                                      Radius.circular(10),
                                                ),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.5),
                                                    spreadRadius: 5,
                                                    blurRadius: 7,
                                                    offset: const Offset(0,
                                                        3), // changes position of shadow
                                                  ),
                                                ],
                                              ),
                                              child: DropdownButtonFormField2(
                                                focusColor: Colors.white,
                                                autofocus: false,
                                                decoration: InputDecoration(
                                                  enabled: true,
                                                  hoverColor: Colors.brown,
                                                  prefixIconColor: Colors.blue,
                                                  fillColor: Colors.white
                                                      .withOpacity(0.05),
                                                  filled: false,
                                                  isDense: true,
                                                  contentPadding:
                                                      EdgeInsets.zero,
                                                  border: OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                            color: Colors.red),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  focusedBorder:
                                                      const OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topRight:
                                                          Radius.circular(10),
                                                      topLeft:
                                                          Radius.circular(10),
                                                      bottomRight:
                                                          Radius.circular(10),
                                                      bottomLeft:
                                                          Radius.circular(10),
                                                    ),
                                                    borderSide: BorderSide(
                                                      width: 1,
                                                      color: Color.fromARGB(
                                                          255, 231, 227, 227),
                                                    ),
                                                  ),
                                                ),
                                                isExpanded: false,
                                                hint: Text(
                                                  renTal_Porvi == null
                                                      ? ''
                                                      : '$renTal_Porvi',
                                                  maxLines: 1,
                                                  style: const TextStyle(
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    fontSize: 15,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                                icon: const Icon(
                                                  Icons.arrow_drop_down,
                                                  color: Colors.black,
                                                ),
                                                style: const TextStyle(
                                                  color: Colors.grey,
                                                ),
                                                iconSize: 30,
                                                buttonHeight: 40,
                                                // buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                                                dropdownDecoration:
                                                    BoxDecoration(
                                                  // color: Colors
                                                  //     .amber,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  border: Border.all(
                                                      color: Colors.white,
                                                      width: 1),
                                                ),
                                                items: provinceNamesTh
                                                    .map((item) =>
                                                        DropdownMenuItem<
                                                            String>(
                                                          value: '${item}',
                                                          child: Text(
                                                            'จังหวัด : ${item}',
                                                            style:
                                                                const TextStyle(
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                          ),
                                                        ))
                                                    .toList(),

                                                onChanged: (value) async {
                                                  setState(() {
                                                    renTal_Porvi = value;
                                                  });

                                                  ///-------------------------------->

                                                  String value_ =
                                                      await '${renTal_Porvi}';

                                                  ///-------------------------------->
                                                  SharedPreferences
                                                      preferences =
                                                      await SharedPreferences
                                                          .getInstance();
                                                  String? ren = preferences
                                                      .getString('renTalSer');
                                                  String? ser_user = preferences
                                                      .getString('ser');
                                                  //UpC_rental_data_editweb
                                                  String url =
                                                      '${MyConstant().domain}/UpC_rental_data_editweb.php?isAdd=true&ren=$ren&ser=$ser_user&value=$value_&typevalue=9';

                                                  try {
                                                    var response = await http
                                                        .get(Uri.parse(url));

                                                    var result = await json
                                                        .decode(response.body);

                                                    if (result.toString() ==
                                                        'true') {
                                                      setState(() {
                                                        signInThread();
                                                        read_GC_rental();
                                                        read_GC_area();
                                                        read_GC_rentaldata();
                                                        read_GC_rental_img();
                                                      });
                                                    } else {}
                                                  } catch (e) {
                                                    print(e);
                                                  }
                                                },
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const Expanded(flex: 1, child: Text('')),
                                Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                        child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Align(
                                          alignment: Alignment.topCenter,
                                          child: Text(
                                            '📠 ช่องทางการติดต่อ',

                                            overflow: TextOverflow.ellipsis,
                                            // minFontSize: 1,
                                            // maxFontSize: 12,
                                            maxLines: 1,
                                            textAlign: TextAlign.left,
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle1
                                                ?.copyWith(
                                                  fontSize: 15.0,
                                                  // fontWeight:
                                                  //     FontWeight.w700,
                                                ),
                                          ),
                                        ),
                                        Stack(
                                          children: [
                                            Container(
                                              height: 190,
                                              width: 210,
                                              decoration: BoxDecoration(
                                                color: Colors.grey[100]!
                                                    .withOpacity(0.5),
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  topLeft: Radius.circular(10),
                                                  topRight: Radius.circular(10),
                                                  bottomLeft:
                                                      Radius.circular(10),
                                                  bottomRight:
                                                      Radius.circular(10),
                                                ),
                                                border: Border.all(
                                                    color: Colors.grey,
                                                    width: 1),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(3.0),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(8.0),
                                                    topRight:
                                                        Radius.circular(8.0),
                                                    bottomLeft:
                                                        Radius.circular(8.0),
                                                    bottomRight:
                                                        Radius.circular(8.0),
                                                  ),
                                                  child: (qr_img_ == null ||
                                                          qr_img_ == '')
                                                      ? Icon(Icons
                                                          .image_not_supported)
                                                      : Image.network(
                                                          '${MyConstant().domain}/files/$foder/webfont/qrimg/$qr_img_',
                                                          fit: BoxFit.fill,
                                                          height: 180,
                                                          width: 200,
                                                        ),
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              bottom: 0,
                                              left: 20,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: InkWell(
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            4.0),
                                                    decoration:
                                                        const BoxDecoration(
                                                      color: Colors.green,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topLeft: Radius
                                                                  .circular(8),
                                                              topRight: Radius
                                                                  .circular(8),
                                                              bottomLeft: Radius
                                                                  .circular(8),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          8)),
                                                      // border: Border.all(
                                                      //     color: Colors.grey, width: 3),
                                                    ),
                                                    width: 150,
                                                    child: Center(
                                                      child: Text(
                                                        (qr_img_ == null ||
                                                                qr_img_ == '')
                                                            ? 'เพิ่ม'
                                                            : 'แก้ไข',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontFamily:
                                                              FontWeight_
                                                                  .Fonts_T,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          //fontSize: 10.0
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  onTap: () async {
                                                    if (qr_img_ == null ||
                                                        qr_img_.toString() ==
                                                            '') {
                                                      uploadFile_Imgman(
                                                          'qrimg');
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
                                                              'มีรูป QR Code อยู่แล้ว',
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
                                                                SingleChildScrollView(
                                                              child: ListBody(
                                                                children: const <
                                                                    Widget>[
                                                                  Text(
                                                                    'มีหน้าปก หากต้องการอัพโหลดกรุณาลบรูปหน้าปกที่มีอยู่แล้วก่อน',
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
                                                                            // String url =
                                                                            //     await '${MyConstant().domain}/files/$foder/logo/$img_logo';
                                                                            deletedFile_(
                                                                              'qrimg',
                                                                              '$qr_img_',
                                                                            );

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
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SizedBox(
                                            // width: 200,
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Column(
                                                      children: [
                                                        Align(
                                                          alignment:
                                                              Alignment.topLeft,
                                                          child: Text(
                                                            'Line',

                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            // minFontSize: 1,
                                                            // maxFontSize: 12,
                                                            maxLines: 1,
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .subtitle1
                                                                ?.copyWith(
                                                                  fontSize:
                                                                      15.0,
                                                                  // fontWeight:
                                                                  //     FontWeight.w700,
                                                                ),
                                                          ),
                                                        ),
                                                        TextFormField(
                                                          // keyboardType: TextInputType.number,
                                                          controller:
                                                              rental_Line_text,

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
                                                                  labelStyle:
                                                                      const TextStyle(
                                                                    color: Colors
                                                                        .black54,
                                                                    fontFamily:
                                                                        FontWeight_
                                                                            .Fonts_T,
                                                                  )),
                                                          // inputFormatters: <TextInputFormatter>[
                                                          //   // for below version 2 use this
                                                          //   // FilteringTextInputFormatter.allow(
                                                          //   //     RegExp(r'[0-9]')),
                                                          //   // for version 2 and greater youcan also use this
                                                          //   FilteringTextInputFormatter.digitsOnly
                                                          // ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Column(
                                                      children: [
                                                        Align(
                                                          alignment:
                                                              Alignment.topLeft,
                                                          child: Text(
                                                            'Facebook',

                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            // minFontSize: 1,
                                                            // maxFontSize: 12,
                                                            maxLines: 1,
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .subtitle1
                                                                ?.copyWith(
                                                                  fontSize:
                                                                      15.0,
                                                                  // fontWeight:
                                                                  //     FontWeight.w700,
                                                                ),
                                                          ),
                                                        ),
                                                        TextFormField(
                                                          // keyboardType: TextInputType.number,
                                                          controller:
                                                              rental_Facebook_text,

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
                                                                  labelStyle:
                                                                      const TextStyle(
                                                                    color: Colors
                                                                        .black54,
                                                                    fontFamily:
                                                                        FontWeight_
                                                                            .Fonts_T,
                                                                  )),
                                                          // inputFormatters: <TextInputFormatter>[
                                                          //   // for below version 2 use this
                                                          //   // FilteringTextInputFormatter.allow(
                                                          //   //     RegExp(r'[0-9]')),
                                                          //   // for version 2 and greater youcan also use this
                                                          //   FilteringTextInputFormatter.digitsOnly
                                                          // ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  'Url Youtube',

                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  // minFontSize: 1,
                                                  // maxFontSize: 12,
                                                  maxLines: 1,
                                                  textAlign: TextAlign.left,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .subtitle1
                                                      ?.copyWith(
                                                        fontSize: 15.0,
                                                        // fontWeight:
                                                        //     FontWeight.w700,
                                                      ),
                                                ),
                                              ),
                                              TextFormField(
                                                // keyboardType: TextInputType.number,
                                                controller:
                                                    rental_UrlYoutube_text,
                                                maxLines: 2,
                                                style: TextStyle(
                                                  color: Colors.blue[300],
                                                  fontFamily: Font_.Fonts_T,
                                                  // fontWeight: FontWeight.bold,
                                                  //fontSize: 10.0
                                                ),
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
                                                  labelStyle: const TextStyle(
                                                    color: Colors.black54,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T,
                                                  ),
                                                ),
                                                // inputFormatters: <TextInputFormatter>[
                                                //   // for below version 2 use this
                                                //   // FilteringTextInputFormatter.allow(
                                                //   //     RegExp(r'[0-9]')),
                                                //   // for version 2 and greater youcan also use this
                                                //   FilteringTextInputFormatter.digitsOnly
                                                // ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: InkWell(
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              decoration: const BoxDecoration(
                                                color: Colors.green,
                                                borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(8),
                                                    topRight:
                                                        Radius.circular(8),
                                                    bottomLeft:
                                                        Radius.circular(8),
                                                    bottomRight:
                                                        Radius.circular(8)),
                                                // border: Border.all(
                                                //     color: Colors.grey, width: 3),
                                              ),
                                              width: 150,
                                              child: const Center(
                                                child: Text(
                                                  'บันทึก',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T,
                                                    fontWeight: FontWeight.bold,
                                                    //fontSize: 10.0
                                                  ),
                                                ),
                                              ),
                                            ),
                                            onTap: () async {
                                              ///-------------------------------->

                                              String line_ =
                                                  '${rental_Line_text.text}';
                                              String face_ =
                                                  '${rental_Facebook_text.text}';
                                              String yout_ =
                                                  '${rental_UrlYoutube_text.text}';

                                              ///-------------------------------->
                                              SharedPreferences preferences =
                                                  await SharedPreferences
                                                      .getInstance();
                                              String? ren = preferences
                                                  .getString('renTalSer');
                                              String? ser_user =
                                                  preferences.getString('ser');
                                              //UpC_rental_data_editweb
                                              String url =
                                                  '${MyConstant().domain}/UpC_rental_data_editweb.php?isAdd=true&ren=$ren&ser=$ser_user&value='
                                                  '&lines=$line_&faces=$face_&youts=$yout_&typevalue=4';

                                              try {
                                                var response = await http
                                                    .get(Uri.parse(url));

                                                var result = await json
                                                    .decode(response.body);

                                                if (result.toString() ==
                                                    'true') {
                                                  setState(() {
                                                    signInThread();
                                                    read_GC_rental();
                                                    read_GC_area();
                                                    read_GC_rentaldata();
                                                    read_GC_rental_img();
                                                  });
                                                } else {}
                                              } catch (e) {
                                                print(e);
                                              }
                                            },
                                          ),
                                        ),
                                      ],
                                    )),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'ตั้งค่ารูปอื่นๆ',
                          style: TextStyle(
                            color: SettingScreen_Color.Colors_Text1_,
                            fontFamily: FontWeight_.Fonts_T,
                            fontWeight: FontWeight.bold,
                            //fontSize: 10.0
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          child: Container(
                            padding: const EdgeInsets.all(4.0),
                            decoration: const BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  topRight: Radius.circular(8),
                                  bottomLeft: Radius.circular(8),
                                  bottomRight: Radius.circular(8)),
                              // border: Border.all(
                              //     color: Colors.grey, width: 3),
                            ),
                            child: const Center(
                              child: Text(
                                '+เพิ่ม',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: FontWeight_.Fonts_T,
                                  fontWeight: FontWeight.bold,
                                  //fontSize: 10.0
                                ),
                              ),
                            ),
                          ),
                          onTap: () {
                            uploadFile_Imgman('abountimg');
                          },
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:
                        // Container(
                        //     height: 120,
                        //     width: 510,
                        //     child: ClipRRect(
                        //         borderRadius: BorderRadius.circular(8.0),
                        //         child: FittedBox(
                        //           fit: BoxFit.cover,
                        //           child: Image.network(
                        //             'https://a.cdn-hotels.com/gdcs/production9/d114/4cdc90ef-91ee-4fb8-8aed-6b77a0c97e30.jpg',
                        //           ),
                        //         ))),
                        Container(
                      height: 200,
                      width: (!Responsive.isDesktop(context))
                          ? 800
                          : MediaQuery.of(context).size.width * 0.8,
                      child: ScrollConfiguration(
                        behavior: ScrollConfiguration.of(context)
                            .copyWith(dragDevices: {
                          PointerDeviceKind.touch,
                          PointerDeviceKind.mouse,
                        }),
                        child: ListView.builder(
                            //controller: scrollController1,
                            scrollDirection: Axis.horizontal,
                            itemCount: renTalimgModels.length,
                            itemBuilder: (context, index) {
                              return Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: 190,
                                      width: 210,
                                      decoration: BoxDecoration(
                                        color:
                                            Colors.grey[100]!.withOpacity(0.5),
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10),
                                        ),
                                        border: Border.all(
                                            color: Colors.grey, width: 1),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: ClipRRect(
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(8.0),
                                            topRight: Radius.circular(8.0),
                                            bottomLeft: Radius.circular(8.0),
                                            bottomRight: Radius.circular(8.0),
                                          ),
                                          child: (renTalimgModels[index].img ==
                                                      null ||
                                                  renTalimgModels[index].img ==
                                                      '')
                                              ? Icon(Icons.image_not_supported)
                                              : Image.network(
                                                  '${MyConstant().domain}/files/$foder/webfont/abountimg/${renTalimgModels[index].img}',
                                                  fit: BoxFit.fill,
                                                  height: 180,
                                                  width: 200,
                                                ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  // Padding(
                                  //   padding: const EdgeInsets.all(8.0),
                                  //   child: Container(
                                  //     decoration: BoxDecoration(
                                  //       borderRadius: const BorderRadius.only(
                                  //           topLeft: Radius.circular(8),
                                  //           topRight: Radius.circular(8),
                                  //           bottomLeft: Radius.circular(8),
                                  //           bottomRight: Radius.circular(8)),
                                  //       border: Border.all(
                                  //           color: Colors.grey, width: 2),
                                  //     ),
                                  //     child: Padding(
                                  //       padding: const EdgeInsets.all(2.0),
                                  //       child: InkWell(
                                  //         onTap: () {},
                                  //         child: Container(
                                  //           width: 150,
                                  //           height: 120,
                                  //           decoration: const BoxDecoration(
                                  //             borderRadius: BorderRadius.only(
                                  //                 topLeft: Radius.circular(8),
                                  //                 topRight: Radius.circular(8),
                                  //                 bottomLeft:
                                  //                     Radius.circular(8),
                                  //                 bottomRight:
                                  //                     Radius.circular(8)),
                                  //             // border: (ser_List_IMG_ == index)
                                  //             //     ? Border.all(
                                  //             //         color: Colors.blueAccent,
                                  //             //         width: 3)
                                  //             //     : null,
                                  //           ),
                                  //           child: ClipRRect(
                                  //             borderRadius:
                                  //                 BorderRadius.circular(8.0),
                                  //             child: FittedBox(
                                  //               fit: BoxFit.cover,
                                  //               child: Image.network(
                                  //                 '${MyConstant().domain}/files/$foder/webfont/abountimg/${renTalimgModels[index].img}',
                                  //                 width: 150,
                                  //                 height: 120,
                                  //               ),
                                  //             ),
                                  //           ),
                                  //         ),
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
                                  Positioned(
                                      top: 15,
                                      right: 15,
                                      child: InkWell(
                                        onTap: () async {
                                          String imag =
                                              '${renTalimgModels[index].img}';
                                          deletedFile_(
                                            'abountimg',
                                            '$imag',
                                          );
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.blueGrey[100],
                                              shape: BoxShape.circle),
                                          child: const Icon(
                                            Icons.close_rounded,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ))
                                ],
                              );
                            }),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'ตั้งค่ารายละเอียดพื้นที่',
                          style: TextStyle(
                            color: SettingScreen_Color.Colors_Text1_,
                            fontFamily: FontWeight_.Fonts_T,
                            fontWeight: FontWeight.bold,
                            //fontSize: 10.0
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            const Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(20, 8, 8, 8),
                                child: Text(
                                  'เวลาทำการ',
                                  style: TextStyle(
                                    color: SettingScreen_Color.Colors_Text1_,
                                    fontFamily: FontWeight_.Fonts_T,
                                    fontWeight: FontWeight.bold,
                                    //fontSize: 10.0
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      // keyboardType: TextInputType.number,
                                      controller: Stimeinput,

                                      // maxLength: 13,
                                      cursorColor: Colors.green,

                                      readOnly:
                                          true, //set it true, so that user will not able to edit text
                                      decoration: InputDecoration(
                                          labelText:
                                              "เวลาเปิด", //label text of field
                                          fillColor:
                                              Colors.white.withOpacity(0.3),
                                          filled: true,
                                          // prefixIcon:
                                          //     const Icon(Icons.person_pin, color: Colors.black),
                                          // suffixIcon: Icon(Icons.clear, color: Colors.black),
                                          focusedBorder:
                                              const OutlineInputBorder(
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
                                          enabledBorder:
                                              const OutlineInputBorder(
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
                                          labelStyle: const TextStyle(
                                            color: Colors.black54,
                                            fontFamily: FontWeight_.Fonts_T,
                                          )),
                                      onTap: () async {
                                        TimeOfDay? pickedTime =
                                            await showTimePicker(
                                          initialTime: TimeOfDay.now(),
                                          context: context,
                                        );

                                        if (pickedTime != null) {
                                          print(pickedTime.format(
                                              context)); //output 10:51 PM
                                          DateTime parsedTime = DateFormat.jm()
                                              .parse(pickedTime
                                                  .format(context)
                                                  .toString());
                                          //converting to DateTime so that we can further format on different pattern.
                                          print(
                                              parsedTime); //output 1970-01-01 22:53:00.000
                                          String formattedTime =
                                              DateFormat('HH:mm:ss')
                                                  .format(parsedTime);
                                          print(
                                              formattedTime); //output 14:59:00
                                          //DateFormat() is from intl package, you can format the time on any pattern you need.

                                          setState(() {
                                            Stimeinput.text =
                                                formattedTime; //set the value of text field.
                                          });
                                        } else {
                                          print("Time is not selected");
                                        }
                                      },
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      // keyboardType: TextInputType.number,
                                      controller: ltimeinput,

                                      // maxLength: 13,
                                      cursorColor: Colors.green,

                                      readOnly:
                                          true, //set it true, so that user will not able to edit text
                                      decoration: InputDecoration(
                                          labelText:
                                              "เวลาปิด", //label text of field
                                          fillColor:
                                              Colors.white.withOpacity(0.3),
                                          filled: true,
                                          // prefixIcon:
                                          //     const Icon(Icons.person_pin, color: Colors.black),
                                          // suffixIcon: Icon(Icons.clear, color: Colors.black),
                                          focusedBorder:
                                              const OutlineInputBorder(
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
                                          enabledBorder:
                                              const OutlineInputBorder(
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
                                          labelStyle: const TextStyle(
                                            color: Colors.black54,
                                            fontFamily: FontWeight_.Fonts_T,
                                          )),
                                      onTap: () async {
                                        TimeOfDay? pickedTime =
                                            await showTimePicker(
                                          initialTime: TimeOfDay.now(),
                                          context: context,
                                        );

                                        if (pickedTime != null) {
                                          print(pickedTime.format(
                                              context)); //output 10:51 PM
                                          DateTime parsedTime = DateFormat.jm()
                                              .parse(pickedTime
                                                  .format(context)
                                                  .toString());
                                          //converting to DateTime so that we can further format on different pattern.
                                          print(
                                              parsedTime); //output 1970-01-01 22:53:00.000
                                          String formattedTime =
                                              DateFormat('HH:mm:ss')
                                                  .format(parsedTime);
                                          print(
                                              formattedTime); //output 14:59:00
                                          //DateFormat() is from intl package, you can format the time on any pattern you need.

                                          setState(() {
                                            ltimeinput.text =
                                                formattedTime; //set the value of text field.
                                          });
                                        } else {
                                          print("Time is not selected");
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  child: Container(
                                    padding: const EdgeInsets.all(4.0),
                                    decoration: const BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(8),
                                          topRight: Radius.circular(8),
                                          bottomLeft: Radius.circular(8),
                                          bottomRight: Radius.circular(8)),
                                      // border: Border.all(
                                      //     color: Colors.grey, width: 3),
                                    ),
                                    width: 150,
                                    child: const Center(
                                      child: Text(
                                        'บันทึก',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: FontWeight_.Fonts_T,
                                          fontWeight: FontWeight.bold,
                                          //fontSize: 10.0
                                        ),
                                      ),
                                    ),
                                  ),
                                  onTap: () async {
                                    ///-------------------------------->

                                    String Stime_ = '${Stimeinput.text}';
                                    String ltime_ = '${ltimeinput.text}';

                                    ///-------------------------------->
                                    SharedPreferences preferences =
                                        await SharedPreferences.getInstance();
                                    String? ren =
                                        preferences.getString('renTalSer');
                                    String? ser_user =
                                        preferences.getString('ser');
                                    //UpC_rental_data_editweb
                                    String url =
                                        '${MyConstant().domain}/UpC_rental_data_editweb.php?isAdd=true&ren=$ren&ser=$ser_user&value='
                                        '&stime=$Stime_&ltime=$ltime_&typevalue=3';

                                    try {
                                      var response =
                                          await http.get(Uri.parse(url));

                                      var result =
                                          await json.decode(response.body);

                                      if (result.toString() == 'true') {
                                        setState(() {
                                          signInThread();
                                          read_GC_rental();
                                          read_GC_area();
                                          read_GC_rentaldata();
                                          read_GC_rental_img();
                                        });
                                      } else {}
                                    } catch (e) {
                                      print(e);
                                    }
                                  },
                                )),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            const Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(20, 8, 8, 8),
                                child: Text(
                                  'Url Google Map  ที่อยู่',
                                  style: TextStyle(
                                    color: SettingScreen_Color.Colors_Text1_,
                                    fontFamily: FontWeight_.Fonts_T,
                                    fontWeight: FontWeight.bold,
                                    //fontSize: 10.0
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                // keyboardType: TextInputType.number,
                                controller: rental_Urladdr_text,
                                style: TextStyle(
                                  color: Colors.blue[300],
                                  fontFamily: Font_.Fonts_T,
                                  // fontWeight: FontWeight.bold,
                                  //fontSize: 10.0
                                ),
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
                                    labelStyle: const TextStyle(
                                      color: Colors.black54,
                                      fontFamily: FontWeight_.Fonts_T,
                                    )),
                                // inputFormatters: <TextInputFormatter>[
                                //   // for below version 2 use this
                                //   // FilteringTextInputFormatter.allow(
                                //   //     RegExp(r'[0-9]')),
                                //   // for version 2 and greater youcan also use this
                                //   FilteringTextInputFormatter.digitsOnly
                                // ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                child: Container(
                                  padding: const EdgeInsets.all(4.0),
                                  decoration: const BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(8),
                                        topRight: Radius.circular(8),
                                        bottomLeft: Radius.circular(8),
                                        bottomRight: Radius.circular(8)),
                                    // border: Border.all(
                                    //     color: Colors.grey, width: 3),
                                  ),
                                  width: 150,
                                  child: const Center(
                                    child: Text(
                                      'บันทึก',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: FontWeight_.Fonts_T,
                                        fontWeight: FontWeight.bold,
                                        //fontSize: 10.0
                                      ),
                                    ),
                                  ),
                                ),
                                onTap: () async {
                                  ///-------------------------------->

                                  String new_value =
                                      '${rental_Urladdr_text.text}';

                                  ///-------------------------------->
                                  SharedPreferences preferences =
                                      await SharedPreferences.getInstance();
                                  String? ren =
                                      preferences.getString('renTalSer');
                                  String? ser_user =
                                      preferences.getString('ser');
                                  //UpC_rental_data_editweb
                                  String url =
                                      '${MyConstant().domain}/UpC_rental_data_editweb.php?isAdd=true&ren=$ren&ser=$ser_user&value=${new_value}&typevalue=2';

                                  try {
                                    var response =
                                        await http.get(Uri.parse(url));

                                    var result =
                                        await json.decode(response.body);

                                    if (result.toString() == 'true') {
                                      setState(() {
                                        signInThread();
                                        read_GC_rental();
                                        read_GC_area();
                                        read_GC_rentaldata();
                                        read_GC_rental_img();
                                      });
                                    } else {}
                                  } catch (e) {
                                    print(e);
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.fromLTRB(20, 8, 8, 8),
                        child: Text(
                          'สิ่งอำนวยความสะดวก',
                          style: TextStyle(
                            color: SettingScreen_Color.Colors_Text1_,
                            fontFamily: FontWeight_.Fonts_T,
                            fontWeight: FontWeight.bold,
                            //fontSize: 10.0
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          child: Container(
                            padding: const EdgeInsets.all(4.0),
                            decoration: const BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  topRight: Radius.circular(8),
                                  bottomLeft: Radius.circular(8),
                                  bottomRight: Radius.circular(8)),
                              // border: Border.all(
                              //     color: Colors.grey, width: 3),
                            ),
                            child: const Center(
                              child: Text(
                                '+เพิ่ม',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: FontWeight_.Fonts_T,
                                  fontWeight: FontWeight.bold,
                                  //fontSize: 10.0
                                ),
                              ),
                            ),
                          ),
                          onTap: () {
                            showDialog<String>(
                              barrierDismissible: false,
                              context: context,
                              builder: (BuildContext context) => StreamBuilder(
                                stream:
                                    Stream.periodic(const Duration(seconds: 1)),
                                builder: (context, snapshot) {
                                  return AlertDialog(
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20.0))),
                                    title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          decoration: const BoxDecoration(
                                            // color:
                                            //     Color.fromARGB(255, 23, 82, 129).withOpacity(0.5),
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(6),
                                              topRight: Radius.circular(6),
                                              bottomLeft: Radius.circular(6),
                                              bottomRight: Radius.circular(6),
                                            ),
                                            // border: Border.all(color: Colors.grey, width: 1),
                                          ),
                                          padding: const EdgeInsets.all(5.0),
                                          child: const Center(
                                              child: Text(
                                            'สิ่งอำนวยความสะดวก',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )),
                                        ),
                                      ],
                                    ),
                                    content: SingleChildScrollView(
                                      child: ListBody(
                                        children: <Widget>[
                                          Container(
                                            decoration: const BoxDecoration(
                                              // color: Colors.green,
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(6),
                                                topRight: Radius.circular(6),
                                                bottomLeft: Radius.circular(6),
                                                bottomRight: Radius.circular(6),
                                              ),
                                              // border: Border.all(color: Colors.grey, width: 1),
                                            ),
                                            padding: const EdgeInsets.all(8.0),
                                            child: TextFormField(
                                              showCursor: true, //add this line
                                              readOnly: false,
                                              controller:
                                                  rental_Facilities_text,
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
                                                  labelStyle: const TextStyle(
                                                    color: Colors.black54,
                                                  )),
                                              inputFormatters: [
                                                FilteringTextInputFormatter
                                                    .deny(','),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    actions: <Widget>[
                                      Column(
                                        children: [
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
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Container(
                                                    width: 100,
                                                    decoration: BoxDecoration(
                                                      color:
                                                          (rental_Facilities_text
                                                                      .text ==
                                                                  '')
                                                              ? Colors
                                                                  .green[100]
                                                              : Colors.green,
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
                                                    ),
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: TextButton(
                                                      onPressed:
                                                          (rental_Facilities_text
                                                                      .text ==
                                                                  '')
                                                              ? null
                                                              : () async {
                                                                  ///-------------------------------->
                                                                  String
                                                                      n_facilities_new =
                                                                      '';
                                                                  String
                                                                      new_value =
                                                                      rental_Facilities_text
                                                                          .text
                                                                          .toString();

                                                                  for (int index =
                                                                          0;
                                                                      index <
                                                                          facilities
                                                                              .length;
                                                                      index++) {
                                                                    n_facilities_new +=
                                                                        '${facilities[index]},';
                                                                  }

                                                                  n_facilities_new +=
                                                                      new_value;

                                                                  print(
                                                                      n_facilities_new);

                                                                  ///-------------------------------->
                                                                  SharedPreferences
                                                                      preferences =
                                                                      await SharedPreferences
                                                                          .getInstance();
                                                                  String? ren =
                                                                      preferences
                                                                          .getString(
                                                                              'renTalSer');
                                                                  String?
                                                                      ser_user =
                                                                      preferences
                                                                          .getString(
                                                                              'ser');

                                                                  String url =
                                                                      '${MyConstant().domain}/UpC_rental_data_Fac_AND_places.php?isAdd=true&ren=$ren&ser=$ser_user&value=${n_facilities_new},&typevalue=1';

                                                                  try {
                                                                    var response =
                                                                        await http
                                                                            .get(Uri.parse(url));

                                                                    var result =
                                                                        json.decode(
                                                                            response.body);
                                                                    if (result
                                                                            .toString() ==
                                                                        'true') {
                                                                      setState(
                                                                          () {
                                                                        signInThread();
                                                                        read_GC_rental();
                                                                        read_GC_area();
                                                                        read_GC_rentaldata();
                                                                        read_GC_rental_img();
                                                                      });
                                                                      Navigator.pop(
                                                                          context,
                                                                          'OK');
                                                                    } else {}
                                                                  } catch (e) {
                                                                    print(e);
                                                                  }
                                                                },
                                                      child: const Text(
                                                        'ยืนยัน',
                                                        style: TextStyle(
                                                          color: Colors.white,
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
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Container(
                                                        width: 100,
                                                        decoration:
                                                            const BoxDecoration(
                                                          color:
                                                              Colors.redAccent,
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
                                                        ),
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: TextButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context, 'OK');
                                                            setState(() {
                                                              rental_Facilities_text
                                                                  .clear();
                                                            });
                                                          },
                                                          child: const Text(
                                                            'ยกเลิก',
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
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
                                        ],
                                      ),
                                    ],
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      // height: 50,
                      padding: const EdgeInsets.all(4.0),
                      decoration: BoxDecoration(
                        // color: Colors.green,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8),
                            bottomLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8)),
                        border: Border.all(color: Colors.grey, width: 2),
                      ),
                      child: Row(
                        children: [
                          for (int index = 0;
                              index < facilities.length;
                              index++)
                            Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                      color: Colors.grey[300],
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text('${facilities[index]}')),
                                ),
                                Positioned(
                                    top: 0,
                                    right: 2,
                                    child: InkWell(
                                      onTap: () async {
                                        setState(() {
                                          facilities
                                              .remove('${facilities[index]}');
                                        });

                                        ///-------------------------------->
                                        String n_facilities_new = '';
                                        String new_value = '';

                                        for (int index = 0;
                                            index < facilities.length;
                                            index++) {
                                          setState(() {
                                            n_facilities_new +=
                                                '${facilities[index]},';
                                          });
                                        }

                                        ///-------------------------------->
                                        SharedPreferences preferences =
                                            await SharedPreferences
                                                .getInstance();
                                        String? ren =
                                            preferences.getString('renTalSer');
                                        String? ser_user =
                                            preferences.getString('ser');
                                        //UpC_rental_data_editweb
                                        String url =
                                            '${MyConstant().domain}/UpC_rental_data_Fac_AND_places.php?isAdd=true&ren=$ren&ser=$ser_user&value=${n_facilities_new}&typevalue=1';

                                        try {
                                          var response =
                                              await http.get(Uri.parse(url));

                                          var result =
                                              await json.decode(response.body);

                                          if (result.toString() == 'true') {
                                            setState(() {
                                              // signInThread();
                                              // read_GC_rental();
                                              // read_GC_area();
                                              // read_GC_rentaldata();
                                              // read_GC_rental_img();
                                            });
                                          } else {}
                                        } catch (e) {
                                          print(e);
                                        }
                                      },
                                      child: const Icon(
                                        Icons.close_rounded,
                                        color: Colors.red,
                                      ),
                                    ))
                              ],
                            ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.fromLTRB(20, 8, 8, 8),
                        child: Text(
                          'สถานที่ใกล้เคียง',
                          style: TextStyle(
                            color: SettingScreen_Color.Colors_Text1_,
                            fontFamily: FontWeight_.Fonts_T,
                            fontWeight: FontWeight.bold,
                            //fontSize: 10.0
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          child: Container(
                            padding: const EdgeInsets.all(4.0),
                            decoration: const BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  topRight: Radius.circular(8),
                                  bottomLeft: Radius.circular(8),
                                  bottomRight: Radius.circular(8)),
                              // border: Border.all(
                              //     color: Colors.grey, width: 3),
                            ),
                            child: const Center(
                              child: Text(
                                '+เพิ่ม',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: FontWeight_.Fonts_T,
                                  fontWeight: FontWeight.bold,
                                  //fontSize: 10.0
                                ),
                              ),
                            ),
                          ),
                          onTap: () {
                            showDialog<String>(
                              barrierDismissible: false,
                              context: context,
                              builder: (BuildContext context) => StreamBuilder(
                                stream:
                                    Stream.periodic(const Duration(seconds: 1)),
                                builder: (context, snapshot) {
                                  return AlertDialog(
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20.0))),
                                    title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          decoration: const BoxDecoration(
                                            // color:
                                            //     Color.fromARGB(255, 23, 82, 129).withOpacity(0.5),
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(6),
                                              topRight: Radius.circular(6),
                                              bottomLeft: Radius.circular(6),
                                              bottomRight: Radius.circular(6),
                                            ),
                                            // border: Border.all(color: Colors.grey, width: 1),
                                          ),
                                          padding: const EdgeInsets.all(5.0),
                                          child: const Center(
                                              child: Text(
                                            'สิ่งอำนวยความสะดวก',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )),
                                        ),
                                      ],
                                    ),
                                    content: SingleChildScrollView(
                                      child: ListBody(
                                        children: <Widget>[
                                          Container(
                                            decoration: const BoxDecoration(
                                              // color: Colors.green,
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(6),
                                                topRight: Radius.circular(6),
                                                bottomLeft: Radius.circular(6),
                                                bottomRight: Radius.circular(6),
                                              ),
                                              // border: Border.all(color: Colors.grey, width: 1),
                                            ),
                                            padding: const EdgeInsets.all(8.0),
                                            child: TextFormField(
                                              showCursor: true, //add this line
                                              readOnly: false,
                                              controller:
                                                  rental_Nearbyplaces_text,
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
                                                  labelStyle: const TextStyle(
                                                    color: Colors.black54,
                                                  )),
                                              inputFormatters: [
                                                FilteringTextInputFormatter
                                                    .deny(','),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    actions: <Widget>[
                                      Column(
                                        children: [
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
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Container(
                                                    width: 100,
                                                    decoration: BoxDecoration(
                                                      color:
                                                          (rental_Nearbyplaces_text
                                                                      .text ==
                                                                  '')
                                                              ? Colors
                                                                  .green[100]
                                                              : Colors.green,
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
                                                    ),
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: TextButton(
                                                      onPressed:
                                                          (rental_Nearbyplaces_text
                                                                      .text ==
                                                                  '')
                                                              ? null
                                                              : () async {
                                                                  ///-------------------------------->
                                                                  String
                                                                      n_places_new =
                                                                      '';
                                                                  String
                                                                      new_value =
                                                                      rental_Nearbyplaces_text
                                                                          .text
                                                                          .toString();

                                                                  for (int index =
                                                                          0;
                                                                      index <
                                                                          nearby_places
                                                                              .length;
                                                                      index++) {
                                                                    n_places_new +=
                                                                        '${nearby_places[index]},';
                                                                  }

                                                                  n_places_new +=
                                                                      new_value;

                                                                  print(
                                                                      n_places_new);

                                                                  ///-------------------------------->
                                                                  SharedPreferences
                                                                      preferences =
                                                                      await SharedPreferences
                                                                          .getInstance();
                                                                  String? ren =
                                                                      preferences
                                                                          .getString(
                                                                              'renTalSer');
                                                                  String?
                                                                      ser_user =
                                                                      preferences
                                                                          .getString(
                                                                              'ser');

                                                                  String url =
                                                                      '${MyConstant().domain}/UpC_rental_data_Fac_AND_places.php?isAdd=true&ren=$ren&ser=$ser_user&value=${n_places_new},&typevalue=2';

                                                                  try {
                                                                    var response =
                                                                        await http
                                                                            .get(Uri.parse(url));

                                                                    var result =
                                                                        json.decode(
                                                                            response.body);
                                                                    if (result
                                                                            .toString() ==
                                                                        'true') {
                                                                      setState(
                                                                          () {
                                                                        signInThread();
                                                                        read_GC_rental();
                                                                        read_GC_area();
                                                                        read_GC_rentaldata();
                                                                        read_GC_rental_img();
                                                                      });
                                                                      Navigator.pop(
                                                                          context,
                                                                          'OK');
                                                                    } else {}
                                                                  } catch (e) {
                                                                    print(e);
                                                                  }
                                                                },
                                                      child: const Text(
                                                        'ยืนยัน',
                                                        style: TextStyle(
                                                          color: Colors.white,
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
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Container(
                                                        width: 100,
                                                        decoration:
                                                            const BoxDecoration(
                                                          color:
                                                              Colors.redAccent,
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
                                                        ),
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: TextButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context, 'OK');
                                                            setState(() {
                                                              rental_Nearbyplaces_text
                                                                  .clear();
                                                            });
                                                          },
                                                          child: const Text(
                                                            'ยกเลิก',
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
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
                                        ],
                                      ),
                                    ],
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      // height: 50,
                      padding: const EdgeInsets.all(4.0),
                      decoration: BoxDecoration(
                        // color: Colors.green,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8),
                            bottomLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8)),
                        border: Border.all(color: Colors.grey, width: 2),
                      ),
                      child: Row(
                        children: [
                          for (int index = 0;
                              index < nearby_places.length;
                              index++)
                            Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                      color: Colors.grey[300],
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text('${nearby_places[index]}')),
                                ),
                                const Positioned(
                                    top: 0,
                                    right: 2,
                                    child: Icon(
                                      Icons.close_rounded,
                                      color: Colors.red,
                                    ))
                              ],
                            ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.fromLTRB(20, 8, 8, 8),
                        child: Text(
                          'คำอธิบายเพิ่มเติมเกี่ยวกับพื้นที่',
                          style: TextStyle(
                            color: SettingScreen_Color.Colors_Text1_,
                            fontFamily: FontWeight_.Fonts_T,
                            fontWeight: FontWeight.bold,
                            //fontSize: 10.0
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 200,
                      decoration: const BoxDecoration(
                        color: AppbackgroundColor.Sub_Abg_Colors,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(0),
                          topRight: Radius.circular(0),
                          bottomLeft: Radius.circular(0),
                          bottomRight: Radius.circular(0),
                        ),
                        // border: Border.all(
                        //     color: Colors.grey, width: 1),
                      ),
                      child: TextFormField(
                        controller: rental_Abount_text,

                        onFieldSubmitted: (value) async {},
                        maxLines: 100,
                        // maxLength: 13,
                        cursorColor: Colors.green,
                        decoration: InputDecoration(
                            fillColor: Colors.white.withOpacity(0.3),
                            filled: true,
                            // prefixIcon:
                            //     const Icon(Icons.person, color: Colors.black),
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
                            // labelText: 'ระบุชื่อร้านค้า',
                            labelStyle: const TextStyle(
                              color: PeopleChaoScreen_Color.Colors_Text2_,
                              // fontWeight: FontWeight.bold,
                              fontFamily: Font_.Fonts_T,
                            )),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          child: Container(
                            padding: const EdgeInsets.all(4.0),
                            decoration: const BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  topRight: Radius.circular(8),
                                  bottomLeft: Radius.circular(8),
                                  bottomRight: Radius.circular(8)),
                              // border: Border.all(
                              //     color: Colors.grey, width: 3),
                            ),
                            width: 100,
                            child: const Center(
                              child: Text(
                                'บันทึก',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: FontWeight_.Fonts_T,
                                  fontWeight: FontWeight.bold,
                                  //fontSize: 10.0
                                ),
                              ),
                            ),
                          ),
                          onTap: () async {
                            ///-------------------------------->

                            String new_value = '${rental_Abount_text.text}';

                            ///-------------------------------->
                            SharedPreferences preferences =
                                await SharedPreferences.getInstance();
                            String? ren = preferences.getString('renTalSer');
                            String? ser_user = preferences.getString('ser');
                            //UpC_rental_data_editweb
                            String url =
                                '${MyConstant().domain}/UpC_rental_data_editweb.php?isAdd=true&ren=$ren&ser=$ser_user&value=${new_value}&typevalue=1';

                            try {
                              var response = await http.get(Uri.parse(url));

                              var result = await json.decode(response.body);

                              if (result.toString() == 'true') {
                                setState(() {
                                  signInThread();
                                  read_GC_rental();
                                  read_GC_area();
                                  read_GC_rentaldata();
                                  read_GC_rental_img();
                                });
                              } else {}
                            } catch (e) {
                              print(e);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 100,
                  )
                ],
              ),
            ),
          ),
        ]));
  }
}
