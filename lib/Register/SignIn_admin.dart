// ignore_for_file: unused_import, unused_local_variable, unnecessary_null_comparison, unused_field, override_on_non_overriding_member, prefer_const_constructors, unnecessary_import, implementation_imports, prefer_const_constructors_in_immutables, non_constant_identifier_names, avoid_init_to_null, prefer_void_to_null, unnecessary_brace_in_string_interps, avoid_print, empty_catches, sized_box_for_whitespace, use_build_context_synchronously, file_names, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_string_interpolations, prefer_collection_literals, sort_child_properties_last, avoid_unnecessary_containers, prefer_is_empty, prefer_final_fields, camel_case_types, avoid_web_libraries_in_flutter, prefer_typing_uninitialized_variables, no_leading_underscores_for_local_identifiers, deprecated_member_use
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/gestures.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../AdminScaffold/AdminScaffold.dart';
import '../Constant/Myconstant.dart';
import '../INSERT_Log/Insert_log.dart';
import '../Model/GC_package_model.dart';
import '../Model/GetC_Otp.dart';
import '../Model/GetC_color.dart';
import '../Model/GetLicensekey_Modely.dart';
import '../Model/GetLicensekey_Modely_up.dart';
import '../Model/GetRenTal_Model.dart';
import '../Model/GetUser_Model.dart';
import '../Responsive/responsive.dart';
import '../Style/colors.dart';
import '../Model/GetUser_Model.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class SignUnAdmin extends StatefulWidget {
  const SignUnAdmin({super.key});

  @override
  State<SignUnAdmin> createState() => _SignUnAdminState();
}

class _SignUnAdminState extends State<SignUnAdmin> {
  List<RenTalModel> renTalModels = [];
  List<PackageModel> packageModels = [];
  List<LicensekeyModel> licensekeyModels = [];
  List<LicensekeyUPModel> licensekeyUPModels = [];
  List<OtpModel> otpModels = [];
  List<UserModel> userModels = [];
  DateTime datenow = DateTime.now();
  String? packSelext,
      day_date = 'D',
      _Licens,
      _pk_sdate,
      _pk_ldate,
      r_email,
      ser_id,
      tem_id,
      user_id;
  String? img1, img2, img3, img4, img5;
  int? packint, num_date = 0;
  final Form1_text = TextEditingController();
  final Form2_text = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    read_GC_rental();
    read_GC_package();
    read_GC_packageGen();
    read_GC_otp();
    read_GC_color();
  }

  ////////------------------------------------>
  Future<Null> read_GC_color() async {
    String url = '${MyConstant().domain}/GC_color.php?isAdd=true';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);

      for (var map in result) {
        Color_Model colorModels = Color_Model.fromJson(map);
        setState(() {
          img1 = colorModels.img.toString();
          img2 = colorModels.img2.toString();
          img3 = colorModels.img3.toString();
          img4 = colorModels.img4.toString();
          img5 = colorModels.img5.toString();
        });
      }
    } catch (e) {}
  }

///////------------------------->
  Color pickerColor = const Color.fromARGB(255, 227, 228, 230);
  Color currentColor = Color.fromARGB(255, 178, 196, 241);
  // var pickerColor, currentColor;
// ValueChanged<Color> callback
  void changeColors(Color color) {
    setState(() => pickerColor = color);
  }

///////------------------------->
  Future<Null> userModelsAddmin() async {
    if (userModels.isNotEmpty) {
      userModels.clear();
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    String url = '${MyConstant().domain}/Connected_UserAll.php?isAdd=true';
    int indexfor = 0;
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);
      if (result != null) {
        for (var map in result) {
          UserModel userModel = UserModel.fromJson(map);
          setState(() {
            userModels.add(userModel);
          });
        }
      } else {}
    } catch (e) {}
    // print('name>>>>>  $renname');
  }

  Future<Null> read_GC_otp() async {
    if (otpModels.isNotEmpty) {
      setState(() {
        otpModels.clear();
      });
    }

    String url = '${MyConstant().domain}/GC_otp.php?isAdd=true';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print('read_GC_rental///// $result');
      for (var map in result) {
        OtpModel otpModel = OtpModel.fromJson(map);
        var ser_idx = otpModel.ser_id;
        var tem_idx = otpModel.tem_id;
        var user_idx = otpModel.user_id;
        var use_idx = otpModel.use_id;
        setState(() {
          if (use_idx == '2') {
            ser_id = ser_idx;
            tem_id = tem_idx;
            user_id = user_idx;
          }

          otpModels.add(otpModel);
        });
      }
    } catch (e) {}
  }
  // String _chars =
  //     'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';

  String _chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890';
  Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  Future<Null> read_GC_rental() async {
    setState(() {
      renTalModels.clear();
    });
    String url = '${MyConstant().domain}/GC_rental_admin.php?isAdd=true';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print('read_GC_rental///// $result');
      for (var map in result) {
        RenTalModel renTalModel = RenTalModel.fromJson(map);

        setState(() {
          renTalModels.add(renTalModel);
        });
      }
      if (renTalModels.isNotEmpty) {
        dynamic colorsren = renTalModels[0].colors_ren;
        if (colorsren is String) {
          setState(() => pickerColor = Color(int.parse(colorsren)));
          // print('Color(int.parse(colorsren))');
          // print(Color(int.parse(colorsren)));
          // print(pickerColor);
        } else {
          // Handle the case where colorsren is not a String
        }
      }
    } catch (e) {}
  }

  Future<Null> read_GC_packageGen() async {
    if (licensekeyModels.isNotEmpty) {
      setState(() {
        licensekeyModels.clear();
      });
    }
    String url = '${MyConstant().domain}/GC_package_Gen.php?isAdd=true';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print('read_GC_rental///// $result');
      for (var map in result) {
        LicensekeyModel licensekeyModel = LicensekeyModel.fromJson(map);

        setState(() {
          licensekeyModels.add(licensekeyModel);
        });
      }
    } catch (e) {}
  }

  Future<Null> read_GC_package() async {
    if (packageModels.isNotEmpty) {
      setState(() {
        packageModels.clear();
      });
    }

    String url = '${MyConstant().domain}/GC_package.php?isAdd=true';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);
      if (result != null) {
        for (var map in result) {
          PackageModel packageModel = PackageModel.fromJson(map);

          setState(() {
            packageModels.add(packageModel);
          });
        }
      } else {}
    } catch (e) {}
  }

  String? base64_Slip, fileName_Slip;
/////----------------------------------->
  Future<void> uploadFile_Slip(index) async {
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
      final base64Image = await base64Encode(imageBytes);
      setState(() {
        base64_Slip = base64Image;
      });
      OKuploadFile_Slip(index);
    }
  }

/////----------------------------------->
  Future<void> OKuploadFile_Slip(index) async {
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
        fileName_Slip = 'Login${index}_${date}_$Time_.png';
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

          UpImg(index);
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

  Future<void> UpImg(index) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var ren = preferences.getString('renTalSer');
    String url =
        '${MyConstant().domain}/UP_imgLogin.php?isAdd=true&ren=$ren&type=$index&imgname=files/ProMoImg/$fileName_Slip';
    var response = await http.get(Uri.parse(url));

    var result = json.decode(response.body);
    print(result.toString());
    try {
      if (result.toString() == 'true') {
        read_GC_color();
        Navigator.of(context).pop();
      } else {}
    } catch (e) {}
  }

  Future<void> UpImg_De(index) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var ren = preferences.getString('renTalSer');
    String name = '';
    String url =
        '${MyConstant().domain}/UP_imgLogin.php?isAdd=true&ren=$ren&type=$index&imgname=$name';
    var response = await http.get(Uri.parse(url));

    var result = json.decode(response.body);
    print(result.toString());
    try {
      if (result.toString() == 'true') {
        read_GC_color();
        Navigator.of(context).pop();
      } else {}
    } catch (e) {}
  }

/////----------------------------------->
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
            backgroundColor: pickerColor,
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.arrow_back_outlined,
                color: Colors.white,
              ),
            ),
            centerTitle: true,
            title: Row(children: [
              Expanded(
                child: InkWell(
                  onTap: () async {
                    userModelsAddmin();
                    DialogEmailAdmin();
                  },
                  child: Text(
                    "Admin Program ",
                    style: const TextStyle(
                      color: Colors.white,
                      fontFamily: Font_.Fonts_T,
                    ),
                  ),
                ),
              ),
              IconButton(
                  onPressed: () {
                    showDialog<void>(
                      barrierDismissible: false,
                      context: context,
                      builder: (BuildContext context) {
                        return StreamBuilder(
                            stream: Stream.periodic(
                                const Duration(milliseconds: 500)),
                            builder: (context, snapshot) {
                              return AlertDialog(
                                backgroundColor: Colors.grey[350],
                                title: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: const Text(
                                        'Setting Image Login ',
                                        style: TextStyle(
                                            fontFamily: Font_.Fonts_T,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: const Text(
                                        '( Image W:600 x H:300)',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontFamily: Font_.Fonts_T,
                                          color: Colors.blue,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                content: SingleChildScrollView(
                                  child: ListBody(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            ElevatedButton(
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
                                                    Colors.grey.shade900,
                                                  )),
                                              onPressed: () {
                                                uploadFile_Slip(1);
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  // "อัพโหลดอีกครั้ง (รูปภาพ1)",
                                                  (img1 == null ||
                                                          img1.toString() == '')
                                                      ? "อัพโหลดรูปภาพ  (รูปภาพ1)"
                                                      : "อัพโหลดอีกครั้ง  (รูปภาพ1)",
                                                  style: TextStyle(
                                                      fontFamily: Font_.Fonts_T,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                            (img1 == null ||
                                                    img1.toString() == '')
                                                ? SizedBox()
                                                : IconButton(
                                                    onPressed: () async {
                                                      UpImg_De(1);
                                                    },
                                                    icon: Icon(Icons.delete))
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            ElevatedButton(
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
                                                    Colors.grey.shade900,
                                                  )),
                                              onPressed: () {
                                                uploadFile_Slip(2);
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  // "อัพโหลดอีกครั้ง (รูปภาพ2)",
                                                  (img2 == null ||
                                                          img2.toString() == '')
                                                      ? "อัพโหลดรูปภาพ  (รูปภาพ2)"
                                                      : "อัพโหลดอีกครั้ง  (รูปภาพ2)",
                                                  style: TextStyle(
                                                      fontFamily: Font_.Fonts_T,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                            (img2 == null ||
                                                    img2.toString() == '')
                                                ? SizedBox()
                                                : IconButton(
                                                    onPressed: () async {
                                                      UpImg_De(2);
                                                    },
                                                    icon: Icon(Icons.delete))
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            ElevatedButton(
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
                                                    Colors.grey.shade900,
                                                  )),
                                              onPressed: () {
                                                uploadFile_Slip(3);
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  // "อัพโหลดอีกครั้ง (รูปภาพ3)",
                                                  (img3 == null ||
                                                          img3.toString() == '')
                                                      ? "อัพโหลดรูปภาพ  (รูปภาพ3)"
                                                      : "อัพโหลดอีกครั้ง  (รูปภาพ3)",
                                                  style: TextStyle(
                                                      fontFamily: Font_.Fonts_T,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                            (img3 == null ||
                                                    img3.toString() == '')
                                                ? SizedBox()
                                                : IconButton(
                                                    onPressed: () async {
                                                      UpImg_De(3);
                                                    },
                                                    icon: Icon(Icons.delete))
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            ElevatedButton(
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
                                                    Colors.grey.shade900,
                                                  )),
                                              onPressed: () {
                                                uploadFile_Slip(4);
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  // "อัพโหลดอีกครั้ง (รูปภาพ4)",
                                                  (img4 == null ||
                                                          img4.toString() == '')
                                                      ? "อัพโหลดรูปภาพ  (รูปภาพ4)"
                                                      : "อัพโหลดอีกครั้ง  (รูปภาพ4)",
                                                  style: TextStyle(
                                                      fontFamily: Font_.Fonts_T,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                            (img4 == null ||
                                                    img4.toString() == '')
                                                ? SizedBox()
                                                : IconButton(
                                                    onPressed: () async {
                                                      UpImg_De(4);
                                                    },
                                                    icon: Icon(Icons.delete))
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            ElevatedButton(
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
                                                    Colors.grey.shade900,
                                                  )),
                                              onPressed: () {
                                                uploadFile_Slip(5);
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  // "อัพโหลดอีกครั้ง (รูปภาพ5)",
                                                  (img5 == null ||
                                                          img5.toString() == '')
                                                      ? "อัพโหลดรูปภาพ  (รูปภาพ5)"
                                                      : "อัพโหลดอีกครั้ง  (รูปภาพ5)",
                                                  style: TextStyle(
                                                      fontFamily: Font_.Fonts_T,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                            (img5 == null ||
                                                    img5.toString() == '')
                                                ? SizedBox()
                                                : IconButton(
                                                    onPressed: () async {
                                                      UpImg_De(5);
                                                    },
                                                    icon: Icon(Icons.delete))
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                actions: <Widget>[
                                  StreamBuilder(
                                      stream: Stream.periodic(
                                          const Duration(milliseconds: 500)),
                                      builder: (context, snapshot) {
                                        return Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: ElevatedButton(
                                                child: const Text('ยกเลิก'),
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor: Colors.red,
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 20,
                                                            vertical: 20),
                                                    textStyle: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                onPressed: () async {
                                                  read_GC_rental();
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ),
                                          ],
                                        );
                                      }),
                                ],
                              );
                            });
                      },
                    );
                  },
                  icon: Icon(Icons.image)),
              OutlinedButton(
                onPressed: () async {
                  int ser_tab = 0;
                  showDialog<void>(
                    barrierDismissible: false,
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        backgroundColor: Colors.grey[350],
                        title: StreamBuilder(
                            stream: Stream.periodic(
                                const Duration(milliseconds: 500)),
                            builder: (context, snapshot) {
                              return Column(
                                children: [
                                  Text((ser_tab == 0)
                                      ? 'ตั้งค่าสี #App Bar (ทุกตลาด)'
                                      : (ser_tab == 1)
                                          ? 'ตั้งค่าสี #Side Bar (ทุกตลาด)'
                                          : (ser_tab == 2)
                                              ? 'ตั้งค่าสี #Light Mode (ทุกตลาด)'
                                              : (ser_tab == 3)
                                                  ? 'ตั้งค่าสี #Dark Mode (ทุกตลาด)'
                                                  : (ser_tab == 4)
                                                      ? 'ตั้งค่าสี #Fool-Login (ทุกตลาด)'
                                                      : 'ตั้งค่าสี #background-Login (ทุกตลาด)'),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: [
                                        for (int index = 0; index < 6; index++)
                                          Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: ElevatedButton(
                                              child: Text((index == 0)
                                                  ? 'App Bar'
                                                  : (index == 1)
                                                      ? ' Side Bar'
                                                      : (index == 2)
                                                          ? 'Light Mode'
                                                          : (index == 3)
                                                              ? 'Dark Mode'
                                                              : (index == 4)
                                                                  ? 'Fool-Login'
                                                                  : 'background-Login'),
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.grey,
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 20,
                                                      vertical: 20),
                                                  textStyle: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              onPressed: () async {
                                                setState(() {
                                                  ser_tab = index;
                                                });
                                              },
                                            ),
                                          ),
                                      ],
                                    ),
                                  )
                                ],
                              );
                            }),
                        // title: const Text('ตั้งค่าสี ทุกตลาด'),UP_ColorsLogin
                        content: ColorPicker(
                          pickerColor: pickerColor,
                          onColorChanged: changeColors,
                        ),
                        actions: <Widget>[
                          StreamBuilder(
                              stream: Stream.periodic(
                                  const Duration(milliseconds: 500)),
                              builder: (context, snapshot) {
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ElevatedButton(
                                        child: const Text('คืนค่า Default'),
                                        onPressed: () async {
                                          var hexColor = (ser_tab == 1)
                                              ? 0xFF9BC945
                                              : 0xFF102456;

                                          var Mode_Color = (ser_tab == 2)
                                              ? 0xFFD9D9B7
                                              : 0xff9ba2cb;

                                          var Mode_ColorsLogin = (ser_tab == 4)
                                              ? 0xFF102456
                                              : 0xfff3f3ee;

                                          String url = (ser_tab == 0 ||
                                                  ser_tab == 1)
                                              ? '${MyConstant().domain}/UP_ColorsRen.php?isAdd=true&colors_ren=${hexColor}&colors_type=0&ser_tap=$ser_tab'
                                              : (ser_tab == 2 || ser_tab == 3)
                                                  ? '${MyConstant().domain}/UP_ColorsRen.php?isAdd=true&colors_ren=${Mode_Color}&colors_type=0&ser_tap=$ser_tab'
                                                  : '${MyConstant().domain}/UP_ColorsLogin.php?isAdd=true&colors_ren=${Mode_ColorsLogin}&colors_type=0&ser_tap=$ser_tab';

                                          try {
                                            var response =
                                                await http.get(Uri.parse(url));

                                            var result =
                                                json.decode(response.body);
                                            if (result.toString() == 'true') {
                                              Future.delayed(
                                                  Duration(milliseconds: 500),
                                                  () {
                                                setState(() {
                                                  read_GC_rental();
                                                  read_GC_package();
                                                  read_GC_packageGen();
                                                  read_GC_otp();
                                                });
                                              });

                                              Navigator.of(context).pop();
                                            }
                                          } catch (e) {
                                            Navigator.of(context).pop();
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.blue,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 20),
                                            textStyle: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ElevatedButton(
                                        child: const Text('ยกเลิก'),
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.red,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 20),
                                            textStyle: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold)),
                                        onPressed: () async {
                                          read_GC_rental();
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ElevatedButton(
                                        child: const Text('บันทึก'),
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.green,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 20),
                                            textStyle: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold)),
                                        onPressed: () async {
                                          // setState(() => currentColor = pickerColor);

                                          String colorString =
                                              pickerColor.toString();
                                          int startIndex =
                                              colorString.indexOf('(') + 1;
                                          int endIndex =
                                              colorString.indexOf(')');
                                          String hexColor = colorString
                                              .substring(startIndex, endIndex);
                                          // print(hexColor);

                                          if (hexColor != '' &&
                                              hexColor != null) {
                                            // String url = (ser_tab < 2)
                                            //     ? '${MyConstant().domain}/UP_ColorsRen.php?isAdd=true&colors_ren=${hexColor}&colors_type=0&ser_tap=$ser_tab'
                                            //     : '${MyConstant().domain}/UP_ColorsRen_Mode.php?isAdd=true&colors_ren=${hexColor}&colors_type=0&ser_tap=$ser_tab';

                                            String url = (ser_tab == 0 ||
                                                    ser_tab == 1)
                                                ? '${MyConstant().domain}/UP_ColorsRen.php?isAdd=true&colors_ren=${hexColor}&colors_type=0&ser_tap=$ser_tab'
                                                : (ser_tab == 2 || ser_tab == 3)
                                                    ? '${MyConstant().domain}/UP_ColorsRen.php?isAdd=true&colors_ren=${hexColor}&colors_type=0&ser_tap=$ser_tab'
                                                    : '${MyConstant().domain}/UP_ColorsLogin.php?isAdd=true&colors_ren=${hexColor}&colors_type=0&ser_tap=$ser_tab';

                                            try {
                                              var response = await http
                                                  .get(Uri.parse(url));

                                              var result =
                                                  json.decode(response.body);
                                              if (result.toString() == 'true') {
                                                Future.delayed(
                                                    Duration(milliseconds: 500),
                                                    () {
                                                  setState(() {
                                                    read_GC_rental();
                                                    read_GC_package();
                                                    read_GC_packageGen();
                                                    read_GC_otp();
                                                  });
                                                });

                                                Navigator.of(context).pop();
                                              }
                                            } catch (e) {
                                              Navigator.of(context).pop();
                                            }
                                          } else {}
                                        },
                                      ),
                                    ),
                                  ],
                                );
                              }),
                        ],
                      );
                    },
                  );
                },
                child: const Text(
                  'Setting Color',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: FontWeight_.Fonts_T),
                ),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    textStyle:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              ),
            ])),
        body: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(dragDevices: {
            PointerDeviceKind.touch,
            PointerDeviceKind.mouse,
          }),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Container(
                  width: (Responsive.isDesktop(context))
                      ? MediaQuery.of(context).size.width
                      : 1000,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Location',
                                        maxLines: 1,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: FontWeight_.Fonts_T,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: Responsive.isDesktop(context)
                                      ? MediaQuery.of(context).size.height -
                                          (MediaQuery.of(context).size.width *
                                              0.1)
                                      : MediaQuery.of(context).size.height *
                                              0.95 -
                                          (MediaQuery.of(context).size.width *
                                              0.2),
                                  child: GridView.count(
                                    crossAxisCount:
                                        Responsive.isDesktop(context) ? 5 : 2,
                                    children: [
                                      for (int i = 0;
                                          i < renTalModels.length;
                                          i++)
                                        Card(
                                          color: Colors.white,
                                          child: InkWell(
                                            onTap: () async {
                                              setState(() {
                                                _Licens = null;
                                              });
                                              genORsign(i);
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                children: [
                                                  OutlinedButton(
                                                    onPressed: () {
                                                      int ser_tab = 0;
                                                      showDialog<void>(
                                                        barrierDismissible:
                                                            false,
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return AlertDialog(
                                                            backgroundColor:
                                                                Colors
                                                                    .grey[350],
                                                            title:
                                                                StreamBuilder(
                                                                    stream: Stream.periodic(const Duration(
                                                                        milliseconds:
                                                                            500)),
                                                                    builder:
                                                                        (context,
                                                                            snapshot) {
                                                                      return Column(
                                                                        children: [
                                                                          Text((ser_tab == 0)
                                                                              ? 'ตั้งค่าสี #App Bar (${renTalModels[i].pn})'
                                                                              : (ser_tab == 1)
                                                                                  ? 'ตั้งค่าสี #Side Bar (${renTalModels[i].pn})'
                                                                                  : (ser_tab == 2)
                                                                                      ? 'ตั้งค่าสี #Light Mode (${renTalModels[i].pn})'
                                                                                      : 'ตั้งค่าสี #Dark Mode (${renTalModels[i].pn})'),
                                                                          Row(
                                                                            children: [
                                                                              for (int index = 0; index < 4; index++)
                                                                                Padding(
                                                                                  padding: const EdgeInsets.all(4.0),
                                                                                  child: ElevatedButton(
                                                                                    child: Text((index == 0)
                                                                                        ? 'App Bar'
                                                                                        : (index == 1)
                                                                                            ? ' Side Bar'
                                                                                            : (index == 2)
                                                                                                ? 'Light Mode'
                                                                                                : 'Dark Mode'),
                                                                                    style: ElevatedButton.styleFrom(backgroundColor: Colors.grey, padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20), textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                                                                                    onPressed: () async {
                                                                                      setState(() {
                                                                                        ser_tab = index;
                                                                                      });

                                                                                      (index == 0)
                                                                                          ? (renTalModels[i].colors_ren == null || renTalModels[i].colors_ren.toString() == '')
                                                                                              ? null
                                                                                              : setState(() => pickerColor = Color(int.parse(renTalModels[i].colors_ren!)))
                                                                                          : (index == 1)
                                                                                              ? (renTalModels[i].colors_subren == null || renTalModels[i].colors_subren.toString() == '')
                                                                                                  ? null
                                                                                                  : setState(() => pickerColor = Color(int.parse(renTalModels[i].colors_subren!)))
                                                                                              : (index == 2)
                                                                                                  ? (renTalModels[i].colors_light == null || renTalModels[i].colors_light.toString() == '')
                                                                                                      ? null
                                                                                                      : setState(() => pickerColor = Color(int.parse(renTalModels[i].colors_light!)))
                                                                                                  : (renTalModels[i].colors_dark == null || renTalModels[i].colors_dark.toString() == '')
                                                                                                      ? null
                                                                                                      : setState(() => pickerColor = Color(int.parse(renTalModels[i].colors_dark!)));
                                                                                    },
                                                                                  ),
                                                                                ),
                                                                            ],
                                                                          )
                                                                        ],
                                                                      );
                                                                    }),
                                                            content:
                                                                ColorPicker(
                                                              pickerColor:
                                                                  pickerColor,
                                                              onColorChanged:
                                                                  changeColors,
                                                            ),
                                                            actions: <Widget>[
                                                              StreamBuilder(
                                                                  stream: Stream.periodic(
                                                                      const Duration(
                                                                          milliseconds:
                                                                              500)),
                                                                  builder: (context,
                                                                      snapshot) {
                                                                    return Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .end,
                                                                      children: [
                                                                        Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(8.0),
                                                                          child:
                                                                              ElevatedButton(
                                                                            child:
                                                                                const Text('คืนค่า Default'),
                                                                            onPressed:
                                                                                () async {
                                                                              var hexColor = (ser_tab == 1) ? 0xFF9BC945 : 0xFF102456;
                                                                              var Mode_Color = (ser_tab == 2) ? 0xFFD9D9B7 : 0xff9ba2cb;

                                                                              String url = (ser_tab < 2) ? '${MyConstant().domain}/UP_ColorsRen.php?isAdd=true&colors_ren=${hexColor}&colors_type=1&ser_ren=${renTalModels[i].ser}&ser_tap=$ser_tab' : '${MyConstant().domain}/UP_ColorsRen.php?isAdd=true&colors_ren=${Mode_Color}&colors_type=1&ser_ren=${renTalModels[i].ser}&ser_tap=$ser_tab';

                                                                              try {
                                                                                var response = await http.get(Uri.parse(url));

                                                                                var result = json.decode(response.body);
                                                                                if (result.toString() == 'true') {
                                                                                  Future.delayed(Duration(milliseconds: 500), () {
                                                                                    setState(() {
                                                                                      read_GC_rental();
                                                                                      read_GC_package();
                                                                                      read_GC_packageGen();
                                                                                      read_GC_otp();
                                                                                    });
                                                                                  });

                                                                                  Navigator.of(context).pop();
                                                                                }
                                                                              } catch (e) {
                                                                                Navigator.of(context).pop();
                                                                              }
                                                                            },
                                                                            style: ElevatedButton.styleFrom(
                                                                                backgroundColor: Colors.blue,
                                                                                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                                                                                textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(8.0),
                                                                          child:
                                                                              ElevatedButton(
                                                                            child:
                                                                                const Text('ยกเลิก'),
                                                                            style: ElevatedButton.styleFrom(
                                                                                backgroundColor: Colors.red,
                                                                                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                                                                                textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                                                                            onPressed:
                                                                                () async {
                                                                              read_GC_rental();
                                                                              Navigator.of(context).pop();
                                                                            },
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(8.0),
                                                                          child:
                                                                              ElevatedButton(
                                                                            child:
                                                                                const Text('บันทึก'),
                                                                            style: ElevatedButton.styleFrom(
                                                                                backgroundColor: Colors.green,
                                                                                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                                                                                textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                                                                            onPressed:
                                                                                () async {
                                                                              // setState(() => currentColor = pickerColor);

                                                                              String colorString = pickerColor.toString();
                                                                              int startIndex = colorString.indexOf('(') + 1;
                                                                              int endIndex = colorString.indexOf(')');
                                                                              String hexColor = colorString.substring(startIndex, endIndex);
                                                                              // print(hexColor);

                                                                              if (hexColor != '' && hexColor != null) {
                                                                                String url = (ser_tab < 2) ? '${MyConstant().domain}/UP_ColorsRen.php?isAdd=true&colors_ren=${hexColor}&colors_type=1&ser_ren=${renTalModels[i].ser}&ser_tap=$ser_tab' : '${MyConstant().domain}/UP_ColorsRen.php?isAdd=true&colors_ren=${hexColor}&colors_type=1&ser_ren=${renTalModels[i].ser}&ser_tap=$ser_tab';

                                                                                try {
                                                                                  var response = await http.get(Uri.parse(url));

                                                                                  var result = json.decode(response.body);
                                                                                  if (result.toString() == 'true') {
                                                                                    Future.delayed(Duration(milliseconds: 500), () {
                                                                                      setState(() {
                                                                                        read_GC_rental();
                                                                                        read_GC_package();
                                                                                        read_GC_packageGen();
                                                                                        read_GC_otp();
                                                                                      });
                                                                                    });

                                                                                    Navigator.of(context).pop();
                                                                                  }
                                                                                } catch (e) {
                                                                                  Navigator.of(context).pop();
                                                                                }
                                                                              } else {}
                                                                            },
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    );
                                                                  }),
                                                            ],
                                                          );
                                                        },
                                                      );
                                                    },
                                                    child: Icon(
                                                        Icons.color_lens,
                                                        color: Colors.white),
                                                    style: ElevatedButton.styleFrom(
                                                        backgroundColor: (renTalModels[i].colors_ren ==
                                                                    null ||
                                                                renTalModels[i]
                                                                        .colors_ren
                                                                        .toString() ==
                                                                    '')
                                                            ? Colors.white
                                                            : Color(int.parse(
                                                                renTalModels[i]
                                                                    .colors_ren
                                                                    .toString())),
                                                        padding:
                                                            EdgeInsets.symmetric(
                                                                horizontal: 10,
                                                                vertical: 10),
                                                        textStyle: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.bold)),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Expanded(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            AutoSizeText(
                                                              minFontSize: 10,
                                                              maxFontSize: 15,
                                                              maxLines: 1,
                                                              '${renTalModels[i].pn}',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: const TextStyle(
                                                                  color: PeopleChaoScreen_Color
                                                                      .Colors_Text2_,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontFamily: Font_
                                                                      .Fonts_T),
                                                            ),
                                                            AutoSizeText(
                                                              minFontSize: 10,
                                                              maxFontSize: 15,
                                                              maxLines: 2,
                                                              '${renTalModels[i].bill_name}',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                  //fontWeight: FontWeight.bold,
                                                                  fontFamily: Font_
                                                                      .Fonts_T),
                                                            ),
                                                            AutoSizeText(
                                                              minFontSize: 10,
                                                              maxFontSize: 15,
                                                              maxLines: 1,
                                                              renTalModels[i]
                                                                          .pkldate ==
                                                                      '0000-00-00'
                                                                  ? '( Free )'
                                                                  : '( ${renTalModels[i].pkldate} )',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                  color: renTalModels[i]
                                                                              .pkldate ==
                                                                          '0000-00-00'
                                                                      ? Colors
                                                                          .blue
                                                                          .shade900
                                                                      : Colors
                                                                          .black,
                                                                  //fontWeight: FontWeight.bold,
                                                                  fontFamily: Font_
                                                                      .Fonts_T),
                                                            ),
                                                            datenow.isAfter(DateTime.parse(renTalModels[i].pkldate ==
                                                                                '0000-00-00'
                                                                            ? '${renTalModels[i].data_update}'
                                                                            : '${renTalModels[i].pkldate} 00:00:00.000')
                                                                        .subtract(const Duration(
                                                                            days:
                                                                                7))) ==
                                                                    true
                                                                ? AutoSizeText(
                                                                    minFontSize:
                                                                        10,
                                                                    maxFontSize:
                                                                        15,
                                                                    maxLines: 1,
                                                                    '- ใกล้หมดอายุ -',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: TextStyle(
                                                                        color: Colors.red,
                                                                        //fontWeight: FontWeight.bold,
                                                                        fontFamily: Font_.Fonts_T),
                                                                  )
                                                                : datenow.isAfter(DateTime.parse(renTalModels[i].pkldate == '0000-00-00'
                                                                                ? '${renTalModels[i].data_update}'
                                                                                : '${renTalModels[i].pkldate} 00:00:00.000')
                                                                            .subtract(const Duration(days: 0))) ==
                                                                        true
                                                                    ? AutoSizeText(
                                                                        minFontSize:
                                                                            10,
                                                                        maxFontSize:
                                                                            15,
                                                                        maxLines:
                                                                            1,
                                                                        '- หมดอายุ -',
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        style: TextStyle(
                                                                            color: Colors.red,
                                                                            //fontWeight: FontWeight.bold,
                                                                            fontFamily: Font_.Fonts_T),
                                                                      )
                                                                    : SizedBox(),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                              child: Column(
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Package',
                                      maxLines: 1,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: FontWeight_.Fonts_T,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: Responsive.isDesktop(context)
                                    ? MediaQuery.of(context).size.height -
                                        (MediaQuery.of(context).size.width *
                                            0.1)
                                    : MediaQuery.of(context).size.height *
                                            0.95 -
                                        (MediaQuery.of(context).size.width *
                                            0.2),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ScrollConfiguration(
                                      behavior: ScrollConfiguration.of(context)
                                          .copyWith(dragDevices: {
                                        PointerDeviceKind.touch,
                                        PointerDeviceKind.mouse,
                                      }),
                                      child: SingleChildScrollView(
                                        child: Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: Responsive.isDesktop(context)
                                              ? MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.12
                                              : MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.35,
                                          child: GridView.count(
                                            scrollDirection: Axis.horizontal,
                                            crossAxisCount: 1,
                                            children: [
                                              for (int i = 0;
                                                  i < packageModels.length;
                                                  i++)
                                                Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Container(
                                                      width: Responsive
                                                              .isDesktop(
                                                                  context)
                                                          ? MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.1
                                                          : MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.22,
                                                      child: InkWell(
                                                        onTap: () async {
                                                          setState(() {
                                                            if (packSelext ==
                                                                packageModels[i]
                                                                    .ser) {
                                                              packSelext = null;
                                                              packint = 0;
                                                            } else {
                                                              packint = i;
                                                              packSelext =
                                                                  packageModels[
                                                                          i]
                                                                      .ser;
                                                            }
                                                          });
                                                        },
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            color: packSelext ==
                                                                    packageModels[
                                                                            i]
                                                                        .ser
                                                                ? Colors.purple
                                                                : Colors
                                                                    .white38,
                                                            borderRadius: const BorderRadius
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
                                                                bottomRight: Radius
                                                                    .circular(
                                                                        10)),
                                                            border: (packSelext ==
                                                                    packageModels[
                                                                            i]
                                                                        .ser)
                                                                ? Border.all(
                                                                    color: Colors
                                                                        .white,
                                                                    width: 1)
                                                                : Border.all(
                                                                    color: Colors
                                                                        .black,
                                                                    width: 1),
                                                          ),
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Center(
                                                            child: Column(
                                                              children: [
                                                                SizedBox(
                                                                  height: 10,
                                                                ),
                                                                Text(
                                                                  'Package ${packageModels[i].pk}',
                                                                  maxLines: 1,
                                                                  style:
                                                                      TextStyle(
                                                                    color: (packSelext ==
                                                                            packageModels[i]
                                                                                .ser)
                                                                        ? Colors
                                                                            .white
                                                                        : Colors
                                                                            .green,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontFamily:
                                                                        FontWeight_
                                                                            .Fonts_T,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 10,
                                                                ),
                                                                Text(
                                                                  '${packageModels[i].qty}',
                                                                  maxLines: 1,
                                                                  style:
                                                                      TextStyle(
                                                                    color: (packSelext ==
                                                                            packageModels[i]
                                                                                .ser)
                                                                        ? Colors
                                                                            .white
                                                                        : Colors
                                                                            .black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontFamily:
                                                                        FontWeight_
                                                                            .Fonts_T,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 10,
                                                                ),
                                                                Text(
                                                                  'ล็อก/แผง',
                                                                  maxLines: 1,
                                                                  style:
                                                                      TextStyle(
                                                                    color: (packSelext ==
                                                                            packageModels[i]
                                                                                .ser)
                                                                        ? Colors
                                                                            .white
                                                                        : Colors
                                                                            .black,
                                                                    fontFamily:
                                                                        Font_
                                                                            .Fonts_T,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  '${packageModels[i].user} สิทธิผู้ใช้งาน',
                                                                  maxLines: 1,
                                                                  style:
                                                                      TextStyle(
                                                                    color: (packSelext ==
                                                                            packageModels[i]
                                                                                .ser)
                                                                        ? Colors
                                                                            .white
                                                                        : Colors
                                                                            .black,
                                                                    fontFamily:
                                                                        Font_
                                                                            .Fonts_T,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  '${NumberFormat("#,##0.00", "en_US").format(double.parse(packageModels[i].rpri!))} บาท/เดือน',
                                                                  maxLines: 1,
                                                                  style:
                                                                      TextStyle(
                                                                    color: (packSelext ==
                                                                            packageModels[i]
                                                                                .ser)
                                                                        ? Colors
                                                                            .white
                                                                        : Colors
                                                                            .black,
                                                                    fontFamily:
                                                                        Font_
                                                                            .Fonts_T,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ))
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            'License Key',
                                            maxLines: 1,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: FontWeight_.Fonts_T,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          flex: 4,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              packSelext == null
                                                  ? ""
                                                  : 'Package ${packageModels[packint!].pk}',
                                              maxLines: 1,
                                              style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.red,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: FontWeight_.Fonts_T,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                            flex: 1,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                height: 50,
                                                decoration: BoxDecoration(
                                                  color: Colors.green.shade900,
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
                                                      color: Colors.white,
                                                      width: 1),
                                                ),
                                                child: InkWell(
                                                  onTap: () async {
                                                    // packint = i;
                                                    //           packSelext =
                                                    //               packageModels[i].ser;

                                                    if (packSelext != null) {
                                                      var vv =
                                                          getRandomString(16);
                                                      String url =
                                                          '${MyConstant().domain}/In_Package.php?isAdd=true&serpk=$packSelext&lisen=$vv';

                                                      try {
                                                        var response =
                                                            await http.get(
                                                                Uri.parse(url));

                                                        var result =
                                                            json.decode(
                                                                response.body);
                                                        print(result);
                                                        if (result.toString() ==
                                                            'true') {
                                                          setState(() {
                                                            read_GC_packageGen();
                                                          });
                                                          print(
                                                              '$vv  $packSelext  $packint');
                                                        }
                                                      } catch (e) {}
                                                      setState(() {
                                                        read_GC_packageGen();
                                                      });
                                                    }
                                                  },
                                                  child: Center(
                                                    child: Text(
                                                      'Generator',
                                                      maxLines: 1,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily:
                                                            FontWeight_.Fonts_T,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ))
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                flex: 1,
                                                child: Text(
                                                  'Package',
                                                  maxLines: 1,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    // fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Text(
                                                  'Unit/User',
                                                  maxLines: 1,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    // fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 4,
                                                child: Text(
                                                  'KEY',
                                                  maxLines: 1,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    // fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Text(
                                                  'Status',
                                                  maxLines: 1,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    // fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.3,
                                          child: ListView.builder(
                                              itemCount:
                                                  licensekeyModels.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return Column(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                            flex: 1,
                                                            child: Text(
                                                              'Package ${licensekeyModels[index].pk}',
                                                              maxLines: 1,
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                // fontWeight: FontWeight.bold,
                                                                fontFamily: Font_
                                                                    .Fonts_T,
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 1,
                                                            child: Text(
                                                              '${licensekeyModels[index].qty}/${licensekeyModels[index].user}',
                                                              maxLines: 1,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                // fontWeight: FontWeight.bold,
                                                                fontFamily: Font_
                                                                    .Fonts_T,
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 4,
                                                            child: licensekeyModels[
                                                                            index]
                                                                        .use ==
                                                                    '0'
                                                                ? SelectableText(
                                                                    '${licensekeyModels[index].key}',
                                                                    maxLines: 1,
                                                                    toolbarOptions: ToolbarOptions(
                                                                        copy:
                                                                            true,
                                                                        selectAll:
                                                                            true,
                                                                        cut:
                                                                            false,
                                                                        paste:
                                                                            false),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      // fontWeight: FontWeight.bold,
                                                                      fontFamily:
                                                                          Font_
                                                                              .Fonts_T,
                                                                    ),
                                                                  )
                                                                : Text(
                                                                    '${licensekeyModels[index].key}',
                                                                    maxLines: 1,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      // fontWeight: FontWeight.bold,
                                                                      fontFamily:
                                                                          Font_
                                                                              .Fonts_T,
                                                                    ),
                                                                  ),
                                                          ),
                                                          Expanded(
                                                            flex: 1,
                                                            child: Text(
                                                              licensekeyModels[
                                                                              index]
                                                                          .use ==
                                                                      '0'
                                                                  ? 'ใช้งานได้'
                                                                  : 'ไม่สามารถใช้งานได้',
                                                              maxLines: 1,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                color: licensekeyModels[index]
                                                                            .use ==
                                                                        '0'
                                                                    ? Colors
                                                                        .green
                                                                    : Colors
                                                                        .red,
                                                                // fontWeight: FontWeight.bold,
                                                                fontFamily: Font_
                                                                    .Fonts_T,
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              }),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          )),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<Null> read_packageGen(ser) async {
    if (licensekeyUPModels.isNotEmpty) {
      setState(() {
        licensekeyUPModels.clear();
      });
    }
    String url = '${MyConstant().domain}/GC_package_up.php?isAdd=true&ser=$ser';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      licensekeyUPModels.clear();
      for (var map in result) {
        LicensekeyUPModel licensekeyUPModel = LicensekeyUPModel.fromJson(map);
        var use = licensekeyUPModel.use;
        var kk = licensekeyUPModel.key;
        var sd = licensekeyUPModel.sdate;
        var ld = licensekeyUPModel.ldate;
        setState(() {
          if (use == '2') {
            _Licens = kk;
            _pk_sdate = sd;
            _pk_ldate = ld;
          }
          licensekeyUPModels.add(licensekeyUPModel);
        });
      }
    } catch (e) {}
  }

  Future<String?> genORsign(int i) {
    print('renTalModels ser ${renTalModels[i].ser}');
    setState(() {
      var ser = renTalModels[i].ser;
      r_email =
          renTalModels[i].bill_email == null ? '' : renTalModels[i].bill_email;
      Form2_text.text = renTalModels[i].bill_email == null
          ? ''
          : renTalModels[i].bill_email.toString();
      read_packageGen(ser);
    });
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        title: Center(
            child: Column(
          children: [
            Text(
              'Sign in or Generator Licens Key',
              style: TextStyle(
                  color: AdminScafScreen_Color.Colors_Text1_,
                  fontWeight: FontWeight.bold,
                  fontFamily: FontWeight_.Fonts_T),
            ),
            Text(
              '${renTalModels[i].pn}',
              style: TextStyle(
                  color: Colors.blue.shade900,
                  fontWeight: FontWeight.bold,
                  fontFamily: FontWeight_.Fonts_T),
            ),
          ],
        )),
        actions: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * 0.4,
            height: MediaQuery.of(context).size.width * 0.3,
            child: StreamBuilder(
                stream: Stream.periodic(const Duration(seconds: 0)),
                builder: (context, snapshot) {
                  return Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.width * 0.23,
                        child: Column(
                          children: [
                            datenow.isAfter(DateTime.parse(renTalModels[i]
                                                    .pkldate ==
                                                '0000-00-00'
                                            ? '${renTalModels[i].data_update}'
                                            : '${renTalModels[i].pkldate} 00:00:00.000')
                                        .subtract(const Duration(days: 7))) ==
                                    true
                                ? AutoSizeText(
                                    minFontSize: 10,
                                    maxFontSize: 15,
                                    maxLines: 1,
                                    'อายุการใช้งานใกล้จะหมดอายุ กรุณาต่ออายุการใช้งาน',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.red,
                                        //fontWeight: FontWeight.bold,
                                        fontFamily: Font_.Fonts_T),
                                  )
                                : datenow.isAfter(DateTime.parse(renTalModels[i]
                                                        .pkldate ==
                                                    '0000-00-00'
                                                ? '${renTalModels[i].data_update}'
                                                : '${renTalModels[i].pkldate} 00:00:00.000')
                                            .subtract(
                                                const Duration(days: 0))) ==
                                        true
                                    ? AutoSizeText(
                                        minFontSize: 10,
                                        maxFontSize: 15,
                                        maxLines: 1,
                                        'อายุการใช้งานหมดอายุแล้ว กรุณาต่ออายุการใช้งาน',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.red,
                                            //fontWeight: FontWeight.bold,
                                            fontFamily: Font_.Fonts_T),
                                      )
                                    : SizedBox(),
                            Divider(),
                            Row(
                              children: [
                                Expanded(
                                  child: AutoSizeText(
                                    minFontSize: 10,
                                    maxFontSize: 15,
                                    maxLines: 1,
                                    'Name',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        color: PeopleChaoScreen_Color
                                            .Colors_Text1_,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: Font_.Fonts_T),
                                  ),
                                ),
                                Expanded(
                                  child: AutoSizeText(
                                    minFontSize: 10,
                                    maxFontSize: 15,
                                    maxLines: 1,
                                    'Chao Name',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        color: PeopleChaoScreen_Color
                                            .Colors_Text1_,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: Font_.Fonts_T),
                                  ),
                                ),
                                Expanded(
                                  child: AutoSizeText(
                                    minFontSize: 10,
                                    maxFontSize: 15,
                                    maxLines: 1,
                                    'Start Date',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        color: PeopleChaoScreen_Color
                                            .Colors_Text1_,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: Font_.Fonts_T),
                                  ),
                                ),
                                Expanded(
                                  child: AutoSizeText(
                                    minFontSize: 10,
                                    maxFontSize: 15,
                                    maxLines: 1,
                                    'Last Date',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        color: PeopleChaoScreen_Color
                                            .Colors_Text1_,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: Font_.Fonts_T),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: AutoSizeText(
                                    minFontSize: 10,
                                    maxFontSize: 15,
                                    maxLines: 1,
                                    '${renTalModels[i].pn}',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        color: PeopleChaoScreen_Color
                                            .Colors_Text1_,
                                        // fontWeight: FontWeight.bold,
                                        fontFamily: Font_.Fonts_T),
                                  ),
                                ),
                                Expanded(
                                  child: AutoSizeText(
                                    minFontSize: 10,
                                    maxFontSize: 15,
                                    maxLines: 1,
                                    '${renTalModels[i].bill_name}',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        color: PeopleChaoScreen_Color
                                            .Colors_Text1_,
                                        // fontWeight: FontWeight.bold,
                                        fontFamily: Font_.Fonts_T),
                                  ),
                                ),
                                Expanded(
                                  child: AutoSizeText(
                                    minFontSize: 10,
                                    maxFontSize: 15,
                                    maxLines: 1,
                                    renTalModels[i].pksdate == '0000-00-00'
                                        ? 'Free 7 Day'
                                        : '${renTalModels[i].pksdate}',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        color: PeopleChaoScreen_Color
                                            .Colors_Text1_,
                                        // fontWeight: FontWeight.bold,
                                        fontFamily: Font_.Fonts_T),
                                  ),
                                ),
                                Expanded(
                                  child: AutoSizeText(
                                    minFontSize: 10,
                                    maxFontSize: 15,
                                    maxLines: 1,
                                    renTalModels[i].pkldate == '0000-00-00'
                                        ? '${renTalModels[i].datex}'
                                        : '${renTalModels[i].pkldate}',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        color: PeopleChaoScreen_Color
                                            .Colors_Text1_,
                                        // fontWeight: FontWeight.bold,
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
                                  child: Card(
                                    color: day_date == 'D' && num_date == 7
                                        ? Colors.green.shade900
                                        : Colors.white,
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          day_date = 'D';
                                          num_date = 7;
                                          Form1_text.clear();
                                        });
                                      },
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.width *
                                                0.04,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              AutoSizeText(
                                                minFontSize: 10,
                                                maxFontSize: 15,
                                                maxLines: 1,
                                                '+7 Day',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: day_date == 'D' &&
                                                            num_date == 7
                                                        ? Colors.white
                                                        : Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: Font_.Fonts_T),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Card(
                                    color: day_date == 'M' && num_date == 1
                                        ? Colors.green.shade900
                                        : Colors.white,
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          day_date = 'M';
                                          num_date = 1;
                                          Form1_text.clear();
                                        });
                                      },
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.width *
                                                0.04,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              AutoSizeText(
                                                minFontSize: 10,
                                                maxFontSize: 15,
                                                maxLines: 1,
                                                '+1 Month',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: day_date == 'M' &&
                                                            num_date == 1
                                                        ? Colors.white
                                                        : Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: Font_.Fonts_T),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Card(
                                    color: day_date == 'Y' && num_date == 1
                                        ? Colors.green.shade900
                                        : Colors.white,
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          day_date = 'Y';
                                          num_date = 1;
                                          Form1_text.clear();
                                        });
                                      },
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.width *
                                                0.04,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              AutoSizeText(
                                                minFontSize: 10,
                                                maxFontSize: 15,
                                                maxLines: 1,
                                                '+1 Year',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: day_date == 'Y' &&
                                                            num_date == 1
                                                        ? Colors.white
                                                        : Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: Font_.Fonts_T),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 4,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Card(
                                          color: Colors.white,
                                          child: TextFormField(
                                            controller: Form1_text,
                                            keyboardType: TextInputType.number,
                                            onChanged: (value) async {
                                              setState(() {
                                                num_date = int.parse(value);
                                              });
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
                                                // labelText: 'Password',
                                                labelStyle: const TextStyle(
                                                  color: ManageScreen_Color
                                                      .Colors_Text2_,
                                                  // fontWeight:
                                                  //     FontWeight.bold,
                                                  fontFamily: Font_.Fonts_T,
                                                )),
                                            inputFormatters: <TextInputFormatter>[
                                              // for below version 2 use this
                                              FilteringTextInputFormatter.allow(
                                                  RegExp(r'[0-9]')),
                                              // for version 2 and greater youcan also use this
                                              FilteringTextInputFormatter
                                                  .digitsOnly
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                          flex: 1,
                                          child: Column(
                                            children: [
                                              TextButton(
                                                  style: TextButton.styleFrom(
                                                      backgroundColor:
                                                          day_date == 'D'
                                                              ? Colors.green
                                                              : Colors.white),
                                                  onPressed: () {
                                                    setState(() {
                                                      day_date = 'D';
                                                    });
                                                  },
                                                  child: AutoSizeText(
                                                    minFontSize: 10,
                                                    maxFontSize: 15,
                                                    maxLines: 1,
                                                    'Day',
                                                    textAlign: TextAlign.end,
                                                    style: TextStyle(
                                                        color: day_date == 'D'
                                                            ? Colors.white
                                                            : Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily:
                                                            Font_.Fonts_T),
                                                  )),
                                              TextButton(
                                                  style: TextButton.styleFrom(
                                                      backgroundColor:
                                                          day_date == 'M'
                                                              ? Colors.green
                                                              : Colors.white),
                                                  onPressed: () {
                                                    setState(() {
                                                      day_date = 'M';
                                                    });
                                                  },
                                                  child: AutoSizeText(
                                                    minFontSize: 10,
                                                    maxFontSize: 15,
                                                    maxLines: 1,
                                                    'Month',
                                                    textAlign: TextAlign.end,
                                                    style: TextStyle(
                                                        color: day_date == 'M'
                                                            ? Colors.white
                                                            : Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily:
                                                            Font_.Fonts_T),
                                                  )),
                                              TextButton(
                                                style: TextButton.styleFrom(
                                                    backgroundColor:
                                                        day_date == 'Y'
                                                            ? Colors.green
                                                            : Colors.white),
                                                onPressed: () {
                                                  setState(() {
                                                    day_date = 'Y';
                                                  });
                                                },
                                                child: AutoSizeText(
                                                  minFontSize: 10,
                                                  maxFontSize: 15,
                                                  maxLines: 1,
                                                  'Year',
                                                  textAlign: TextAlign.end,
                                                  style: TextStyle(
                                                      color: day_date == 'Y'
                                                          ? Colors.white
                                                          : Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily:
                                                          Font_.Fonts_T),
                                                ),
                                              ),
                                            ],
                                          ))
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Expanded(
                                    flex: 4,
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.03,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          width: 1,
                                        ),
                                        color: Colors.white,
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(15),
                                            topRight: Radius.circular(15),
                                            bottomLeft: Radius.circular(15),
                                            bottomRight: Radius.circular(15)),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Center(
                                            child: _Licens == null
                                                ? AutoSizeText(
                                                    minFontSize: 10,
                                                    maxFontSize: 15,
                                                    maxLines: 1,
                                                    '',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily:
                                                            Font_.Fonts_T),
                                                  )
                                                : SelectableText(
                                                    '$_Licens',
                                                    maxLines: 1,
                                                    toolbarOptions:
                                                        ToolbarOptions(
                                                            copy: true,
                                                            selectAll: true,
                                                            cut: false,
                                                            paste: false),
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      // fontWeight: FontWeight.bold,
                                                      fontFamily: Font_.Fonts_T,
                                                    ),
                                                  )),
                                      ),
                                    )),
                                Expanded(
                                  flex: 2,
                                  child: Card(
                                    color: Colors.black,
                                    child: InkWell(
                                      onTap: () async {
                                        var ser = renTalModels[i].ser;
                                        if (_Licens == null) {
                                          if (day_date != null &&
                                              num_date != 0) {
                                            String vv = getRandomString(16);
                                            // setState(() {
                                            //   _Licens = vv;
                                            // });
                                            var nd = num_date;
                                            var dd = day_date;
                                            var ld = renTalModels[i].pkldate ==
                                                    '0000-00-00'
                                                ? renTalModels[i].datex
                                                : renTalModels[i].pkldate;

                                            var sta = 'Y';
                                            var ema = Form2_text.text;
                                            var pack = '0';
                                            var fileName_Slip_ = '';
                                            var pri = '0';
                                            print(
                                                'serren=$ser&lisen=$vv&num_date=$nd&day_date=$dd&ldate=$ld');
                                            String url =
                                                '${MyConstant().domain}/In_Package_put.php?isAdd=true&serren=$ser&lisen=$vv&num_date=$nd&day_date=$dd&ldate=$ld&sta=$sta&ema=$ema&pack=$pack&Slip=$fileName_Slip_&pri=$pri';

                                            try {
                                              var response = await http
                                                  .get(Uri.parse(url));

                                              var result =
                                                  json.decode(response.body);
                                              print(result);
                                              if (result.toString() == 'true') {
                                                setState(() {
                                                  read_packageGen(ser);
                                                });
                                              }
                                            } catch (e) {}
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                  content: Text(
                                                      'อายุการใช้งานไม่ถูกต้อง!')),
                                            );
                                          }
                                        } else {
                                          if (day_date != null &&
                                              num_date != 0) {
                                            String vv = getRandomString(16);
                                            // setState(() {
                                            //   _Licens = vv;
                                            // });
                                            var nd = num_date;
                                            var dd = day_date;
                                            var ld = renTalModels[i].pkldate ==
                                                    '0000-00-00'
                                                ? renTalModels[i].datex
                                                : renTalModels[i].pkldate;

                                            print(
                                                'Up_Package_put >>> serren=$ser&lisen=$vv&num_date=$nd&day_date=$dd&ldate=$ld');
                                            String url =
                                                '${MyConstant().domain}/Up_Package_put.php?isAdd=true&serren=$ser&lisen=$vv&num_date=$nd&day_date=$dd&ldate=$ld';

                                            try {
                                              var response = await http
                                                  .get(Uri.parse(url));

                                              var result =
                                                  json.decode(response.body);
                                              print(result);
                                              if (result.toString() == 'true') {
                                                setState(() {
                                                  read_packageGen(ser);
                                                });
                                              }
                                            } catch (e) {}
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                  content: Text(
                                                      'อายุการใช้งานไม่ถูกต้อง!')),
                                            );
                                          }
                                        }
                                        setState(() {
                                          read_packageGen(ser);
                                        });
                                      },
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.width *
                                                0.03,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              AutoSizeText(
                                                minFontSize: 10,
                                                maxFontSize: 15,
                                                maxLines: 1,
                                                _Licens == null
                                                    ? 'Generator'
                                                    : 'Generator New',
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                    color:
                                                        PeopleChaoScreen_Color
                                                            .Colors_Text3_,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: Font_.Fonts_T),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            _Licens == null
                                ? SizedBox()
                                : Row(
                                    children: [
                                      Expanded(
                                        child: AutoSizeText(
                                          minFontSize: 10,
                                          maxFontSize: 15,
                                          maxLines: 1,
                                          'Start : $_pk_sdate',
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              color: PeopleChaoScreen_Color
                                                  .Colors_Text1_,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: Font_.Fonts_T),
                                        ),
                                      ),
                                      Expanded(
                                        child: AutoSizeText(
                                          minFontSize: 10,
                                          maxFontSize: 15,
                                          maxLines: 1,
                                          'End : $_pk_ldate',
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              color: PeopleChaoScreen_Color
                                                  .Colors_Text1_,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: Font_.Fonts_T),
                                        ),
                                      )
                                    ],
                                  ),
                            SizedBox(
                              height: 20,
                            ),
                            _Licens == null
                                ? SizedBox()
                                : Row(
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Card(
                                          color: Colors.orange.shade900,
                                          child: InkWell(
                                            onTap: () async {
                                              if (_Licens != null) {
                                                var ser = renTalModels[i].ser;
                                                var lc = _Licens;
                                                var sd = _pk_sdate;
                                                var ld = _pk_ldate;

                                                String url =
                                                    '${MyConstant().domain}/up_rentel_pac.php?isAdd=true&serren=$ser&lisen=$lc&pk_sdate=$sd&pk_ldate=$ld';

                                                try {
                                                  var response = await http
                                                      .get(Uri.parse(url));

                                                  var result = json
                                                      .decode(response.body);
                                                  print(result);
                                                  if (result.toString() ==
                                                      'true') {
                                                    MaterialPageRoute route =
                                                        MaterialPageRoute(
                                                      builder: (context) =>
                                                          SignUnAdmin(),
                                                    );
                                                    Navigator
                                                        .pushAndRemoveUntil(
                                                            context,
                                                            route,
                                                            (route) => true);
                                                  }
                                                } catch (e) {}
                                                MaterialPageRoute route =
                                                    MaterialPageRoute(
                                                  builder: (context) =>
                                                      SignUnAdmin(),
                                                );
                                                Navigator.pushAndRemoveUntil(
                                                    context,
                                                    route,
                                                    (route) => false);
                                              }
                                            },
                                            child: Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.03,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    AutoSizeText(
                                                      minFontSize: 10,
                                                      maxFontSize: 15,
                                                      maxLines: 1,
                                                      'Update Now',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: const TextStyle(
                                                          color:
                                                              PeopleChaoScreen_Color
                                                                  .Colors_Text3_,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily:
                                                              Font_.Fonts_T),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                          flex: 4,
                                          child: Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.03,
                                            decoration: BoxDecoration(
                                                // border: Border.all(
                                                //   width: 1,
                                                // ),
                                                // color: Colors.white,
                                                // borderRadius:
                                                //     const BorderRadius.only(
                                                //         topLeft:
                                                //             Radius.circular(15),
                                                //         topRight:
                                                //             Radius.circular(15),
                                                //         bottomLeft:
                                                //             Radius.circular(15),
                                                //         bottomRight:
                                                //             Radius.circular(15)),
                                                ),
                                            child: TextFormField(
                                              controller: Form2_text,
                                              onChanged: (value) async {
                                                setState(() {
                                                  r_email = value;
                                                });
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
                                                  // labelText: 'Password',
                                                  labelStyle: const TextStyle(
                                                    color: ManageScreen_Color
                                                        .Colors_Text2_,
                                                    // fontWeight:
                                                    //     FontWeight.bold,
                                                    fontFamily: Font_.Fonts_T,
                                                  )),
                                            ),
                                          )),
                                      Expanded(
                                        flex: 2,
                                        child: Card(
                                          color: Colors.orange.shade900,
                                          child: InkWell(
                                            onTap: () async {
                                              final response = await SendEmail(
                                                  '${renTalModels[i].pn}',
                                                  Form2_text.text,
                                                  '$_Licens');

                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                response == 200
                                                    ? const SnackBar(
                                                        content: Text(
                                                            'ส่ง Licens Key ไปยัง Email ของท่านแล้ว!!',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontFamily: Font_
                                                                    .Fonts_T)),
                                                        backgroundColor:
                                                            Colors.green)
                                                    : const SnackBar(
                                                        content: Text(
                                                            'Failed to send message!',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontFamily: Font_
                                                                    .Fonts_T)),
                                                        backgroundColor:
                                                            Colors.red),
                                              );
                                              Navigator.pop(context);
                                            },
                                            child: Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.03,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    AutoSizeText(
                                                      minFontSize: 10,
                                                      maxFontSize: 15,
                                                      maxLines: 1,
                                                      'Sene Mail',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: const TextStyle(
                                                          color:
                                                              PeopleChaoScreen_Color
                                                                  .Colors_Text3_,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily:
                                                              Font_.Fonts_T),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Icon(Icons.send_outlined,
                                                        color: Colors.white),
                                                  ],
                                                ),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 3,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                AutoSizeText(
                                  minFontSize: 10,
                                  maxFontSize: 15,
                                  maxLines: 1,
                                  '',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color:
                                          PeopleChaoScreen_Color.Colors_Text3_,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: Font_.Fonts_T),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                AutoSizeText(
                                  minFontSize: 10,
                                  maxFontSize: 15,
                                  maxLines: 1,
                                  '',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color:
                                          PeopleChaoScreen_Color.Colors_Text3_,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: Font_.Fonts_T),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Card(
                                  color: Colors.blue.shade900,
                                  child: InkWell(
                                    onTap: () {
                                      var serren = renTalModels[i].ser;
                                      signInThread(serren);
                                    },
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.035,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            AutoSizeText(
                                              minFontSize: 10,
                                              maxFontSize: 15,
                                              maxLines: 1,
                                              'Sign in',
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                  color: PeopleChaoScreen_Color
                                                      .Colors_Text3_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: Font_.Fonts_T),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Card(
                                  color: Colors.black,
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.035,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            AutoSizeText(
                                              minFontSize: 10,
                                              maxFontSize: 15,
                                              maxLines: 1,
                                              'Close',
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                  color: PeopleChaoScreen_Color
                                                      .Colors_Text3_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: Font_.Fonts_T),
                                            )
                                          ],
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
                  );
                }),
          )
        ],
      ),
    );
  }

  DialogEmailAdmin() async {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        title: Center(
            child: Text(
          'Email Admin Chao ',
          style: TextStyle(
              color: AdminScafScreen_Color.Colors_Text1_,
              fontWeight: FontWeight.bold,
              fontFamily: FontWeight_.Fonts_T),
        )),
        content: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(dragDevices: {
            PointerDeviceKind.touch,
            PointerDeviceKind.mouse,
          }),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            dragStartBehavior: DragStartBehavior.start,
            child: Row(
              children: [
                Container(
                  width: (Responsive.isDesktop(context))
                      ? MediaQuery.of(context).size.width * 0.7
                      : 800,
                  child: StreamBuilder(
                      stream: Stream.periodic(const Duration(seconds: 0)),
                      builder: (context, snapshot) {
                        return Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  'ทั้งหมด : ${userModels.length} คน',
                                  style: TextStyle(
                                      color:
                                          AdminScafScreen_Color.Colors_Text1_,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: FontWeight_.Fonts_T),
                                ),
                              ],
                            ),
                            Container(
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
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Container(
                                    width: 50,
                                    child: Text(
                                      '...',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: AdminScafScreen_Color
                                              .Colors_Text1_,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: FontWeight_.Fonts_T),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      'Email',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: AdminScafScreen_Color
                                              .Colors_Text1_,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: FontWeight_.Fonts_T),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Text(
                                      'ชื่อ',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: AdminScafScreen_Color
                                              .Colors_Text1_,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: FontWeight_.Fonts_T),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Text(
                                      'ตำแหน่ง',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: AdminScafScreen_Color
                                              .Colors_Text1_,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: FontWeight_.Fonts_T),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Text(
                                      'ขณะนี้อยู่ตลาด',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: AdminScafScreen_Color
                                              .Colors_Text1_,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: FontWeight_.Fonts_T),
                                    ),
                                  ),
                                  Container(
                                    width: 50,
                                    child: Text(
                                      '...',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: AdminScafScreen_Color
                                              .Colors_Text1_,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: FontWeight_.Fonts_T),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.55,
                                width: (Responsive.isDesktop(context))
                                    ? MediaQuery.of(context).size.width * 0.7
                                    : 800,
                                child: ListView.builder(
                                    padding: const EdgeInsets.all(8),
                                    itemCount: userModels.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Container(
                                        decoration: BoxDecoration(
                                          // color: Colors.green[100]!
                                          //     .withOpacity(0.5),
                                          border: const Border(
                                            bottom: BorderSide(
                                              color: Colors.black12,
                                              width: 1,
                                            ),
                                          ),
                                        ),
                                        padding: const EdgeInsets.all(4),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 50,
                                              child: Text(
                                                '${index + 1}',
                                                textAlign: TextAlign.start,
                                                maxLines: 2,
                                                style: TextStyle(
                                                    color: AdminScafScreen_Color
                                                        .Colors_Text1_,
                                                    // fontWeight: FontWeight.bold,
                                                    fontFamily: Font_.Fonts_T),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Text(
                                                textAlign: TextAlign.start,
                                                maxLines: 2,
                                                '${userModels[index].email}',
                                                style: TextStyle(
                                                    color: AdminScafScreen_Color
                                                        .Colors_Text1_,
                                                    // fontWeight: FontWeight.bold,
                                                    fontFamily: Font_.Fonts_T),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Text(
                                                textAlign: TextAlign.start,
                                                maxLines: 2,
                                                '${userModels[index].fname} ${userModels[index].lname}',
                                                style: TextStyle(
                                                    color: AdminScafScreen_Color
                                                        .Colors_Text1_,
                                                    // fontWeight: FontWeight.bold,
                                                    fontFamily: Font_.Fonts_T),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Text(
                                                '${userModels[index].position}',
                                                textAlign: TextAlign.start,
                                                maxLines: 2,
                                                style: TextStyle(
                                                    color: AdminScafScreen_Color
                                                        .Colors_Text1_,
                                                    // fontWeight: FontWeight.bold,
                                                    fontFamily: Font_.Fonts_T),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Text(
                                                renTalModels
                                                        .where((model) =>
                                                            model.ser
                                                                .toString() ==
                                                            '${userModels[index].rser}')
                                                        .map((renTalModels) =>
                                                            renTalModels.rtname)
                                                        .isEmpty
                                                    ? '??'
                                                    : renTalModels
                                                        .firstWhere((model) =>
                                                            model.ser
                                                                .toString() ==
                                                            '${userModels[index].rser}')
                                                        .pn
                                                        .toString(),
                                                // '${userModels[index].rser}',
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                    color: Colors.green,
                                                    fontWeight: FontWeight.w600,
                                                    fontFamily: Font_.Fonts_T),
                                              ),
                                            ),
                                            Container(
                                              width: 50,
                                              child: PopupMenuButton<int>(
                                                color: Colors.green[50],
                                                tooltip: '',
                                                child: Icon(
                                                  Icons.edit,
                                                  color: Colors.orange[900],
                                                  size: 20,
                                                ),
                                                itemBuilder: (context) {
                                                  return [
                                                    for (int index = 0;
                                                        index <
                                                            renTalModels.length;
                                                        index++)
                                                      PopupMenuItem<int>(
                                                          value: int.parse(
                                                              '${renTalModels[index].ser}'),
                                                          child: Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                // color: Colors.green[100]!
                                                                //     .withOpacity(0.5),
                                                                border:
                                                                    const Border(
                                                                  bottom:
                                                                      BorderSide(
                                                                    color: Colors
                                                                        .black12,
                                                                    width: 1,
                                                                  ),
                                                                ),
                                                              ),
                                                              width: 220,
                                                              child: Text(
                                                                  "${index + 1}. ${renTalModels[index].pn}",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .start,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          14,
                                                                      color: AdminScafScreen_Color
                                                                          .Colors_Text1_,
                                                                      fontFamily:
                                                                          Font_
                                                                              .Fonts_T)))),
                                                  ];
                                                },
                                                onOpened: () {},
                                                onCanceled: () {},
                                                onSelected: (value) async {
                                                  ///UP_emailAdminSer
                                                  print(value);
                                                  try {
                                                    final url =
                                                        '${MyConstant().domain}/UP_emailAdminSer.php';

                                                    final response = await http
                                                        .post(Uri.parse(url),
                                                            body: {
                                                          'isAdd': 'true',
                                                          'seruser':
                                                              '${userModels[index].ser}',
                                                          'serrenTal': '$value',
                                                        });
                                                    setState(() {
                                                      userModelsAddmin();
                                                    });
                                                  } catch (e) {
                                                    setState(() {
                                                      userModelsAddmin();
                                                    });
                                                  }
                                                },
                                              ),
                                            )
                                          ],
                                        ),
                                      );
                                    })),
                          ],
                        );
                      }),
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
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
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
                                'ปิด',
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
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future SendEmail(String name, String email, String message) async {
    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
    final response = await http.post(url,
        headers: {
          'Content-Type': 'application/json'
        }, //This line makes sure it works for all platforms.
        body: json.encode({
          'service_id': ser_id,
          'template_id': tem_id,
          'user_id': user_id,
          'template_params': {
            'from_name': name,
            'from_email': email,
            'message': 'License Key : $message'
          }
        }));
    return response.statusCode;
  }

  Future<Null> signInThread(serren) async {
    String url =
        '${MyConstant().domain}/GC_user.php?isAdd=true&email=dzentric.com@gmail.com';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print(result);
      for (var map in result) {
        UserModel userModel = UserModel.fromJson(map);
        print('serren>>>>$serren');
        routeToService(AdminScafScreen(route: 'หน้าหลัก'), userModel, serren);
      }
    } catch (e) {
      Insert_log.Insert_logs('ล็อคอิน', 'เข้าสู่ระบบ ผิดพลาด');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Username ผิดพลาด กรุณาลองใหม่!',
                style:
                    TextStyle(color: Colors.white, fontFamily: Font_.Fonts_T))),
      );
    }
  }

  Future<Null> in_Package_put(serren) async {
    String url =
        '${MyConstant().domain}/GC_user.php?isAdd=true&email=dzentric.com@gmail.com';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print(result);
      for (var map in result) {
        UserModel userModel = UserModel.fromJson(map);
        print('serren>>>>$serren');
        routeToService(AdminScafScreen(route: 'หน้าหลัก'), userModel, serren);
      }
    } catch (e) {
      Insert_log.Insert_logs('ล็อคอิน', 'เข้าสู่ระบบ ผิดพลาด');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Username ผิดพลาด กรุณาลองใหม่!',
                style:
                    TextStyle(color: Colors.white, fontFamily: Font_.Fonts_T))),
      );
    }
  }

  Future<Null> routeToService(
      Widget myWidget, UserModel userModel, serren) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('ser', userModel.ser.toString());
    preferences.setString('position', userModel.position.toString());
    preferences.setString('fname', userModel.fname.toString());
    preferences.setString('lname', userModel.lname.toString());
    preferences.setString('email', userModel.email.toString());
    preferences.setString('utype', userModel.utype.toString());
    preferences.setString('verify', userModel.verify.toString());
    preferences.setString('permission', userModel.permission.toString());
    preferences.setString('rser', serren.toString());
    preferences.setString('lavel', userModel.user_id.toString());
    preferences.setString('route', 'หน้าหลัก');
    preferences.setString('pakanPay', 0.toString());
    Insert_log.Insert_logs('ล็อคอิน', 'เข้าสู่ระบบ');
    MaterialPageRoute route = MaterialPageRoute(
      builder: (context) => myWidget,
    );
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }
}
