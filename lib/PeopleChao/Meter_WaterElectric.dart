// ignore_for_file: unused_import, unused_local_variable, unnecessary_null_comparison, unused_field, override_on_non_overriding_member, duplicate_import, must_be_immutable, body_might_complete_normally_nullable
import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'dart:html' as html;
import '../Constant/Myconstant.dart';
import '../INSERT_Log/Insert_log.dart';
import '../Model/GetContractx_Model.dart';
import '../Model/GetExp_Model.dart';
import '../Model/GetRenTal_Model.dart';
import '../Model/GetTrans_Model.dart';
import '../Model/electricity_history_model.dart';
import '../Responsive/responsive.dart';
import '../Style/colors.dart';
import 'dart:html' as html;
import 'package:path/path.dart' as path;
import 'package:image/image.dart' as img;

class MeterWaterElectric extends StatefulWidget {
  final Get_Value_NameShop_index;
  final Get_Value_cid;
  const MeterWaterElectric({
    super.key,
    this.Get_Value_NameShop_index,
    this.Get_Value_cid,
  });

  @override
  State<MeterWaterElectric> createState() => _MeterWaterElectricState();
}

class _MeterWaterElectricState extends State<MeterWaterElectric> {
  @override
  ScrollController _scrollController1 = ScrollController();
  ScrollController _scrollController2 = ScrollController();

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

  List<String> mont = [
    'มกราคม',
    'กุมภาพันธ์	',
    'มีนาคม',
    'เมษายน',
    'พฤษภาคม',
    'มิถุนายน',
    'กรกฎาคม',
    'สิงหาคม',
    'กันยายน',
    'ตุลาคม',
    'พฤศจิกายน',
    'ธันวาคม'
  ];

  String? _celvat,
      _cname,
      _cnamex,
      _cmeter,
      _cser,
      _cunitser,
      _cqty_vat,
      _cunit;
  var nFormat = NumberFormat("#,##0.00", "en_US");
  List<TransModel> _TransModels = [];
  List<ContractxModel> _ContractxModels = [];
  List<ElectricityHistoryModel> electricityHistoryModels = [];
  List<RenTalModel> renTalModels = [];
  int Ser__TapContractx = 0, renTal_lavel = 0;
  String tappedIndex_1 = '';
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
      foder;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    red_exp_wherser();
    read_GC_rental();
  }

  Future<Null> read_GC_rental() async {
    if (renTalModels.isNotEmpty) {
      renTalModels.clear();
    }

    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');

    setState(() {
      renTal_lavel = int.parse(preferences.getString('lavel').toString());
    });
    String url =
        '${MyConstant().domain}/GC_rental_setring.php?isAdd=true&ren=$ren';

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
            renTalModels.add(renTalModel);
          });
        }
      } else {}
    } catch (e) {}
    print('name>>>>>  $renname');
  }

  Future<Null> red_Trans(_cser) async {
    if (_TransModels.length != 0) {
      setState(() {
        _TransModels.clear();
      });
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    var ciddoc = widget.Get_Value_cid;
    var qutser = widget.Get_Value_NameShop_index;

    if (qutser == '1') {
      String url = _cser == null
          ? '${MyConstant().domain}/GC_quotx_consx.php?isAdd=true&ren=$ren&ciddoc=$ciddoc&qutser=$qutser&_cser=${_ContractxModels[0].ser}}'
          : '${MyConstant().domain}/GC_quotx_consx.php?isAdd=true&ren=$ren&ciddoc=$ciddoc&qutser=$qutser&_cser=$_cser';
      try {
        var response = await http.get(Uri.parse(url));

        var result = json.decode(response.body);
        print(result);
        if (result.toString() != 'null') {
          for (var map in result) {
            TransModel _TransModel = TransModel.fromJson(map);
            setState(() {
              _TransModels.add(_TransModel);
            });
          }
        } else {
          setState(() {
            _TransModels.clear();
          });
        }
      } catch (e) {}
    }

    if (_cser == null) {
      setState(() {
        _celvat = _ContractxModels[0].nvat;
        _cname =
            '${_ContractxModels[0].expname!.trim()}( ${_ContractxModels[0].unit} )\n${_ContractxModels[0].meter}';
        _cmeter = _ContractxModels[0].meter;
        _cnamex = '${_ContractxModels[0].expname}';
        _cser = _ContractxModels[0].ser;
        _cunitser = _ContractxModels[0].unitser;
        _cunit = _ContractxModels[0].unit;
        _cqty_vat = _ContractxModels[0].qty;
      });
    }
  }

  Future<Null> red_exp_wherser() async {
    if (_ContractxModels.length != 0) {
      setState(() {
        _ContractxModels.clear();
      });
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    var ciddoc = widget.Get_Value_cid;
    var qutser = widget.Get_Value_NameShop_index;

    if (qutser == '1') {
      String url =
          '${MyConstant().domain}/GC_exp_wherser.php?isAdd=true&ren=$ren&ciddoc=$ciddoc&qutser=$qutser';
      try {
        var response = await http.get(Uri.parse(url));

        var result = json.decode(response.body);
        print(result);
        if (result.toString() != 'null') {
          for (var map in result) {
            ContractxModel _ContractxModel = ContractxModel.fromJson(map);
            setState(() {
              _ContractxModels.add(_ContractxModel);
            });
          }
        } else {
          setState(() {
            _ContractxModels.clear();
          });
        }
      } catch (e) {}
    }

    if (_cser == null) {
      setState(() {
        _celvat = _ContractxModels[0].nvat;
        _cname =
            '${_ContractxModels[0].expname!.trim()}( ${_ContractxModels[0].unit} )\n${_ContractxModels[0].meter}';
        _cmeter = _ContractxModels[0].meter;
        _cnamex = '${_ContractxModels[0].expname}';
        _cser = _ContractxModels[0].ser;
        _cunitser = _ContractxModels[0].unitser;
        _cunit = _ContractxModels[0].unit;
        _cqty_vat = _ContractxModels[0].qty;
      });
    }

    setState(() {
      red_Trans(_cser);
    });
  }

  ////-----------------------------------------------------ฬ
  var extension_;
  var file_;
  String? base64_Slip, fileName_Slip;
  Future<void> uploadFile_Slip(indextran) async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.getImage(
        source: ImageSource.gallery, maxHeight: 100, maxWidth: 100);

    if (pickedFile == null) {
      print('User canceled image selection');
      return;
    } else {
      // 2. Read the image as bytes
      final imageBytes = await pickedFile.readAsBytes();

      // 3. Encode the image as a base64 string
      final base64Image = base64Encode(imageBytes);
      setState(() {
        base64_Slip = base64Image;
      });

      setState(() {
        extension_ = 'png';
        // file_ = file;
      });
      print(extension_);
      print(extension_);
      Future.delayed(Duration(milliseconds: 200), () {
        OKuploadFile_Slip(indextran);
      });
    }
    // print(base64_Slip);
    //
  }

  Future<void> OKuploadFile_Slip(indextran) async {
    if (base64_Slip != null) {
      String Path_foder = 'Meter';
      String dateTimeNow = DateTime.now().toString();
      String date = DateFormat('ddMMyyyy')
          .format(DateTime.parse('${dateTimeNow}'))
          .toString();
      final dateTimeNow2 = DateTime.now().toUtc().add(const Duration(hours: 7));
      final formatter2 = DateFormat('HHmmss');
      final formattedTime2 = formatter2.format(dateTimeNow2);
      String Time_ = formattedTime2.toString();

      setState(() {
        fileName_Slip =
            'Meter_${widget.Get_Value_cid}_${date}_$Time_.$extension_';
      });

      try {
        // 2. Read the image as bytes
        // final imageBytes = await pickedFile.readAsBytes();

        // 3. Encode the image as a base64 string
        // final base64Image = base64Encode(imageBytes);

        // 4. Make an HTTP POST request to your server
        final url =
            '${MyConstant().domain}/File_uploadMeter.php?name=$fileName_Slip&Foder=$foder&extension=$extension_';

        final response = await http.post(
          Uri.parse(url),
          body: {
            'image': base64_Slip,
            'Foder': foder,
            'name': fileName_Slip,
            'ex': extension_.toString()
          }, // Send the image as a form field named 'image'
        );

        if (response.statusCode == 200) {
          print('File uploaded successfully!*** : $fileName_Slip');
          OK_up_insert_img(indextran);
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
//   Future<void> captureImage(indextran) async {
//     final picker = ImagePicker();
//     final XFile? photo = await picker.pickImage(source: ImageSource.camera);
//     if (photo != null) {
//       final Uint8List imageBytes = await photo.readAsBytes();
//       final String filePath = photo.path;

//       if (filePath.isNotEmpty) {
//         final String extension = path.extension(filePath);
//         // Resize the image
//         final img.Image resizedImage = img.decodeImage(imageBytes)!;
//         final img.Image thumbnail =
//             img.copyResize(resizedImage, width: 220, height: 200);
//         final List<int> resizedBytes = img.encodeJpg(thumbnail);
//         setState(() {
//           base64_Slip = base64Encode(imageBytes);
//           extension_ = extension;
//         });
//         String Path_foder = 'Meter';
//         String dateTimeNow = DateTime.now().toString();
//         String date = DateFormat('ddMMyyyy')
//             .format(DateTime.parse('${dateTimeNow}'))
//             .toString();
//         final dateTimeNow2 =
//             DateTime.now().toUtc().add(const Duration(hours: 7));
//         final formatter2 = DateFormat('HHmmss');
//         final formattedTime2 = formatter2.format(dateTimeNow2);
//         String Time_ = formattedTime2.toString();
//         setState(() {
//           fileName_Slip = 'Meter_${widget.Get_Value_cid}_${date}_$Time_.png';
//         });
//         print('Extension: $extension');

//         // Create the form data
//         final formData = html.FormData();
//         // formData.append(
//         //     'file', html.Blob([imageBytes.buffer]) as String, fileName_Slip);
//         formData.appendBlob('file', html.Blob([resizedBytes]), fileName_Slip);
//         // Create and send the request
//         final request = html.HttpRequest();
//         request.open('POST',
//             '${MyConstant().domain}/File_uploadSlip.php?name=$fileName_Slip&Foder=$foder&Pathfoder=$Path_foder');
//         request.send(formData);

//         // Handle the request response
//         request.onLoad.listen((html.ProgressEvent e) {
//           final response = request.response;
//           if (request.status == 200) {
//             // File upload successful
//             print('File uploaded successfully! : $fileName_Slip');
//             OK_up_insert_img(indextran);
//           } else {
//             // File upload failed
//             print('File upload failed');
//           }
//         });
//       } else {
//         print('Error: File path is empty.');
//       }
//     } else {
//       // User cancelled image capture
//     }
//   }

//   Future<void> uploadFile_Slip(indextran) async {
//     // InsertFile_SQL(fileName, MixPath_);
//     // Open the file picker and get the selected file
//     final input = html.FileUploadInputElement();
//     // input..accept = 'application/pdf';
//     input.accept = 'image/jpeg,image/png,image/jpg';
//     input.click();
//     // deletedFile_('IDcard_LE000001_25-02-2023.pdf');
//     await input.onChange.first;

//     final file = input.files!.first;
//     final reader = html.FileReader();
//     reader.readAsArrayBuffer(file);
//     await reader.onLoadEnd.first;
//     String fileName_ = file.name;
//     String extension = fileName_.split('.').last;
// // print('File name: $fileName_');
//     print('Extension: $extension');

//     final Uint8List fileBytes = Uint8List.fromList(reader.result as List<int>);
//     final img.Image resizedImage = img.decodeImage(fileBytes)!;
//     final img.Image thumbnail =
//         img.copyResize(resizedImage, width: 220, height: 200);
//     final List<int> resizedBytes = img.encodeJpg(thumbnail);
//     setState(() {
//       base64_Slip = base64Encode(reader.result as Uint8List);
//     });
//     // print(base64_Slip);
//     setState(() {
//       extension_ = extension;
//       file_ = file;
//     });
//     OKuploadFile_Slip(resizedBytes, indextran);
//   }

//   Future<void> OKuploadFile_Slip(resizedBytes, indextran) async {
//     if (base64_Slip != null) {
//       String Path_foder = 'Meter';
//       String dateTimeNow = DateTime.now().toString();
//       String date = DateFormat('ddMMyyyy')
//           .format(DateTime.parse('${dateTimeNow}'))
//           .toString();
//       final dateTimeNow2 = DateTime.now().toUtc().add(const Duration(hours: 7));
//       final formatter2 = DateFormat('HHmmss');
//       final formattedTime2 = formatter2.format(dateTimeNow2);
//       String Time_ = formattedTime2.toString();

//       setState(() {
//         fileName_Slip =
//             'Meter_${widget.Get_Value_cid}_${date}_$Time_.$extension_';
//       });
//       // String fileName = 'slip_${widget.Get_Value_cid}_${date}_$Time_.$extension_';
//       // InsertFile_SQL(fileName, MixPath_, formattedTime1);
//       // Create a new FormData object and add the file to it

//       final blob = html.Blob([resizedBytes]);
//       final formData = html.FormData();

//       formData.appendBlob('file', blob, fileName_Slip);
//       // Send the request
//       final request = html.HttpRequest();
//       request.open('POST',
//           '${MyConstant().domain}/File_uploadSlip.php?name=$fileName_Slip&Foder=$foder&Pathfoder=$Path_foder');
//       request.send(formData);
//       // print(formData);

//       // Handle the response
//       await request.onLoad.first;

//       if (request.status == 200) {
//         print('File uploaded successfully!*** : $fileName_Slip');
//         OK_up_insert_img(indextran);
//       } else {
//         print('File upload failed with status code: ${request.status}');
//       }
//     } else {
//       print('ยังไม่ได้เลือกรูปภาพ');
//     }
//   }

  Future<void> OK_up_insert_img(indextran) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    var user = preferences.getString('ser');

    var tran_ser = _TransModels[indextran].ser;
    String url =
        '${MyConstant().domain}/UPC_Invoice_img.php?isAdd=true&ren=$ren&fileName=$fileName_Slip&transer=$tran_ser';
    print('$tran_ser /// $ren /// $user /// $fileName_Slip ');
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);

      if (result.toString() == 'true') {
        print(result);
        // Navigator.pop(context);
        setState(() {
          red_exp_wherser();
          read_GC_rental();
        });
      }
    } catch (e) {
      print('******************** > $e');
    }
  }

  @override

  ///----------------->
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: Color(0xfff3f3ee),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
        ),
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              child: ScrollConfiguration(
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
                      for (int index = 0;
                          index < _ContractxModels.length;
                          index++)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                _celvat = _ContractxModels[index].nvat;
                                _cname =
                                    '${_ContractxModels[index].expname!.trim()}( ${_ContractxModels[index].unit} )\n${_ContractxModels[index].meter}';
                                _cmeter = _ContractxModels[index].meter;
                                _cnamex = '${_ContractxModels[index].expname}';
                                _cser = _ContractxModels[index].ser;
                                _cunitser = _ContractxModels[index].unitser;
                                _cunit = _ContractxModels[index].unit;
                                _cqty_vat = _ContractxModels[index].qty;

                                red_Trans(_cser);
                                Ser__TapContractx = index;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: (Ser__TapContractx == index)
                                    ? Colors.blue[500]
                                    : Colors.blue[200],
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10)),
                                border:
                                    Border.all(color: Colors.white, width: 1),
                              ),
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      AutoSizeText(
                                        minFontSize: 10,
                                        maxFontSize: 25,
                                        maxLines: 1,
                                        '${_ContractxModels[index].expname}',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: (Ser__TapContractx == index)
                                                ? Colors.white
                                                : PeopleChaoScreen_Color
                                                    .Colors_Text1_,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: FontWeight_.Fonts_T
                                            //fontSize: 10.0
                                            ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      AutoSizeText(
                                        minFontSize: 10,
                                        maxFontSize: 25,
                                        maxLines: 1,
                                        '( ${_ContractxModels[index].unit} )',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: (Ser__TapContractx == index)
                                                ? Colors.white
                                                : PeopleChaoScreen_Color
                                                    .Colors_Text1_,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: FontWeight_.Fonts_T
                                            //fontSize: 10.0
                                            ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      AutoSizeText(
                                        minFontSize: 10,
                                        maxFontSize: 25,
                                        maxLines: 1,
                                        '${_ContractxModels[index].meter}',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: (Ser__TapContractx == index)
                                                ? Colors.white
                                                : PeopleChaoScreen_Color
                                                    .Colors_Text1_,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: FontWeight_.Fonts_T
                                            //fontSize: 10.0
                                            ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                              // Text(
                              //   '${_ContractxModels[index].expname}( ${_ContractxModels[index].unit} )\n${_ContractxModels[index].meter}',
                              //   textAlign: TextAlign.center,
                              //   style: const TextStyle(
                              //       color: Colors.black,
                              //       fontWeight: FontWeight.bold,
                              //       fontSize: 15.0),
                              // ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
            _ContractxModels.isEmpty
                ? const SizedBox()
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ScrollConfiguration(
                        behavior: ScrollConfiguration.of(context)
                            .copyWith(dragDevices: {
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
                                      ? MediaQuery.of(context).size.width * 0.84
                                      : 800,
                                  // height: MediaQuery.of(context).size.width * 0.5,
                                  child: Column(children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () {
                                              if (renTal_lavel > 1) {
                                                showDialog<void>(
                                                  context: context,
                                                  barrierDismissible:
                                                      false, // user must tap button!
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      shape: const RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius.circular(
                                                                      20.0))),
                                                      // title: const Text('AlertDialog Title'),
                                                      content:
                                                          SingleChildScrollView(
                                                        child: ListBody(
                                                          children: <Widget>[
                                                            Container(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.3,
                                                              height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.08,
                                                              child: Center(
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Column(
                                                                    children: [
                                                                      Container(
                                                                        padding:
                                                                            const EdgeInsets.all(8.0),
                                                                        child:
                                                                            AutoSizeText(
                                                                          maxLines:
                                                                              2,
                                                                          minFontSize:
                                                                              8,
                                                                          // maxFontSize: 15,
                                                                          'เลขมิเตอร์เดิม $_cmeter',
                                                                          textAlign:
                                                                              TextAlign.start,
                                                                          style: const TextStyle(
                                                                              color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                              // fontWeight: FontWeight.bold,
                                                                              fontFamily: Font_.Fonts_T

                                                                              //fontSize: 10.0
                                                                              ),
                                                                        ),
                                                                      ),
                                                                      TextFormField(
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        // initialValue:
                                                                        //     _cmeter,
                                                                        onFieldSubmitted:
                                                                            (value) async {
                                                                          SharedPreferences
                                                                              preferences =
                                                                              await SharedPreferences.getInstance();
                                                                          String?
                                                                              ren =
                                                                              preferences.getString('renTalSer');
                                                                          String?
                                                                              ser_user =
                                                                              preferences.getString('ser');
                                                                          var qser =
                                                                              _cser;
                                                                          String
                                                                              url =
                                                                              '${MyConstant().domain}/UM_contactx.php?isAdd=true&ren=$ren&qser=$qser&qty=$value&ser_user=$ser_user';

                                                                          try {
                                                                            var response =
                                                                                await http.get(Uri.parse(url));

                                                                            var result =
                                                                                json.decode(response.body);
                                                                            print(result);
                                                                            if (result.toString() ==
                                                                                'true') {
                                                                              setState(() {
                                                                                _cser = null;
                                                                              });

                                                                              red_exp_wherser();
                                                                            }
                                                                          } catch (e) {}
                                                                          Navigator.of(context)
                                                                              .pop();
                                                                        },
                                                                        // maxLength: 13,
                                                                        cursorColor:
                                                                            Colors.green,
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
                                                                            labelText: 'แก้ไขเลขเครื่อง',
                                                                            labelStyle: const TextStyle(
                                                                                color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                                // fontWeight: FontWeight.bold,
                                                                                fontFamily: Font_.Fonts_T)),
                                                                        // inputFormatters: <TextInputFormatter>[
                                                                        //   // for below version 2 use this
                                                                        //   FilteringTextInputFormatter.allow(
                                                                        //       RegExp(r'[0-9]')),
                                                                        //   // for version 2 and greater youcan also use this
                                                                        //   FilteringTextInputFormatter
                                                                        //       .digitsOnly
                                                                        // ],
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      actions: <Widget>[
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: [
                                                            Container(
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: InkWell(
                                                                  child: Container(
                                                                      width: 100,
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
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.white,
                                                                            fontWeight: FontWeight.bold,
                                                                            fontFamily: FontWeight_.Fonts_T
                                                                            //fontSize: 10.0
                                                                            ),
                                                                      ))),
                                                                  onTap: () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );
                                              }
                                            },
                                            child: Container(
                                              height: 80,
                                              decoration: BoxDecoration(
                                                color: Colors.blue[200],
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  topLeft: Radius.circular(10),
                                                  topRight: Radius.circular(10),
                                                  bottomLeft:
                                                      Radius.circular(0),
                                                  bottomRight:
                                                      Radius.circular(0),
                                                ),
                                                // border: Border.all(
                                                //     color: Colors.grey, width: 1),
                                              ),
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                '$_cnamex ($_cunit)\n$_cmeter',
                                                maxLines: 3,
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                    color:
                                                        PeopleChaoScreen_Color
                                                            .Colors_Text1_,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T
                                                    //fontSize: 10.0
                                                    ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(4.0),
                                      // height: 70,
                                      color: Colors.blue[200],
                                      child: Row(
                                        children: [
                                          const Expanded(
                                            flex: 1,
                                            child: Center(
                                              child: Text(
                                                'เดือน',
                                                maxLines: 1,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color:
                                                        PeopleChaoScreen_Color
                                                            .Colors_Text1_,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T
                                                    //fontSize: 10.0
                                                    ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: const [
                                                    AutoSizeText(
                                                      minFontSize: 8,
                                                      maxFontSize: 14,
                                                      'ก่อน',
                                                      maxLines: 1,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          color:
                                                              PeopleChaoScreen_Color
                                                                  .Colors_Text1_,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily:
                                                              FontWeight_
                                                                  .Fonts_T
                                                          //fontSize: 10.0
                                                          ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: const [
                                                    AutoSizeText(
                                                      minFontSize: 8,
                                                      maxFontSize: 14,
                                                      'เลขมิเตอร์(หน่วย)',
                                                      maxLines: 1,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          color:
                                                              PeopleChaoScreen_Color
                                                                  .Colors_Text1_,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily:
                                                              FontWeight_
                                                                  .Fonts_T
                                                          //fontSize: 10.0
                                                          ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: const [
                                                    AutoSizeText(
                                                      minFontSize: 8,
                                                      maxFontSize: 14,
                                                      'หลัง',
                                                      maxLines: 1,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          color:
                                                              PeopleChaoScreen_Color
                                                                  .Colors_Text1_,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily:
                                                              FontWeight_
                                                                  .Fonts_T
                                                          //fontSize: 10.0
                                                          ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: const [
                                                    AutoSizeText(
                                                      minFontSize: 8,
                                                      maxFontSize: 14,
                                                      'เลขมิเตอร์(หน่วย)',
                                                      maxLines: 1,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          color:
                                                              PeopleChaoScreen_Color
                                                                  .Colors_Text1_,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily:
                                                              FontWeight_
                                                                  .Fonts_T
                                                          //fontSize: 10.0
                                                          ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: const [
                                                    AutoSizeText(
                                                      minFontSize: 8,
                                                      maxFontSize: 14,
                                                      'ใช้ไป(หน่วย)',
                                                      maxLines: 1,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          color:
                                                              PeopleChaoScreen_Color
                                                                  .Colors_Text1_,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily:
                                                              FontWeight_
                                                                  .Fonts_T
                                                          //fontSize: 10.0
                                                          ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: const [
                                                    AutoSizeText(
                                                      minFontSize: 8,
                                                      maxFontSize: 14,
                                                      'ยอดเงิน',
                                                      maxLines: 1,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          color:
                                                              PeopleChaoScreen_Color
                                                                  .Colors_Text1_,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily:
                                                              FontWeight_
                                                                  .Fonts_T
                                                          //fontSize: 10.0
                                                          ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    AutoSizeText(
                                                      minFontSize: 8,
                                                      maxFontSize: 14,
                                                      '(รวม VAT)',
                                                      maxLines: 1,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: const TextStyle(
                                                          color:
                                                              PeopleChaoScreen_Color
                                                                  .Colors_Text1_,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily:
                                                              FontWeight_
                                                                  .Fonts_T
                                                          //fontSize: 10.0
                                                          ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          const Expanded(
                                            flex: 1,
                                            child: Center(
                                              child: AutoSizeText(
                                                minFontSize: 8,
                                                maxFontSize: 14,
                                                'หลักฐาน',
                                                maxLines: 1,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color:
                                                        PeopleChaoScreen_Color
                                                            .Colors_Text1_,
                                                    fontWeight: FontWeight.bold,
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
                                    Container(
                                      width: (Responsive.isDesktop(context))
                                          ? MediaQuery.of(context).size.width *
                                              0.84
                                          : 800,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.4,
                                      // padding: EdgeInsets.only(bottom: 20),
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
                                            const AlwaysScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: _TransModels.length,
                                        itemBuilder: (BuildContext context,
                                            int indextran) {
                                          // ignore: curly_braces_in_flow_control_structures
                                          return Material(
                                            color: tappedIndex_1 ==
                                                    indextran.toString()
                                                ? tappedIndex_Color
                                                    .tappedIndex_Colors
                                                : AppbackgroundColor
                                                    .Sub_Abg_Colors,
                                            child: Container(
                                              // color: tappedIndex_1 ==
                                              //         indextran.toString()
                                              //     ? tappedIndex_Color
                                              //         .tappedIndex_Colors
                                              //         .withOpacity(0.5)
                                              //     : null,
                                              child: ListTile(
                                                onTap: () {
                                                  setState(() {
                                                    tappedIndex_1 =
                                                        indextran.toString();
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
                                                          // ignore: unnecessary_string_interpolations
                                                          '${DateFormat.MMMM('th_TH').format((DateTime.parse('${_TransModels[indextran].date} 00:00:00')))}\n${DateTime.parse('${_TransModels[indextran].date} 00:00:00').year + 543}',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style:
                                                              const TextStyle(
                                                                  color: PeopleChaoScreen_Color
                                                                      .Colors_Text2_,
                                                                  //fontWeight: FontWeight.bold,
                                                                  fontFamily: Font_
                                                                      .Fonts_T),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: _cunitser != '6'
                                                            ? Text(
                                                                '$_cunit',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: const TextStyle(
                                                                    color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                    //fontWeight: FontWeight.bold,
                                                                    fontFamily: Font_.Fonts_T),
                                                              )
                                                            : Container(
                                                                decoration:
                                                                    const BoxDecoration(
                                                                  // color: Colors.green,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .only(
                                                                    topLeft: Radius
                                                                        .circular(
                                                                            6),
                                                                    topRight: Radius
                                                                        .circular(
                                                                            6),
                                                                    bottomLeft:
                                                                        Radius.circular(
                                                                            6),
                                                                    bottomRight:
                                                                        Radius.circular(
                                                                            6),
                                                                  ),
                                                                  // border: Border.all(color: Colors.grey, width: 1),
                                                                ),
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: indextran ==
                                                                        0
                                                                    ? _TransModels[indextran].ovalue !=
                                                                            null
                                                                        ? GestureDetector(
                                                                            onTap:
                                                                                () {
                                                                              if (_TransModels[indextran].docno_in == '') {
                                                                                if (renTal_lavel > 1) {
                                                                                  print('123254 Edit');
                                                                                  showDialog<void>(
                                                                                    context: context,
                                                                                    barrierDismissible: false, // user must tap button!
                                                                                    builder: (BuildContext context) {
                                                                                      return AlertDialog(
                                                                                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
                                                                                        // title: const Text('AlertDialog Title'),
                                                                                        content: SingleChildScrollView(
                                                                                          child: ListBody(
                                                                                            children: <Widget>[
                                                                                              Container(
                                                                                                width: MediaQuery.of(context).size.width * 0.3,
                                                                                                height: MediaQuery.of(context).size.width * 0.08,
                                                                                                child: Center(
                                                                                                  child: Padding(
                                                                                                    padding: const EdgeInsets.all(8.0),
                                                                                                    child: Column(
                                                                                                      children: [
                                                                                                        Container(
                                                                                                          padding: const EdgeInsets.all(8.0),
                                                                                                          child: AutoSizeText(
                                                                                                            maxLines: 2,
                                                                                                            minFontSize: 8,
                                                                                                            // maxFontSize: 15,
                                                                                                            'แก้ไขเลขมิเตอร์เริ่มต้น',
                                                                                                            textAlign: TextAlign.start,
                                                                                                            style: const TextStyle(
                                                                                                                color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                                                                // fontWeight: FontWeight.bold,
                                                                                                                fontFamily: Font_.Fonts_T

                                                                                                                //fontSize: 10.0
                                                                                                                ),
                                                                                                          ),
                                                                                                        ),
                                                                                                        TextFormField(
                                                                                                          textAlign: TextAlign.center,
                                                                                                          // initialValue:
                                                                                                          //     _cmeter,
                                                                                                          onFieldSubmitted: (value) async {
                                                                                                            SharedPreferences preferences = await SharedPreferences.getInstance();
                                                                                                            String? ren = preferences.getString('renTalSer');
                                                                                                            String? ser_user = preferences.getString('ser');
                                                                                                            var qser_in = _TransModels[indextran].ser_in;
                                                                                                            var ovalue = _TransModels[indextran].ovalue;
                                                                                                            var qser = _cser;
                                                                                                            String url = '${MyConstant().domain}/UPC_Invoice_ovalue.php?isAdd=true&ren=$ren&qser_in=$qser_in&qty=$value&ser_user=$ser_user';

                                                                                                            try {
                                                                                                              var response = await http.get(Uri.parse(url));

                                                                                                              var result = json.decode(response.body);
                                                                                                              print(result);
                                                                                                              if (result.toString() == 'true') {
                                                                                                                Insert_log.Insert_logs('แก้ไขเลขมิเตอร์เริ่มต้น', 'แก้ไข $ovalue >> $value');
                                                                                                                setState(() {
                                                                                                                  red_Trans(_cser);
                                                                                                                });
                                                                                                              }
                                                                                                            } catch (e) {}
                                                                                                            Navigator.of(context).pop();
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
                                                                                                              labelText: 'แก้ไขเลขมิเตอร์เริ่มต้น',
                                                                                                              labelStyle: const TextStyle(
                                                                                                                  color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                                                                  // fontWeight: FontWeight.bold,
                                                                                                                  fontFamily: Font_.Fonts_T)),
                                                                                                          // inputFormatters: <TextInputFormatter>[
                                                                                                          //   // for below version 2 use this
                                                                                                          //   FilteringTextInputFormatter.allow(
                                                                                                          //       RegExp(r'[0-9]')),
                                                                                                          //   // for version 2 and greater youcan also use this
                                                                                                          //   FilteringTextInputFormatter
                                                                                                          //       .digitsOnly
                                                                                                          // ],
                                                                                                        ),
                                                                                                      ],
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            ],
                                                                                          ),
                                                                                        ),
                                                                                        actions: <Widget>[
                                                                                          Row(
                                                                                            mainAxisAlignment: MainAxisAlignment.end,
                                                                                            children: [
                                                                                              Container(
                                                                                                child: Padding(
                                                                                                  padding: const EdgeInsets.all(8.0),
                                                                                                  child: InkWell(
                                                                                                    child: Container(
                                                                                                        width: 100,
                                                                                                        decoration: const BoxDecoration(
                                                                                                          color: Colors.black,
                                                                                                          borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                                                                                                          // border: Border.all(color: Colors.white, width: 1),
                                                                                                        ),
                                                                                                        padding: const EdgeInsets.all(8.0),
                                                                                                        child: const Center(
                                                                                                            child: Text(
                                                                                                          'ปิด',
                                                                                                          textAlign: TextAlign.center,
                                                                                                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontFamily: FontWeight_.Fonts_T
                                                                                                              //fontSize: 10.0
                                                                                                              ),
                                                                                                        ))),
                                                                                                    onTap: () {
                                                                                                      Navigator.of(context).pop();
                                                                                                    },
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            ],
                                                                                          ),
                                                                                        ],
                                                                                      );
                                                                                    },
                                                                                  );
                                                                                }
                                                                              }
                                                                            },
                                                                            child:
                                                                                Container(
                                                                              decoration: BoxDecoration(
                                                                                color: Colors.grey.shade300,
                                                                                borderRadius: const BorderRadius.only(
                                                                                  topLeft: Radius.circular(15),
                                                                                  topRight: Radius.circular(15),
                                                                                  bottomLeft: Radius.circular(15),
                                                                                  bottomRight: Radius.circular(15),
                                                                                ),
                                                                                border: Border.all(color: Colors.grey, width: 1),
                                                                              ),
                                                                              padding: const EdgeInsets.all(8.0),
                                                                              child: Text(
                                                                                indextran == 0
                                                                                    ? '${_TransModels[indextran].ovalue!.padLeft(4, '0')}' // '${nFormat.format(double.parse(_TransModels[indextran].ovalue!))}'
                                                                                    //'${_TransModels[indextran].ovalue}'
                                                                                    : '${_TransModels[indextran - 1].nvalue!.padLeft(4, '0')}', //'${nFormat.format(double.parse(_TransModels[indextran - 1].nvalue!))}',
                                                                                // '${_TransModels[indextran - 1].nvalue}',
                                                                                textAlign: TextAlign.right,
                                                                                style: const TextStyle(
                                                                                    color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                                    //fontWeight: FontWeight.bold,
                                                                                    fontFamily: Font_.Fonts_T),
                                                                              ),
                                                                            ),
                                                                          )
                                                                        : TextFormField(
                                                                            textAlign:
                                                                                TextAlign.right,
                                                                            keyboardType:
                                                                                TextInputType.number,
                                                                            showCursor: indextran == 0
                                                                                ? _TransModels[indextran].ovalue == null
                                                                                    ? true
                                                                                    : false
                                                                                : false,
                                                                            readOnly: indextran == 0
                                                                                ? _TransModels[indextran].ovalue == null
                                                                                    ? false
                                                                                    : true
                                                                                : true,
                                                                            initialValue: indextran == 0
                                                                                ? _TransModels[indextran].ovalue
                                                                                : _TransModels[indextran - 1].nvalue,
                                                                            onFieldSubmitted:
                                                                                (value) async {
                                                                              if (indextran == 0) {
                                                                                if (_TransModels[indextran].ovalue == null) {
                                                                                  SharedPreferences preferences = await SharedPreferences.getInstance();
                                                                                  String? ren = preferences.getString('renTalSer');
                                                                                  String? ser_user = preferences.getString('ser');
                                                                                  var qser = _TransModels[indextran].ser;

                                                                                  var oval = '$_cnamex ${DateFormat.MMM('th_TH').format((DateTime.parse('${_TransModels[indextran].date} 00:00:00')))} ${DateTime.parse('${_TransModels[indextran].date} 00:00:00').year + 543}';
                                                                                  String url = '${MyConstant().domain}/InC_Invoice.php?isAdd=true&ren=$ren&qser=$qser&qty=$value&ser_user=$ser_user&oval=$oval&con_ser=$_cser';

                                                                                  try {
                                                                                    var response = await http.get(Uri.parse(url));

                                                                                    var result = json.decode(response.body);
                                                                                    print(result);
                                                                                    if (result.toString() != 'null') {
                                                                                      setState(() {
                                                                                        red_Trans(_cser);
                                                                                      });
                                                                                    }
                                                                                  } catch (e) {}
                                                                                }
                                                                              }
                                                                            },
                                                                            // cursorColor:
                                                                            //     Colors.black,
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
                                                                                labelStyle: const TextStyle(color: Colors.black54, fontFamily: Font_.Fonts_T)),
                                                                            inputFormatters: <TextInputFormatter>[
                                                                              // for below version 2 use this
                                                                              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                                                              // for version 2 and greater youcan also use this
                                                                              FilteringTextInputFormatter.digitsOnly
                                                                            ],
                                                                          )
                                                                    : Container(
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color: Colors
                                                                              .grey
                                                                              .shade300,
                                                                          borderRadius:
                                                                              const BorderRadius.only(
                                                                            topLeft:
                                                                                Radius.circular(15),
                                                                            topRight:
                                                                                Radius.circular(15),
                                                                            bottomLeft:
                                                                                Radius.circular(15),
                                                                            bottomRight:
                                                                                Radius.circular(15),
                                                                          ),
                                                                          border: Border.all(
                                                                              color: Colors.grey,
                                                                              width: 1),
                                                                        ),
                                                                        padding:
                                                                            const EdgeInsets.all(8.0),
                                                                        child:
                                                                            Text(
                                                                          indextran == 0
                                                                              ? '${_TransModels[indextran].ovalue!.padLeft(4, '0')}' //'${nFormat.format(double.parse(_TransModels[indextran].ovalue!))}'
                                                                              // '${_TransModels[indextran].ovalue}'
                                                                              : _TransModels[indextran - 1].nvalue == null
                                                                                  ? ''
                                                                                  : '${_TransModels[indextran - 1].nvalue!.padLeft(4, '0')}', // '${nFormat.format(double.parse(_TransModels[indextran - 1].nvalue!))}',
                                                                          //'${_TransModels[indextran - 1].nvalue}',
                                                                          textAlign:
                                                                              TextAlign.right,
                                                                          style: const TextStyle(
                                                                              color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                              //fontWeight: FontWeight.bold,
                                                                              fontFamily: Font_.Fonts_T),
                                                                        ),
                                                                      ),
                                                              ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: _cunitser != '6'
                                                            ? Text(
                                                                '$_cunit',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: const TextStyle(
                                                                    color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                    //fontWeight: FontWeight.bold,
                                                                    fontFamily: Font_.Fonts_T),
                                                              )
                                                            : _TransModels[indextran]
                                                                            .docno_in ==
                                                                        null ||
                                                                    _TransModels[indextran]
                                                                            .docno_in ==
                                                                        ''
                                                                ? Container(
                                                                    decoration:
                                                                        const BoxDecoration(
                                                                      // color: Colors.green,
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .only(
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
                                                                        const EdgeInsets.all(
                                                                            8.0),
                                                                    child:
                                                                        TextFormField(
                                                                      textAlign:
                                                                          TextAlign
                                                                              .right,
                                                                      keyboardType:
                                                                          TextInputType
                                                                              .number,
                                                                      showCursor: _TransModels[indextran].docno_in == null ||
                                                                              _TransModels[indextran].docno_in == ''
                                                                          ? true
                                                                          : false,
                                                                      //add this line
                                                                      readOnly: _TransModels[indextran].docno_in == null ||
                                                                              _TransModels[indextran].docno_in == ''
                                                                          ? false
                                                                          : true,

                                                                      initialValue:
                                                                          _TransModels[indextran]
                                                                              .nvalue,

                                                                      // controller: Form_nameshop,
                                                                      onFieldSubmitted:
                                                                          (value) async {
                                                                        if (indextran ==
                                                                            0) {
                                                                          SharedPreferences
                                                                              preferences =
                                                                              await SharedPreferences.getInstance();
                                                                          String?
                                                                              ren =
                                                                              preferences.getString('renTalSer');
                                                                          String?
                                                                              ser_user =
                                                                              preferences.getString('ser');

                                                                          var qser_in =
                                                                              _TransModels[indextran].ser_in;
                                                                          var tran_expser =
                                                                              _TransModels[indextran].expser;
                                                                          var qser_inn =
                                                                              _TransModels[indextran].ser_in;

                                                                          var tran_ser =
                                                                              _TransModels[indextran].ser;
                                                                          var tran_sern =
                                                                              _TransModels[indextran].ser;
                                                                          var ovalue =
                                                                              _TransModels[indextran].ovalue; // ก่อน
                                                                          var nvalue =
                                                                              _TransModels[indextran].nvalue; // หลัง
                                                                          _celvat; //vat
                                                                          _cqty_vat; // หน่วย

                                                                          print(
                                                                              'ovalue>>>. $ovalue  ---- nvalue>>>>>> $nvalue');

                                                                          String
                                                                              url =
                                                                              '${MyConstant().domain}/UPC_Invoice.php?isAdd=true&ren=$ren&qser_in=$qser_in&qty=$value&ser_user=$ser_user&ovalue=$ovalue&nvalue=$nvalue&_celvat=$_celvat&_cqty_vat=$_cqty_vat&con_ser=$_cser&tran_ser=$tran_ser&tran_sern=$tran_sern&qser_inn=$qser_inn&tran_expser=$tran_expser';

                                                                          try {
                                                                            var response =
                                                                                await http.get(Uri.parse(url));

                                                                            var result =
                                                                                json.decode(response.body);
                                                                            print(result);
                                                                            if (result.toString() !=
                                                                                'null') {
                                                                              setState(() {
                                                                                red_Trans(_cser);
                                                                              });
                                                                            }
                                                                          } catch (e) {}
                                                                        } else {
                                                                          if (_TransModels[indextran].ovalue ==
                                                                              null) {
                                                                            if (_TransModels[indextran].ovalue ==
                                                                                null) {
                                                                              SharedPreferences preferences = await SharedPreferences.getInstance();
                                                                              String? ren = preferences.getString('renTalSer');
                                                                              String? ser_user = preferences.getString('ser');

                                                                              var qser_in = _TransModels[indextran].ser_in; // ser in

                                                                              var tran_ser = _TransModels[indextran].ser; // ser tran
                                                                              var ovalue = _TransModels[indextran - 1].nvalue; // ก่อน
                                                                              var nvalue = _TransModels[indextran].nvalue; // หลัง
                                                                              _celvat; //vat
                                                                              _cqty_vat; // หน่วย
                                                                              print('1ovalue>>>. $ovalue  ---- nvalue>>>>>> $nvalue');
                                                                              var oval = '$_cnamex ${DateFormat.MMM('th_TH').format((DateTime.parse('${_TransModels[indextran].date} 00:00:00')))} ${DateTime.parse('${_TransModels[indextran].date} 00:00:00').year + 543}';
                                                                              String url = '${MyConstant().domain}/InC_InvoiceNew.php?isAdd=true&ren=$ren&tran_ser=$tran_ser&qty=$value&ser_user=$ser_user&oval=$oval&ovalue=$ovalue&nvalue=$nvalue&_celvat=$_celvat&_cqty_vat=$_cqty_vat&con_ser=$_cser';

                                                                              try {
                                                                                var response = await http.get(Uri.parse(url));

                                                                                var result = json.decode(response.body);
                                                                                print(result);
                                                                                if (result.toString() != 'null') {
                                                                                  setState(() {
                                                                                    red_Trans(_cser);
                                                                                  });
                                                                                }
                                                                              } catch (e) {}
                                                                            }
                                                                          } else {
                                                                            SharedPreferences
                                                                                preferences =
                                                                                await SharedPreferences.getInstance();
                                                                            String?
                                                                                ren =
                                                                                preferences.getString('renTalSer');
                                                                            String?
                                                                                ser_user =
                                                                                preferences.getString('ser');

                                                                            var qser_in =
                                                                                _TransModels[indextran].ser_in;
                                                                            var qser_inn =
                                                                                _TransModels[indextran].ser_in;
                                                                            var tran_expser =
                                                                                _TransModels[indextran].expser;
                                                                            var tran_sern =
                                                                                _TransModels[indextran].ser;
                                                                            var tran_ser =
                                                                                _TransModels[indextran].ser;
                                                                            var ovalue =
                                                                                _TransModels[indextran].ovalue; // ก่อน
                                                                            var nvalue =
                                                                                _TransModels[indextran].nvalue; // หลัง
                                                                            _celvat; //vat
                                                                            _cqty_vat; // หน่วย

                                                                            print('2ovalue>>>. $ovalue  --$value-- nvalue>>>>>> $nvalue ');

                                                                            if (double.parse(value) <
                                                                                double.parse(ovalue!)) {
                                                                              print('23ovalue>>>--$value-- น้อยกว่า  $ovalue');
                                                                              showDialog<void>(
                                                                                  context: context,
                                                                                  barrierDismissible: false, // user must tap button!
                                                                                  builder: (BuildContext context) {
                                                                                    return AlertDialog(
                                                                                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
                                                                                      // title: const Text('AlertDialog Title'),
                                                                                      content: SingleChildScrollView(
                                                                                        child: ListBody(
                                                                                          children: <Widget>[
                                                                                            Center(
                                                                                              child: Column(
                                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                                children: [
                                                                                                  Padding(
                                                                                                    padding: const EdgeInsets.all(8.0),
                                                                                                    child: Icon(
                                                                                                      Icons.report_problem,
                                                                                                      size: 50,
                                                                                                      color: Colors.yellow.shade800,
                                                                                                    ),
                                                                                                  ),
                                                                                                  Padding(
                                                                                                    padding: const EdgeInsets.all(8.0),
                                                                                                    child: Text(
                                                                                                      'เลขมิเตอร์น้อยกว่าเลขมิเตอร์ก่อนหน้า ต้องการเริ่มเลขมิเตอร์ใหม่',
                                                                                                      textAlign: TextAlign.center,
                                                                                                      style: TextStyle(color: PeopleChaoScreen_Color.Colors_Text1_, fontWeight: FontWeight.bold, fontFamily: FontWeight_.Fonts_T
                                                                                                          //fontSize: 10.0
                                                                                                          ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ],
                                                                                              ),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                      actions: <Widget>[
                                                                                        Row(
                                                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                                                          children: [
                                                                                            Expanded(
                                                                                              child: Container(
                                                                                                child: Padding(
                                                                                                  padding: const EdgeInsets.all(8.0),
                                                                                                  child: InkWell(
                                                                                                    child: Container(
                                                                                                        width: 100,
                                                                                                        decoration: BoxDecoration(
                                                                                                          color: Colors.green.shade900,
                                                                                                          borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                                                                                                          // border: Border.all(color: Colors.white, width: 1),
                                                                                                        ),
                                                                                                        padding: const EdgeInsets.all(8.0),
                                                                                                        child: const Center(
                                                                                                            child: Text(
                                                                                                          'ตกลง',
                                                                                                          textAlign: TextAlign.center,
                                                                                                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontFamily: FontWeight_.Fonts_T
                                                                                                              //fontSize: 10.0
                                                                                                              ),
                                                                                                        ))),
                                                                                                    onTap: () async {
                                                                                                      String url = '${MyConstant().domain}/UPC_Invoice.php?isAdd=true&ren=$ren&qser_in=$qser_in&qty=$value&ser_user=$ser_user&ovalue=$ovalue&nvalue=$nvalue&_celvat=$_celvat&_cqty_vat=$_cqty_vat&con_ser=$_cser&tran_ser=$tran_ser&tran_sern=$tran_sern&qser_inn=$qser_inn&tran_expser=$tran_expser';

                                                                                                      try {
                                                                                                        var response = await http.get(Uri.parse(url));

                                                                                                        var result = json.decode(response.body);
                                                                                                        print(result);
                                                                                                        if (result.toString() != 'null') {
                                                                                                          setState(() {
                                                                                                            Navigator.of(context).pop();
                                                                                                            red_Trans(_cser);
                                                                                                          });
                                                                                                        }
                                                                                                      } catch (e) {}
                                                                                                    },
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                            Expanded(
                                                                                              child: Container(
                                                                                                child: Padding(
                                                                                                  padding: const EdgeInsets.all(8.0),
                                                                                                  child: InkWell(
                                                                                                    child: Container(
                                                                                                        width: 100,
                                                                                                        decoration: const BoxDecoration(
                                                                                                          color: Colors.black,
                                                                                                          borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                                                                                                          // border: Border.all(color: Colors.white, width: 1),
                                                                                                        ),
                                                                                                        padding: const EdgeInsets.all(8.0),
                                                                                                        child: const Center(
                                                                                                            child: Text(
                                                                                                          'ปิด',
                                                                                                          textAlign: TextAlign.center,
                                                                                                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontFamily: FontWeight_.Fonts_T
                                                                                                              //fontSize: 10.0
                                                                                                              ),
                                                                                                        ))),
                                                                                                    onTap: () {
                                                                                                      Navigator.of(context).pop();
                                                                                                    },
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            )
                                                                                          ],
                                                                                        ),
                                                                                      ],
                                                                                    );
                                                                                  });
                                                                            } else {
                                                                              String url = '${MyConstant().domain}/UPC_Invoice.php?isAdd=true&ren=$ren&qser_in=$qser_in&qty=$value&ser_user=$ser_user&ovalue=$ovalue&nvalue=$nvalue&_celvat=$_celvat&_cqty_vat=$_cqty_vat&con_ser=$_cser&tran_ser=$tran_ser&tran_sern=$tran_sern&qser_inn=$qser_inn&tran_expser=$tran_expser';

                                                                              try {
                                                                                var response = await http.get(Uri.parse(url));

                                                                                var result = json.decode(response.body);
                                                                                print(result);
                                                                                if (result.toString() != 'null') {
                                                                                  setState(() {
                                                                                    red_Trans(_cser);
                                                                                  });
                                                                                }
                                                                              } catch (e) {}
                                                                            }

                                                                            // String
                                                                            //     url =
                                                                            //     '${MyConstant().domain}/UPC_Invoice.php?isAdd=true&ren=$ren&qser_in=$qser_in&qty=$value&ser_user=$ser_user&ovalue=$ovalue&nvalue=$nvalue&_celvat=$_celvat&_cqty_vat=$_cqty_vat&con_ser=$_cser&tran_ser=$tran_ser&tran_sern=$tran_sern&qser_inn=$qser_inn&tran_expser=$tran_expser';

                                                                            // try {
                                                                            //   var response =
                                                                            //       await http.get(Uri.parse(url));

                                                                            //   var result =
                                                                            //       json.decode(response.body);
                                                                            //   print(result);
                                                                            //   if (result.toString() !=
                                                                            //       'null') {
                                                                            //     setState(() {
                                                                            //       red_Trans(_cser);
                                                                            //     });
                                                                            //   }
                                                                            // } catch (e) {}
                                                                          }
                                                                        }
                                                                      },
                                                                      // cursorColor:
                                                                      //     Colors
                                                                      //         .green,
                                                                      decoration: InputDecoration(
                                                                          fillColor: Colors.white.withOpacity(0.3),
                                                                          filled: true,
                                                                          // prefixIcon:
                                                                          //     const Icon(Icons.person, color: Colors.black),
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
                                                                          // labelText: 'ระบุชื่อร้านค้า',
                                                                          labelStyle: const TextStyle(
                                                                              color: Colors.black54,

                                                                              //fontWeight: FontWeight.bold,
                                                                              fontFamily: Font_.Fonts_T)),
                                                                      inputFormatters: <TextInputFormatter>[
                                                                        // for below version 2 use this
                                                                        FilteringTextInputFormatter.allow(
                                                                            RegExp(r'[0-9]')),
                                                                        // for version 2 and greater youcan also use this
                                                                        FilteringTextInputFormatter
                                                                            .digitsOnly
                                                                      ],
                                                                    ),
                                                                  )
                                                                : Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            8.0),
                                                                    child:
                                                                        Container(
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: Colors
                                                                            .grey
                                                                            .shade300,
                                                                        borderRadius:
                                                                            const BorderRadius.only(
                                                                          topLeft:
                                                                              Radius.circular(15),
                                                                          topRight:
                                                                              Radius.circular(15),
                                                                          bottomLeft:
                                                                              Radius.circular(15),
                                                                          bottomRight:
                                                                              Radius.circular(15),
                                                                        ),
                                                                        border: Border.all(
                                                                            color:
                                                                                Colors.grey,
                                                                            width: 1),
                                                                      ),
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              8.0),
                                                                      child:
                                                                          Text(
                                                                        '${_TransModels[indextran].nvalue!.padLeft(4, '0')}', // '${nFormat.format(double.parse(_TransModels[indextran].nvalue!))}',
                                                                        // '${_TransModels[indextran].nvalue}',
                                                                        textAlign:
                                                                            TextAlign.right,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        style: const TextStyle(
                                                                            color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                            //fontWeight: FontWeight.bold,
                                                                            fontFamily: Font_.Fonts_T),
                                                                      ),
                                                                    ),
                                                                  ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Text(
                                                          '${nFormat.format(double.parse(_TransModels[indextran].qty5!))}',
                                                          // '${_TransModels[indextran].qty5}',
                                                          textAlign:
                                                              TextAlign.right,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style:
                                                              const TextStyle(
                                                                  color: PeopleChaoScreen_Color
                                                                      .Colors_Text2_,
                                                                  //fontWeight: FontWeight.bold,
                                                                  fontFamily: Font_
                                                                      .Fonts_T),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            setState(() {
                                                              electricityHistoryModels
                                                                  .clear();
                                                              unit1 = 0;
                                                              unit2 = 0;
                                                              unit3 = 0;
                                                              unit4 = 0;
                                                              unit5 = 0;
                                                              unit6 = 0;
                                                              sum1 = 0;
                                                              sum2 = 0;
                                                              sum3 = 0;
                                                              sum4 = 0;
                                                              sum5 = 0;
                                                              sum6 = 0;
                                                              unit = 0;
                                                              unit1c = 0;
                                                              unit2c = 0;
                                                              unit3c = 0;
                                                              unit4c = 0;
                                                              unit5c = 0;
                                                              unit6c = 0;
                                                              ele_tf = 0.0000;
                                                              ele_other = 0;
                                                              ele_vat = 0;
                                                              ele_one = 0;
                                                              ele_mit_one = 0;
                                                              ele_gob_one = 0;
                                                              ele_two = 0;
                                                              ele_mit_two = 0;
                                                              ele_gob_two = 0;
                                                              ele_three = 0;
                                                              ele_mit_three = 0;
                                                              ele_gob_three = 0;
                                                              ele_tour = 0;
                                                              ele_mit_tour = 0;
                                                              ele_gob_tour = 0;
                                                              ele_five = 0;
                                                              ele_mit_five = 0;
                                                              ele_gob_five = 0;
                                                              ele_six = 0;
                                                              ele_mit_six = 0;
                                                              ele_gob_six = 0;
                                                              sum = 0;
                                                              sum_n = 0;
                                                              sum_f = 0;
                                                              sum_per = 0;
                                                              sum_all = 0;
                                                            });
                                                            showmiter(
                                                                indextran);
                                                          },
                                                          child: Text(
                                                            '${nFormat.format(double.parse(_TransModels[indextran].amt!))}',
                                                            //  '${_TransModels[indextran].amt}',
                                                            textAlign:
                                                                TextAlign.right,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style:
                                                                const TextStyle(
                                                                    color: PeopleChaoScreen_Color
                                                                        .Colors_Text2_,
                                                                    //fontWeight: FontWeight.bold,
                                                                    fontFamily:
                                                                        Font_
                                                                            .Fonts_T),
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: (_TransModels[
                                                                        indextran]
                                                                    .docno_in !=
                                                                '')
                                                            ? SizedBox()
                                                            : Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .fromLTRB(
                                                                            15,
                                                                            8,
                                                                            15,
                                                                            8),
                                                                child: InkWell(
                                                                  child:
                                                                      Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Colors
                                                                              .green[
                                                                          300],
                                                                      borderRadius:
                                                                          const BorderRadius
                                                                              .only(
                                                                        topLeft:
                                                                            Radius.circular(15),
                                                                        topRight:
                                                                            Radius.circular(15),
                                                                        bottomLeft:
                                                                            Radius.circular(15),
                                                                        bottomRight:
                                                                            Radius.circular(15),
                                                                      ),
                                                                      border: Border.all(
                                                                          color: Colors
                                                                              .grey,
                                                                          width:
                                                                              1),
                                                                    ),
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            4.0),
                                                                    child: Text(
                                                                      (_TransModels[indextran].img == null ||
                                                                              _TransModels[indextran].img.toString() == '')
                                                                          ? 'ไม่พบหลักฐาน'
                                                                          : 'พบหลักฐาน',
                                                                      maxLines:
                                                                          1,
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style: const TextStyle(
                                                                          color: Colors
                                                                              .white,
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontFamily:
                                                                              FontWeight_.Fonts_T
                                                                          //fontSize: 10.0
                                                                          ),
                                                                    ),
                                                                  ),
                                                                  onTap: () {
                                                                    if (_TransModels
                                                                            .isEmpty ||
                                                                        _TransModels[indextran].img.toString() ==
                                                                            '' ||
                                                                        _TransModels[indextran].img ==
                                                                            null) {
                                                                      uploadFile_Slip(
                                                                          indextran);
                                                                    } else {
                                                                      showDialog(
                                                                        context:
                                                                            context,
                                                                        builder:
                                                                            (_) =>
                                                                                Dialog(
                                                                          child:
                                                                              SizedBox(
                                                                            // width: MediaQuery.of(context)
                                                                            //     .size
                                                                            //     .width,
                                                                            child: (_TransModels.isEmpty || _TransModels[indextran].img.toString() == '' || _TransModels[indextran].img == null)
                                                                                ? Center(child: Icon(Icons.image_not_supported))
                                                                                : Image.network(
                                                                                    // '${MyConstant().domain}/files/kad_taii/logo/${Img_logo_}',
                                                                                    '${MyConstant().domain}/files/$foder/Meter/${_TransModels[indextran].img}',
                                                                                    fit: BoxFit.cover,
                                                                                  ),
                                                                          ),
                                                                        ),
                                                                      );
                                                                    }
                                                                  },
                                                                )),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    Container(
                                      color: AppbackgroundColor.Sub_Abg_Colors,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            right: 10, left: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: const [
                                            AutoSizeText(
                                              maxLines: 1,
                                              minFontSize: 5,
                                              maxFontSize: 12,
                                              '* กด Enter ทุกครั้งที่มีการเปลี่ยนแปลงข้อมูลเพื่อบันทึกข้อมูล',
                                              textAlign: TextAlign.end,
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontFamily: Font_.Fonts_T
                                                  // fontWeight: FontWeight.bold,
                                                  //fontSize: 10.0
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ])),
                            ],
                          ),
                        ),
                      ),

                      Container(
                          width: (Responsive.isDesktop(context))
                              ? MediaQuery.of(context).size.width * 0.84
                              : MediaQuery.of(context).size.width,
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
                                        onTap: () {
                                          _scrollController1.animateTo(
                                            0,
                                            duration:
                                                const Duration(seconds: 1),
                                            curve: Curves.easeOut,
                                          );
                                        },
                                        child: Container(
                                            decoration: BoxDecoration(
                                              // color: AppbackgroundColor
                                              //     .TiTile_Colors,
                                              borderRadius:
                                                  const BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(6),
                                                      topRight:
                                                          Radius.circular(6),
                                                      bottomLeft:
                                                          Radius.circular(6),
                                                      bottomRight:
                                                          Radius.circular(8)),
                                              border: Border.all(
                                                  color: Colors.grey, width: 1),
                                            ),
                                            padding: const EdgeInsets.all(3.0),
                                            child: const Text(
                                              'Top',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 10.0,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T),
                                            )),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        if (_scrollController1.hasClients) {
                                          final position = _scrollController1
                                              .position.maxScrollExtent;
                                          _scrollController1.animateTo(
                                            position,
                                            duration:
                                                const Duration(seconds: 1),
                                            curve: Curves.easeOut,
                                          );
                                        }
                                      },
                                      child: Container(
                                          decoration: BoxDecoration(
                                            // color: AppbackgroundColor
                                            //     .TiTile_Colors,
                                            borderRadius:
                                                const BorderRadius.only(
                                                    topLeft: Radius.circular(6),
                                                    topRight:
                                                        Radius.circular(6),
                                                    bottomLeft:
                                                        Radius.circular(6),
                                                    bottomRight:
                                                        Radius.circular(6)),
                                            border: Border.all(
                                                color: Colors.grey, width: 1),
                                          ),
                                          padding: const EdgeInsets.all(3.0),
                                          child: const Text(
                                            'Down',
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 10.0,
                                                fontFamily:
                                                    FontWeight_.Fonts_T),
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
                                              fontFamily: FontWeight_.Fonts_T),
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

                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: Container(
                      //       width: MediaQuery.of(context).size.width / 2.8,
                      //       child: Column(children: [
                      //         Row(
                      //           children: [
                      //             Expanded(
                      //               flex: 4,
                      //               child: Container(
                      //                 height: 50,
                      //                 decoration: BoxDecoration(
                      //                   color: Colors.red[200],
                      //                   borderRadius: const BorderRadius.only(
                      //                     topLeft: Radius.circular(10),
                      //                     topRight: Radius.circular(10),
                      //                     bottomLeft: Radius.circular(0),
                      //                     bottomRight: Radius.circular(0),
                      //                   ),
                      //                   // border: Border.all(
                      //                   //     color: Colors.grey, width: 1),
                      //                 ),
                      //                 padding: const EdgeInsets.all(8.0),
                      //                 child: const Center(
                      //                   child: Text(
                      //                     'ไฟฟ้า',
                      //                     textAlign: TextAlign.center,
                      //                     style: TextStyle(
                      //                       color: Colors.black,
                      //                       fontWeight: FontWeight.bold,
                      //                       //fontSize: 10.0
                      //                     ),
                      //                   ),
                      //                 ),
                      //               ),
                      //             ),
                      //           ],
                      //         ),
                      //         Row(
                      //           children: [
                      //             Expanded(
                      //               flex: 1,
                      //               child: Container(
                      //                 height: 50,
                      //                 color: Colors.red[200],
                      //                 padding: const EdgeInsets.all(8.0),
                      //                 child: const Center(
                      //                   child: Text(
                      //                     'เดือน',
                      //                     textAlign: TextAlign.center,
                      //                     style: TextStyle(
                      //                       color: Colors.black,
                      //                       fontWeight: FontWeight.bold,
                      //                       //fontSize: 10.0
                      //                     ),
                      //                   ),
                      //                 ),
                      //               ),
                      //             ),
                      //             Expanded(
                      //               flex: 1,
                      //               child: Container(
                      //                 height: 50,
                      //                 color: Colors.red[200],
                      //                 padding: const EdgeInsets.all(8.0),
                      //                 child: const Center(
                      //                   child: Text(
                      //                     'เลขมิเตอร์(หน่วย)',
                      //                     textAlign: TextAlign.center,
                      //                     style: TextStyle(
                      //                       color: Colors.black,
                      //                       fontWeight: FontWeight.bold,
                      //                       //fontSize: 10.0
                      //                     ),
                      //                   ),
                      //                 ),
                      //               ),
                      //             ),
                      //             Expanded(
                      //               flex: 1,
                      //               child: Container(
                      //                 height: 50,
                      //                 color: Colors.red[200],
                      //                 padding: const EdgeInsets.all(8.0),
                      //                 child: const Center(
                      //                   child: Text(
                      //                     'ใช้ไป(หน่วย)',
                      //                     textAlign: TextAlign.center,
                      //                     style: TextStyle(
                      //                       color: Colors.black,
                      //                       fontWeight: FontWeight.bold,
                      //                       //fontSize: 10.0
                      //                     ),
                      //                   ),
                      //                 ),
                      //               ),
                      //             ),
                      //             Expanded(
                      //               flex: 1,
                      //               child: Container(
                      //                 height: 50,
                      //                 color: Colors.red[200],
                      //                 padding: const EdgeInsets.all(8.0),
                      //                 child: const Center(
                      //                   child: Text(
                      //                     'ยอดเงิน(บาท)',
                      //                     textAlign: TextAlign.center,
                      //                     style: TextStyle(
                      //                       color: Colors.black,
                      //                       fontWeight: FontWeight.bold,
                      //                       //fontSize: 10.0
                      //                     ),
                      //                   ),
                      //                 ),
                      //               ),
                      //             ),
                      //           ],
                      //         ),
                      //         Row(
                      //           children: [
                      //             Expanded(
                      //               flex: 1,
                      //               child: Container(
                      //                 height: 50,
                      //                 color: AppbackgroundColor.Sub_Abg_Colors,
                      //                 padding: const EdgeInsets.all(8.0),
                      //                 child: const Center(
                      //                   child: Text(
                      //                     'ยอดเริ่มต้น',
                      //                     textAlign: TextAlign.center,
                      //                     style: TextStyle(
                      //                       color: Colors.black,
                      //                       fontWeight: FontWeight.bold,
                      //                       //fontSize: 10.0
                      //                     ),
                      //                   ),
                      //                 ),
                      //               ),
                      //             ),
                      //             Expanded(
                      //               flex: 1,
                      //               child: Container(
                      //                 height: 50,
                      //                 color: AppbackgroundColor.Sub_Abg_Colors,
                      //                 padding: const EdgeInsets.all(8.0),
                      //                 child: const Center(
                      //                   child: Text(
                      //                     '70',
                      //                     textAlign: TextAlign.center,
                      //                     style: TextStyle(
                      //                       color: Colors.black,
                      //                       fontWeight: FontWeight.bold,
                      //                       //fontSize: 10.0
                      //                     ),
                      //                   ),
                      //                 ),
                      //               ),
                      //             ),
                      //             Expanded(
                      //               flex: 1,
                      //               child: Container(
                      //                 height: 50,
                      //                 color: AppbackgroundColor.Sub_Abg_Colors,
                      //                 padding: const EdgeInsets.all(8.0),
                      //                 child: const Center(
                      //                   child: Text(
                      //                     '0',
                      //                     textAlign: TextAlign.center,
                      //                     style: TextStyle(
                      //                       color: Colors.black,
                      //                       fontWeight: FontWeight.bold,
                      //                       //fontSize: 10.0
                      //                     ),
                      //                   ),
                      //                 ),
                      //               ),
                      //             ),
                      //             Expanded(
                      //               flex: 1,
                      //               child: Container(
                      //                 height: 50,
                      //                 color: AppbackgroundColor.Sub_Abg_Colors,
                      //                 padding: const EdgeInsets.all(8.0),
                      //                 child: const Center(
                      //                   child: Text(
                      //                     '0',
                      //                     textAlign: TextAlign.center,
                      //                     style: TextStyle(
                      //                       color: Colors.black,
                      //                       fontWeight: FontWeight.bold,
                      //                       //fontSize: 10.0
                      //                     ),
                      //                   ),
                      //                 ),
                      //               ),
                      //             ),
                      //           ],
                      //         ),
                      //         Container(
                      //           height: 200,
                      //           decoration: const BoxDecoration(
                      //             color: AppbackgroundColor.Sub_Abg_Colors,
                      //             borderRadius: BorderRadius.only(
                      //               topLeft: Radius.circular(0),
                      //               topRight: Radius.circular(0),
                      //               bottomLeft: Radius.circular(0),
                      //               bottomRight: Radius.circular(0),
                      //             ),
                      //             // border: Border.all(
                      //             //     color: Colors.grey, width: 1),
                      //           ),
                      //           child: ListView.builder(
                      //             controller: _scrollController1,
                      //             // itemExtent: 50,
                      //             physics: const NeverScrollableScrollPhysics(),
                      //             shrinkWrap: true,
                      //             itemCount: 12,
                      //             itemBuilder: (BuildContext context, int index) {
                      //               return ListTile(
                      //                 title: Row(
                      //                   children: [
                      //                     Expanded(
                      //                       flex: 1,
                      //                       child: Text(
                      //                         '${mont[index]}',
                      //                         textAlign: TextAlign.center,
                      //                         style: const TextStyle(
                      //                           color: TextHome_Color.TextHome_Colors,
                      //                           //fontWeight: FontWeight.bold,
                      //                           //fontSize: 10.0
                      //                         ),
                      //                       ),
                      //                     ),
                      //                     Expanded(
                      //                       flex: 1,
                      //                       child: Text(
                      //                         '${750 + index + 1}',
                      //                         textAlign: TextAlign.center,
                      //                         style: TextStyle(
                      //                           color: TextHome_Color.TextHome_Colors,
                      //                           //fontWeight: FontWeight.bold,
                      //                           //fontSize: 10.0
                      //                         ),
                      //                       ),
                      //                     ),
                      //                     Expanded(
                      //                       flex: 1,
                      //                       child: Text(
                      //                         '${230 + index + 1}',
                      //                         textAlign: TextAlign.center,
                      //                         style: TextStyle(
                      //                           color: TextHome_Color.TextHome_Colors,
                      //                           //fontWeight: FontWeight.bold,
                      //                           //fontSize: 10.0
                      //                         ),
                      //                       ),
                      //                     ),
                      //                     Expanded(
                      //                       flex: 1,
                      //                       child: Text(
                      //                         '${1386 + index + 1}',
                      //                         textAlign: TextAlign.center,
                      //                         style: TextStyle(
                      //                           color: TextHome_Color.TextHome_Colors,
                      //                           //fontWeight: FontWeight.bold,
                      //                           //fontSize: 10.0
                      //                         ),
                      //                       ),
                      //                     ),
                      //                   ],
                      //                 ),
                      //               );
                      //             },
                      //           ),
                      //         ),
                      //         Container(
                      //             width: MediaQuery.of(context).size.width,
                      //             decoration: const BoxDecoration(
                      //               color: AppbackgroundColor.Sub_Abg_Colors,
                      //               borderRadius: BorderRadius.only(
                      //                   topLeft: Radius.circular(0),
                      //                   topRight: Radius.circular(0),
                      //                   bottomLeft: Radius.circular(10),
                      //                   bottomRight: Radius.circular(10)),
                      //             ),
                      //             child: Row(
                      //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //               children: [
                      //                 Align(
                      //                   alignment: Alignment.centerLeft,
                      //                   child: Row(
                      //                     children: [
                      //                       Padding(
                      //                         padding: const EdgeInsets.all(8.0),
                      //                         child: InkWell(
                      //                           onTap: () {
                      //                             _scrollController1.animateTo(
                      //                               0,
                      //                               duration: const Duration(seconds: 1),
                      //                               curve: Curves.easeOut,
                      //                             );
                      //                           },
                      //                           child: Container(
                      //                               decoration: BoxDecoration(
                      //                                 // color: AppbackgroundColor
                      //                                 //     .TiTile_Colors,
                      //                                 borderRadius:
                      //                                     const BorderRadius.only(
                      //                                         topLeft: Radius.circular(6),
                      //                                         topRight:
                      //                                             Radius.circular(6),
                      //                                         bottomLeft:
                      //                                             Radius.circular(6),
                      //                                         bottomRight:
                      //                                             Radius.circular(8)),
                      //                                 border: Border.all(
                      //                                     color: Colors.grey, width: 1),
                      //                               ),
                      //                               padding: const EdgeInsets.all(3.0),
                      //                               child: const Text(
                      //                                 'Top',
                      //                                 style: TextStyle(
                      //                                     color: Colors.grey,
                      //                                     fontSize: 10.0),
                      //                               )),
                      //                         ),
                      //                       ),
                      //                       InkWell(
                      //                         onTap: () {
                      //                           if (_scrollController1.hasClients) {
                      //                             final position = _scrollController1
                      //                                 .position.maxScrollExtent;
                      //                             _scrollController1.animateTo(
                      //                               position,
                      //                               duration: const Duration(seconds: 1),
                      //                               curve: Curves.easeOut,
                      //                             );
                      //                           }
                      //                         },
                      //                         child: Container(
                      //                             decoration: BoxDecoration(
                      //                               // color: AppbackgroundColor
                      //                               //     .TiTile_Colors,
                      //                               borderRadius: const BorderRadius.only(
                      //                                   topLeft: Radius.circular(6),
                      //                                   topRight: Radius.circular(6),
                      //                                   bottomLeft: Radius.circular(6),
                      //                                   bottomRight: Radius.circular(6)),
                      //                               border: Border.all(
                      //                                   color: Colors.grey, width: 1),
                      //                             ),
                      //                             padding: const EdgeInsets.all(3.0),
                      //                             child: const Text(
                      //                               'Down',
                      //                               style: TextStyle(
                      //                                   color: Colors.grey,
                      //                                   fontSize: 10.0),
                      //                             )),
                      //                       ),
                      //                     ],
                      //                   ),
                      //                 ),
                      //                 Align(
                      //                   alignment: Alignment.centerRight,
                      //                   child: Row(
                      //                     children: [
                      //                       InkWell(
                      //                         onTap: _moveUp1,
                      //                         child: const Padding(
                      //                             padding: EdgeInsets.all(8.0),
                      //                             child: Align(
                      //                               alignment: Alignment.centerLeft,
                      //                               child: Icon(
                      //                                 Icons.arrow_upward,
                      //                                 color: Colors.grey,
                      //                               ),
                      //                             )),
                      //                       ),
                      //                       Container(
                      //                           decoration: BoxDecoration(
                      //                             // color: AppbackgroundColor
                      //                             //     .TiTile_Colors,
                      //                             borderRadius: const BorderRadius.only(
                      //                                 topLeft: Radius.circular(6),
                      //                                 topRight: Radius.circular(6),
                      //                                 bottomLeft: Radius.circular(6),
                      //                                 bottomRight: Radius.circular(6)),
                      //                             border: Border.all(
                      //                                 color: Colors.grey, width: 1),
                      //                           ),
                      //                           padding: const EdgeInsets.all(3.0),
                      //                           child: const Text(
                      //                             'Scroll',
                      //                             style: TextStyle(
                      //                                 color: Colors.grey, fontSize: 10.0),
                      //                           )),
                      //                       InkWell(
                      //                         onTap: _moveDown1,
                      //                         child: const Padding(
                      //                             padding: EdgeInsets.all(8.0),
                      //                             child: Align(
                      //                               alignment: Alignment.centerRight,
                      //                               child: Icon(
                      //                                 Icons.arrow_downward,
                      //                                 color: Colors.grey,
                      //                               ),
                      //                             )),
                      //                       ),
                      //                     ],
                      //                   ),
                      //                 )
                      //               ],
                      //             ))
                      //       ])),
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: Container(
                      //       width: MediaQuery.of(context).size.width / 2.5,
                      //       child: Column(children: [
                      //         Row(
                      //           children: [
                      //             Expanded(
                      //               flex: 4,
                      //               child: Container(
                      //                 height: 50,
                      //                 decoration: BoxDecoration(
                      //                   color: Colors.blue[200],
                      //                   borderRadius: const BorderRadius.only(
                      //                     topLeft: Radius.circular(10),
                      //                     topRight: Radius.circular(10),
                      //                     bottomLeft: Radius.circular(0),
                      //                     bottomRight: Radius.circular(0),
                      //                   ),
                      //                   // border: Border.all(
                      //                   //     color: Colors.grey, width: 1),
                      //                 ),
                      //                 padding: const EdgeInsets.all(8.0),
                      //                 child: const Center(
                      //                   child: Text(
                      //                     'น้ำ',
                      //                     textAlign: TextAlign.center,
                      //                     style: TextStyle(
                      //                       color: Colors.black,
                      //                       fontWeight: FontWeight.bold,
                      //                       //fontSize: 10.0
                      //                     ),
                      //                   ),
                      //                 ),
                      //               ),
                      //             ),
                      //           ],
                      //         ),
                      //         Row(
                      //           children: [
                      //             Expanded(
                      //               flex: 1,
                      //               child: Container(
                      //                 height: 50,
                      //                 color: Colors.blue[200],
                      //                 padding: const EdgeInsets.all(8.0),
                      //                 child: const Center(
                      //                   child: Text(
                      //                     'เดือน',
                      //                     textAlign: TextAlign.center,
                      //                     style: TextStyle(
                      //                       color: Colors.black,
                      //                       fontWeight: FontWeight.bold,
                      //                       //fontSize: 10.0
                      //                     ),
                      //                   ),
                      //                 ),
                      //               ),
                      //             ),
                      //             Expanded(
                      //               flex: 1,
                      //               child: Container(
                      //                 height: 50,
                      //                 color: Colors.blue[200],
                      //                 padding: const EdgeInsets.all(8.0),
                      //                 child: const Center(
                      //                   child: Text(
                      //                     'เลขมิเตอร์(หน่วย)',
                      //                     textAlign: TextAlign.center,
                      //                     style: TextStyle(
                      //                       color: Colors.black,
                      //                       fontWeight: FontWeight.bold,
                      //                       //fontSize: 10.0
                      //                     ),
                      //                   ),
                      //                 ),
                      //               ),
                      //             ),
                      //             Expanded(
                      //               flex: 1,
                      //               child: Container(
                      //                 height: 50,
                      //                 color: Colors.blue[200],
                      //                 padding: const EdgeInsets.all(8.0),
                      //                 child: const Center(
                      //                   child: Text(
                      //                     'ใช้ไป(หน่วย)',
                      //                     textAlign: TextAlign.center,
                      //                     style: TextStyle(
                      //                       color: Colors.black,
                      //                       fontWeight: FontWeight.bold,
                      //                       //fontSize: 10.0
                      //                     ),
                      //                   ),
                      //                 ),
                      //               ),
                      //             ),
                      //             Expanded(
                      //               flex: 1,
                      //               child: Container(
                      //                 height: 50,
                      //                 color: Colors.blue[200],
                      //                 padding: const EdgeInsets.all(8.0),
                      //                 child: const Center(
                      //                   child: Text(
                      //                     'ยอดเงิน(บาท)',
                      //                     textAlign: TextAlign.center,
                      //                     style: TextStyle(
                      //                       color: Colors.black,
                      //                       fontWeight: FontWeight.bold,
                      //                       //fontSize: 10.0
                      //                     ),
                      //                   ),
                      //                 ),
                      //               ),
                      //             ),
                      //           ],
                      //         ),
                      //         Row(
                      //           children: [
                      //             Expanded(
                      //               flex: 1,
                      //               child: Container(
                      //                 height: 50,
                      //                 color: AppbackgroundColor.Sub_Abg_Colors,
                      //                 padding: const EdgeInsets.all(8.0),
                      //                 child: const Center(
                      //                   child: Text(
                      //                     'ยอดเริ่มต้น',
                      //                     textAlign: TextAlign.center,
                      //                     style: TextStyle(
                      //                       color: Colors.black,
                      //                       fontWeight: FontWeight.bold,
                      //                       //fontSize: 10.0
                      //                     ),
                      //                   ),
                      //                 ),
                      //               ),
                      //             ),
                      //             Expanded(
                      //               flex: 1,
                      //               child: Container(
                      //                 height: 50,
                      //                 color: AppbackgroundColor.Sub_Abg_Colors,
                      //                 padding: const EdgeInsets.all(8.0),
                      //                 child: const Center(
                      //                   child: Text(
                      //                     '70',
                      //                     textAlign: TextAlign.center,
                      //                     style: TextStyle(
                      //                       color: Colors.black,
                      //                       fontWeight: FontWeight.bold,
                      //                       //fontSize: 10.0
                      //                     ),
                      //                   ),
                      //                 ),
                      //               ),
                      //             ),
                      //             Expanded(
                      //               flex: 1,
                      //               child: Container(
                      //                 height: 50,
                      //                 color: AppbackgroundColor.Sub_Abg_Colors,
                      //                 padding: const EdgeInsets.all(8.0),
                      //                 child: const Center(
                      //                   child: Text(
                      //                     '0',
                      //                     textAlign: TextAlign.center,
                      //                     style: TextStyle(
                      //                       color: Colors.black,
                      //                       fontWeight: FontWeight.bold,
                      //                       //fontSize: 10.0
                      //                     ),
                      //                   ),
                      //                 ),
                      //               ),
                      //             ),
                      //             Expanded(
                      //               flex: 1,
                      //               child: Container(
                      //                 height: 50,
                      //                 color: AppbackgroundColor.Sub_Abg_Colors,
                      //                 padding: const EdgeInsets.all(8.0),
                      //                 child: const Center(
                      //                   child: Text(
                      //                     '0',
                      //                     textAlign: TextAlign.center,
                      //                     style: TextStyle(
                      //                       color: Colors.black,
                      //                       fontWeight: FontWeight.bold,
                      //                       //fontSize: 10.0
                      //                     ),
                      //                   ),
                      //                 ),
                      //               ),
                      //             ),
                      //           ],
                      //         ),
                      //         Container(
                      //           height: 200,
                      //           decoration: const BoxDecoration(
                      //             color: AppbackgroundColor.Sub_Abg_Colors,
                      //             borderRadius: BorderRadius.only(
                      //               topLeft: Radius.circular(0),
                      //               topRight: Radius.circular(0),
                      //               bottomLeft: Radius.circular(0),
                      //               bottomRight: Radius.circular(0),
                      //             ),
                      //             // border: Border.all(
                      //             //     color: Colors.grey, width: 1),
                      //           ),
                      //           child: ListView.builder(
                      //             controller: _scrollController2,
                      //             // itemExtent: 50,
                      //             physics: const NeverScrollableScrollPhysics(),
                      //             shrinkWrap: true,
                      //             itemCount: 12,
                      //             itemBuilder: (BuildContext context, int index) {
                      //               return ListTile(
                      //                 title: Row(
                      //                   children: [
                      //                     Expanded(
                      //                       flex: 1,
                      //                       child: Text(
                      //                         '${mont[index]}',
                      //                         textAlign: TextAlign.center,
                      //                         style: const TextStyle(
                      //                           color: TextHome_Color.TextHome_Colors,
                      //                           //fontWeight: FontWeight.bold,
                      //                           //fontSize: 10.0
                      //                         ),
                      //                       ),
                      //                     ),
                      //                     Expanded(
                      //                       flex: 1,
                      //                       child: Text(
                      //                         '${70 + index + 1}',
                      //                         textAlign: TextAlign.center,
                      //                         style: TextStyle(
                      //                           color: TextHome_Color.TextHome_Colors,
                      //                           //fontWeight: FontWeight.bold,
                      //                           //fontSize: 10.0
                      //                         ),
                      //                       ),
                      //                     ),
                      //                     Expanded(
                      //                       flex: 1,
                      //                       child: Text(
                      //                         '${83 + index + 1}',
                      //                         textAlign: TextAlign.center,
                      //                         style: TextStyle(
                      //                           color: TextHome_Color.TextHome_Colors,
                      //                           //fontWeight: FontWeight.bold,
                      //                           //fontSize: 10.0
                      //                         ),
                      //                       ),
                      //                     ),
                      //                     Expanded(
                      //                       flex: 1,
                      //                       child: Text(
                      //                         '${390 + index + 1}',
                      //                         textAlign: TextAlign.center,
                      //                         style: TextStyle(
                      //                           color: TextHome_Color.TextHome_Colors,
                      //                           //fontWeight: FontWeight.bold,
                      //                           //fontSize: 10.0
                      //                         ),
                      //                       ),
                      //                     ),
                      //                   ],
                      //                 ),
                      //               );
                      //             },
                      //           ),
                      //         ),
                      //         Container(
                      //             width: MediaQuery.of(context).size.width,
                      //             decoration: const BoxDecoration(
                      //               color: AppbackgroundColor.Sub_Abg_Colors,
                      //               borderRadius: BorderRadius.only(
                      //                   topLeft: Radius.circular(0),
                      //                   topRight: Radius.circular(0),
                      //                   bottomLeft: Radius.circular(10),
                      //                   bottomRight: Radius.circular(10)),
                      //             ),
                      //             child: Row(
                      //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //               children: [
                      //                 Align(
                      //                   alignment: Alignment.centerLeft,
                      //                   child: Row(
                      //                     children: [
                      //                       Padding(
                      //                         padding: const EdgeInsets.all(8.0),
                      //                         child: InkWell(
                      //                           onTap: () {
                      //                             _scrollController2.animateTo(
                      //                               0,
                      //                               duration: const Duration(seconds: 1),
                      //                               curve: Curves.easeOut,
                      //                             );
                      //                           },
                      //                           child: Container(
                      //                               decoration: BoxDecoration(
                      //                                 // color: AppbackgroundColor
                      //                                 //     .TiTile_Colors,
                      //                                 borderRadius:
                      //                                     const BorderRadius.only(
                      //                                         topLeft: Radius.circular(6),
                      //                                         topRight:
                      //                                             Radius.circular(6),
                      //                                         bottomLeft:
                      //                                             Radius.circular(6),
                      //                                         bottomRight:
                      //                                             Radius.circular(8)),
                      //                                 border: Border.all(
                      //                                     color: Colors.grey, width: 1),
                      //                               ),
                      //                               padding: const EdgeInsets.all(3.0),
                      //                               child: const Text(
                      //                                 'Top',
                      //                                 style: TextStyle(
                      //                                     color: Colors.grey,
                      //                                     fontSize: 10.0),
                      //                               )),
                      //                         ),
                      //                       ),
                      //                       InkWell(
                      //                         onTap: () {
                      //                           if (_scrollController2.hasClients) {
                      //                             final position = _scrollController2
                      //                                 .position.maxScrollExtent;
                      //                             _scrollController2.animateTo(
                      //                               position,
                      //                               duration: const Duration(seconds: 1),
                      //                               curve: Curves.easeOut,
                      //                             );
                      //                           }
                      //                         },
                      //                         child: Container(
                      //                             decoration: BoxDecoration(
                      //                               // color: AppbackgroundColor
                      //                               //     .TiTile_Colors,
                      //                               borderRadius: const BorderRadius.only(
                      //                                   topLeft: Radius.circular(6),
                      //                                   topRight: Radius.circular(6),
                      //                                   bottomLeft: Radius.circular(6),
                      //                                   bottomRight: Radius.circular(6)),
                      //                               border: Border.all(
                      //                                   color: Colors.grey, width: 1),
                      //                             ),
                      //                             padding: const EdgeInsets.all(3.0),
                      //                             child: const Text(
                      //                               'Down',
                      //                               style: TextStyle(
                      //                                   color: Colors.grey,
                      //                                   fontSize: 10.0),
                      //                             )),
                      //                       ),
                      //                     ],
                      //                   ),
                      //                 ),
                      //                 Align(
                      //                   alignment: Alignment.centerRight,
                      //                   child: Row(
                      //                     children: [
                      //                       InkWell(
                      //                         onTap: _moveUp2,
                      //                         child: const Padding(
                      //                             padding: EdgeInsets.all(8.0),
                      //                             child: Align(
                      //                               alignment: Alignment.centerLeft,
                      //                               child: Icon(
                      //                                 Icons.arrow_upward,
                      //                                 color: Colors.grey,
                      //                               ),
                      //                             )),
                      //                       ),
                      //                       Container(
                      //                           decoration: BoxDecoration(
                      //                             // color: AppbackgroundColor
                      //                             //     .TiTile_Colors,
                      //                             borderRadius: const BorderRadius.only(
                      //                                 topLeft: Radius.circular(6),
                      //                                 topRight: Radius.circular(6),
                      //                                 bottomLeft: Radius.circular(6),
                      //                                 bottomRight: Radius.circular(6)),
                      //                             border: Border.all(
                      //                                 color: Colors.grey, width: 1),
                      //                           ),
                      //                           padding: const EdgeInsets.all(3.0),
                      //                           child: const Text(
                      //                             'Scroll',
                      //                             style: TextStyle(
                      //                                 color: Colors.grey, fontSize: 10.0),
                      //                           )),
                      //                       InkWell(
                      //                         onTap: _moveDown2,
                      //                         child: const Padding(
                      //                             padding: EdgeInsets.all(8.0),
                      //                             child: Align(
                      //                               alignment: Alignment.centerRight,
                      //                               child: Icon(
                      //                                 Icons.arrow_downward,
                      //                                 color: Colors.grey,
                      //                               ),
                      //                             )),
                      //                       ),
                      //                     ],
                      //                   ),
                      //                 )
                      //               ],
                      //             ))
                      //       ])),
                      // ),
                    ],
                  ),
            // SizedBox(
            //   height: 20,
            // ),
            // InkWell(
            //   onTap: () {},
            //   child: Container(
            //     width: 200,
            //     decoration: BoxDecoration(
            //       color: Colors.green,
            //       borderRadius: const BorderRadius.only(
            //           topLeft: Radius.circular(10),
            //           topRight: Radius.circular(10),
            //           bottomLeft: Radius.circular(10),
            //           bottomRight: Radius.circular(10)),
            //       border: Border.all(color: Colors.grey, width: 1),
            //     ),
            //     padding: const EdgeInsets.all(8.0),
            //     child: Center(
            //       child: const AutoSizeText(
            //         minFontSize: 10,
            //         maxFontSize: 15,
            //         'บันทึกและตั้งหนี้',
            //         style: TextStyle(
            //             color: PeopleChaoScreen_Color.Colors_Text1_,
            //             fontWeight: FontWeight.bold,
            //             fontFamily: FontWeight_.Fonts_T
            //             //fontSize: 10.0
            //             //0953873075
            //             ),
            //       ),
            //     ),
            //   ),
            // ),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }

  double unit1 = 0,
      unit2 = 0,
      unit3 = 0,
      unit4 = 0,
      unit5 = 0,
      unit6 = 0,
      sum1 = 0,
      sum2 = 0,
      sum3 = 0,
      sum4 = 0,
      sum5 = 0,
      sum6 = 0,
      unit = 0,
      unit1c = 0,
      unit2c = 0,
      unit3c = 0,
      unit4c = 0,
      unit5c = 0,
      unit6c = 0,
      ele_tf = 0.0000,
      ele_other = 0,
      ele_vat = 0,
      ele_one = 0,
      ele_mit_one = 0,
      ele_gob_one = 0,
      ele_two = 0,
      ele_mit_two = 0,
      ele_gob_two = 0,
      ele_three = 0,
      ele_mit_three = 0,
      ele_gob_three = 0,
      ele_tour = 0,
      ele_mit_tour = 0,
      ele_gob_tour = 0,
      ele_five = 0,
      ele_mit_five = 0,
      ele_gob_five = 0,
      ele_six = 0,
      ele_mit_six = 0,
      ele_gob_six = 0,
      sum = 0,
      sum_n = 0,
      sum_f = 0,
      sum_per = 0,
      sum_all = 0;

  Future<dynamic> showmiter(int indextran) async {
    var qser_in = _TransModels[indextran].ser_in;

    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    String url =
        '${MyConstant().domain}/GC_electricity_history.php?isAdd=true&ren=$ren&qser_in=$qser_in';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print(result);
      if (result != null) {
        for (var map in result) {
          ElectricityHistoryModel electricityHistoryModel =
              ElectricityHistoryModel.fromJson(map);
          setState(() {
            electricityHistoryModels.add(electricityHistoryModel);
          });
        }
      } else {}
    } catch (e) {}

    if (electricityHistoryModels.isEmpty) {
      return null;
    } else {
      setState(() {
        unit = double.parse(electricityHistoryModels[0].edit_new!);

        unit1c = double.parse(electricityHistoryModels[0].eleOne!) - 0;
        unit2c = double.parse(electricityHistoryModels[0].eleTwo!) -
            double.parse(electricityHistoryModels[0].eleOne!);
        unit3c = double.parse(electricityHistoryModels[0].eleThree!) -
            double.parse(electricityHistoryModels[0].eleTwo!);
        unit4c = double.parse(electricityHistoryModels[0].eleTour!) -
            double.parse(electricityHistoryModels[0].eleThree!);
        unit5c = double.parse(electricityHistoryModels[0].eleFive!) -
            double.parse(electricityHistoryModels[0].eleTour!);
        unit6c = unit - double.parse(electricityHistoryModels[0].eleSix!);

        ele_tf = double.parse(electricityHistoryModels[0].eleTf!);
        ele_other = double.parse(electricityHistoryModels[0].other!);
        ele_vat = double.parse(electricityHistoryModels[0].vat!);

        ele_one = double.parse(electricityHistoryModels[0].eleOne!);
        ele_mit_one = double.parse(electricityHistoryModels[0].eleMitOne!);
        ele_gob_one = double.parse(electricityHistoryModels[0].eleGobOne!);

        ele_two = double.parse(electricityHistoryModels[0].eleTwo!);
        ele_mit_two = double.parse(electricityHistoryModels[0].eleMitTwo!);
        ele_gob_two = double.parse(electricityHistoryModels[0].eleGobTwo!);

        ele_three = double.parse(electricityHistoryModels[0].eleThree!);
        ele_mit_three = double.parse(electricityHistoryModels[0].eleMitThree!);
        ele_gob_three = double.parse(electricityHistoryModels[0].eleGobThree!);

        ele_tour = double.parse(electricityHistoryModels[0].eleTour!);
        ele_mit_tour = double.parse(electricityHistoryModels[0].eleMitTour!);
        ele_gob_tour = double.parse(electricityHistoryModels[0].eleGobTour!);

        ele_five = double.parse(electricityHistoryModels[0].eleFive!);
        ele_mit_five = double.parse(electricityHistoryModels[0].eleMitFive!);
        ele_gob_five = double.parse(electricityHistoryModels[0].eleGobFive!);

        ele_six = double.parse(electricityHistoryModels[0].eleSix!);
        ele_mit_six = double.parse(electricityHistoryModels[0].eleMitSix!);
        ele_gob_six = double.parse(electricityHistoryModels[0].eleGobSix!);
      });

      if (unit > unit1c) {
        setState(() {
          unit1 = unit - unit1c;
        });

        if (ele_gob_one != 0.00) {
          setState(() {
            sum1 = ele_gob_one;
          });
        } else {
          setState(() {
            sum1 = unit1c * ele_mit_one;
          });
        }
      } else {
        if (ele_gob_one != 0.00) {
          setState(() {
            sum1 = ele_gob_one;
          });
        } else {
          setState(() {
            sum1 = unit * ele_mit_one;
          });
        }
      }

      if (unit1 >= unit2c) {
        setState(() {
          unit2 = unit1 - unit2c;
        });

        if (ele_gob_two != 0.00) {
          setState(() {
            sum2 = ele_gob_two;
          });
        } else {
          setState(() {
            sum2 = unit2c * ele_mit_two;
          });
        }
      } else {
        if (ele_gob_two != 0.00) {
          setState(() {
            sum2 = ele_gob_two;
          });
        } else {
          setState(() {
            sum2 = unit1 * ele_mit_two;
          });
        }
      }

      if (unit2 >= unit3c) {
        setState(() {
          unit3 = unit2 - unit3c;
        });
        if (ele_gob_three != 0.00) {
          setState(() {
            sum3 = ele_gob_three;
          });
        } else {
          setState(() {
            sum3 = unit3c * ele_mit_three;
          });
        }
      } else {
        if (ele_gob_three != 0.00) {
          setState(() {
            sum3 = ele_gob_three;
          });
        } else {
          setState(() {
            sum3 = unit2 * ele_mit_three;
          });
        }
      }

      if (unit3 >= unit4c) {
        setState(() {
          unit4 = unit3 - unit4c;
        });

        if (ele_gob_tour != 0.00) {
          setState(() {
            sum4 = ele_gob_tour;
          });
        } else {
          setState(() {
            sum4 = unit4c * ele_mit_tour;
          });
        }
      } else {
        if (ele_gob_tour != 0.00) {
          setState(() {
            sum4 = ele_gob_tour;
          });
        } else {
          setState(() {
            sum4 = unit3 * ele_mit_tour;
          });
        }
      }

      if (unit4 >= unit5c) {
        setState(() {
          unit5 = unit4 - unit5c;
        });

        if (ele_gob_five != 0.00) {
          setState(() {
            sum5 = ele_gob_five;
          });
        } else {
          setState(() {
            sum5 = unit5c * ele_mit_five;
          });
        }
      } else {
        if (ele_gob_five != 0.00) {
          setState(() {
            sum5 = ele_gob_five;
          });
        } else {
          setState(() {
            sum5 = unit4 * ele_mit_five;
          });
        }
      }

      if (unit5 >= unit6c) {
        setState(() {
          unit6 = unit5 - unit6c;
        });

        if (ele_gob_six != 0.00) {
          setState(() {
            sum6 = ele_gob_six;
          });
        } else {
          setState(() {
            sum6 = unit6c * ele_mit_six;
          });
        }
      } else {
        if (ele_gob_six != 0.00) {
          setState(() {
            sum6 = ele_gob_six;
          });
        } else {
          setState(() {
            sum6 = unit5 * ele_mit_six;
          });
        }
      }

      // if (unit5 >= unit6c) {
      //   if (ele_gob_six != 0.00) {
      //     setState(() {
      //       sum6 = ele_gob_six;
      //     });
      //   } else {
      //     setState(() {
      //       sum6 = unit6c * ele_mit_six;
      //     });
      //   }
      // }
      setState(() {
        if (sum6 < 0) {
          sum = sum1 + sum2 + sum3 + sum4 + sum5;
        } else {
          sum = sum1 + sum2 + sum3 + sum4 + sum5 + sum6;
        }
      });
      setState(() {
        sum_n = sum + ele_other;
      });
      setState(() {
        sum_f = unit * ele_tf;
      });
      setState(() {
        sum_per = (sum_n + sum_f) * ele_vat / 100;
      });
      setState(() {
        sum_all = sum_n + sum_f + sum_per;
      });

      return showDialog(
          context: context,
          builder: (_) {
            return Dialog(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.width * 0.4,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Text(
                                // ignore: unnecessary_string_interpolations
                                '${DateFormat.MMMM('th_TH').format((DateTime.parse('${_TransModels[indextran].date} 00:00:00')))} ${DateTime.parse('${_TransModels[indextran].date} 00:00:00').year + 543}',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: PeopleChaoScreen_Color.Colors_Text2_,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                    fontFamily: Font_.Fonts_T),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Divider(),
                      Row(
                        children: [
                          Expanded(
                            flex: 4,
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Text(
                                '',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: PeopleChaoScreen_Color.Colors_Text2_,
                                    fontFamily: Font_.Fonts_T),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Text(
                                '${_TransModels[indextran].ser} หน่วยที่ใช้ไป : ',
                                textAlign: TextAlign.end,
                                style: const TextStyle(
                                    color: PeopleChaoScreen_Color.Colors_Text2_,
                                    fontFamily: Font_.Fonts_T),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Text(
                                '$unit',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: PeopleChaoScreen_Color.Colors_Text2_,
                                    fontFamily: Font_.Fonts_T),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Text(
                                'หน่วย',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: PeopleChaoScreen_Color.Colors_Text2_,
                                    fontFamily: Font_.Fonts_T),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Divider(),
                      (unit - unit1) == 0 || sum1 <= 0
                          ? SizedBox()
                          : Row(
                              children: [
                                Expanded(flex: 1, child: Text('')),
                                Expanded(
                                  flex: 4,
                                  child: RichText(
                                    textAlign: TextAlign.start,
                                    text: TextSpan(
                                      text: 'หน่วยที่ 0-$ele_one',
                                      style: TextStyle(
                                          color: PeopleChaoScreen_Color
                                              .Colors_Text2_,
                                          fontFamily: Font_.Fonts_T),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: ele_mit_one == 0
                                              ? ' (เหมาจ่าย $ele_gob_one บาท)'
                                              : ' (หน่วยละ $ele_mit_one บาท)',
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontFamily: Font_.Fonts_T),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    '${unit - unit1} หน่วย',
                                    textAlign: TextAlign.start,
                                    style: const TextStyle(
                                        color: PeopleChaoScreen_Color
                                            .Colors_Text2_,
                                        fontFamily: Font_.Fonts_T),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    '${nFormat.format(sum1)}',
                                    textAlign: TextAlign.end,
                                    style: const TextStyle(
                                        color: PeopleChaoScreen_Color
                                            .Colors_Text2_,
                                        fontFamily: Font_.Fonts_T),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    'บาท',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        color: PeopleChaoScreen_Color
                                            .Colors_Text2_,
                                        fontFamily: Font_.Fonts_T),
                                  ),
                                ),
                              ],
                            ),
                      SizedBox(
                        height: 10,
                      ),
                      (unit1 - unit2) == 0 || sum2 <= 0
                          ? SizedBox()
                          : Row(
                              children: [
                                Expanded(flex: 1, child: Text('')),
                                Expanded(
                                  flex: 4,
                                  child: RichText(
                                    textAlign: TextAlign.start,
                                    text: TextSpan(
                                      text:
                                          'หน่วยที่ ${(ele_one + 1)} - $ele_two',
                                      style: TextStyle(
                                          color: PeopleChaoScreen_Color
                                              .Colors_Text2_,
                                          fontFamily: Font_.Fonts_T),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: ele_mit_two == 0
                                              ? ' (เหมาจ่าย $ele_gob_two บาท)'
                                              : ' (หน่วยละ $ele_mit_two บาท)',
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontFamily: Font_.Fonts_T),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    '${unit1 - unit2} หน่วย',
                                    textAlign: TextAlign.start,
                                    style: const TextStyle(
                                        color: PeopleChaoScreen_Color
                                            .Colors_Text2_,
                                        fontFamily: Font_.Fonts_T),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    '${nFormat.format(sum2)}',
                                    textAlign: TextAlign.end,
                                    style: const TextStyle(
                                        color: PeopleChaoScreen_Color
                                            .Colors_Text2_,
                                        fontFamily: Font_.Fonts_T),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    'บาท',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        color: PeopleChaoScreen_Color
                                            .Colors_Text2_,
                                        fontFamily: Font_.Fonts_T),
                                  ),
                                ),
                              ],
                            ),
                      SizedBox(
                        height: 10,
                      ),
                      (unit2 - unit3) == 0 || sum3 <= 0
                          ? SizedBox()
                          : Row(
                              children: [
                                Expanded(flex: 1, child: Text('')),
                                Expanded(
                                  flex: 4,
                                  child: RichText(
                                    textAlign: TextAlign.start,
                                    text: TextSpan(
                                      text:
                                          'หน่วยที่ ${(ele_two + 1)} - $ele_three',
                                      style: TextStyle(
                                          color: PeopleChaoScreen_Color
                                              .Colors_Text2_,
                                          fontFamily: Font_.Fonts_T),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: ele_mit_three == 0
                                              ? ' (เหมาจ่าย $ele_gob_three บาท)'
                                              : ' (หน่วยละ $ele_mit_three บาท)',
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontFamily: Font_.Fonts_T),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    '${unit2 - unit3} หน่วย',
                                    textAlign: TextAlign.start,
                                    style: const TextStyle(
                                        color: PeopleChaoScreen_Color
                                            .Colors_Text2_,
                                        fontFamily: Font_.Fonts_T),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    '${nFormat.format(sum3)}',
                                    textAlign: TextAlign.end,
                                    style: const TextStyle(
                                        color: PeopleChaoScreen_Color
                                            .Colors_Text2_,
                                        fontFamily: Font_.Fonts_T),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    'บาท',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        color: PeopleChaoScreen_Color
                                            .Colors_Text2_,
                                        fontFamily: Font_.Fonts_T),
                                  ),
                                ),
                              ],
                            ),
                      SizedBox(
                        height: 10,
                      ),
                      (unit3 - unit4) == 0 || sum4 <= 0
                          ? SizedBox()
                          : Row(
                              children: [
                                Expanded(flex: 1, child: Text('')),
                                Expanded(
                                  flex: 4,
                                  child: RichText(
                                    textAlign: TextAlign.start,
                                    text: TextSpan(
                                      text:
                                          'หน่วยที่ ${(ele_three + 1)} - $ele_tour',
                                      style: TextStyle(
                                          color: PeopleChaoScreen_Color
                                              .Colors_Text2_,
                                          fontFamily: Font_.Fonts_T),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: ele_mit_tour == 0
                                              ? ' (เหมาจ่าย $ele_gob_tour บาท)'
                                              : ' (หน่วยละ $ele_mit_tour บาท)',
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontFamily: Font_.Fonts_T),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    '${unit3 - unit4} หน่วย',
                                    textAlign: TextAlign.start,
                                    style: const TextStyle(
                                        color: PeopleChaoScreen_Color
                                            .Colors_Text2_,
                                        fontFamily: Font_.Fonts_T),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    '${nFormat.format(sum4)}',
                                    textAlign: TextAlign.end,
                                    style: const TextStyle(
                                        color: PeopleChaoScreen_Color
                                            .Colors_Text2_,
                                        fontFamily: Font_.Fonts_T),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    'บาท',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        color: PeopleChaoScreen_Color
                                            .Colors_Text2_,
                                        fontFamily: Font_.Fonts_T),
                                  ),
                                ),
                              ],
                            ),
                      SizedBox(
                        height: 10,
                      ),
                      (unit4 - unit5) == 0 || sum5 <= 0
                          ? SizedBox()
                          : Row(
                              children: [
                                Expanded(flex: 1, child: Text('')),
                                Expanded(
                                  flex: 4,
                                  child: RichText(
                                    textAlign: TextAlign.start,
                                    text: TextSpan(
                                      text:
                                          'หน่วยที่ ${(ele_tour + 1)} - $ele_five',
                                      style: TextStyle(
                                          color: PeopleChaoScreen_Color
                                              .Colors_Text2_,
                                          fontFamily: Font_.Fonts_T),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: ele_mit_five == 0
                                              ? ' (เหมาจ่าย $ele_gob_five บาท)'
                                              : ' (หน่วยละ $ele_mit_five บาท)',
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontFamily: Font_.Fonts_T),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    '${unit4 - unit5} หน่วย',
                                    textAlign: TextAlign.start,
                                    style: const TextStyle(
                                        color: PeopleChaoScreen_Color
                                            .Colors_Text2_,
                                        fontFamily: Font_.Fonts_T),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    '${nFormat.format(sum5)}',
                                    textAlign: TextAlign.end,
                                    style: const TextStyle(
                                        color: PeopleChaoScreen_Color
                                            .Colors_Text2_,
                                        fontFamily: Font_.Fonts_T),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    'บาท',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        color: PeopleChaoScreen_Color
                                            .Colors_Text2_,
                                        fontFamily: Font_.Fonts_T),
                                  ),
                                ),
                              ],
                            ),
                      SizedBox(
                        height: 10,
                      ),
                      (unit5 - unit6) == 0 || sum6 <= 0
                          ? SizedBox()
                          : sum6 < 0
                              ? SizedBox()
                              : Row(
                                  children: [
                                    Expanded(flex: 1, child: Text('')),
                                    Expanded(
                                      flex: 4,
                                      child: RichText(
                                        textAlign: TextAlign.start,
                                        text: TextSpan(
                                          text: 'หน่วยที่ $ele_six ขึ้นไป',
                                          style: TextStyle(
                                              color: PeopleChaoScreen_Color
                                                  .Colors_Text2_,
                                              fontFamily: Font_.Fonts_T),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: ele_mit_six == 0
                                                  ? ' (เหมาจ่าย $ele_gob_six บาท)'
                                                  : ' (หน่วยละ $ele_mit_six บาท)',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontFamily: Font_.Fonts_T),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        '${unit5 - unit6} หน่วย',
                                        textAlign: TextAlign.start,
                                        style: const TextStyle(
                                            color: PeopleChaoScreen_Color
                                                .Colors_Text2_,
                                            fontFamily: Font_.Fonts_T),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        '${nFormat.format(sum6)}',
                                        textAlign: TextAlign.end,
                                        style: const TextStyle(
                                            color: PeopleChaoScreen_Color
                                                .Colors_Text2_,
                                            fontFamily: Font_.Fonts_T),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        'บาท',
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            color: PeopleChaoScreen_Color
                                                .Colors_Text2_,
                                            fontFamily: Font_.Fonts_T),
                                      ),
                                    ),
                                  ],
                                ),
                      Divider(),
                      Row(
                        children: [
                          Expanded(
                            flex: 4,
                            child: Text(
                              ' ',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: PeopleChaoScreen_Color.Colors_Text2_,
                                  fontFamily: Font_.Fonts_T),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              'เงิน$_cnamexฐาน',
                              textAlign: TextAlign.end,
                              style: const TextStyle(
                                  color: PeopleChaoScreen_Color.Colors_Text2_,
                                  fontFamily: Font_.Fonts_T),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              '${nFormat.format(sum)}',
                              textAlign: TextAlign.end,
                              style: const TextStyle(
                                  color: PeopleChaoScreen_Color.Colors_Text2_,
                                  fontFamily: Font_.Fonts_T),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              'บาท',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: PeopleChaoScreen_Color.Colors_Text2_,
                                  fontFamily: Font_.Fonts_T),
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
                            child: Text(
                              '',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: PeopleChaoScreen_Color.Colors_Text2_,
                                  fontFamily: Font_.Fonts_T),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: RichText(
                              textAlign: TextAlign.end,
                              text: TextSpan(
                                text: 'ค่า Ft',
                                style: TextStyle(
                                    color: PeopleChaoScreen_Color.Colors_Text2_,
                                    fontFamily: Font_.Fonts_T),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: ' ( $ele_tf ) บาท/หน่วย',
                                    style: TextStyle(
                                        color: PeopleChaoScreen_Color
                                            .Colors_Text2_,
                                        fontFamily: Font_.Fonts_T),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              '${nFormat.format(sum_f)}',
                              textAlign: TextAlign.end,
                              style: const TextStyle(
                                  color: PeopleChaoScreen_Color.Colors_Text2_,
                                  fontFamily: Font_.Fonts_T),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              'บาท',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: PeopleChaoScreen_Color.Colors_Text2_,
                                  fontFamily: Font_.Fonts_T),
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
                            child: Text(
                              ' ',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: PeopleChaoScreen_Color.Colors_Text2_,
                                  fontFamily: Font_.Fonts_T),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              'ค่าบริการรายเดือน',
                              textAlign: TextAlign.end,
                              style: const TextStyle(
                                  color: PeopleChaoScreen_Color.Colors_Text2_,
                                  fontFamily: Font_.Fonts_T),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              '${nFormat.format(ele_other)}',
                              textAlign: TextAlign.end,
                              style: const TextStyle(
                                  color: PeopleChaoScreen_Color.Colors_Text2_,
                                  fontFamily: Font_.Fonts_T),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              'บาท',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: PeopleChaoScreen_Color.Colors_Text2_,
                                  fontFamily: Font_.Fonts_T),
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
                            child: Text(
                              ' ',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: PeopleChaoScreen_Color.Colors_Text2_,
                                  fontFamily: Font_.Fonts_T),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              '',
                              textAlign: TextAlign.end,
                              style: const TextStyle(
                                  color: PeopleChaoScreen_Color.Colors_Text2_,
                                  fontFamily: Font_.Fonts_T),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Divider(),
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
                            child: Text(
                              '',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: PeopleChaoScreen_Color.Colors_Text2_,
                                  fontFamily: Font_.Fonts_T),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: RichText(
                              textAlign: TextAlign.end,
                              text: TextSpan(
                                text: 'ภาษีมูลค่าเพิ่ม',
                                style: TextStyle(
                                    color: PeopleChaoScreen_Color.Colors_Text2_,
                                    fontFamily: Font_.Fonts_T),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: ' ${nFormat.format(ele_vat)} % (VAT)',
                                    style: TextStyle(
                                        color: PeopleChaoScreen_Color
                                            .Colors_Text2_,
                                        fontFamily: Font_.Fonts_T),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              '${nFormat.format(sum_per)}',
                              textAlign: TextAlign.end,
                              style: const TextStyle(
                                  color: PeopleChaoScreen_Color.Colors_Text2_,
                                  fontFamily: Font_.Fonts_T),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              'บาท',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: PeopleChaoScreen_Color.Colors_Text2_,
                                  fontFamily: Font_.Fonts_T),
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
                            child: Text(
                              ' ',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: PeopleChaoScreen_Color.Colors_Text2_,
                                  fontFamily: Font_.Fonts_T),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              '',
                              textAlign: TextAlign.end,
                              style: const TextStyle(
                                  color: PeopleChaoScreen_Color.Colors_Text2_,
                                  fontFamily: Font_.Fonts_T),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Divider(),
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
                            child: Text(
                              '',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: PeopleChaoScreen_Color.Colors_Text2_,
                                  fontFamily: Font_.Fonts_T),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              'รวมเงิน$_cnamexเดือนปัจจุบัน',
                              textAlign: TextAlign.end,
                              style: const TextStyle(
                                color: PeopleChaoScreen_Color.Colors_Text2_,
                                fontFamily: Font_.Fonts_T,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              '${nFormat.format(sum_all)}',
                              textAlign: TextAlign.end,
                              style: const TextStyle(
                                  color: PeopleChaoScreen_Color.Colors_Text2_,
                                  fontFamily: Font_.Fonts_T),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              'บาท',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: PeopleChaoScreen_Color.Colors_Text2_,
                                  fontFamily: Font_.Fonts_T),
                            ),
                          ),
                        ],
                      ),
                      Divider(),
                      Row(
                        children: [
                          Expanded(
                            flex: 4,
                            child: Text(
                              'รวมเงินทั้งสิ้น',
                              textAlign: TextAlign.end,
                              style: const TextStyle(
                                color: PeopleChaoScreen_Color.Colors_Text2_,
                                fontFamily: FontWeight_.Fonts_T,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              ' ',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: PeopleChaoScreen_Color.Colors_Text2_,
                                fontFamily: FontWeight_.Fonts_T,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              '${nFormat.format(sum_all)}',
                              textAlign: TextAlign.end,
                              style: const TextStyle(
                                color: PeopleChaoScreen_Color.Colors_Text2_,
                                fontFamily: FontWeight_.Fonts_T,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              'บาท',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: PeopleChaoScreen_Color.Colors_Text2_,
                                fontFamily: FontWeight_.Fonts_T,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 50,
                      )
                    ],
                  ),
                ),
              ),
            );
          });
    }
  }
}
