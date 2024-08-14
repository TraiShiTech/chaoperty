// ignore_for_file: unused_import, unused_local_variable, unnecessary_null_comparison, unused_field, override_on_non_overriding_member, duplicate_import, must_be_immutable, body_might_complete_normally_nullable
import 'dart:async';
import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:time_range_picker/time_range_picker.dart';

import 'package:url_launcher/url_launcher.dart';

import 'dart:html' as html;
import '../Constant/Myconstant.dart';
import '../INSERT_Log/Insert_log.dart';
import '../Model/GetArea_Model.dart';
import '../Model/GetC_rantaldata_Model.dart';
import '../Model/GetExp_Model.dart';
import '../Model/GetPerMission_Model.dart';
import '../Model/GetRenTal_Model.dart';
import '../Model/GetRenTalimg_Model.dart';
import '../Model/GetUser_Model.dart';
import '../Model/GetZone_Model.dart';
import '../Model/Get_prebook_Model.dart';
import '../Responsive/responsive.dart';
import '../Style/Translate.dart';
import '../Style/colors.dart';
import '../Style/downloadImage.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class EditwebScreen extends StatefulWidget {
  const EditwebScreen({super.key});

  @override
  State<EditwebScreen> createState() => _EditwebScreenState();
}

class _EditwebScreenState extends State<EditwebScreen> {
  var nFormat = NumberFormat("#,##0.00", "en_US");
  var nFormat2 = NumberFormat("###0", "en_US");
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
  List<String> Show_Titel_webmarket = [
    'โซนพื้นที่',
    'ชื้อพื้นที่',
    'ขนาดพื้นที่(ต.ร.ม.)',
    'ค่าเช่าต่องวด',
    'เลขที่ใบสัญญา',
    'เลขที่ใบเสนอราคา',
    'วันสิ้นสุดสัญญา',
    'สถานะ',
  ];
  List<String> Show_tenant_status = [
    'หมดสัญญา',
    'เสนอราคา',
    'เสนอราคา(มัดจำ)',
    'ว่าง',
  ];
  List<ZoneModel> zoneModels = [];
  List<RenTalModel> renTalModels = [];
  List<PerMissionModel> perMissionModels = [];
  List<RenTaldataModel> renTaldataModels = [];
  List<AreaModel> areaModels = [];
  List<RenTalimgModel> renTalimgModels = [];
  List<dynamic> facilities = [];
  List<dynamic> nearby_places = [];
  List<dynamic> title_webs_list = [];
  List<ExpModel> expModels = [];
  List<PrebookModel> prebookModels = [];
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
      renTal_ser,
      renTal_addr,
      renTal_Porvi,
      type,
      typex,
      man_img_,
      qr_img_,
      n_places_,
      f_lities,
      renTal_statusweb,
      title_webs,
      renTal_nameTH,
      hiprice,
      dialog_status,
      rtview,
      R_tel,
      Parking,
      Openbook_lockpay;
  String? Lock_Day1,
      Lock_Day2,
      Lock_Day3,
      Lock_Day4,
      Lock_Day5,
      Lock_Day6,
      Lock_Day7;

  var LDay_Special1, LDay_Special2, LDay_Special3, LDay_Special4, LDay_Special5;
  //////////////------------------------------------------->
  var SDay_Prebook1, SDay_Prebook2, SDay_Prebook3, SDay_Prebook4, SDay_Prebook5;
  var LDay_Prebook1, LDay_Prebook2, LDay_Prebook3, LDay_Prebook4, LDay_Prebook5;
  var STime_Prebook1,
      STime_Prebook2,
      STime_Prebook3,
      STime_Prebook4,
      STime_Prebook5;
  var LTime_Prebook1,
      LTime_Prebook2,
      LTime_Prebook3,
      Lime_Prebook4,
      LTime_Prebook5;
  //////////////------------------------------------------->
  final rental_name_text = TextEditingController();
  final rental_nameTH_text = TextEditingController();
  final rental_Line_text = TextEditingController();
  final rental_Facebook_text = TextEditingController();
  final rental_UrlYoutube_text = TextEditingController();
  final Stimeinput = TextEditingController();
  final ltimeinput = TextEditingController();
  final rental_Urladdr_text = TextEditingController();
  final rental_Facilities_text = TextEditingController();
  final rental_Nearbyplaces_text = TextEditingController();
  final rental_Abount_text = TextEditingController();
  final rental_AbountAll_text = TextEditingController();
  final rental_lowest_price_text = TextEditingController();
  final hiprice_text = TextEditingController();
  final dialog_text = TextEditingController();
  final tel_text = TextEditingController();

  final qrImageKey = GlobalKey();

  @override
  void initState() {
    signInThread();
    read_GC_rental();
    read_GC_area();
    read_GC_rentaldata();
    read_GC_rental_img();
    read_GC_zone();
    read_GC_Exp();
    CG_Prebook();
    super.initState();
  }

  void _launchURL() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');

    final String url = 'https://chaoperties.com/market/#/serrental=$ren';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<Null> CG_Prebook() async {
    if (prebookModels.isNotEmpty) {
      prebookModels.clear();
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var ren = preferences.getString('renTalSer');

    String url = '${MyConstant().domain}/GC_prebook.php?isAdd=true&ren=$ren';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);
      if (result != null) {
        for (var map in result) {
          PrebookModel prebookModelss = PrebookModel.fromJson(map);

          setState(() {
            prebookModels.add(prebookModelss);
          });
        }
      } else {}
    } catch (e) {}
  }

  Future<Null> read_GC_Exp() async {
    if (expModels.isNotEmpty) {
      expModels.clear();
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var ren = preferences.getString('renTalSer');

    String url =
        '${MyConstant().domain}/GC_exp_setring.php?isAdd=true&ren=$ren';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print(result);
      if (result != null) {
        for (var map in result) {
          ExpModel expModel = ExpModel.fromJson(map);

          setState(() {
            expModels.add(expModel);
          });
        }
      } else {}
    } catch (e) {}
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
      // Map<String, dynamic> map = Map();
      // map['ser'] = '0';
      // map['rser'] = '0';
      // map['zn'] = 'ทั้งหมด';
      // map['qty'] = '0';
      // map['img'] = '0';
      // map['data_update'] = '0';

      // ZoneModel zoneModelx = ZoneModel.fromJson(map);

      // setState(() {
      //   zoneModels.add(zoneModelx);
      // });

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
            renTal_ser = renTalModel.ser;
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
    // print('**$ren***ren****ren**renrenren***ren*******${ren}');
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
          title_webs = renTaldataModel.title_web.toString();
          renTal_name = renTaldataModel.pn;
          renTal_nameTH = renTaldataModel.pn_TH;
          renTaldataModels.add(renTaldataModel);
          rental_nameTH_text.text = renTaldataModel.pn_TH.toString();
          rental_lowest_price_text.text =
              '${nFormat.format(double.parse(renTaldataModel.range_lowpri.toString()))}';
          hiprice = renTaldataModel.range_heipri.toString();
          hiprice_text.text =
              '${nFormat.format(double.parse(renTaldataModel.range_heipri.toString()))}';

          dialog_text.text = renTaldataModel.dialog_tex.toString();
          dialog_status = renTaldataModel.dialog.toString();
          rtview = renTaldataModel.rt_view.toString();
          tel_text.text = renTaldataModel.r_tel.toString();
          Parking = renTaldataModel.par_king.toString();
          rental_AbountAll_text.text = renTaldataModel.a_aboutAll.toString();
          //---------------------------->
          Openbook_lockpay = renTaldataModel.open_book.toString();
          Lock_Day1 = renTaldataModel.d1.toString();
          Lock_Day2 = renTaldataModel.d2.toString();
          Lock_Day3 = renTaldataModel.d3.toString();
          Lock_Day4 = renTaldataModel.d4.toString();
          Lock_Day5 = renTaldataModel.d5.toString();
          Lock_Day6 = renTaldataModel.d6.toString();
          Lock_Day7 = renTaldataModel.d7.toString();
          LDay_Special1 = renTaldataModel.ds1.toString();
          LDay_Special2 = renTaldataModel.ds2.toString();
          LDay_Special3 = renTaldataModel.ds3.toString();
          LDay_Special4 = renTaldataModel.ds4.toString();
          LDay_Special5 = renTaldataModel.ds5.toString();
        });
      }

      ///title_webs_list
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

        //////////----------------------------------
        String titlewebs = title_webs.toString();
        List<String> titlewebsList = titlewebs.split(",");
        // List<dynamic> faciliTies =
        //     facilitiesList.map((place) => place.trim()).toList();
        List<dynamic> titlewebsListTies = titlewebsList
            .map((faci) => faci.trim())
            .where((faci) => faci.isNotEmpty)
            .toList();
        setState(() {
          title_webs_list = titlewebsListTies;
          nearby_places = nearbyPlaces;
          facilities = faciliTies;
        });
        title_webs_list.sort((a, b) {
          if (a is Comparable && b is Comparable) {
            return a.compareTo(b);
          } else {
            // Handle non-comparable elements if needed
            return 0;
          }
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
        // try {
        //   var response = await http.get(Uri.parse(url));

        //   var result = await json.decode(response.body);

        //   if (result.toString() == 'true') {
        //     setState(() {
        //       signInThread();
        //       read_GC_rental();
        //       read_GC_area();
        //       read_GC_rentaldata();
        //       read_GC_rental_img();
        //     });
        //   } else {}
        // } catch (e) {
        //   print(e);
        // }
        // UpImg(context, fileName, Path_, Ser_);
      } else {
        print('File upload failed with status code: ${request.status}');
      }
    } else {
      print('ยังไม่ได้เลือกรูปภาพ');
    }
  }

///////////////-------------------------------->
  Dia_log() {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) {
          Timer(const Duration(milliseconds: 1500), () {
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

  void changeColor() {
    Color tiTileColorss1 = Color.fromARGB(255, 203, 200, 219);
    Color tiTileColorss2 = Color(0xFFD9D9B7);

    setState(() {
      if (AppbackgroundColor.TiTile_Colors == tiTileColorss1) {
        AppbackgroundColor.TiTile_Colors = tiTileColorss2;
      } else {
        AppbackgroundColor.TiTile_Colors = tiTileColorss1;
      }
    });
  }

///////--------------------------------------------->
  DateRangePickerController _datePickerController = DateRangePickerController();
  var selectsdate;
  var selectldate;
  bool rangedate = false;
  selectdate(index, type_value) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          backgroundColor: Colors.white,
          titlePadding: const EdgeInsets.all(0.0),
          contentPadding: const EdgeInsets.all(5.0),
          actionsPadding: const EdgeInsets.all(6.0),
          content: Container(
            width: (MediaQuery.of(context).size.width < 1000)
                ? MediaQuery.of(context).size.width
                : MediaQuery.of(context).size.width * 0.75,
            // width: Metrics.width(context) * 0.5,
            height: MediaQuery.of(context).size.height,
            clipBehavior: Clip.antiAlias,
            padding: EdgeInsets.all(0),
            margin: EdgeInsets.all(0),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: SfDateRangePicker(
              controller: _datePickerController,
              view: DateRangePickerView.month,
              // monthViewSettings:
              //     DateRangePickerMonthViewSettings(firstDayOfWeek: 1),
              monthViewSettings: const DateRangePickerMonthViewSettings(
                  // showWeekNumber: true,
                  ),
              showActionButtons: true,
              showTodayButton: true,
              confirmText: 'OK',
              cancelText: 'Cancel',
              backgroundColor: Colors.white,
              minDate: DateTime(DateTime.now().year, DateTime.now().month, 1,
                  00, 00, 00, 00, 00),
              maxDate: DateTime.now().add(Duration(days: 90)),
              initialSelectedDate: selectsdate,
              initialSelectedRange: rangedate
                  ? PickerDateRange(selectsdate, selectldate)
                  : PickerDateRange(selectsdate, selectldate),
              headerStyle:
                  DateRangePickerHeaderStyle(backgroundColor: Colors.white),
              selectionColor: Color.fromRGBO(232, 191, 66, 1).withOpacity(0.5),
              startRangeSelectionColor: Colors.green,
              rangeSelectionColor:
                  Color.fromRGBO(232, 191, 66, 1).withOpacity(0.5),
              todayHighlightColor: Colors.green,
              endRangeSelectionColor: Colors.red,
              onCancel: () {
                setState(() {
                  selectsdate = null;
                  selectldate = null;
                  rangedate = false;
                });
                Navigator.of(context).pop();
              },
              showNavigationArrow: true,
              navigationMode: DateRangePickerNavigationMode.snap,
              selectionMode: DateRangePickerSelectionMode.range,
              onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                selectsdate = args.value.startDate;
                selectldate = args.value.endDate;
              },
              // selectableDayPredicate: (DateTime date) {
              //   return !isNoReservationPeriod(date);
              // },
              // onSubmit: (Object? value) {
              //   if (selectsdate != null && selectldate != null) {
              //     numberOfDays = selectldate!.difference(selectsdate!).inDays;
              //     DateTime noReservationStart = DateTime.parse('${S_Datexnow}');
              //     DateTime noReservationEnd = DateTime.parse('${L_Datexnow}');
              //     // Define no reservation period

              //     if (selectsdate!.isBefore(noReservationEnd) &&
              //         selectldate!.isAfter(noReservationStart)) {
              //       showDialog<void>(
              //         context: context,
              //         barrierDismissible: true,
              //         builder: (BuildContext context) {
              //           return AlertDialog(
              //             title: Text('No Reservations'),
              //             content: Text(
              //                 'No reservations from 26/06/2024 to 25/07/2024.'),
              //             actions: <Widget>[
              //               TextButton(
              //                 child: Text('OK'),
              //                 onPressed: () {
              //                   Navigator.of(context).pop();
              //                 },
              //               ),
              //             ],
              //           );
              //         },
              //       );
              //     } else {
              //       setState(() {
              //         sdate = DateFormat('d MMMM yyyy', 'en_US')
              //             .format(selectsdate!);
              //         ldate = DateFormat('d MMMM yyyy', 'en_US')
              //             .format(selectldate!);
              //       });
              //       Navigator.of(context).pop();
              //     }
              //   }
              // },
              onSubmit: (p0) async {
                SharedPreferences preferences =
                    await SharedPreferences.getInstance();

                var ren = preferences.getString('renTalSer');
                // if (selectsdate != null && selectldate != null) {
                //   numberOfDays = DateTime.parse(selectldate.toString())
                //       .difference(DateTime.parse(selectsdate.toString()))
                //       .inDays;
                // }
                // print(selectsdate);
                // print(selectldate);
                setState(() {
                  if (selectldate == null) {
                    rangedate = false;
                  } else {
                    SDay_Prebook1 = DateFormat('yyyy-MM-dd')
                        .format(DateTime.parse(selectsdate.toString()));

                    LDay_Prebook1 = DateFormat('yyyy-MM-dd')
                        .format(DateTime.parse(selectldate.toString()));
                  }
                });
                if (type_value.toString() == 'pdate') {
                  try {
                    final url =
                        '${MyConstant().domain}/UP_In_prebook.php?isAdd=true';

                    final response = await http.post(
                      Uri.parse(url),
                      body: {
                        'ren': '$ren',
                        'type': 'UP',
                        'ser': '${prebookModels[index].ser}',
                        'zone': '${prebookModels[index].zone}',
                        'pdate': '${SDay_Prebook1}',
                        'ts_padte': '${prebookModels[index].ts_padte}',
                        'ldate': '${LDay_Prebook1}',
                        'tl_ldate': '${prebookModels[index].tl_ldate}',
                        'bdate': '${prebookModels[index].bdate}',
                        'bldate': '${prebookModels[index].bldate}'
                      },
                    );
                  } catch (e) {}
                } else {
                  try {
                    final url =
                        '${MyConstant().domain}/UP_In_prebook.php?isAdd=true';

                    final response = await http.post(
                      Uri.parse(url),
                      body: {
                        'ren': '$ren',
                        'type': 'UP',
                        'ser': '${prebookModels[index].ser}',
                        'zone': '${prebookModels[index].zone}',
                        'pdate': '${prebookModels[index].pdate}',
                        'ts_padte': '${prebookModels[index].ts_padte}',
                        'ldate': '${prebookModels[index].ldate}',
                        'tl_ldate': '${prebookModels[index].tl_ldate}',
                        'bdate': '${SDay_Prebook1}',
                        'bldate': '${LDay_Prebook1}'
                      },
                    );
                  } catch (e) {}
                }

                print('$type_value //// $SDay_Prebook1 //// $LDay_Prebook1');
                setState(() {
                  CG_Prebook();
                  Navigator.of(context).pop();
                });
                Dia_log();
              },
            ),
          ),
        );
      },
    );
  }

  /////////------------------------------------------->
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
        child: Column(children: [
          // Padding(
          //   padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
          //   child: Container(
          //     height: 20,
          //     decoration: const BoxDecoration(
          //       color: Colors.white30,
          //       borderRadius: BorderRadius.only(
          //           topLeft: Radius.circular(0),
          //           topRight: Radius.circular(0),
          //           bottomLeft: Radius.circular(10),
          //           bottomRight: Radius.circular(10)),
          //       // border: Border.all(color: Colors.white, width: 1),
          //     ),
          //   ),
          // ),
          Container(
            width: (!Responsive.isDesktop(context))
                ? 800
                : MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              // color: AppbackgroundColor.Sub_Abg_Colors,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              // border: Border.all(
              //     color: Colors.grey, width: 1),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          colorFilter: new ColorFilter.mode(
                              Colors.black.withOpacity(0.1), BlendMode.dstATop),
                          image: AssetImage("images/BG_im.png"),
                          fit: BoxFit.cover,
                        ),
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                        // border: Border.all(color: Colors.white, width: 1),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Translate.TranslateAndSetText(
                                    'ตั้งค่าหน้าเว็ป ',
                                    SettingScreen_Color.Colors_Text1_,
                                    TextAlign.center,
                                    FontWeight.bold,
                                    FontWeight_.Fonts_T,
                                    16,
                                    1),
                              ),
                              // Container(
                              //   height: 150,
                              //   width: 300,
                              //   decoration: BoxDecoration(
                              //     image: DecorationImage(
                              //       image: NetworkImage(
                              //           "https://assets.designs.ai/images/creative_tools/logomaker.webp"),
                              //       fit: BoxFit.cover,
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                          // Container(
                          //   height: 150,
                          //   width: 300,
                          //   decoration: BoxDecoration(
                          //     image: DecorationImage(
                          //       image: NetworkImage(
                          //           "https://png.pngtree.com/png-clipart/20210311/original/pngtree-cartoon-painted-curved-arrow-png-image_6018663.jpg"),
                          //       fit: BoxFit.cover,
                          //     ),
                          //   ),
                          // ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Stack(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(4.0),
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(8),
                                        topRight: Radius.circular(8),
                                        bottomLeft: Radius.circular(8),
                                        bottomRight: Radius.circular(8)),
                                    border: Border.all(
                                        color: Colors.grey, width: 3),
                                  ),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: RepaintBoundary(
                                          key: qrImageKey,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(10),
                                                  topRight: Radius.circular(10),
                                                  bottomLeft:
                                                      Radius.circular(10),
                                                  bottomRight:
                                                      Radius.circular(10)),
                                              border: Border.all(
                                                  color: Colors.grey, width: 1),
                                            ),
                                            padding: const EdgeInsets.all(4.0),
                                            child: PrettyQr(
                                              // typeNumber: 3,
                                              image: AssetImage(
                                                "images/Icon-chao.png",
                                              ),
                                              size: 120,
                                              data:
                                                  'https://www.dzentric.com/chaoperty_market/#/serrental=$renTal_ser',
                                              errorCorrectLevel:
                                                  QrErrorCorrectLevel.M,
                                              roundEdges: true,
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () => _launchURL(),
                                        child: Container(
                                          padding: const EdgeInsets.all(4.0),
                                          decoration: BoxDecoration(
                                            color:
                                                Colors.white.withOpacity(0.5),
                                            borderRadius:
                                                const BorderRadius.only(
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
                                          child: Center(
                                            child: Translate.TranslateAndSetText(
                                                (renTal_nameTH != null ||
                                                        renTal_nameTH
                                                                .toString()
                                                                .trim() !=
                                                            '' ||
                                                        renTal_nameTH
                                                                .toString() !=
                                                            'null')
                                                    ? '🌍 เปิดเว็ปไซต์ : $renTal_nameTH'
                                                    : '🌍 เปิดเว็ปไซต์ : $renTal_name',
                                                SettingScreen_Color
                                                    .Colors_Text1_,
                                                TextAlign.center,
                                                FontWeight.bold,
                                                FontWeight_.Fonts_T,
                                                16,
                                                1),

                                            //  Text(
                                            //   (renTal_nameTH != null ||
                                            //           renTal_nameTH
                                            //                   .toString()
                                            //                   .trim() !=
                                            //               '' ||
                                            //           renTal_nameTH
                                            //                   .toString() !=
                                            //               'null')
                                            //       ? '🌍 เปิดเว็ปไซต์ : $renTal_nameTH'
                                            //       : '🌍 เปิดเว็ปไซต์ : $renTal_name',
                                            //   style: TextStyle(
                                            //       decoration:
                                            //           TextDecoration.underline,
                                            //       color: Colors.black,
                                            //       fontFamily:
                                            //           FontWeight_.Fonts_T,
                                            //       fontWeight: FontWeight.bold,
                                            //       fontSize: 12.0),
                                            // ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Positioned(
                                    top: 5,
                                    right: 4,
                                    child: InkWell(
                                        onTap: () {
                                          changeColor();
                                          // Future.delayed(
                                          //     const Duration(milliseconds: 300),
                                          //     () async {
                                          //   captureAndConvertToBase64(
                                          //       qrImageKey, 'QR_WEB_');
                                          // });
                                        },
                                        child: CircleAvatar(
                                          radius: 12,
                                          backgroundColor: Colors.green,
                                          child: Icon(
                                            Icons.download,
                                            color: Colors.white,
                                          ),
                                        )))
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                      // border: Border.all(color: Colors.white, width: 1),
                    ),
                    child: ScrollConfiguration(
                      behavior: ScrollConfiguration.of(context)
                          .copyWith(dragDevices: {
                        PointerDeviceKind.touch,
                        PointerDeviceKind.mouse,
                      }),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Container(
                              width: (MediaQuery.of(context).size.width < 650)
                                  ? 850
                                  : MediaQuery.of(context).size.width * 0.84,
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                      child: Container(
                                        width: 200,
                                        decoration: BoxDecoration(
                                          color: renTal_statusweb == '1'
                                              ? Colors.grey[100]!
                                                  .withOpacity(0.5)
                                              : Colors.red[100]!
                                                  .withOpacity(0.5),
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
                                              padding:
                                                  const EdgeInsets.all(2.0),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.green[100]!
                                                      .withOpacity(0.5),
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
                                                  border: Border.all(
                                                      color: Colors.grey,
                                                      width: 1),
                                                ),
                                                padding:
                                                    const EdgeInsets.all(2.0),
                                                child: Row(
                                                  children: [
                                                    Translate
                                                        .TranslateAndSetText(
                                                            'ปิดร้าน',
                                                            SettingScreen_Color
                                                                .Colors_Text1_,
                                                            TextAlign.center,
                                                            null,
                                                            Font_.Fonts_T,
                                                            12,
                                                            2),
                                                    InkWell(
                                                      onTap: () async {
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
                                                        var open =
                                                            renTal_statusweb ==
                                                                    '1'
                                                                ? '0'
                                                                : '1';
                                                        var vser =
                                                            renTal_statusweb;

                                                        ///-------------------------------->

                                                        String value_ =
                                                            '${open}';

                                                        ///-------------------------------->

                                                        //
                                                        String url =
                                                            '${MyConstant().domain}/UpC_rental_data_editweb.php?isAdd=true&ren=$ren&ser=$ser_user&value=$value_&typevalue=7';

                                                        try {
                                                          var response =
                                                              await http.get(
                                                                  Uri.parse(
                                                                      url));

                                                          var result =
                                                              await json.decode(
                                                                  response
                                                                      .body);

                                                          if (result
                                                                  .toString() ==
                                                              'true') {
                                                            Dia_log();
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
                                                              color:
                                                                  Colors.green,
                                                              size: 35.0,
                                                            )
                                                          : const Icon(
                                                              Icons.toggle_off,
                                                              size: 35.0,
                                                            ),
                                                    ),
                                                    Translate
                                                        .TranslateAndSetText(
                                                            'เปิดร้าน',
                                                            SettingScreen_Color
                                                                .Colors_Text1_,
                                                            TextAlign.center,
                                                            null,
                                                            Font_.Fonts_T,
                                                            12,
                                                            2),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Stack(
                                              children: [
                                                Container(
                                                  width: 200,
                                                  height: 130,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            3.0),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          const BorderRadius
                                                              .only(
                                                        topLeft:
                                                            Radius.circular(
                                                                8.0),
                                                        topRight:
                                                            Radius.circular(
                                                                8.0),
                                                        bottomLeft:
                                                            Radius.circular(
                                                                8.0),
                                                        bottomRight:
                                                            Radius.circular(
                                                                8.0),
                                                      ),
                                                      child: (man_img_ ==
                                                                  null ||
                                                              man_img_ == '')
                                                          ? const Icon(Icons
                                                              .image_not_supported)
                                                          : Image.network(
                                                              '${MyConstant().domain}/files/$foder/webfont/manimg/$man_img_',
                                                              fit: BoxFit.fill),
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  top: 5,
                                                  right: 5,
                                                  child: Container(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(2, 2, 5, 2),
                                                    decoration: BoxDecoration(
                                                      color: Colors.red
                                                          .withOpacity(0.6),
                                                      borderRadius:
                                                          const BorderRadius
                                                              .only(
                                                        topLeft:
                                                            Radius.circular(8),
                                                        topRight:
                                                            Radius.circular(8),
                                                        bottomLeft:
                                                            Radius.circular(8),
                                                        bottomRight:
                                                            Radius.circular(8),
                                                      ),
                                                      border: Border.all(
                                                          color: const Color
                                                                  .fromARGB(255,
                                                              211, 207, 207),
                                                          width: 0.5),
                                                    ),
                                                    width: 80,
                                                    child: Row(
                                                      children: [
                                                        const Icon(
                                                          Icons.remove_red_eye,
                                                          size: 15,
                                                          color: Colors.white,
                                                        ),
                                                        Expanded(
                                                          child: Text(
                                                            '${nFormat2.format(double.parse(rtview.toString()))}',

                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            // minFontSize: 5,
                                                            // maxFontSize: 15,
                                                            maxLines: 1,
                                                            textAlign:
                                                                TextAlign.right,
                                                            style:
                                                                const TextStyle(
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              color:
                                                                  Colors.white,
                                                              fontFamily:
                                                                  Font_.Fonts_T,
                                                              fontSize: 10.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(0.0),
                                              child: Container(
                                                width: 180,
                                                padding:
                                                    const EdgeInsets.all(3.0),
                                                child: Text(
                                                  '${renTal_name}',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  // minFontSize: 5,
                                                  // maxFontSize: 15,
                                                  maxLines: 1,
                                                  textAlign: TextAlign.left,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .subtitle1
                                                      ?.copyWith(
                                                        fontSize: 10.0,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(0.0),
                                              child: Container(
                                                width: 180,
                                                padding:
                                                    const EdgeInsets.all(3.0),
                                                child: Text(
                                                  '${renTal_nameTH}',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  // minFontSize: 5,
                                                  // maxFontSize: 15,
                                                  maxLines: 1,
                                                  textAlign: TextAlign.left,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .subtitle1
                                                      ?.copyWith(
                                                        fontSize: 15.0,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      8, 0, 0, 0),
                                              child: Container(
                                                width: 180,
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
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .subtitle1
                                                            ?.copyWith(
                                                              fontSize: 10.0,
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
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      8, 2, 0, 0),
                                              child: Container(
                                                width: 180,
                                                child: Column(
                                                  children: [
                                                    Translate.TranslateAndSetText(
                                                        'พบ ${areaModels.length} พื้นที่พร้อมให้เช่า',
                                                        SettingScreen_Color
                                                            .Colors_Text1_,
                                                        TextAlign.left,
                                                        null,
                                                        Font_.Fonts_T,
                                                        16,
                                                        1),
                                                    // Text(
                                                    //   'พบ ${areaModels.length} พื้นที่พร้อมให้เช่า',

                                                    //   overflow:
                                                    //       TextOverflow.ellipsis,
                                                    //   // minFontSize: 1,
                                                    //   // maxFontSize: 12,
                                                    //   maxLines: 1,
                                                    //   textAlign: TextAlign.left,
                                                    //   style: Theme.of(context)
                                                    //       .textTheme
                                                    //       .subtitle1
                                                    //       ?.copyWith(
                                                    //         fontSize: 12.0,
                                                    //         // fontWeight:
                                                    //         //     FontWeight.w700,
                                                    //       ),
                                                    // ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: 180,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Container(
                                                    width: 110,
                                                    child: Divider(
                                                      color:
                                                          const Color.fromARGB(
                                                                  255,
                                                                  23,
                                                                  82,
                                                                  129)
                                                              .withOpacity(0.5),
                                                      height: 8.0,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      8, 8, 0, 8),
                                              child: Container(
                                                width: 180,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        color: const Color
                                                                    .fromARGB(
                                                                255,
                                                                138,
                                                                216,
                                                                115)
                                                            .withOpacity(0.5),
                                                        borderRadius:
                                                            const BorderRadius
                                                                .only(
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
                                                                  5),
                                                        ),
                                                      ),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              2.0),
                                                      child: Translate
                                                          .TranslateAndSetText(
                                                              '$typex',
                                                              SettingScreen_Color
                                                                  .Colors_Text1_,
                                                              TextAlign.left,
                                                              null,
                                                              Font_.Fonts_T,
                                                              16,
                                                              1),
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
                                    flex: 3,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(8, 8, 8, 8),
                                      child: Container(
                                        // color: Colors.green,
                                        width: 200,
                                        height: 280,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              child: Column(
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      color: AppbackgroundColor
                                                          .TiTile_Colors,
                                                      // color: AppbackgroundColor
                                                      //         .TiTile_Colors
                                                      //     .withOpacity(0.7),
                                                      borderRadius:
                                                          const BorderRadius
                                                                  .only(
                                                              topLeft: Radius
                                                                  .circular(10),
                                                              topRight: Radius
                                                                  .circular(10),
                                                              bottomLeft: Radius
                                                                  .circular(0),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          0)),
                                                      border: Border.all(
                                                          color: Colors.grey,
                                                          width: 0.5),
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                          flex: 1,
                                                          child: Align(
                                                            alignment: Alignment
                                                                .topCenter,
                                                            child: Translate.TranslateAndSetText(
                                                                'แก้ไขชื่อ(ไทย)',
                                                                SettingScreen_Color
                                                                    .Colors_Text1_,
                                                                TextAlign.left,
                                                                FontWeight.w700,
                                                                Font_.Fonts_T,
                                                                16,
                                                                1),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 1,
                                                          child: Align(
                                                            alignment: Alignment
                                                                .topCenter,
                                                            child: Translate.TranslateAndSetText(
                                                                'แก้ไขชื่อ(อังกฤษ)',
                                                                SettingScreen_Color
                                                                    .Colors_Text1_,
                                                                TextAlign.left,
                                                                FontWeight.w700,
                                                                Font_.Fonts_T,
                                                                16,
                                                                1),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.grey[100]!
                                                          .withOpacity(0.5),
                                                      borderRadius:
                                                          const BorderRadius
                                                                  .only(
                                                              topLeft: Radius
                                                                  .circular(0),
                                                              topRight: Radius
                                                                  .circular(0),
                                                              bottomLeft: Radius
                                                                  .circular(10),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          10)),
                                                      border: Border.all(
                                                          color: Colors.grey,
                                                          width: 0.5),
                                                    ),
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                              flex: 1,
                                                              child: Align(
                                                                alignment:
                                                                    Alignment
                                                                        .topLeft,
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child:
                                                                      SizedBox(
                                                                    // width: 200,
                                                                    child:
                                                                        TextFormField(
                                                                      // keyboardType: TextInputType.number,
                                                                      controller:
                                                                          rental_nameTH_text,

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
                                                                              topRight: Radius.circular(15),
                                                                              topLeft: Radius.circular(15),
                                                                              bottomRight: Radius.circular(15),
                                                                              bottomLeft: Radius.circular(15),
                                                                            ),
                                                                            borderSide:
                                                                                BorderSide(
                                                                              width: 1,
                                                                              color: Colors.black,
                                                                            ),
                                                                          ),
                                                                          enabledBorder: const OutlineInputBorder(
                                                                            borderRadius:
                                                                                BorderRadius.only(
                                                                              topRight: Radius.circular(15),
                                                                              topLeft: Radius.circular(15),
                                                                              bottomRight: Radius.circular(15),
                                                                              bottomLeft: Radius.circular(15),
                                                                            ),
                                                                            borderSide:
                                                                                BorderSide(
                                                                              width: 1,
                                                                              color: Colors.grey,
                                                                            ),
                                                                          ),
                                                                          labelStyle: const TextStyle(
                                                                            color:
                                                                                Colors.black54,
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
                                                            ),
                                                            Expanded(
                                                              flex: 1,
                                                              child: Align(
                                                                alignment:
                                                                    Alignment
                                                                        .topLeft,
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child:
                                                                      SizedBox(
                                                                    // width: 200,
                                                                    child:
                                                                        TextFormField(
                                                                      // keyboardType: TextInputType.number,
                                                                      controller:
                                                                          rental_name_text,

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
                                                                              topRight: Radius.circular(15),
                                                                              topLeft: Radius.circular(15),
                                                                              bottomRight: Radius.circular(15),
                                                                              bottomLeft: Radius.circular(15),
                                                                            ),
                                                                            borderSide:
                                                                                BorderSide(
                                                                              width: 1,
                                                                              color: Colors.black,
                                                                            ),
                                                                          ),
                                                                          enabledBorder: const OutlineInputBorder(
                                                                            borderRadius:
                                                                                BorderRadius.only(
                                                                              topRight: Radius.circular(15),
                                                                              topLeft: Radius.circular(15),
                                                                              bottomRight: Radius.circular(15),
                                                                              bottomLeft: Radius.circular(15),
                                                                            ),
                                                                            borderSide:
                                                                                BorderSide(
                                                                              width: 1,
                                                                              color: Colors.grey,
                                                                            ),
                                                                          ),
                                                                          labelStyle: const TextStyle(
                                                                            color:
                                                                                Colors.black54,
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
                                                            ),
                                                          ],
                                                        ),
                                                        Align(
                                                          alignment: Alignment
                                                              .topCenter,
                                                          child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: InkWell(
                                                                child:
                                                                    Container(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          4.0),
                                                                  decoration:
                                                                      const BoxDecoration(
                                                                    color: Colors
                                                                        .green,
                                                                    borderRadius: BorderRadius.only(
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
                                                                            Radius.circular(8)),
                                                                    // border: Border.all(
                                                                    //     color: Colors.grey, width: 3),
                                                                  ),
                                                                  width: 150,
                                                                  child: Center(
                                                                    child: Translate.TranslateAndSetText(
                                                                        'บันทึก',
                                                                        SettingScreen_Color
                                                                            .Colors_Text3_,
                                                                        TextAlign
                                                                            .left,
                                                                        FontWeight
                                                                            .w700,
                                                                        Font_
                                                                            .Fonts_T,
                                                                        16,
                                                                        1),
                                                                  ),
                                                                ),
                                                                onTap:
                                                                    () async {
                                                                  ///-------------------------------->

                                                                  String
                                                                      value_ =
                                                                      '${rental_name_text.text}';
                                                                  String
                                                                      valueth_ =
                                                                      '${rental_nameTH_text.text}';

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
                                                                  Dia_log();
                                                                  String url =
                                                                      '${MyConstant().domain}/UpC_rental_data_editweb.php?isAdd=true&ren=$ren&ser=$ser_user&value=$value_&nameth=$valueth_&typevalue=8';

                                                                  try {
                                                                    var response =
                                                                        await http
                                                                            .get(Uri.parse(url));

                                                                    var result =
                                                                        await json
                                                                            .decode(response.body);

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
                                                                    } else {}
                                                                  } catch (e) {
                                                                    print(e);
                                                                  }
                                                                },
                                                              )),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(0, 8, 0, 0),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color:
                                                            AppbackgroundColor
                                                                .TiTile_Colors,
                                                        // color: AppbackgroundColor
                                                        //         .TiTile_Colors
                                                        //     .withOpacity(0.7),
                                                        borderRadius: const BorderRadius
                                                                .only(
                                                            topLeft: Radius
                                                                .circular(10),
                                                            topRight:
                                                                Radius.circular(
                                                                    10),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    0),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    0)),
                                                        border: Border.all(
                                                            color: Colors.grey,
                                                            width: 0.5),
                                                      ),
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                            flex: 1,
                                                            child: Align(
                                                              alignment:
                                                                  Alignment
                                                                      .topCenter,
                                                              child: Translate.TranslateAndSetText(
                                                                  'แก้ไขรูปภาพหน้าปก',
                                                                  SettingScreen_Color
                                                                      .Colors_Text3_,
                                                                  TextAlign
                                                                      .left,
                                                                  FontWeight
                                                                      .w700,
                                                                  Font_.Fonts_T,
                                                                  16,
                                                                  1),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 2,
                                                            child: Align(
                                                              alignment:
                                                                  Alignment
                                                                      .topCenter,
                                                              child: Translate.TranslateAndSetText(
                                                                  'แก้ไขจังหวัด',
                                                                  SettingScreen_Color
                                                                      .Colors_Text3_,
                                                                  TextAlign
                                                                      .left,
                                                                  FontWeight
                                                                      .w700,
                                                                  Font_.Fonts_T,
                                                                  16,
                                                                  1),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.grey[100]!
                                                          .withOpacity(0.5),
                                                      borderRadius:
                                                          const BorderRadius
                                                                  .only(
                                                              topLeft: Radius
                                                                  .circular(0),
                                                              topRight: Radius
                                                                  .circular(0),
                                                              bottomLeft: Radius
                                                                  .circular(10),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          10)),
                                                      border: Border.all(
                                                          color: Colors.grey,
                                                          width: 0.5),
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                          flex: 1,
                                                          child: Align(
                                                            alignment: Alignment
                                                                .topCenter,
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: InkWell(
                                                                child:
                                                                    Container(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          4.0),
                                                                  decoration:
                                                                      const BoxDecoration(
                                                                    color: Colors
                                                                        .green,
                                                                    borderRadius: BorderRadius.only(
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
                                                                            Radius.circular(8)),
                                                                    // border: Border.all(
                                                                    //     color: Colors.grey, width: 3),
                                                                  ),
                                                                  width: 150,
                                                                  child: Center(
                                                                    child: Translate.TranslateAndSetText(
                                                                        (man_img_ == null || man_img_ == '')
                                                                            ? 'เพิ่ม'
                                                                            : 'แก้ไข',
                                                                        SettingScreen_Color
                                                                            .Colors_Text3_,
                                                                        TextAlign
                                                                            .left,
                                                                        FontWeight
                                                                            .w700,
                                                                        Font_
                                                                            .Fonts_T,
                                                                        16,
                                                                        1),
                                                                  ),
                                                                ),
                                                                onTap:
                                                                    () async {
                                                                  if (man_img_ ==
                                                                          null ||
                                                                      man_img_.toString() ==
                                                                          '') {
                                                                    uploadFile_Imgman(
                                                                        'manimg');
                                                                  } else {
                                                                    showDialog<
                                                                        void>(
                                                                      context:
                                                                          context,
                                                                      barrierDismissible:
                                                                          false, // user must tap button!
                                                                      builder:
                                                                          (BuildContext
                                                                              context) {
                                                                        return AlertDialog(
                                                                          shape:
                                                                              const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                                                                          title:
                                                                              Center(
                                                                            child: Translate.TranslateAndSetText(
                                                                                'มีรูปหน้าปกอยู่แล้ว ',
                                                                                SettingScreen_Color.Colors_Text1_,
                                                                                TextAlign.left,
                                                                                FontWeight.bold,
                                                                                FontWeight_.Fonts_T,
                                                                                16,
                                                                                1),
                                                                          ),
                                                                          content:
                                                                              SingleChildScrollView(
                                                                            child:
                                                                                ListBody(
                                                                              children: <Widget>[
                                                                                Translate.TranslateAndSetText('มีหน้าปก หากต้องการอัพโหลดกรุณาลบรูปหน้าปกที่มีอยู่แล้วก่อน', SettingScreen_Color.Colors_Text1_, TextAlign.left, FontWeight.bold, FontWeight_.Fonts_T, 16, 1),
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
                                                                                  color: Colors.grey,
                                                                                  height: 4.0,
                                                                                ),
                                                                                const SizedBox(
                                                                                  height: 5.0,
                                                                                ),
                                                                                Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                  children: [
                                                                                    Padding(
                                                                                      padding: const EdgeInsets.all(8.0),
                                                                                      child: InkWell(
                                                                                        child: Container(
                                                                                          width: 50,
                                                                                          decoration: BoxDecoration(
                                                                                            color: Colors.red[600],
                                                                                            borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                                                                                            // border: Border.all(color: Colors.white, width: 1),
                                                                                          ),
                                                                                          padding: const EdgeInsets.all(8.0),
                                                                                          child: Center(
                                                                                            child: Translate.TranslateAndSetText('ลบรูป', SettingScreen_Color.Colors_Text3_, TextAlign.left, FontWeight.bold, FontWeight_.Fonts_T, 16, 1),
                                                                                          ),
                                                                                        ),
                                                                                        onTap: () async {
                                                                                          // String url =
                                                                                          //     await '${MyConstant().domain}/files/$foder/logo/$img_logo';
                                                                                          deletedFile_(
                                                                                            'manimg',
                                                                                            '$man_img_',
                                                                                          );

                                                                                          Navigator.of(context).pop();
                                                                                        },
                                                                                      ),
                                                                                    ),
                                                                                    SizedBox(
                                                                                      child: Row(
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
                                                                                                  child: Center(
                                                                                                    child: Translate.TranslateAndSetText('ปิด', SettingScreen_Color.Colors_Text3_, TextAlign.left, FontWeight.bold, FontWeight_.Fonts_T, 16, 1),
                                                                                                  )),
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
                                                        ),
                                                        Expanded(
                                                          flex: 2,
                                                          child: Align(
                                                            alignment: Alignment
                                                                .topCenter,
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(0.0),
                                                              child: Container(
                                                                // width: 150,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  borderRadius:
                                                                      const BorderRadius
                                                                          .only(
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
                                                                            10),
                                                                  ),
                                                                  boxShadow: [
                                                                    BoxShadow(
                                                                      color: Colors
                                                                          .grey
                                                                          .withOpacity(
                                                                              0.5),
                                                                      spreadRadius:
                                                                          5,
                                                                      blurRadius:
                                                                          7,
                                                                      offset: const Offset(
                                                                          0,
                                                                          3), // changes position of shadow
                                                                    ),
                                                                  ],
                                                                ),
                                                                child:
                                                                    DropdownButtonFormField2(
                                                                  focusColor:
                                                                      Colors
                                                                          .white,
                                                                  autofocus:
                                                                      false,
                                                                  decoration:
                                                                      InputDecoration(
                                                                    enabled:
                                                                        true,
                                                                    hoverColor:
                                                                        Colors
                                                                            .brown,
                                                                    prefixIconColor:
                                                                        Colors
                                                                            .blue,
                                                                    fillColor: Colors
                                                                        .white
                                                                        .withOpacity(
                                                                            0.05),
                                                                    filled:
                                                                        false,
                                                                    isDense:
                                                                        true,
                                                                    contentPadding:
                                                                        EdgeInsets
                                                                            .zero,
                                                                    border:
                                                                        OutlineInputBorder(
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
                                                                          BorderRadius
                                                                              .only(
                                                                        topRight:
                                                                            Radius.circular(10),
                                                                        topLeft:
                                                                            Radius.circular(10),
                                                                        bottomRight:
                                                                            Radius.circular(10),
                                                                        bottomLeft:
                                                                            Radius.circular(10),
                                                                      ),
                                                                      borderSide:
                                                                          BorderSide(
                                                                        width:
                                                                            1,
                                                                        color: Color.fromARGB(
                                                                            255,
                                                                            231,
                                                                            227,
                                                                            227),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  isExpanded:
                                                                      false,
                                                                  hint: Text(
                                                                    renTal_Porvi ==
                                                                            null
                                                                        ? ''
                                                                        : '$renTal_Porvi',
                                                                    maxLines: 1,
                                                                    style:
                                                                        const TextStyle(
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      fontSize:
                                                                          15,
                                                                      color: Colors
                                                                          .grey,
                                                                    ),
                                                                  ),
                                                                  icon:
                                                                      const Icon(
                                                                    Icons
                                                                        .arrow_drop_down,
                                                                    color: Colors
                                                                        .black,
                                                                  ),
                                                                  style:
                                                                      const TextStyle(
                                                                    color: Colors
                                                                        .grey,
                                                                  ),
                                                                  // buttonWidth: 20,
                                                                  iconSize: 20,
                                                                  buttonHeight:
                                                                      40,
                                                                  // buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                                                                  dropdownDecoration:
                                                                      BoxDecoration(
                                                                    // color: Colors
                                                                    //     .amber,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                    border: Border.all(
                                                                        color: Colors
                                                                            .white,
                                                                        width:
                                                                            1),
                                                                  ),
                                                                  items: provinceNamesTh
                                                                      .map((item) => DropdownMenuItem<String>(
                                                                            value:
                                                                                '${item}',
                                                                            child: Translate.TranslateAndSetText(
                                                                                'จังหวัด : ${item}',
                                                                                SettingScreen_Color.Colors_Text2_,
                                                                                TextAlign.left,
                                                                                FontWeight.w600,
                                                                                FontWeight_.Fonts_T,
                                                                                16,
                                                                                1),
                                                                          ))
                                                                      .toList(),

                                                                  onChanged:
                                                                      (value) async {
                                                                    setState(
                                                                        () {
                                                                      renTal_Porvi =
                                                                          value;
                                                                    });

                                                                    ///-------------------------------->

                                                                    String
                                                                        value_ =
                                                                        await '${renTal_Porvi}';

                                                                    ///-------------------------------->
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
                                                                    Dia_log();
                                                                    String url =
                                                                        '${MyConstant().domain}/UpC_rental_data_editweb.php?isAdd=true&ren=$ren&ser=$ser_user&value=$value_&typevalue=9';

                                                                    try {
                                                                      var response =
                                                                          await http
                                                                              .get(Uri.parse(url));

                                                                      var result =
                                                                          await json
                                                                              .decode(response.body);

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
                                                                      } else {}
                                                                    } catch (e) {
                                                                      print(e);
                                                                    }
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
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
                                          decoration: BoxDecoration(
                                            color: Colors.grey[100]!
                                                .withOpacity(0.5),
                                            borderRadius: const BorderRadius
                                                    .only(
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(10),
                                                bottomLeft: Radius.circular(10),
                                                bottomRight:
                                                    Radius.circular(10)),
                                            border: Border.all(
                                                color: Colors.grey, width: 0.5),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Expanded(
                                                    flex: 1,
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color:
                                                            AppbackgroundColor
                                                                .TiTile_Colors,
                                                        // color: AppbackgroundColor
                                                        //         .TiTile_Colors
                                                        //     .withOpacity(0.7),
                                                        borderRadius: const BorderRadius
                                                                .only(
                                                            topLeft: Radius
                                                                .circular(10),
                                                            topRight:
                                                                Radius.circular(
                                                                    10),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    0),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    0)),
                                                        border: Border.all(
                                                            color: Colors.grey,
                                                            width: 0.5),
                                                      ),
                                                      child: Align(
                                                        alignment:
                                                            Alignment.topCenter,
                                                        child: Translate
                                                            .TranslateAndSetText(
                                                                '📠 อื่นๆ',
                                                                SettingScreen_Color
                                                                    .Colors_Text2_,
                                                                TextAlign.left,
                                                                FontWeight.bold,
                                                                FontWeight_
                                                                    .Fonts_T,
                                                                16,
                                                                1),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Stack(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Container(
                                                      height: 190,
                                                      width: 210,
                                                      decoration: BoxDecoration(
                                                        color: AppbackgroundColor
                                                                .TiTile_Colors
                                                            .withOpacity(0.7),
                                                        borderRadius:
                                                            const BorderRadius
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
                                                                  10),
                                                        ),
                                                        border: Border.all(
                                                            color: Colors.grey,
                                                            width: 1),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(3.0),
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    8.0),
                                                            topRight:
                                                                Radius.circular(
                                                                    8.0),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    8.0),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    8.0),
                                                          ),
                                                          child: (qr_img_ ==
                                                                      null ||
                                                                  qr_img_ == '')
                                                              ? const Icon(Icons
                                                                  .image_not_supported)
                                                              : Image.network(
                                                                  '${MyConstant().domain}/files/$foder/webfont/qrimg/$qr_img_',
                                                                  fit: BoxFit
                                                                      .fill,
                                                                  height: 180,
                                                                  width: 200,
                                                                ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    bottom: 0,
                                                    left: 20,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: InkWell(
                                                        child: Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(4.0),
                                                          decoration:
                                                              const BoxDecoration(
                                                            color: Colors.green,
                                                            borderRadius: BorderRadius.only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        8),
                                                                topRight: Radius
                                                                    .circular(
                                                                        8),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        8),
                                                                bottomRight:
                                                                    Radius
                                                                        .circular(
                                                                            8)),
                                                            // border: Border.all(
                                                            //     color: Colors.grey, width: 3),
                                                          ),
                                                          width: 150,
                                                          child: Center(
                                                            child: Translate.TranslateAndSetText(
                                                                (qr_img_ == null ||
                                                                        qr_img_ ==
                                                                            '')
                                                                    ? 'เพิ่ม'
                                                                    : 'แก้ไข',
                                                                SettingScreen_Color
                                                                    .Colors_Text3_,
                                                                TextAlign.left,
                                                                FontWeight.bold,
                                                                FontWeight_
                                                                    .Fonts_T,
                                                                16,
                                                                1),
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
                                                              builder:
                                                                  (BuildContext
                                                                      context) {
                                                                return AlertDialog(
                                                                  shape: const RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.all(
                                                                              Radius.circular(10.0))),
                                                                  title: Center(
                                                                    child: Translate.TranslateAndSetText(
                                                                        'มีรูป QR Code อยู่แล้ว',
                                                                        SettingScreen_Color
                                                                            .Colors_Text1_,
                                                                        TextAlign
                                                                            .left,
                                                                        FontWeight
                                                                            .bold,
                                                                        FontWeight_
                                                                            .Fonts_T,
                                                                        16,
                                                                        1),
                                                                  ),
                                                                  content:
                                                                      SingleChildScrollView(
                                                                    child:
                                                                        ListBody(
                                                                      children: <Widget>[
                                                                        Translate.TranslateAndSetText(
                                                                            'มีหน้าปก หากต้องการอัพโหลดกรุณาลบรูปหน้าปกที่มีอยู่แล้วก่อน',
                                                                            SettingScreen_Color.Colors_Text2_,
                                                                            TextAlign.left,
                                                                            FontWeight.bold,
                                                                            FontWeight_.Fonts_T,
                                                                            16,
                                                                            1),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  actions: <Widget>[
                                                                    Column(
                                                                      children: [
                                                                        const SizedBox(
                                                                          height:
                                                                              5.0,
                                                                        ),
                                                                        const Divider(
                                                                          color:
                                                                              Colors.grey,
                                                                          height:
                                                                              4.0,
                                                                        ),
                                                                        const SizedBox(
                                                                          height:
                                                                              5.0,
                                                                        ),
                                                                        Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            Padding(
                                                                              padding: const EdgeInsets.all(8.0),
                                                                              child: InkWell(
                                                                                child: Container(
                                                                                    width: 50,
                                                                                    decoration: BoxDecoration(
                                                                                      color: Colors.red[600],
                                                                                      borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                                                                                      // border: Border.all(color: Colors.white, width: 1),
                                                                                    ),
                                                                                    padding: const EdgeInsets.all(8.0),
                                                                                    child: Center(
                                                                                      child: Translate.TranslateAndSetText('ลบรูป', SettingScreen_Color.Colors_Text3_, TextAlign.left, FontWeight.bold, FontWeight_.Fonts_T, 16, 1),
                                                                                    )),
                                                                                onTap: () async {
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
                                                                              child: Row(
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
                                                                                          child: Center(
                                                                                            child: Translate.TranslateAndSetText('ปิด', SettingScreen_Color.Colors_Text3_, TextAlign.left, FontWeight.bold, FontWeight_.Fonts_T, 16, 1),
                                                                                          )),
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
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: SizedBox(
                                                  // width: 200,
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        flex: 1,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Column(
                                                            children: [
                                                              Align(
                                                                alignment:
                                                                    Alignment
                                                                        .topLeft,
                                                                child: Text(
                                                                  'Line',

                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  // minFontSize: 1,
                                                                  // maxFontSize: 12,
                                                                  maxLines: 1,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
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
                                                              SizedBox(
                                                                height: 30,
                                                                child:
                                                                    TextFormField(
                                                                  // keyboardType: TextInputType.number,
                                                                  controller:
                                                                      rental_Line_text,

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
                                                                      labelStyle: const TextStyle(
                                                                        color: Colors
                                                                            .black54,
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
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Column(
                                                            children: [
                                                              Align(
                                                                alignment:
                                                                    Alignment
                                                                        .topLeft,
                                                                child: Text(
                                                                  'Facebook',

                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  // minFontSize: 1,
                                                                  // maxFontSize: 12,
                                                                  maxLines: 1,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
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
                                                              SizedBox(
                                                                height: 30,
                                                                child:
                                                                    TextFormField(
                                                                  // keyboardType: TextInputType.number,
                                                                  controller:
                                                                      rental_Facebook_text,

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
                                                                      labelStyle: const TextStyle(
                                                                        color: Colors
                                                                            .black54,
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
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    flex: 1,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              2.0),
                                                      child: Column(
                                                        children: [
                                                          Align(
                                                            alignment: Alignment
                                                                .topLeft,
                                                            child: Text(
                                                              'Tel.',

                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              // minFontSize: 1,
                                                              // maxFontSize: 12,
                                                              maxLines: 1,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
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
                                                          SizedBox(
                                                            height: 35,
                                                            child:
                                                                TextFormField(
                                                              keyboardType:
                                                                  TextInputType
                                                                      .number,
                                                              controller:
                                                                  tel_text,
                                                              maxLines: 1,
                                                              style:
                                                                  const TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontFamily: Font_
                                                                    .Fonts_T,
                                                                // fontWeight: FontWeight.bold,
                                                                //fontSize: 10.0
                                                              ),
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
                                                                    topRight: Radius
                                                                        .circular(
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
                                                                    topRight: Radius
                                                                        .circular(
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
                                                                ),
                                                              ),
                                                              inputFormatters: <TextInputFormatter>[
                                                                // for below version 2 use this
                                                                FilteringTextInputFormatter
                                                                    .allow(RegExp(
                                                                        r'[0-9]')),
                                                                // for version 2 and greater youcan also use this
                                                                FilteringTextInputFormatter
                                                                    .digitsOnly
                                                              ],
                                                            ),
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
                                                              2.0),
                                                      child: Column(
                                                        children: [
                                                          Align(
                                                            alignment: Alignment
                                                                .topLeft,
                                                            child: Translate
                                                                .TranslateAndSetText(
                                                                    'ที่จอดรถ.',
                                                                    SettingScreen_Color
                                                                        .Colors_Text2_,
                                                                    TextAlign
                                                                        .left,
                                                                    FontWeight
                                                                        .bold,
                                                                    FontWeight_
                                                                        .Fonts_T,
                                                                    16,
                                                                    1),
                                                          ),
                                                          SizedBox(
                                                            height: 30,
                                                            child: Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5),
                                                                color: Colors
                                                                    .grey[200],
                                                              ),
                                                              child: InkWell(
                                                                onTap:
                                                                    () async {
                                                                  var parking =
                                                                      (Parking.toString() ==
                                                                              '0')
                                                                          ? '1'
                                                                          : '0';

                                                                  ///-------------------------------->

                                                                  String line_ =
                                                                      '${rental_Line_text.text}';
                                                                  String face_ =
                                                                      '${rental_Facebook_text.text}';
                                                                  String yout_ =
                                                                      '${rental_UrlYoutube_text.text}';
                                                                  String telss =
                                                                      '${tel_text.text}';
                                                                  print(telss);

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
                                                                  Dia_log();
                                                                  String url =
                                                                      '${MyConstant().domain}/UpC_rental_data_editweb.php?isAdd=true&ren=$ren&ser=$ser_user&value='
                                                                      '&lines=$line_&faces=$face_&youts=$yout_&tels=$telss&par_king=$parking&typevalue=4';

                                                                  try {
                                                                    var response =
                                                                        await http
                                                                            .get(Uri.parse(url));

                                                                    var result =
                                                                        await json
                                                                            .decode(response.body);

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
                                                                    } else {}
                                                                  } catch (e) {
                                                                    print(e);
                                                                  }
                                                                },
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Translate.TranslateAndSetText(
                                                                        'ไม่มี',
                                                                        SettingScreen_Color
                                                                            .Colors_Text2_,
                                                                        TextAlign
                                                                            .left,
                                                                        FontWeight
                                                                            .bold,
                                                                        FontWeight_
                                                                            .Fonts_T,
                                                                        16,
                                                                        1),
                                                                    Container(
                                                                        padding:
                                                                            const EdgeInsets.all(
                                                                                0.0),
                                                                        child: (Parking.toString() ==
                                                                                '0')
                                                                            ? const Icon(
                                                                                Icons.toggle_on,
                                                                                color: Colors.green,
                                                                                size: 40,
                                                                              )
                                                                            : const Icon(
                                                                                Icons.toggle_off,
                                                                                size: 40,
                                                                              )),
                                                                    Translate.TranslateAndSetText(
                                                                        'มี',
                                                                        SettingScreen_Color
                                                                            .Colors_Text2_,
                                                                        TextAlign
                                                                            .left,
                                                                        FontWeight
                                                                            .bold,
                                                                        FontWeight_
                                                                            .Fonts_T,
                                                                        16,
                                                                        1),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(2.0),
                                                child: Column(
                                                  children: [
                                                    Align(
                                                      alignment:
                                                          Alignment.topLeft,
                                                      child: Text(
                                                        'Youtube',

                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        // minFontSize: 1,
                                                        // maxFontSize: 12,
                                                        maxLines: 1,
                                                        textAlign:
                                                            TextAlign.left,
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
                                                    SizedBox(
                                                      height: 35,
                                                      child: TextFormField(
                                                        // keyboardType: TextInputType.number,
                                                        controller:
                                                            rental_UrlYoutube_text,
                                                        maxLines: 1,
                                                        style: const TextStyle(
                                                          color: Colors.black,
                                                          fontFamily:
                                                              Font_.Fonts_T,
                                                          // fontWeight: FontWeight.bold,
                                                          //fontSize: 10.0
                                                        ),
                                                        // maxLength: 13,
                                                        cursorColor:
                                                            Colors.green,
                                                        decoration:
                                                            InputDecoration(
                                                          fillColor: Colors
                                                              .white
                                                              .withOpacity(0.3),
                                                          filled: true,
                                                          // prefixIcon:
                                                          //     const Icon(Icons.person_pin, color: Colors.black),
                                                          // suffixIcon: Icon(Icons.clear, color: Colors.black),
                                                          focusedBorder:
                                                              const OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .only(
                                                              topRight: Radius
                                                                  .circular(15),
                                                              topLeft: Radius
                                                                  .circular(15),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          15),
                                                              bottomLeft: Radius
                                                                  .circular(15),
                                                            ),
                                                            borderSide:
                                                                BorderSide(
                                                              width: 1,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                          enabledBorder:
                                                              const OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .only(
                                                              topRight: Radius
                                                                  .circular(15),
                                                              topLeft: Radius
                                                                  .circular(15),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          15),
                                                              bottomLeft: Radius
                                                                  .circular(15),
                                                            ),
                                                            borderSide:
                                                                BorderSide(
                                                              width: 1,
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                          ),
                                                          labelStyle:
                                                              const TextStyle(
                                                            color:
                                                                Colors.black54,
                                                            fontFamily:
                                                                FontWeight_
                                                                    .Fonts_T,
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
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
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
                                                      child: Translate
                                                          .TranslateAndSetText(
                                                              'บันทึก',
                                                              SettingScreen_Color
                                                                  .Colors_Text3_,
                                                              TextAlign.left,
                                                              FontWeight.bold,
                                                              FontWeight_
                                                                  .Fonts_T,
                                                              16,
                                                              1),
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
                                                    String tel_ =
                                                        '${tel_text.text}';

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
                                                    Dia_log();
                                                    String url =
                                                        '${MyConstant().domain}/UpC_rental_data_editweb.php?isAdd=true&ren=$ren&ser=$ser_user&value='
                                                        '&lines=$line_&faces=$face_&youts=$yout_&tels=$tel_&typevalue=4';

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
                  ),

                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Translate.TranslateAndSetText(
                            'ตั้งค่ารายละเอียดพื้นที่',
                            SettingScreen_Color.Colors_Text2_,
                            TextAlign.left,
                            FontWeight.bold,
                            FontWeight_.Fonts_T,
                            16,
                            1),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                // color: Colors.grey[100]!.withOpacity(0.5),
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10)),
                                border:
                                    Border.all(color: Colors.grey, width: 0.5),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(0.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: AppbackgroundColor
                                                  .TiTile_Colors,
                                              borderRadius:
                                                  const BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(5),
                                                      topRight:
                                                          Radius.circular(5),
                                                      bottomLeft:
                                                          Radius.circular(0),
                                                      bottomRight:
                                                          Radius.circular(0)),
                                            ),
                                            child: Align(
                                              alignment: Alignment.topLeft,
                                              child: Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    20, 8, 8, 8),
                                                child: Translate
                                                    .TranslateAndSetText(
                                                        'เวลาทำการ',
                                                        SettingScreen_Color
                                                            .Colors_Text2_,
                                                        TextAlign.left,
                                                        FontWeight.bold,
                                                        FontWeight_.Fonts_T,
                                                        16,
                                                        1),
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
                                                DateTime parsedTime =
                                                    DateFormat.jm().parse(
                                                        pickedTime
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
                                                DateTime parsedTime =
                                                    DateFormat.jm().parse(
                                                        pickedTime
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
                                                bottomRight:
                                                    Radius.circular(8)),
                                            // border: Border.all(
                                            //     color: Colors.grey, width: 3),
                                          ),
                                          width: 150,
                                          child: Center(
                                            child:
                                                Translate.TranslateAndSetText(
                                                    'บันทึก',
                                                    SettingScreen_Color
                                                        .Colors_Text3_,
                                                    TextAlign.left,
                                                    FontWeight.bold,
                                                    FontWeight_.Fonts_T,
                                                    16,
                                                    1),
                                          ),
                                        ),
                                        onTap: () async {
                                          ///-------------------------------->

                                          String Stime_ = '${Stimeinput.text}';
                                          String ltime_ = '${ltimeinput.text}';

                                          ///-------------------------------->
                                          SharedPreferences preferences =
                                              await SharedPreferences
                                                  .getInstance();
                                          String? ren = preferences
                                              .getString('renTalSer');
                                          String? ser_user =
                                              preferences.getString('ser');
                                          Dia_log();
                                          String url =
                                              '${MyConstant().domain}/UpC_rental_data_editweb.php?isAdd=true&ren=$ren&ser=$ser_user&value='
                                              '&stime=$Stime_&ltime=$ltime_&typevalue=3';

                                          try {
                                            var response =
                                                await http.get(Uri.parse(url));

                                            var result = await json
                                                .decode(response.body);

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
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                // color: Colors.grey[100]!.withOpacity(0.5),
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10)),
                                border:
                                    Border.all(color: Colors.grey, width: 0.5),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(0.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: AppbackgroundColor
                                                  .TiTile_Colors,
                                              borderRadius:
                                                  const BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(5),
                                                      topRight:
                                                          Radius.circular(5),
                                                      bottomLeft:
                                                          Radius.circular(0),
                                                      bottomRight:
                                                          Radius.circular(0)),
                                            ),
                                            child: const Align(
                                              alignment: Alignment.topLeft,
                                              child: Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    20, 8, 8, 8),
                                                child: Text(
                                                  'Url Google Map',
                                                  style: TextStyle(
                                                    color: SettingScreen_Color
                                                        .Colors_Text1_,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T,
                                                    fontWeight: FontWeight.bold,
                                                    //fontSize: 10.0
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
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
                                        child: Center(
                                          child: Translate.TranslateAndSetText(
                                              'บันทึก',
                                              SettingScreen_Color.Colors_Text3_,
                                              TextAlign.left,
                                              FontWeight.bold,
                                              FontWeight_.Fonts_T,
                                              16,
                                              1),
                                        ),
                                      ),
                                      onTap: () async {
                                        ///-------------------------------->

                                        String new_value =
                                            '${rental_Urladdr_text.text}';

                                        ///-------------------------------->
                                        SharedPreferences preferences =
                                            await SharedPreferences
                                                .getInstance();
                                        String? ren =
                                            preferences.getString('renTalSer');
                                        String? ser_user =
                                            preferences.getString('ser');
                                        Dia_log();
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
                          ),
                        ),
                      ],
                    ),
                  ),

                  // const Padding(
                  //   padding: EdgeInsets.fromLTRB(20, 8, 8, 8),
                  //   child: Text(
                  //     'ช่วงราคา',
                  //     style: TextStyle(
                  //       color: SettingScreen_Color.Colors_Text1_,
                  //       fontFamily: FontWeight_.Fonts_T,
                  //       fontWeight: FontWeight.bold,
                  //       //fontSize: 10.0
                  //     ),
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: AppbackgroundColor
                                                    .TiTile_Colors,
                                                borderRadius:
                                                    const BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(10),
                                                        topRight:
                                                            Radius.circular(10),
                                                        bottomLeft:
                                                            Radius.circular(0),
                                                        bottomRight:
                                                            Radius.circular(0)),
                                                border: Border.all(
                                                    color: Colors.grey,
                                                    width: 0.5),
                                              ),
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child:
                                                  Translate.TranslateAndSetText(
                                                      'ช่วงราคา',
                                                      SettingScreen_Color
                                                          .Colors_Text1_,
                                                      TextAlign.left,
                                                      FontWeight.bold,
                                                      FontWeight_.Fonts_T,
                                                      16,
                                                      1),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          // color: Colors.grey[100]!.withOpacity(0.5),
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(0),
                                              topRight: Radius.circular(0),
                                              bottomLeft: Radius.circular(10),
                                              bottomRight: Radius.circular(10)),
                                          border: Border.all(
                                              color: Colors.grey, width: 0.5),
                                        ),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    flex: 1,
                                                    child: Align(
                                                      alignment:
                                                          Alignment.topLeft,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: SizedBox(
                                                          // width: 200,
                                                          child: TextFormField(
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            controller:
                                                                rental_lowest_price_text,

                                                            // maxLength: 13,
                                                            cursorColor:
                                                                Colors.green,
                                                            decoration:
                                                                InputDecoration(
                                                                    labelText:
                                                                        'ช่วงราคาต่ำสุด',
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
                                                                            .black,
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
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  const Text(
                                                    '-',
                                                    style: TextStyle(
                                                      color: SettingScreen_Color
                                                          .Colors_Text1_,
                                                      fontFamily:
                                                          FontWeight_.Fonts_T,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      //fontSize: 10.0
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Align(
                                                      alignment:
                                                          Alignment.topLeft,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: SizedBox(
                                                          // width: 200,
                                                          child: TextFormField(
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            controller:
                                                                hiprice_text,

                                                            // maxLength: 13,
                                                            cursorColor:
                                                                Colors.green,
                                                            decoration:
                                                                InputDecoration(
                                                                    labelText:
                                                                        'ช่วงราคาสูงสุด',
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
                                                                            .black,
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
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.all(8.0),
                                                    child: Translate
                                                        .TranslateAndSetText(
                                                            ' / เดือน',
                                                            SettingScreen_Color
                                                                .Colors_Text1_,
                                                            TextAlign.left,
                                                            FontWeight.bold,
                                                            FontWeight_.Fonts_T,
                                                            16,
                                                            1),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
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
                                                    child: Translate
                                                        .TranslateAndSetText(
                                                            'บันทึก',
                                                            SettingScreen_Color
                                                                .Colors_Text3_,
                                                            TextAlign.left,
                                                            FontWeight.bold,
                                                            FontWeight_.Fonts_T,
                                                            16,
                                                            1),
                                                  ),
                                                ),
                                                onTap: () async {
                                                  ///-------------------------------->

                                                  String new_value =
                                                      '${rental_Urladdr_text.text}';

                                                  ///-------------------------------->
                                                  SharedPreferences
                                                      preferences =
                                                      await SharedPreferences
                                                          .getInstance();
                                                  String? ren = preferences
                                                      .getString('renTalSer');
                                                  String? ser_user = preferences
                                                      .getString('ser');
                                                  Dia_log();
                                                  String url =
                                                      '${MyConstant().domain}/UpC_rental_data_editweb.php?isAdd=true&ren=$ren&ser=$ser_user&lowpri=${rental_lowest_price_text.text}&hipri=${hiprice_text.text}&typevalue=11';

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
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )),
                          Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  child: Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color:
                                              AppbackgroundColor.TiTile_Colors,
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10),
                                              bottomLeft: Radius.circular(0),
                                              bottomRight: Radius.circular(0)),
                                          border: Border.all(
                                              color: Colors.grey, width: 0.5),
                                        ),
                                        padding: const EdgeInsets.fromLTRB(
                                            8, 0, 8, 0),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child:
                                                  Translate.TranslateAndSetText(
                                                      'Dialog แจ้งเตือน',
                                                      SettingScreen_Color
                                                          .Colors_Text2_,
                                                      TextAlign.left,
                                                      FontWeight.bold,
                                                      FontWeight_.Fonts_T,
                                                      16,
                                                      1),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Align(
                                                alignment: Alignment.topRight,
                                                child: Tooltip(
                                                  richMessage: TextSpan(
                                                    text: (dialog_status
                                                                .toString() ==
                                                            '1')
                                                        ? 'คลิก : เพื่อ ปิด'
                                                        : 'คลิก : เพื่อ เปิด',
                                                    style: const TextStyle(
                                                      color: SettingScreen_Color
                                                          .Colors_Text1_,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily:
                                                          FontWeight_.Fonts_T,
                                                      //fontSize: 10.0
                                                    ),
                                                  ),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    color: (dialog_status
                                                                .toString() ==
                                                            '1')
                                                        ? Colors.red[200]
                                                        : Colors
                                                            .lightGreen[200],
                                                  ),
                                                  child: InkWell(
                                                    onTap: () async {
                                                      ///-------------------------------->
                                                      var statuss = (dialog_status
                                                                  .toString() ==
                                                              '1')
                                                          ? '0'
                                                          : '1';
                                                      String new_value =
                                                          '${dialog_text.text}';

                                                      ///-------------------------------->
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
                                                      Dia_log();
                                                      String url =
                                                          '${MyConstant().domain}/UpC_rental_data_editweb.php?isAdd=true&ren=$ren&ser=$ser_user&value=${new_value}&di_status=$statuss&typevalue=12';

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
                                                    child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(0.0),
                                                        child: (dialog_status
                                                                    .toString() ==
                                                                '1')
                                                            ? const Icon(
                                                                Icons.toggle_on,
                                                                color: Colors
                                                                    .green,
                                                                size: 40,
                                                              )
                                                            : const Icon(
                                                                Icons
                                                                    .toggle_off,
                                                                size: 40,
                                                              )),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          // color: Colors.grey[100]!.withOpacity(0.5),
                                          // color:
                                          //     (dialog_status.toString() == '1')
                                          //         ? Colors.grey[100]!
                                          //             .withOpacity(0.5)
                                          //         : Colors.red[100]!
                                          //             .withOpacity(0.2),
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(0),
                                              topRight: Radius.circular(0),
                                              bottomLeft: Radius.circular(10),
                                              bottomRight: Radius.circular(10)),
                                          border: Border.all(
                                              color: Colors.grey, width: 0.5),
                                        ),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    flex: 1,
                                                    child: Align(
                                                      alignment:
                                                          Alignment.topLeft,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: SizedBox(
                                                          // width: 200,
                                                          child: TextFormField(
                                                            // keyboardType:
                                                            //     TextInputType
                                                            //         .number,
                                                            controller:
                                                                dialog_text,
                                                            // maxLines: 1,
                                                            // maxLength: 225,
                                                            cursorColor:
                                                                Colors.green,
                                                            decoration:
                                                                InputDecoration(
                                                                    labelText:
                                                                        'dialog',
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
                                                                            .black,
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
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
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
                                                    child: Translate
                                                        .TranslateAndSetText(
                                                            'บันทึก',
                                                            SettingScreen_Color
                                                                .Colors_Text3_,
                                                            TextAlign.left,
                                                            FontWeight.bold,
                                                            FontWeight_.Fonts_T,
                                                            16,
                                                            1),
                                                  ),
                                                ),
                                                onTap: () async {
                                                  ///-------------------------------->
                                                  var statuss = dialog_status;
                                                  String new_value =
                                                      '${dialog_text.text}';

                                                  ///-------------------------------->
                                                  SharedPreferences
                                                      preferences =
                                                      await SharedPreferences
                                                          .getInstance();
                                                  String? ren = preferences
                                                      .getString('renTalSer');
                                                  String? ser_user = preferences
                                                      .getString('ser');
                                                  Dia_log();
                                                  String url =
                                                      '${MyConstant().domain}/UpC_rental_data_editweb.php?isAdd=true&ren=$ren&ser=$ser_user&value=${new_value}&di_status=$statuss&typevalue=12';

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
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )),
                        ],
                      ),
                    ),
                  ),

                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 8, 8, 8),
                        child: Translate.TranslateAndSetText(
                            'สิ่งอำนวยความสะดวก',
                            SettingScreen_Color.Colors_Text1_,
                            TextAlign.left,
                            FontWeight.bold,
                            FontWeight_.Fonts_T,
                            16,
                            1),
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
                            child: Center(
                              child: Translate.TranslateAndSetText(
                                  '+เพิ่ม',
                                  SettingScreen_Color.Colors_Text3_,
                                  TextAlign.left,
                                  FontWeight.bold,
                                  FontWeight_.Fonts_T,
                                  16,
                                  1),
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
                                          child: Center(
                                            child:
                                                Translate.TranslateAndSetText(
                                                    'สิ่งอำนวยความสะดวก',
                                                    SettingScreen_Color
                                                        .Colors_Text1_,
                                                    TextAlign.left,
                                                    FontWeight.bold,
                                                    FontWeight_.Fonts_T,
                                                    16,
                                                    1),
                                          ),
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
                                                                  Dia_log();
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
                                                      child: Translate
                                                          .TranslateAndSetText(
                                                              'ยืนยัน',
                                                              SettingScreen_Color
                                                                  .Colors_Text3_,
                                                              TextAlign.left,
                                                              FontWeight.bold,
                                                              FontWeight_
                                                                  .Fonts_T,
                                                              16,
                                                              1),
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
                                                          child: Translate
                                                              .TranslateAndSetText(
                                                                  'ยกเลิก',
                                                                  SettingScreen_Color
                                                                      .Colors_Text3_,
                                                                  TextAlign
                                                                      .left,
                                                                  FontWeight
                                                                      .bold,
                                                                  FontWeight_
                                                                      .Fonts_T,
                                                                  16,
                                                                  1),
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
                        color: Colors.white,
                        // color: Colors.grey[100]!.withOpacity(0.5),
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8),
                            bottomLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8)),
                        border: Border.all(color: Colors.grey, width: 0.5),
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
                                      decoration: BoxDecoration(
                                        color: Colors.grey[300],
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(5),
                                            topRight: Radius.circular(5),
                                            bottomLeft: Radius.circular(5),
                                            bottomRight: Radius.circular(5)),
                                        border: Border.all(
                                            color: Colors.grey, width: 1),
                                      ),
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
                                        Icons.cancel,
                                        color: Colors.red,
                                        size: 20,
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
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 8, 8, 8),
                        child: Translate.TranslateAndSetText(
                            'สถานที่ใกล้เคียง',
                            SettingScreen_Color.Colors_Text1_,
                            TextAlign.left,
                            FontWeight.bold,
                            FontWeight_.Fonts_T,
                            16,
                            1),
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
                            child: Center(
                              child: Translate.TranslateAndSetText(
                                  '+เพิ่ม',
                                  SettingScreen_Color.Colors_Text3_,
                                  TextAlign.left,
                                  FontWeight.bold,
                                  FontWeight_.Fonts_T,
                                  16,
                                  1),
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
                                          child: Center(
                                            child:
                                                Translate.TranslateAndSetText(
                                                    'สถานที่ใกล้เคียง',
                                                    SettingScreen_Color
                                                        .Colors_Text1_,
                                                    TextAlign.left,
                                                    FontWeight.bold,
                                                    FontWeight_.Fonts_T,
                                                    16,
                                                    1),
                                          ),
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
                                                                  Dia_log();
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
                                                      child: Translate
                                                          .TranslateAndSetText(
                                                              'ยืนยัน',
                                                              SettingScreen_Color
                                                                  .Colors_Text3_,
                                                              TextAlign.left,
                                                              FontWeight.bold,
                                                              FontWeight_
                                                                  .Fonts_T,
                                                              16,
                                                              1),
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
                                                          child: Translate
                                                              .TranslateAndSetText(
                                                                  'ยกเลิก',
                                                                  SettingScreen_Color
                                                                      .Colors_Text3_,
                                                                  TextAlign
                                                                      .left,
                                                                  FontWeight
                                                                      .bold,
                                                                  FontWeight_
                                                                      .Fonts_T,
                                                                  16,
                                                                  1),
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
                        color: Colors.white,
                        // color: Colors.grey[100]!.withOpacity(0.5),
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8),
                            bottomLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8)),
                        border: Border.all(color: Colors.grey, width: 0.5),
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
                                      decoration: BoxDecoration(
                                        color: Colors.grey[300],
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(5),
                                            topRight: Radius.circular(5),
                                            bottomLeft: Radius.circular(5),
                                            bottomRight: Radius.circular(5)),
                                        border: Border.all(
                                            color: Colors.grey, width: 1),
                                      ),

                                      // color: Colors.grey[300],
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text('${nearby_places[index]}')),
                                ),
                                Positioned(
                                    top: 0,
                                    right: 2,
                                    child: InkWell(
                                      onTap: () async {
                                        setState(() {
                                          nearby_places.remove(
                                              '${nearby_places[index]}');
                                        });

                                        ///-------------------------------->
                                        String n_nearby_new = '';
                                        String new_value = '';

                                        for (int index = 0;
                                            index < nearby_places.length;
                                            index++) {
                                          setState(() {
                                            n_nearby_new +=
                                                '${nearby_places[index]},';
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
                                            '${MyConstant().domain}/UpC_rental_data_Fac_AND_places.php?isAdd=true&ren=$ren&ser=$ser_user&value=${n_nearby_new}&typevalue=2';

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
                                        Icons.cancel,
                                        color: Colors.red,
                                        size: 20,
                                      ),
                                    ))
                              ],
                            ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        // color: Colors.grey[100]!.withOpacity(0.5),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                        border: Border.all(color: Colors.grey, width: 0.5),
                      ),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: AppbackgroundColor.TiTile_Colors,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(0),
                                bottomRight: Radius.circular(0),
                              ),
                              border:
                                  Border.all(color: Colors.grey, width: 0.5),
                            ),
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    child: Translate.TranslateAndSetText(
                                        'ล็อคเสียบ',
                                        SettingScreen_Color.Colors_Text1_,
                                        TextAlign.left,
                                        FontWeight.bold,
                                        FontWeight_.Fonts_T,
                                        16,
                                        1),
                                  ),
                                ),
                                Container(
                                  width: 220,
                                  height: 30,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.grey[200],
                                    ),
                                    child: InkWell(
                                      onTap: () async {
                                        var OpenbooK =
                                            (Openbook_lockpay.toString() == '0')
                                                ? '1'
                                                : '0';

                                        ///-------------------------------->

                                        ///-------------------------------->
                                        SharedPreferences preferences =
                                            await SharedPreferences
                                                .getInstance();
                                        String? ren =
                                            preferences.getString('renTalSer');
                                        String? ser_user =
                                            preferences.getString('ser');
                                        Dia_log();
                                        String url =
                                            '${MyConstant().domain}/UpC_rental_data_editweb.php?isAdd=true&ren=$ren&ser=$ser_user&value=$OpenbooK&typevalue=13';

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
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Translate.TranslateAndSetText(
                                              'ไม่เปิดให้จอง',
                                              SettingScreen_Color.Colors_Text1_,
                                              TextAlign.left,
                                              FontWeight.bold,
                                              FontWeight_.Fonts_T,
                                              16,
                                              1),
                                          Container(
                                              padding:
                                                  const EdgeInsets.all(0.0),
                                              child: (Openbook_lockpay
                                                          .toString() ==
                                                      '1')
                                                  ? const Icon(
                                                      Icons.toggle_on,
                                                      color: Colors.green,
                                                      size: 40,
                                                    )
                                                  : const Icon(
                                                      Icons.toggle_off,
                                                      size: 40,
                                                    )),
                                          Translate.TranslateAndSetText(
                                              'เปิดให้จอง',
                                              SettingScreen_Color.Colors_Text1_,
                                              TextAlign.left,
                                              FontWeight.bold,
                                              FontWeight_.Fonts_T,
                                              16,
                                              1),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(20, 8, 8, 8),
                                child: Translate.TranslateAndSetText(
                                    'วันที่/เวลาที่เปิดให้จอง',
                                    Colors.blueGrey,
                                    TextAlign.left,
                                    FontWeight.bold,
                                    FontWeight_.Fonts_T,
                                    16,
                                    1),
                              ),
                              InkWell(
                                onTap: () async {
                                  SharedPreferences preferences =
                                      await SharedPreferences.getInstance();
                                  String? ren =
                                      preferences.getString('renTalSer');

                                  Dia_log();
                                  try {
                                    final url =
                                        '${MyConstant().domain}/UP_In_prebook.php?isAdd=true';

                                    final response = await http.post(
                                      Uri.parse(url),
                                      body: {
                                        'ren': '$ren',
                                        'type': 'INSERT',
                                        'ser': '',
                                        'zone': '',
                                        'pdate': '',
                                        'ts_padte': '',
                                        'ldate': '',
                                        'tl_ldate': '',
                                        'bdate': '',
                                        'bldate': ''
                                      },
                                    );
                                  } catch (e) {}
                                  setState(() {
                                    CG_Prebook();
                                  });
                                },
                                child: Icon(
                                  Icons.add_circle,
                                  color: Colors.green,
                                ),
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: AppbackgroundColor.TiTile_Colors
                                    .withOpacity(0.1),
                                // color: const Color.fromARGB(255, 226, 230, 233)!
                                //     .withOpacity(0.5),
                                // color: AppbackgroundColor
                                //     .TiTile_Colors,
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10)),
                                border:
                                    Border.all(color: Colors.grey, width: 0.5),
                              ),
                              padding: const EdgeInsets.all(2.0),
                              child: ScrollConfiguration(
                                behavior: ScrollConfiguration.of(context)
                                    .copyWith(dragDevices: {
                                  PointerDeviceKind.touch,
                                  PointerDeviceKind.mouse,
                                }),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      for (int index = 0;
                                          index < prebookModels.length;
                                          index++)
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.grey[200],
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
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.all(2.0),
                                              child: Row(
                                                children: [
                                                  Translate.TranslateAndSetText(
                                                      'เงื่อนไข ${index + 1} :',
                                                      ReportScreen_Color
                                                          .Colors_Text2_,
                                                      TextAlign.left,
                                                      FontWeight.bold,
                                                      FontWeight_.Fonts_T,
                                                      16,
                                                      1),
                                                  Stack(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: InkWell(
                                                          // onTap: () {
                                                          //   selectdate(index);
                                                          // },
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              color: AppbackgroundColor
                                                                  .Sub_Abg_Colors,
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
                                                                      .grey,
                                                                  width: 1),
                                                            ),
                                                            width: 260,
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    Expanded(
                                                                      child: Translate.TranslateAndSetText(
                                                                          (prebookModels[index].pdate.toString() == '0000-00-00' || prebookModels[index].ldate.toString() == '0000-00-00' || prebookModels[index].pdate.toString() == 'null' || prebookModels[index].ldate.toString() == 'null')
                                                                              ? 'เลือก'
                                                                              : '${DateFormat('dd-MM').format(DateTime.parse('${prebookModels[index].pdate}'))}-${DateTime.parse('${prebookModels[index].pdate}').year + 543} ถึง ${DateFormat('dd-MM').format(DateTime.parse('${prebookModels[index].ldate}'))}-${DateTime.parse('${prebookModels[index].ldate}').year + 0}',
                                                                          ReportScreen_Color
                                                                              .Colors_Text2_,
                                                                          TextAlign
                                                                              .left,
                                                                          null,
                                                                          Font_
                                                                              .Fonts_T,
                                                                          12,
                                                                          1),
                                                                    ),
                                                                    InkWell(
                                                                      onTap:
                                                                          () {
                                                                        selectdate(
                                                                            index,
                                                                            'pdate');
                                                                      },
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .date_range,
                                                                        color: Colors
                                                                            .blue,
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                                SizedBox(
                                                                  height: 5,
                                                                ),
                                                                Divider(
                                                                  color: Colors
                                                                      .grey,
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    Expanded(
                                                                      child: Translate.TranslateAndSetText(
                                                                          'เวลา : ${prebookModels[index].ts_padte} ถึง ${prebookModels[index].tl_ldate}',
                                                                          ReportScreen_Color
                                                                              .Colors_Text2_,
                                                                          TextAlign
                                                                              .left,
                                                                          null,
                                                                          Font_
                                                                              .Fonts_T,
                                                                          12,
                                                                          1),
                                                                    ),
                                                                    InkWell(
                                                                      onTap:
                                                                          () async {
                                                                        TimeRange
                                                                            result =
                                                                            await showTimeRangePicker(
                                                                          context:
                                                                              context,
                                                                          rotateLabels:
                                                                              false,
                                                                          use24HourFormat:
                                                                              true,
                                                                          paintingStyle:
                                                                              PaintingStyle.fill,
                                                                          ticks:
                                                                              12,
                                                                          ticksColor:
                                                                              Colors.grey,
                                                                          ticksOffset:
                                                                              -12,
                                                                          labels:
                                                                              [
                                                                            "24 h",
                                                                            "3 h",
                                                                            "6 h",
                                                                            "9 h",
                                                                            "12 h",
                                                                            "15 h",
                                                                            "18 h",
                                                                            "21 h"
                                                                          ].asMap().entries.map((e) {
                                                                            return ClockLabel.fromIndex(
                                                                                idx: e.key,
                                                                                length: 8,
                                                                                text: e.value);
                                                                          }).toList(),
                                                                          labelOffset:
                                                                              -30,
                                                                          padding:
                                                                              55,
                                                                          start: const TimeOfDay(
                                                                              hour: 00,
                                                                              minute: 00),
                                                                          end: const TimeOfDay(
                                                                              hour: 06,
                                                                              minute: 00),
                                                                          // disabledTime:
                                                                          //     TimeRange(
                                                                          //   startTime:
                                                                          //       const TimeOfDay(hour: 4, minute: 0),
                                                                          //   endTime:
                                                                          //       const TimeOfDay(hour: 10, minute: 0),
                                                                          // ),
                                                                          maxDuration: Duration(
                                                                              hours: 23,
                                                                              minutes: 59),
                                                                        );
                                                                        SharedPreferences
                                                                            preferences =
                                                                            await SharedPreferences.getInstance();

                                                                        var ren =
                                                                            preferences.getString('renTalSer');
                                                                        try {
                                                                          final url =
                                                                              '${MyConstant().domain}/UP_In_prebook.php?isAdd=true';

                                                                          final response =
                                                                              await http.post(
                                                                            Uri.parse(url),
                                                                            body: {
                                                                              'ren': '$ren',
                                                                              'type': 'UP',
                                                                              'ser': '${prebookModels[index].ser}',
                                                                              'zone': '${prebookModels[index].zone}',
                                                                              'pdate': '${prebookModels[index].pdate}',
                                                                              'ts_padte': '${result.startTime.hour}:${result.startTime.minute}:00',
                                                                              'ldate': '${prebookModels[index].ldate}',
                                                                              'tl_ldate': '${result.endTime.hour}:${result.endTime.minute}:00',
                                                                              'bdate': '${prebookModels[index].bdate}',
                                                                              'bldate': '${prebookModels[index].bldate}'
                                                                            },
                                                                          );
                                                                        } catch (e) {}
                                                                        setState(
                                                                            () {
                                                                          CG_Prebook();
                                                                        });
                                                                        Dia_log();
                                                                        print(
                                                                            '${result.startTime}');
                                                                      },

                                                                      //  () =>
                                                                      //     TimeRangePicker
                                                                      //         .show(
                                                                      //   context:
                                                                      //       context,
                                                                      //   unSelectedEmpty:
                                                                      //       true,
                                                                      //   startTime: TimeOfDay(
                                                                      //       hour:
                                                                      //           00,
                                                                      //       minute:
                                                                      //           30),
                                                                      //   endTime: TimeOfDay(
                                                                      //       hour:
                                                                      //           12,
                                                                      //       minute:
                                                                      //           30),
                                                                      //   onSubmitted:
                                                                      //       (TimeRangeValue
                                                                      //           value) async {
                                                                      //     SharedPreferences
                                                                      //         preferences =
                                                                      //         await SharedPreferences.getInstance();

                                                                      //     var ren =
                                                                      //         preferences.getString('renTalSer');
                                                                      //     try {
                                                                      //       final url =
                                                                      //           '${MyConstant().domain}/UP_In_prebook.php?isAdd=true';

                                                                      //       final response =
                                                                      //           await http.post(
                                                                      //         Uri.parse(url),
                                                                      //         body: {
                                                                      //           'ren': '$ren',
                                                                      //           'type': 'UP',
                                                                      //           'ser': '${prebookModels[index].ser}',
                                                                      //           'zone': '${prebookModels[index].zone}',
                                                                      //           'pdate': '${prebookModels[index].pdate}',
                                                                      //           'ts_padte': '${prebookModels[index].ts_padte}',
                                                                      //           'ldate': '${prebookModels[index].ldate}',
                                                                      //           'tl_ldate': '${prebookModels[index].tl_ldate}',
                                                                      //           'bdate': '${prebookModels[index].bdate}',
                                                                      //           'bldate': '${prebookModels[index].bldate}'
                                                                      //         },
                                                                      //       );
                                                                      //     } catch (e) {}
                                                                      //   },
                                                                      // ),
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .timer_sharp,
                                                                        color: Colors
                                                                            .blue,
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                                SizedBox(
                                                                  height: 5,
                                                                ),
                                                                Divider(
                                                                  color: Colors
                                                                      .grey,
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    Translate.TranslateAndSetText(
                                                                        'เปิดให้จอง : ',
                                                                        ReportScreen_Color
                                                                            .Colors_Text2_,
                                                                        TextAlign
                                                                            .left,
                                                                        null,
                                                                        Font_
                                                                            .Fonts_T,
                                                                        12,
                                                                        1),
                                                                    Expanded(
                                                                      child: Translate.TranslateAndSetText(
                                                                          (prebookModels[index].bdate.toString() == '0000-00-00' || prebookModels[index].bldate.toString() == '0000-00-00' || prebookModels[index].bdate.toString() == 'null' || prebookModels[index].bldate.toString() == 'null')
                                                                              ? 'เลือก'
                                                                              : '${DateFormat('dd-MM').format(DateTime.parse('${prebookModels[index].bdate}'))}-${DateTime.parse('${prebookModels[index].bdate}').year + 543} ถึง ${DateFormat('dd-MM').format(DateTime.parse('${prebookModels[index].bldate}'))}-${DateTime.parse('${prebookModels[index].bldate}').year + 0}',
                                                                          ReportScreen_Color
                                                                              .Colors_Text2_,
                                                                          TextAlign
                                                                              .left,
                                                                          null,
                                                                          Font_
                                                                              .Fonts_T,
                                                                          12,
                                                                          1),
                                                                    ),
                                                                    InkWell(
                                                                      onTap:
                                                                          () {
                                                                        selectdate(
                                                                            index,
                                                                            'bdate');
                                                                      },
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .date_range,
                                                                        color: Colors
                                                                            .green,
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Positioned(
                                                          top: 0,
                                                          left: 5,
                                                          child: InkWell(
                                                            onTap: () async {
                                                              ///-------------------------------->
                                                              SharedPreferences
                                                                  preferences =
                                                                  await SharedPreferences
                                                                      .getInstance();
                                                              String? ren =
                                                                  preferences
                                                                      .getString(
                                                                          'renTalSer');
                                                              // String? ser_user =
                                                              //     preferences
                                                              //         .getString(
                                                              //             'ser');
                                                              Dia_log();
                                                              String url =
                                                                  '${MyConstant().domain}/De_prebook.php?isAdd=true&ren=$ren&ser=${prebookModels[index].ser}';

                                                              try {
                                                                var response =
                                                                    await http.get(
                                                                        Uri.parse(
                                                                            url));

                                                                var result =
                                                                    await json.decode(
                                                                        response
                                                                            .body);

                                                                if (result
                                                                        .toString() ==
                                                                    'true') {
                                                                  setState(() {
                                                                    signInThread();
                                                                    read_GC_rental();
                                                                    read_GC_area();
                                                                    read_GC_rentaldata();
                                                                    read_GC_rental_img();
                                                                    CG_Prebook();
                                                                  });
                                                                } else {}
                                                              } catch (e) {
                                                                print(e);
                                                              }
                                                            },
                                                            child: Icon(
                                                              Icons.cancel,
                                                              size: 20,
                                                              color: Colors.red,
                                                            ),
                                                          ))
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(20, 8, 8, 8),
                                child: Translate.TranslateAndSetText(
                                    'วันที่เปิดให้จอง',
                                    SettingScreen_Color.Colors_Text1_,
                                    TextAlign.left,
                                    FontWeight.bold,
                                    FontWeight_.Fonts_T,
                                    16,
                                    1),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 0, 8, 4),
                            child: Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: AppbackgroundColor.TiTile_Colors
                                      .withOpacity(0.1),
                                  // color: const Color.fromARGB(255, 226, 230, 233)!
                                  //     .withOpacity(0.5),
                                  // color: AppbackgroundColor
                                  //     .TiTile_Colors,
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10)),
                                  border: Border.all(
                                      color: Colors.grey, width: 0.5),
                                ),
                                padding: const EdgeInsets.all(2.0),
                                child: ScrollConfiguration(
                                  behavior: ScrollConfiguration.of(context)
                                      .copyWith(dragDevices: {
                                    PointerDeviceKind.touch,
                                    PointerDeviceKind.mouse,
                                  }),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: [
                                        Container(
                                          width: (MediaQuery.of(context)
                                                      .size
                                                      .width <
                                                  500)
                                              ? (MediaQuery.of(context)
                                                      .size
                                                      .width) +
                                                  420
                                              : MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.8,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              for (int index = 0;
                                                  index < 7;
                                                  index++)
                                                Expanded(
                                                  flex: 1,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            4.0),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: Colors.grey[200],
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
                                                      ),
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(2.0),
                                                              child: Translate.TranslateAndSetText(
                                                                  (index == 0)
                                                                      ? 'อาทิตย์'
                                                                      : (index == 1)
                                                                          ? 'จันทร์'
                                                                          : (index == 2)
                                                                              ? 'อังคาร'
                                                                              : (index == 3)
                                                                                  ? 'พุธ'
                                                                                  : (index == 4)
                                                                                      ? 'พฤหัสบดี'
                                                                                      : (index == 5)
                                                                                          ? 'ศุกร์'
                                                                                          : 'เสาร์',
                                                                  SettingScreen_Color.Colors_Text1_,
                                                                  TextAlign.left,
                                                                  FontWeight.bold,
                                                                  FontWeight_.Fonts_T,
                                                                  16,
                                                                  1),
                                                            ),
                                                          ),
                                                          StreamBuilder(
                                                              stream: Stream.periodic(
                                                                  const Duration(
                                                                      seconds:
                                                                          0)),
                                                              builder: (context,
                                                                  snapshot) {
                                                                return Tooltip(
                                                                  richMessage:
                                                                      TextSpan(
                                                                    text: (index ==
                                                                            0)
                                                                        ? (Lock_Day1.toString() ==
                                                                                '1')
                                                                            ? 'คลิก : เพื่อ ปิด'
                                                                            : 'คลิก : เพื่อ เปิด'
                                                                        : (index ==
                                                                                1)
                                                                            ? (Lock_Day2.toString() == '1')
                                                                                ? 'คลิก : เพื่อ ปิด'
                                                                                : 'คลิก : เพื่อ เปิด'
                                                                            : (index == 2)
                                                                                ? (Lock_Day3.toString() == '1')
                                                                                    ? 'คลิก : เพื่อ ปิด'
                                                                                    : 'คลิก : เพื่อ เปิด'
                                                                                : (index == 3)
                                                                                    ? (Lock_Day4.toString() == '1')
                                                                                        ? 'คลิก : เพื่อ ปิด'
                                                                                        : 'คลิก : เพื่อ เปิด'
                                                                                    : (index == 4)
                                                                                        ? (Lock_Day5.toString() == '1')
                                                                                            ? 'คลิก : เพื่อ ปิด'
                                                                                            : 'คลิก : เพื่อ เปิด'
                                                                                        : (index == 5)
                                                                                            ? (Lock_Day6.toString() == '1')
                                                                                                ? 'คลิก : เพื่อ ปิด'
                                                                                                : 'คลิก : เพื่อ เปิด'
                                                                                            : (Lock_Day7.toString() == '1')
                                                                                                ? 'คลิก : เพื่อ ปิด'
                                                                                                : 'คลิก : เพื่อ เปิด',
                                                                    style:
                                                                        const TextStyle(
                                                                      color: SettingScreen_Color
                                                                          .Colors_Text1_,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontFamily:
                                                                          FontWeight_
                                                                              .Fonts_T,
                                                                      //fontSize: 10.0
                                                                    ),
                                                                  ),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(5),
                                                                    color: (index ==
                                                                            0)
                                                                        ? (Lock_Day1.toString() ==
                                                                                '1')
                                                                            ? Colors.red[
                                                                                200]
                                                                            : Colors.lightGreen[
                                                                                200]
                                                                        : (index ==
                                                                                1)
                                                                            ? (Lock_Day2.toString() == '1')
                                                                                ? Colors.red[200]
                                                                                : Colors.lightGreen[200]
                                                                            : (index == 2)
                                                                                ? (Lock_Day3.toString() == '1')
                                                                                    ? Colors.red[200]
                                                                                    : Colors.lightGreen[200]
                                                                                : (index == 3)
                                                                                    ? (Lock_Day4.toString() == '1')
                                                                                        ? Colors.red[200]
                                                                                        : Colors.lightGreen[200]
                                                                                    : (index == 4)
                                                                                        ? (Lock_Day5.toString() == '1')
                                                                                            ? Colors.red[200]
                                                                                            : Colors.lightGreen[200]
                                                                                        : (index == 5)
                                                                                            ? (Lock_Day6.toString() == '1')
                                                                                                ? Colors.red[200]
                                                                                                : Colors.lightGreen[200]
                                                                                            : (Lock_Day7.toString() == '1')
                                                                                                ? Colors.red[200]
                                                                                                : Colors.lightGreen[200],
                                                                  ),
                                                                  child: Padding(
                                                                      padding: const EdgeInsets.all(4.0),
                                                                      child: InkWell(
                                                                        child:
                                                                            Container(
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color: (index == 0)
                                                                                ? (Lock_Day1.toString() == '1')
                                                                                    ? Colors.grey[100]!.withOpacity(0.5)
                                                                                    : Colors.red[100]!.withOpacity(0.2)
                                                                                : (index == 1)
                                                                                    ? (Lock_Day2.toString() == '1')
                                                                                        ? Colors.grey[100]!.withOpacity(0.5)
                                                                                        : Colors.red[100]!.withOpacity(0.2)
                                                                                    : (index == 2)
                                                                                        ? (Lock_Day3.toString() == '1')
                                                                                            ? Colors.grey[100]!.withOpacity(0.5)
                                                                                            : Colors.red[100]!.withOpacity(0.2)
                                                                                        : (index == 3)
                                                                                            ? (Lock_Day4.toString() == '1')
                                                                                                ? Colors.grey[100]!.withOpacity(0.5)
                                                                                                : Colors.red[100]!.withOpacity(0.2)
                                                                                            : (index == 4)
                                                                                                ? (Lock_Day5.toString() == '1')
                                                                                                    ? Colors.grey[100]!.withOpacity(0.5)
                                                                                                    : Colors.red[100]!.withOpacity(0.2)
                                                                                                : (index == 5)
                                                                                                    ? (Lock_Day6.toString() == '1')
                                                                                                        ? Colors.grey[100]!.withOpacity(0.5)
                                                                                                        : Colors.red[100]!.withOpacity(0.2)
                                                                                                    : (Lock_Day7.toString() == '1')
                                                                                                        ? Colors.grey[100]!.withOpacity(0.5)
                                                                                                        : Colors.red[100]!.withOpacity(0.2),

                                                                            borderRadius:
                                                                                const BorderRadius.only(
                                                                              topLeft: Radius.circular(10),
                                                                              topRight: Radius.circular(10),
                                                                              bottomLeft: Radius.circular(10),
                                                                              bottomRight: Radius.circular(10),
                                                                            ),
                                                                            // border: Border.all(
                                                                            //     color: Colors.grey, width: 1),
                                                                          ),
                                                                          padding:
                                                                              const EdgeInsets.all(0.0),
                                                                          child: (index == 0)
                                                                              ? (Lock_Day1.toString() == '1')
                                                                                  ? const Icon(
                                                                                      Icons.toggle_on,
                                                                                      color: Colors.green,
                                                                                      size: 50,
                                                                                    )
                                                                                  : const Icon(
                                                                                      Icons.toggle_off,
                                                                                      size: 50,
                                                                                    )
                                                                              : (index == 1)
                                                                                  ? (Lock_Day2.toString() == '1')
                                                                                      ? const Icon(
                                                                                          Icons.toggle_on,
                                                                                          color: Colors.green,
                                                                                          size: 50,
                                                                                        )
                                                                                      : const Icon(
                                                                                          Icons.toggle_off,
                                                                                          size: 50,
                                                                                        )
                                                                                  : (index == 2)
                                                                                      ? (Lock_Day3.toString() == '1')
                                                                                          ? const Icon(
                                                                                              Icons.toggle_on,
                                                                                              color: Colors.green,
                                                                                              size: 50,
                                                                                            )
                                                                                          : const Icon(
                                                                                              Icons.toggle_off,
                                                                                              size: 50,
                                                                                            )
                                                                                      : (index == 3)
                                                                                          ? (Lock_Day4.toString() == '1')
                                                                                              ? const Icon(
                                                                                                  Icons.toggle_on,
                                                                                                  color: Colors.green,
                                                                                                  size: 50,
                                                                                                )
                                                                                              : const Icon(
                                                                                                  Icons.toggle_off,
                                                                                                  size: 50,
                                                                                                )
                                                                                          : (index == 4)
                                                                                              ? (Lock_Day5.toString() == '1')
                                                                                                  ? const Icon(
                                                                                                      Icons.toggle_on,
                                                                                                      color: Colors.green,
                                                                                                      size: 50,
                                                                                                    )
                                                                                                  : const Icon(
                                                                                                      Icons.toggle_off,
                                                                                                      size: 50,
                                                                                                    )
                                                                                              : (index == 5)
                                                                                                  ? (Lock_Day6.toString() == '1')
                                                                                                      ? const Icon(
                                                                                                          Icons.toggle_on,
                                                                                                          color: Colors.green,
                                                                                                          size: 50,
                                                                                                        )
                                                                                                      : const Icon(
                                                                                                          Icons.toggle_off,
                                                                                                          size: 50,
                                                                                                        )
                                                                                                  : (Lock_Day7.toString() == '1')
                                                                                                      ? const Icon(
                                                                                                          Icons.toggle_on,
                                                                                                          color: Colors.green,
                                                                                                          size: 50,
                                                                                                        )
                                                                                                      : const Icon(
                                                                                                          Icons.toggle_off,
                                                                                                          size: 50,
                                                                                                        ),
                                                                        ),
                                                                        onTap:
                                                                            () async {
                                                                          var OpenDay1,
                                                                              OpenDay2,
                                                                              OpenDay3,
                                                                              OpenDay4,
                                                                              OpenDay5,
                                                                              OpenDay6,
                                                                              OpenDay7;
                                                                          setState(
                                                                              () {
                                                                            OpenDay1 = (index == 0)
                                                                                ? (Lock_Day1.toString() == '0')
                                                                                    ? '1'
                                                                                    : '0'
                                                                                : '$Lock_Day1';
                                                                            OpenDay2 = (index == 1)
                                                                                ? (Lock_Day2.toString() == '0')
                                                                                    ? '1'
                                                                                    : '0'
                                                                                : '$Lock_Day2';
                                                                            OpenDay3 = (index == 2)
                                                                                ? (Lock_Day2.toString() == '0')
                                                                                    ? '1'
                                                                                    : '0'
                                                                                : '$Lock_Day3';
                                                                            OpenDay4 = (index == 3)
                                                                                ? (Lock_Day4.toString() == '0')
                                                                                    ? '1'
                                                                                    : '0'
                                                                                : '$Lock_Day4';
                                                                            OpenDay5 = (index == 4)
                                                                                ? (Lock_Day5.toString() == '0')
                                                                                    ? '1'
                                                                                    : '0'
                                                                                : '$Lock_Day5';
                                                                            OpenDay6 = (index == 5)
                                                                                ? (Lock_Day6.toString() == '0')
                                                                                    ? '1'
                                                                                    : '0'
                                                                                : '$Lock_Day6';
                                                                            OpenDay7 = (index == 6)
                                                                                ? (Lock_Day7.toString() == '0')
                                                                                    ? '1'
                                                                                    : '0'
                                                                                : '$Lock_Day7';
                                                                          });

                                                                          ///-------------------------------->
                                                                          SharedPreferences
                                                                              preferences =
                                                                              await SharedPreferences.getInstance();
                                                                          String?
                                                                              ren =
                                                                              preferences.getString('renTalSer');
                                                                          String?
                                                                              ser_user =
                                                                              preferences.getString('ser');
                                                                          Dia_log();
                                                                          String
                                                                              url =
                                                                              '${MyConstant().domain}/UpC_rental_data_editweb.php?isAdd=true&ren=$ren&ser=$ser_user&D1=$OpenDay1&D2=$OpenDay2&D3=$OpenDay3&D4=$OpenDay4&D5=$OpenDay5&D6=$OpenDay6&D7=$OpenDay7&typevalue=14';

                                                                          try {
                                                                            var response =
                                                                                await http.get(Uri.parse(url));

                                                                            var result =
                                                                                await json.decode(response.body);

                                                                            if (result.toString() ==
                                                                                'true') {
                                                                              setState(() {
                                                                                signInThread();
                                                                                read_GC_rental();
                                                                                read_GC_area();
                                                                                read_GC_rentaldata();
                                                                                read_GC_rental_img();
                                                                                CG_Prebook();
                                                                              });
                                                                            } else {}
                                                                          } catch (e) {
                                                                            print(e);
                                                                          }
                                                                        },
                                                                      )),
                                                                );
                                                              }),
                                                        ],
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
                                )),
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(20, 8, 8, 8),
                                child: Translate.TranslateAndSetText(
                                    'วันหยุดพิเศษ/วันนักขัตฤกษ์',
                                    Colors.blueGrey,
                                    TextAlign.left,
                                    FontWeight.bold,
                                    FontWeight_.Fonts_T,
                                    16,
                                    1),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: AppbackgroundColor.TiTile_Colors
                                    .withOpacity(0.1),
                                // color: const Color.fromARGB(255, 226, 230, 233)!
                                //     .withOpacity(0.5),
                                // color: AppbackgroundColor
                                //     .TiTile_Colors,
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10)),
                                border:
                                    Border.all(color: Colors.grey, width: 0.5),
                              ),
                              padding: const EdgeInsets.all(2.0),
                              child: ScrollConfiguration(
                                behavior: ScrollConfiguration.of(context)
                                    .copyWith(dragDevices: {
                                  PointerDeviceKind.touch,
                                  PointerDeviceKind.mouse,
                                }),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      for (int index = 1; index < 6; index++)
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.grey[200],
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
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.all(2.0),
                                              child: Row(
                                                children: [
                                                  Translate.TranslateAndSetText(
                                                      'วันหยุดพิเศษ $index :',
                                                      ReportScreen_Color
                                                          .Colors_Text2_,
                                                      TextAlign.left,
                                                      FontWeight.bold,
                                                      FontWeight_.Fonts_T,
                                                      16,
                                                      1),
                                                  Stack(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: InkWell(
                                                          onTap: () {
                                                            final Future<
                                                                    DateTime?>
                                                                picked =
                                                                showDatePicker(
                                                              // locale: const Locale('th', 'TH'),
                                                              helpText:
                                                                  'เลือกวันที่',
                                                              confirmText:
                                                                  'ตกลง',
                                                              cancelText:
                                                                  'ยกเลิก',
                                                              context: context,
                                                              initialDate: DateTime(
                                                                  DateTime.now()
                                                                      .year,
                                                                  DateTime.now()
                                                                      .month,
                                                                  DateTime.now()
                                                                          .day -
                                                                      1),
                                                              initialDatePickerMode:
                                                                  DatePickerMode
                                                                      .day,
                                                              firstDate:
                                                                  DateTime(2023,
                                                                      1, 1),
                                                              lastDate: DateTime(
                                                                  DateTime.now()
                                                                          .year +
                                                                      1,
                                                                  DateTime.now()
                                                                      .month,
                                                                  DateTime.now()
                                                                      .day),
                                                              // selectableDayPredicate: _decideWhichDayToEnable,
                                                              builder: (context,
                                                                  child) {
                                                                return Theme(
                                                                  data: Theme.of(
                                                                          context)
                                                                      .copyWith(
                                                                    colorScheme:
                                                                        const ColorScheme
                                                                            .light(
                                                                      primary:
                                                                          AppBarColors
                                                                              .ABar_Colors, // header background color
                                                                      onPrimary:
                                                                          Colors
                                                                              .white, // header text color
                                                                      onSurface:
                                                                          Colors
                                                                              .black, // body text color
                                                                    ),
                                                                    textButtonTheme:
                                                                        TextButtonThemeData(
                                                                      style: TextButton
                                                                          .styleFrom(
                                                                        primary:
                                                                            Colors.black, // button text color
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  child: child!,
                                                                );
                                                              },
                                                            );
                                                            picked.then(
                                                                (result) async {
                                                              if (picked !=
                                                                  null) {
                                                                var formatter =
                                                                    DateFormat(
                                                                        'y-MM-d');
                                                                if (index ==
                                                                    1) {
                                                                  setState(() {
                                                                    LDay_Special1 =
                                                                        "${formatter.format(result!)}";
                                                                  });
                                                                } else if (index ==
                                                                    2) {
                                                                  setState(() {
                                                                    LDay_Special2 =
                                                                        "${formatter.format(result!)}";
                                                                  });
                                                                } else if (index ==
                                                                    3) {
                                                                  setState(() {
                                                                    LDay_Special3 =
                                                                        "${formatter.format(result!)}";
                                                                  });
                                                                } else if (index ==
                                                                    4) {
                                                                  setState(() {
                                                                    LDay_Special4 =
                                                                        "${formatter.format(result!)}";
                                                                  });
                                                                } else if (index ==
                                                                    5) {
                                                                  setState(() {
                                                                    LDay_Special5 =
                                                                        "${formatter.format(result!)}";
                                                                  });
                                                                }
                                                              }

                                                              ///-------------------------------->
                                                              SharedPreferences
                                                                  preferences =
                                                                  await SharedPreferences
                                                                      .getInstance();
                                                              String? ren =
                                                                  preferences
                                                                      .getString(
                                                                          'renTalSer');
                                                              String? ser_user =
                                                                  preferences
                                                                      .getString(
                                                                          'ser');
                                                              Dia_log();
                                                              String url =
                                                                  '${MyConstant().domain}/UpC_rental_data_editweb.php?isAdd=true&ren=$ren&ser=$ser_user&Ds1=$LDay_Special1&Ds2=$LDay_Special2&Ds3=$LDay_Special3&Ds4=$LDay_Special4&Ds5=$LDay_Special5&typevalue=15';

                                                              try {
                                                                var response =
                                                                    await http.get(
                                                                        Uri.parse(
                                                                            url));

                                                                var result =
                                                                    await json.decode(
                                                                        response
                                                                            .body);

                                                                if (result
                                                                        .toString() ==
                                                                    'true') {
                                                                  setState(() {
                                                                    signInThread();
                                                                    read_GC_rental();
                                                                    read_GC_area();
                                                                    read_GC_rentaldata();
                                                                    read_GC_rental_img();
                                                                    CG_Prebook();
                                                                  });
                                                                } else {}
                                                              } catch (e) {
                                                                print(e);
                                                              }
                                                            });
                                                          },
                                                          child: Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: AppbackgroundColor
                                                                    .Sub_Abg_Colors,
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
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .grey,
                                                                    width: 1),
                                                              ),
                                                              width: 120,
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Center(
                                                                child: Translate.TranslateAndSetText(
                                                                    (index == 1)
                                                                        ? (LDay_Special1.toString() == '0000-00-00')
                                                                            ? 'เลือก'
                                                                            : '${DateFormat('dd-MM').format(DateTime.parse('${LDay_Special1}'))}-${DateTime.parse('${LDay_Special1}').year + 543}'
                                                                        : (index == 2)
                                                                            ? (LDay_Special2.toString() == '0000-00-00')
                                                                                ? 'เลือก'
                                                                                : '${DateFormat('dd-MM').format(DateTime.parse('${LDay_Special2}'))}-${DateTime.parse('${LDay_Special2}').year + 543}'
                                                                            : (index == 3)
                                                                                ? (LDay_Special3.toString() == '0000-00-00')
                                                                                    ? 'เลือก'
                                                                                    : '${DateFormat('dd-MM').format(DateTime.parse('${LDay_Special3}'))}-${DateTime.parse('${LDay_Special3}').year + 543}'
                                                                                : (index == 4)
                                                                                    ? (LDay_Special4.toString() == '0000-00-00')
                                                                                        ? 'เลือก'
                                                                                        : '${DateFormat('dd-MM').format(DateTime.parse('${LDay_Special4}'))}-${DateTime.parse('${LDay_Special4}').year + 543}'
                                                                                    : (LDay_Special5.toString() == '0000-00-00')
                                                                                        ? 'เลือก'
                                                                                        : '${DateFormat('dd-MM').format(DateTime.parse('${LDay_Special5}'))}-${DateTime.parse('${LDay_Special5}').year + 543}',
                                                                    ReportScreen_Color.Colors_Text2_,
                                                                    TextAlign.left,
                                                                    FontWeight.bold,
                                                                    FontWeight_.Fonts_T,
                                                                    16,
                                                                    1),

                                                                //  Text(
                                                                //   (index == 1)
                                                                //       ? (LDay_Special1.toString() ==
                                                                //               '0000-00-00')
                                                                //           ? 'เลือก'
                                                                //           : '${DateFormat('dd-MM').format(DateTime.parse('${LDay_Special1}'))}-${DateTime.parse('${LDay_Special1}').year + 543}'
                                                                //       : (index ==
                                                                //               2)
                                                                //           ? (LDay_Special2.toString() == '0000-00-00')
                                                                //               ? 'เลือก'
                                                                //               : '${DateFormat('dd-MM').format(DateTime.parse('${LDay_Special2}'))}-${DateTime.parse('${LDay_Special2}').year + 543}'
                                                                //           : (index == 3)
                                                                //               ? (LDay_Special3.toString() == '0000-00-00')
                                                                //                   ? 'เลือก'
                                                                //                   : '${DateFormat('dd-MM').format(DateTime.parse('${LDay_Special3}'))}-${DateTime.parse('${LDay_Special3}').year + 543}'
                                                                //               : (index == 4)
                                                                //                   ? (LDay_Special4.toString() == '0000-00-00')
                                                                //                       ? 'เลือก'
                                                                //                       : '${DateFormat('dd-MM').format(DateTime.parse('${LDay_Special4}'))}-${DateTime.parse('${LDay_Special4}').year + 543}'
                                                                //                   : (LDay_Special5.toString() == '0000-00-00')
                                                                //                       ? 'เลือก'
                                                                //                       : '${DateFormat('dd-MM').format(DateTime.parse('${LDay_Special5}'))}-${DateTime.parse('${LDay_Special5}').year + 543}',
                                                                //   style:
                                                                //       const TextStyle(
                                                                //     color: ReportScreen_Color
                                                                //         .Colors_Text2_,
                                                                //     // fontWeight: FontWeight.bold,
                                                                //     fontFamily:
                                                                //         Font_
                                                                //             .Fonts_T,
                                                                //   ),
                                                                // ),
                                                              )),
                                                        ),
                                                      ),
                                                      Positioned(
                                                          top: 0,
                                                          right: 5,
                                                          child: InkWell(
                                                            onTap: () async {
                                                              if (index == 1) {
                                                                setState(() {
                                                                  LDay_Special1 =
                                                                      '0000-00-00';
                                                                });
                                                              } else if (index ==
                                                                  2) {
                                                                setState(() {
                                                                  LDay_Special2 =
                                                                      '0000-00-00';
                                                                });
                                                              } else if (index ==
                                                                  3) {
                                                                setState(() {
                                                                  LDay_Special3 =
                                                                      '0000-00-00';
                                                                });
                                                              } else if (index ==
                                                                  4) {
                                                                setState(() {
                                                                  LDay_Special4 =
                                                                      '0000-00-00';
                                                                });
                                                              } else if (index ==
                                                                  5) {
                                                                setState(() {
                                                                  LDay_Special5 =
                                                                      '0000-00-00';
                                                                });
                                                              }

                                                              ///-------------------------------->
                                                              SharedPreferences
                                                                  preferences =
                                                                  await SharedPreferences
                                                                      .getInstance();
                                                              String? ren =
                                                                  preferences
                                                                      .getString(
                                                                          'renTalSer');
                                                              String? ser_user =
                                                                  preferences
                                                                      .getString(
                                                                          'ser');
                                                              Dia_log();
                                                              String url =
                                                                  '${MyConstant().domain}/UpC_rental_data_editweb.php?isAdd=true&ren=$ren&ser=$ser_user&Ds1=$LDay_Special1&Ds2=$LDay_Special2&Ds3=$LDay_Special3&Ds4=$LDay_Special4&Ds5=$LDay_Special5&typevalue=15';

                                                              try {
                                                                var response =
                                                                    await http.get(
                                                                        Uri.parse(
                                                                            url));

                                                                var result =
                                                                    await json.decode(
                                                                        response
                                                                            .body);

                                                                if (result
                                                                        .toString() ==
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
                                                            child: Icon(
                                                              Icons.cancel,
                                                              size: 20,
                                                              color: Colors.red,
                                                            ),
                                                          ))
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(20, 8, 8, 8),
                                child: Translate.TranslateAndSetText(
                                    'ค่าบริการเพิ่มเติม ล็อคเสียบ',
                                    Colors.blueGrey,
                                    TextAlign.left,
                                    FontWeight.bold,
                                    FontWeight_.Fonts_T,
                                    16,
                                    1),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                            child: Container(
                              child: GridView.count(
                                  padding: ((MediaQuery.of(context).size.width) <
                                          650)
                                      ? const EdgeInsets.all(2)
                                      : const EdgeInsets.all(5),
                                  crossAxisSpacing:
                                      ((MediaQuery.of(context).size.width) < 650)
                                          ? 10.00
                                          : 16.0,
                                  mainAxisSpacing:
                                      ((MediaQuery.of(context).size.width) <
                                              650)
                                          ? 10.00
                                          : 16.0,
                                  crossAxisCount:
                                      (MediaQuery.of(context).size.width) < 650
                                          ? 2
                                          : 6,
                                  childAspectRatio: ((MediaQuery.of(context)
                                                  .size
                                                  .width) <
                                              650 &&
                                          (MediaQuery.of(context).size.width) >
                                              500)
                                      ? 1.6
                                      : ((MediaQuery.of(context).size.width) <
                                              500)
                                          ? 1.3
                                          : 1.9,
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  children: <Widget>[
                                    for (int index = 0;
                                        index < expModels.length;
                                        index++)
                                      Container(
                                        decoration: BoxDecoration(
                                          // boxShadow: [
                                          //   BoxShadow(
                                          //     color: Colors.grey.withOpacity(0.5),
                                          //     spreadRadius: 2,
                                          //     blurRadius: 7,
                                          //     offset: Offset(
                                          //         0, 3), // changes position of shadow
                                          //   ),
                                          // ],
                                          // color:
                                          //     const Color.fromARGB(255, 226, 230, 233)!
                                          //         .withOpacity(0.5),

                                          color: (expModels[index]
                                                      .show_book
                                                      .toString() ==
                                                  '1')
                                              ? Colors.grey[100]!
                                                  .withOpacity(0.5)
                                              : Colors.red[100]!
                                                  .withOpacity(0.2),
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10),
                                              bottomLeft: Radius.circular(10),
                                              bottomRight: Radius.circular(10)),
                                          border: Border.all(
                                              color: Colors.grey, width: 0.5),
                                        ),
                                        padding: const EdgeInsets.all(0.0),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.grey
                                                          .withOpacity(0.5),
                                                      borderRadius:
                                                          const BorderRadius
                                                              .only(
                                                        topLeft:
                                                            Radius.circular(10),
                                                        topRight:
                                                            Radius.circular(10),
                                                        bottomLeft:
                                                            Radius.circular(10),
                                                        bottomRight:
                                                            Radius.circular(10),
                                                      ),
                                                      border: Border.all(
                                                          color: Colors.grey,
                                                          width: 0.5),
                                                    ),
                                                    child: Align(
                                                      alignment:
                                                          Alignment.topRight,
                                                      child: Tooltip(
                                                        richMessage: TextSpan(
                                                          text: (expModels[
                                                                          index]
                                                                      .show_book
                                                                      .toString() ==
                                                                  '1')
                                                              ? 'คลิก : เพื่อ ปิด'
                                                              : 'คลิก : เพื่อ เปิด',
                                                          style:
                                                              const TextStyle(
                                                            color: SettingScreen_Color
                                                                .Colors_Text1_,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontFamily:
                                                                FontWeight_
                                                                    .Fonts_T,
                                                            //fontSize: 10.0
                                                          ),
                                                        ),
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          color: (expModels[
                                                                          index]
                                                                      .show_book
                                                                      .toString() ==
                                                                  '1')
                                                              ? Colors.red[200]
                                                              : Colors.lightGreen[
                                                                  200],
                                                        ),
                                                        child: InkWell(
                                                          onTap: () async {
                                                            SharedPreferences
                                                                preferences =
                                                                await SharedPreferences
                                                                    .getInstance();
                                                            String? ren =
                                                                preferences
                                                                    .getString(
                                                                        'renTalSer');
                                                            String? ser_user =
                                                                preferences
                                                                    .getString(
                                                                        'ser');
                                                            var vser =
                                                                expModels[index]
                                                                    .ser;
                                                            var values = (expModels[
                                                                            index]
                                                                        .show_book
                                                                        .toString() ==
                                                                    '1')
                                                                ? '0'
                                                                : '1';
                                                            Dia_log();
                                                            String url =
                                                                '${MyConstant().domain}/UpC_exp_editwebmar.php?isAdd=true&ren=$ren&vser=$vser&showbook=$values&pribook=${expModels[index].pri_book}';

                                                            try {
                                                              var response =
                                                                  await http.get(
                                                                      Uri.parse(
                                                                          url));

                                                              var result =
                                                                  json.decode(
                                                                      response
                                                                          .body);
                                                              print(result);
                                                              if (result
                                                                      .toString() ==
                                                                  'true') {
                                                                // Insert_log.Insert_logs(
                                                                //     'ตั้งค่า',
                                                                //     'ตั้งค่าพิเศษ>>ปรับ >> ${zoneModels[index].zn.toString()} >> Acc3 >> $value');
                                                                setState(() {
                                                                  read_GC_Exp();
                                                                });
                                                              } else {}
                                                            } catch (e) {}
                                                          },
                                                          child: Container(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(0.0),
                                                              child: (expModels[
                                                                              index]
                                                                          .show_book
                                                                          .toString() ==
                                                                      '1')
                                                                  ? const Icon(
                                                                      Icons
                                                                          .toggle_on,
                                                                      color: Colors
                                                                          .green,
                                                                      size: 40,
                                                                    )
                                                                  : const Icon(
                                                                      Icons
                                                                          .toggle_off,
                                                                      size: 40,
                                                                    )),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Align(
                                              alignment: Alignment.topCenter,
                                              child: Container(
                                                child: Text(
                                                  '${expModels[index].expname}',
                                                  textAlign: TextAlign.center,
                                                  maxLines: 2,
                                                  style: const TextStyle(
                                                      color: SettingScreen_Color
                                                          .Colors_Text1_,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily:
                                                          FontWeight_.Fonts_T,
                                                      fontSize: 13.0),
                                                ),
                                              ),
                                            ),
                                            if (expModels[index]
                                                    .show_book
                                                    .toString() ==
                                                '1')
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Container(
                                                        height: 30,
                                                        color: Colors.grey[100],
                                                        child: TextFormField(
                                                          initialValue:
                                                              expModels[index]
                                                                  .pri_book,
                                                          readOnly: (expModels[
                                                                          index]
                                                                      .show_book
                                                                      .toString() ==
                                                                  '1')
                                                              ? false
                                                              : true,
                                                          onFieldSubmitted:
                                                              (value) async {
                                                            SharedPreferences
                                                                preferences =
                                                                await SharedPreferences
                                                                    .getInstance();
                                                            String? ren =
                                                                preferences
                                                                    .getString(
                                                                        'renTalSer');
                                                            String? ser_user =
                                                                preferences
                                                                    .getString(
                                                                        'ser');
                                                            var vser =
                                                                expModels[index]
                                                                    .ser;
                                                            String url =
                                                                '${MyConstant().domain}/UpC_exp_editwebmar.php?isAdd=true&ren=$ren&vser=$vser&showbook=${expModels[index].show_book}&pribook=$value';

                                                            try {
                                                              var response =
                                                                  await http.get(
                                                                      Uri.parse(
                                                                          url));

                                                              var result =
                                                                  json.decode(
                                                                      response
                                                                          .body);
                                                              print(result);
                                                              if (result
                                                                      .toString() ==
                                                                  'true') {
                                                                setState(() {
                                                                  read_GC_Exp();
                                                                });
                                                              } else {}
                                                            } catch (e) {}
                                                          },
                                                          // maxLength: 13,
                                                          cursorColor:
                                                              Colors.green,
                                                          decoration:
                                                              InputDecoration(
                                                            fillColor: Colors
                                                                .white
                                                                .withOpacity(
                                                                    0.05),
                                                            filled: true,
                                                            // prefixIcon:
                                                            //     const Icon(Icons.key, color: Colors.black),
                                                            // suffixIcon: Icon(Icons.clear, color: Colors.black),
                                                            focusedBorder:
                                                                const OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .only(
                                                                topRight: Radius
                                                                    .circular(
                                                                        6),
                                                                topLeft: Radius
                                                                    .circular(
                                                                        6),
                                                                bottomRight:
                                                                    Radius
                                                                        .circular(
                                                                            6),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        6),
                                                              ),
                                                              borderSide:
                                                                  BorderSide(
                                                                width: 1,
                                                                color:
                                                                    Colors.grey,
                                                              ),
                                                            ),
                                                            enabledBorder:
                                                                const OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .only(
                                                                topRight: Radius
                                                                    .circular(
                                                                        6),
                                                                topLeft: Radius
                                                                    .circular(
                                                                        6),
                                                                bottomRight:
                                                                    Radius
                                                                        .circular(
                                                                            6),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        6),
                                                              ),
                                                              borderSide:
                                                                  BorderSide(
                                                                width: 1,
                                                                color:
                                                                    Colors.grey,
                                                              ),
                                                            ),
                                                            // labelText: 'PASSWOED',
                                                            labelStyle:
                                                                const TextStyle(
                                                                    color: PeopleChaoScreen_Color
                                                                        .Colors_Text2_,
                                                                    // fontWeight: FontWeight.bold,
                                                                    fontFamily:
                                                                        Font_
                                                                            .Fonts_T),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            4.0),
                                                    child: Text(
                                                      '฿',
                                                      style: TextStyle(
                                                        color:
                                                            SettingScreen_Color
                                                                .Colors_Text1_,
                                                        fontFamily:
                                                            Font_.Fonts_T,
                                                        // fontWeight:
                                                        //     FontWeight.bold,
                                                        //fontSize: 10.0
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                          ],
                                        ),
                                      ),
                                  ]),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),

                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 8, 8, 8),
                        child: Translate.TranslateAndSetText(
                            'ข้อมูลพื้นที่',
                            SettingScreen_Color.Colors_Text1_,
                            TextAlign.left,
                            FontWeight.bold,
                            FontWeight_.Fonts_T,
                            16,
                            1),
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
                      child: Container(
                        width: (MediaQuery.of(context).size.width < 650)
                            ? 850
                            : MediaQuery.of(context).size.width * 0.85,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 8, 8, 0),
                              child: Container(
                                  // width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    // color: Color.fromARGB(255, 193, 210, 224),
                                    color: AppbackgroundColor.TiTile_Colors,
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(0),
                                        bottomRight: Radius.circular(0)),
                                    border: Border.all(
                                        color: Colors.grey, width: 0.5),
                                  ),
                                  padding: const EdgeInsets.all(4.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      for (int index = 0;
                                          index < Show_Titel_webmarket.length;
                                          index++)
                                        Expanded(
                                          flex: 1,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Translate.TranslateAndSetText(
                                                '${Show_Titel_webmarket[index]}',
                                                SettingScreen_Color
                                                    .Colors_Text1_,
                                                TextAlign.left,
                                                FontWeight.bold,
                                                FontWeight_.Fonts_T,
                                                16,
                                                1),

                                            //  Text(
                                            //   '${Show_Titel_webmarket[index]}',
                                            //   textAlign: TextAlign.center,
                                            //   style: const TextStyle(
                                            //       color: SettingScreen_Color
                                            //           .Colors_Text1_,
                                            //       fontWeight: FontWeight.bold,
                                            //       fontFamily:
                                            //           FontWeight_.Fonts_T
                                            //       //fontSize: 10.0
                                            //       ),
                                            // ),
                                          ),
                                        ),
                                    ],
                                  )),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                              child: Container(
                                  // width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    // color: Colors.grey[100]!.withOpacity(0.5),
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(0),
                                        topRight: Radius.circular(0),
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10)),
                                    border: Border.all(
                                        color: Colors.grey, width: 0.5),
                                  ),
                                  padding: const EdgeInsets.all(4.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      for (int index = 0;
                                          index < Show_Titel_webmarket.length;
                                          index++)
                                        Expanded(
                                          flex: 1,
                                          child: StreamBuilder(
                                              stream: Stream.periodic(
                                                  const Duration(seconds: 0)),
                                              builder: (context, snapshot) {
                                                return Tooltip(
                                                  richMessage: TextSpan(
                                                    text: (title_webs_list
                                                            .toString()
                                                            .contains(index
                                                                .toString()))
                                                        ? 'คลิก : เพื่อ ปิด'
                                                        : 'คลิก : เพื่อ เปิด',
                                                    style: const TextStyle(
                                                      color: SettingScreen_Color
                                                          .Colors_Text1_,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily:
                                                          FontWeight_.Fonts_T,
                                                      //fontSize: 10.0
                                                    ),
                                                  ),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    color: (title_webs_list
                                                            .toString()
                                                            .contains(index
                                                                .toString()))
                                                        ? Colors.red[200]
                                                        : Colors
                                                            .lightGreen[200],
                                                  ),
                                                  child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              2.0),
                                                      child: InkWell(
                                                        child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              color: (title_webs_list
                                                                      .toString()
                                                                      .contains(
                                                                          index
                                                                              .toString()))
                                                                  ? Colors.grey[
                                                                          100]!
                                                                      .withOpacity(
                                                                          0.5)
                                                                  : Colors
                                                                      .red[100]!
                                                                      .withOpacity(
                                                                          0.2),
                                                              borderRadius:
                                                                  const BorderRadius
                                                                      .only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        10),
                                                                topRight: Radius
                                                                    .circular(
                                                                        10),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        10),
                                                                bottomRight:
                                                                    Radius
                                                                        .circular(
                                                                            10),
                                                              ),
                                                              // border: Border.all(
                                                              //     color: Colors.grey, width: 1),
                                                            ),
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(0.0),
                                                            child: (title_webs_list
                                                                    .toString()
                                                                    .contains(index
                                                                        .toString()))
                                                                ? const Icon(
                                                                    Icons
                                                                        .toggle_on,
                                                                    color: Colors
                                                                        .green,
                                                                    size: 50,
                                                                  )
                                                                : const Icon(
                                                                    Icons
                                                                        .toggle_off,
                                                                    size: 50,
                                                                  )),
                                                        onTap: () async {
                                                          ///-------------------------------->
                                                          String
                                                              Titel_webmarket_new =
                                                              '';
                                                          String new_value =
                                                              rental_Nearbyplaces_text
                                                                  .text
                                                                  .toString();
                                                          if (!title_webs_list
                                                              .toString()
                                                              .contains(index
                                                                  .toString())) {
                                                            title_webs_list.add(
                                                                index
                                                                    .toString());
                                                          } else {
                                                            title_webs_list
                                                                .remove(index
                                                                    .toString());
                                                          }
                                                          title_webs_list
                                                              .sort((a, b) {
                                                            if (a is Comparable &&
                                                                b is Comparable) {
                                                              return a
                                                                  .compareTo(b);
                                                            } else {
                                                              // Handle non-comparable elements if needed
                                                              return 0;
                                                            }
                                                          });

                                                          await Future.delayed(
                                                              const Duration(
                                                                  milliseconds:
                                                                      200));

                                                          for (int index = 0;
                                                              index <
                                                                  title_webs_list
                                                                      .length;
                                                              index++) {
                                                            Titel_webmarket_new +=
                                                                '${title_webs_list[index]},';
                                                          }

                                                          Titel_webmarket_new +=
                                                              new_value;
                                                          print(
                                                              Titel_webmarket_new);

                                                          ///-------------------------------->
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
                                                          Dia_log();
                                                          String url =
                                                              '${MyConstant().domain}/UpC_rental_data_Fac_AND_places.php?isAdd=true&ren=$ren&ser=$ser_user&value=${Titel_webmarket_new}&typevalue=3';

                                                          try {
                                                            var response =
                                                                await http.get(
                                                                    Uri.parse(
                                                                        url));

                                                            var result =
                                                                await json.decode(
                                                                    response
                                                                        .body);

                                                            if (result
                                                                    .toString() ==
                                                                'true') {
                                                              setState(() {
                                                                // read_GC_area();
                                                                // signInThread();
                                                                // read_GC_rental();
                                                                // read_GC_area();
                                                                read_GC_rentaldata();
                                                                // read_GC_rental_img();
                                                              });
                                                            } else {}
                                                          } catch (e) {
                                                            print(e);
                                                          }
                                                        },
                                                      )),
                                                );
                                              }),
                                        ),
                                    ],
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        // color: Colors.grey[100]!.withOpacity(0.5),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                        border: Border.all(color: Colors.grey, width: 0.5),
                      ),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: AppbackgroundColor.TiTile_Colors,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(0),
                                bottomRight: Radius.circular(0),
                              ),
                              border:
                                  Border.all(color: Colors.grey, width: 0.5),
                            ),
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(20, 8, 8, 8),
                                  child: Translate.TranslateAndSetText(
                                      'โซนพื้นที่',
                                      SettingScreen_Color.Colors_Text1_,
                                      TextAlign.left,
                                      FontWeight.bold,
                                      FontWeight_.Fonts_T,
                                      16,
                                      1),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                            child: Container(
                              child: GridView.count(
                                  padding: ((MediaQuery.of(context).size.width) <
                                          650)
                                      ? const EdgeInsets.all(2)
                                      : const EdgeInsets.all(5),
                                  crossAxisSpacing:
                                      ((MediaQuery.of(context).size.width) < 650)
                                          ? 10.00
                                          : 16.0,
                                  mainAxisSpacing:
                                      ((MediaQuery.of(context).size.width) <
                                              650)
                                          ? 10.00
                                          : 16.0,
                                  crossAxisCount:
                                      (MediaQuery.of(context).size.width) < 650
                                          ? 2
                                          : 6,
                                  childAspectRatio: ((MediaQuery.of(context)
                                                  .size
                                                  .width) <
                                              650 &&
                                          (MediaQuery.of(context).size.width) >
                                              500)
                                      ? 2.2
                                      : ((MediaQuery.of(context).size.width) <
                                              500)
                                          ? 1.5
                                          : 2.5,
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  children: <Widget>[
                                    for (int index = 0;
                                        index < zoneModels.length;
                                        index++)
                                      Container(
                                        decoration: BoxDecoration(
                                          // boxShadow: [
                                          //   BoxShadow(
                                          //     color: Colors.grey.withOpacity(0.5),
                                          //     spreadRadius: 2,
                                          //     blurRadius: 7,
                                          //     offset: Offset(
                                          //         0, 3), // changes position of shadow
                                          //   ),
                                          // ],
                                          // color:
                                          //     const Color.fromARGB(255, 226, 230, 233)!
                                          //         .withOpacity(0.5),

                                          color: (zoneModels[index]
                                                      .status
                                                      .toString() ==
                                                  '0')
                                              ? Colors.grey[100]!
                                                  .withOpacity(0.5)
                                              : Colors.red[100]!
                                                  .withOpacity(0.2),
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10),
                                              bottomLeft: Radius.circular(10),
                                              bottomRight: Radius.circular(10)),
                                          border: Border.all(
                                              color: Colors.grey, width: 0.5),
                                        ),
                                        padding: const EdgeInsets.all(0.0),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.grey
                                                          .withOpacity(0.5),
                                                      borderRadius:
                                                          const BorderRadius
                                                              .only(
                                                        topLeft:
                                                            Radius.circular(10),
                                                        topRight:
                                                            Radius.circular(10),
                                                        bottomLeft:
                                                            Radius.circular(10),
                                                        bottomRight:
                                                            Radius.circular(10),
                                                      ),
                                                      border: Border.all(
                                                          color: Colors.grey,
                                                          width: 0.5),
                                                    ),
                                                    child: Align(
                                                      alignment:
                                                          Alignment.topRight,
                                                      child: Tooltip(
                                                        richMessage: TextSpan(
                                                          text: (title_webs_list
                                                                  .toString()
                                                                  .contains(index
                                                                      .toString()))
                                                              ? 'คลิก : เพื่อ ปิด'
                                                              : 'คลิก : เพื่อ เปิด',
                                                          style:
                                                              const TextStyle(
                                                            color: SettingScreen_Color
                                                                .Colors_Text1_,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontFamily:
                                                                FontWeight_
                                                                    .Fonts_T,
                                                            //fontSize: 10.0
                                                          ),
                                                        ),
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          color: (title_webs_list
                                                                  .toString()
                                                                  .contains(index
                                                                      .toString()))
                                                              ? Colors.red[200]
                                                              : Colors.lightGreen[
                                                                  200],
                                                        ),
                                                        child: InkWell(
                                                          onTap: () async {
                                                            SharedPreferences
                                                                preferences =
                                                                await SharedPreferences
                                                                    .getInstance();
                                                            String? ren =
                                                                preferences
                                                                    .getString(
                                                                        'renTalSer');
                                                            String? ser_user =
                                                                preferences
                                                                    .getString(
                                                                        'ser');
                                                            var values = (zoneModels[
                                                                            index]
                                                                        .status
                                                                        .toString() ==
                                                                    '0')
                                                                ? '1'
                                                                : '0';
                                                            Dia_log();
                                                            String url =
                                                                '${MyConstant().domain}/UP_c_zone_onoff.php?isAdd=true&ren=$ren&zser=${zoneModels[index].ser}&va_lue=$values';

                                                            try {
                                                              var response =
                                                                  await http.get(
                                                                      Uri.parse(
                                                                          url));

                                                              var result =
                                                                  json.decode(
                                                                      response
                                                                          .body);
                                                              print(result);
                                                              if (result
                                                                      .toString() ==
                                                                  'true') {
                                                                // Insert_log.Insert_logs(
                                                                //     'ตั้งค่า',
                                                                //     'ตั้งค่าพิเศษ>>ปรับ >> ${zoneModels[index].zn.toString()} >> Acc3 >> $value');
                                                                setState(() {
                                                                  read_GC_zone();
                                                                });
                                                              } else {}
                                                            } catch (e) {}
                                                          },
                                                          child: Container(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(0.0),
                                                              child: (zoneModels[
                                                                              index]
                                                                          .status
                                                                          .toString() ==
                                                                      '0')
                                                                  ? const Icon(
                                                                      Icons
                                                                          .toggle_on,
                                                                      color: Colors
                                                                          .green,
                                                                      size: 40,
                                                                    )
                                                                  : const Icon(
                                                                      Icons
                                                                          .toggle_off,
                                                                      size: 40,
                                                                    )),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Align(
                                              alignment: Alignment.topCenter,
                                              child: Container(
                                                child: Text(
                                                  '${zoneModels[index].zn}',
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                      color: SettingScreen_Color
                                                          .Colors_Text1_,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily:
                                                          FontWeight_.Fonts_T
                                                      //fontSize: 10.0
                                                      ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                  ]),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppbackgroundColor.TiTile_Colors,
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(0),
                                  bottomRight: Radius.circular(0)),
                              border:
                                  Border.all(color: Colors.grey, width: 0.5),
                            ),
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Translate.TranslateAndSetText(
                                      'ตั้งค่ารูปอื่นๆ',
                                      SettingScreen_Color.Colors_Text1_,
                                      TextAlign.left,
                                      FontWeight.bold,
                                      FontWeight_.Fonts_T,
                                      16,
                                      1),
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
                                      child: Center(
                                        child: Translate.TranslateAndSetText(
                                            '+เพิ่ม',
                                            SettingScreen_Color.Colors_Text3_,
                                            TextAlign.left,
                                            FontWeight.bold,
                                            FontWeight_.Fonts_T,
                                            16,
                                            1),
                                      ),
                                    ),
                                    onTap: () {
                                      uploadFile_Imgman('abountimg');
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
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
                          : MediaQuery.of(context).size.width * 0.85,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        // color: Colors.grey[100]!.withOpacity(0.5),
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(0),
                            topRight: Radius.circular(0),
                            bottomLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8)),
                        border: Border.all(color: Colors.grey, width: 0.5),
                      ),
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
                                              ? const Icon(
                                                  Icons.image_not_supported)
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
                    height: 20,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 8, 8, 8),
                        child: Translate.TranslateAndSetText(
                            'คำอธิบายเกี่ยวกับพื้นที่',
                            SettingScreen_Color.Colors_Text1_,
                            TextAlign.left,
                            FontWeight.bold,
                            FontWeight_.Fonts_T,
                            16,
                            1),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppbackgroundColor.TiTile_Colors,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(0),
                          bottomRight: Radius.circular(0),
                        ),
                        border: Border.all(
                            color: const Color.fromARGB(255, 194, 191, 191),
                            width: 1),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(20, 8, 8, 8),
                              child: Translate.TranslateAndSetText(
                                  'คำอธิบาย',
                                  SettingScreen_Color.Colors_Text1_,
                                  TextAlign.left,
                                  FontWeight.bold,
                                  FontWeight_.Fonts_T,
                                  16,
                                  1),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: InkWell(
                              child: Container(
                                padding: const EdgeInsets.all(2.0),
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
                                child: Center(
                                  child: Translate.TranslateAndSetText(
                                      'คำอธิบาย',
                                      SettingScreen_Color.Colors_Text3_,
                                      TextAlign.left,
                                      FontWeight.bold,
                                      FontWeight_.Fonts_T,
                                      16,
                                      1),
                                ),
                              ),
                              onTap: () async {
                                ///-------------------------------->

                                String new_value = '${rental_Abount_text.text}';
                                String new_valueAll =
                                    '${rental_AbountAll_text.text}';

                                ///-------------------------------->
                                SharedPreferences preferences =
                                    await SharedPreferences.getInstance();
                                String? ren =
                                    preferences.getString('renTalSer');
                                String? ser_user = preferences.getString('ser');
                                Dia_log();
                                String url =
                                    '${MyConstant().domain}/UpC_rental_data_editweb.php?isAdd=true&ren=$ren&ser=$ser_user&value=${new_value}&about_all=$new_valueAll&typevalue=1';

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
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                    child: Container(
                      height: 150,
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
                        maxLength: 220,
                        cursorColor: Colors.green,
                        decoration: InputDecoration(
                            fillColor: Colors.grey[50],
                            filled: true,
                            // prefixIcon:
                            //     const Icon(Icons.person, color: Colors.black),
                            // suffixIcon: Icon(Icons.clear, color: Colors.black),
                            focusedBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(0),
                                topLeft: Radius.circular(0),
                                bottomRight: Radius.circular(0),
                                bottomLeft: Radius.circular(0),
                              ),
                              borderSide: BorderSide(
                                width: 0.5,
                                color: Colors.white,
                              ),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(0),
                                topLeft: Radius.circular(0),
                                bottomRight: Radius.circular(0),
                                bottomLeft: Radius.circular(0),
                              ),
                              borderSide: BorderSide(
                                width: 0.5,
                                color: Colors.white,
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
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                    child: Container(
                        // width: MediaQuery.of(context)
                        //     .size
                        //     .width,
                        decoration: const BoxDecoration(
                          color: AppbackgroundColor.Sub_Abg_Colors,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(0),
                              topRight: Radius.circular(0),
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
                        ),
                        child: Column(
                          children: [
                            const Align(
                              alignment: Alignment.bottomRight,
                              child: Text(
                                '',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 12.0,
                                    fontFamily: FontWeight_.Fonts_T),
                              ),
                            ),
                          ],
                        )),
                  ),

                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 8, 8, 8),
                        child: Translate.TranslateAndSetText(
                            'คำอธิบายเพิ่มเติมเกี่ยวกับพื้นที่',
                            SettingScreen_Color.Colors_Text1_,
                            TextAlign.left,
                            FontWeight.bold,
                            FontWeight_.Fonts_T,
                            16,
                            1),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                    child: Container(
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
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(20, 8, 8, 8),
                              child: Translate.TranslateAndSetText(
                                  'คำอธิบายเพิ่มเติม',
                                  SettingScreen_Color.Colors_Text1_,
                                  TextAlign.left,
                                  FontWeight.bold,
                                  FontWeight_.Fonts_T,
                                  16,
                                  1),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: InkWell(
                              child: Container(
                                padding: const EdgeInsets.all(2.0),
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
                                child: Center(
                                  child: Translate.TranslateAndSetText(
                                      'บันทึก',
                                      SettingScreen_Color.Colors_Text3_,
                                      TextAlign.left,
                                      FontWeight.bold,
                                      FontWeight_.Fonts_T,
                                      16,
                                      1),
                                ),
                              ),
                              onTap: () async {
                                ///-------------------------------->

                                String new_value = '${rental_Abount_text.text}';
                                String new_valueAll =
                                    '${rental_AbountAll_text.text}';

                                ///-------------------------------->
                                SharedPreferences preferences =
                                    await SharedPreferences.getInstance();
                                String? ren =
                                    preferences.getString('renTalSer');
                                String? ser_user = preferences.getString('ser');
                                Dia_log();
                                String url =
                                    '${MyConstant().domain}/UpC_rental_data_editweb.php?isAdd=true&ren=$ren&ser=$ser_user&value=${new_value}&about_all=$new_valueAll&typevalue=1';

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
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                    child: Container(
                      height: 150,
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
                        controller: rental_AbountAll_text,
                        onFieldSubmitted: (value) async {},
                        maxLines: 100,
                        maxLength: 220,
                        cursorColor: Colors.green,
                        decoration: InputDecoration(
                            fillColor: Colors.grey[50],
                            filled: true,
                            // prefixIcon:
                            //     const Icon(Icons.person, color: Colors.black),
                            // suffixIcon: Icon(Icons.clear, color: Colors.black),
                            focusedBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(0),
                                topLeft: Radius.circular(0),
                                bottomRight: Radius.circular(0),
                                bottomLeft: Radius.circular(0),
                              ),
                              borderSide: BorderSide(
                                width: 0.5,
                                color: Colors.white,
                              ),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(0),
                                topLeft: Radius.circular(0),
                                bottomRight: Radius.circular(0),
                                bottomLeft: Radius.circular(0),
                              ),
                              borderSide: BorderSide(
                                width: 0.5,
                                color: Colors.white,
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
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                    child: Container(
                        // width: MediaQuery.of(context)
                        //     .size
                        //     .width,
                        decoration: const BoxDecoration(
                          color: AppbackgroundColor.Sub_Abg_Colors,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(0),
                              topRight: Radius.circular(0),
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
                        ),
                        child: Column(
                          children: [
                            const Align(
                              alignment: Alignment.bottomRight,
                              child: Text(
                                '',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 12.0,
                                    fontFamily: FontWeight_.Fonts_T),
                              ),
                            ),
                          ],
                        )),
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
