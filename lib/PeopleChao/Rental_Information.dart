// ignore_for_file: unused_import, unused_local_variable, unnecessary_null_comparison, unused_field, override_on_non_overriding_member, duplicate_import, must_be_immutable, body_might_complete_normally_nullable
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:html' as html;
import 'dart:typed_data';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:chaoperty/PeopleChao/Seteing_listmenu.dart';
import 'package:crypto/crypto.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import 'package:file_picker/file_picker.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_limited_checkbox/flutter_limited_checkbox.dart';
import 'package:group_radio_button/group_radio_button.dart';
// import 'package:hand_signature/signature.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

import 'package:radio_grouped_buttons/custom_buttons/custom_radio_buttons_group.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_barcodes/barcodes.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
// import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

import '../ChaoArea/ChaoRe_contact_add.dart';
import '../Constant/Myconstant.dart';
import '../INSERT_Log/Insert_log.dart';
import '../Model/GetC_Quot_Select_Model.dart';
import '../Model/GetContract_Photo_Model.dart';
import '../Model/GetContractf_Model.dart';
import '../Model/GetCustomer_Model.dart';
import '../Model/GetRenTal_Model.dart';
import '../Model/GetTeNant_Model.dart';
import '../Model/GetTrans_Model.dart';
import '../Model/electricity_model.dart';
import '../PDF/Choice/pdf_Agreement_Choice.dart';
import '../PDF/Choice/pdf_Agreement_Choice2.dart';
import '../PDF/Choice/pdf_Agreement_Choice3.dart';
import '../PDF/PDF_Agreement/Ama1000/pdf_Agreement_ama1000.dart';
import '../PDF/PDF_Agreement/Ortor/BangKla/pdf_Agreement_Ortor.dart';
import '../PDF/PDF_Agreement/pdf_Agreement.dart';
import '../PDF/PDF_Agreement/pdf_Agreement2.dart';
import '../PDF/PDF_Agreement/pdf_Agreement_JSpace.dart';
import '../PDF/PDF_Agreement/pdf_Agreement_JSpace2.dart';
import '../PDF/PDF_Agreement/pdf_RentalInforma.dart';
import '../Responsive/responsive.dart';
import '../Style/colors.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:url_launcher/url_launcher.dart';
import 'package:path/path.dart';
import 'package:path/path.dart' as path;
import 'package:pdf/widgets.dart' as pw;
import 'dart:ui' as ui;
import 'dart:convert';
import 'dart:js' as js;
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import 'PeopleChao_Screen2.dart';
import 'QR_PDF2.dart';
import 'package:convert/convert.dart';

class RentalInformation extends StatefulWidget {
  final Get_Value_NameShop_index;
  final Get_Value_cid;
  final Get_Value_statu;

  const RentalInformation({
    super.key,
    this.Get_Value_NameShop_index,
    this.Get_Value_cid,
    this.Get_Value_statu,
  });

  @override
  State<RentalInformation> createState() => _RentalInformationState();
}

class _RentalInformationState extends State<RentalInformation> {
  var nFormat = NumberFormat("#,##0.00", "en_US");
  DateTime datex = DateTime.now();
  List<TeNantModel> teNantModels = [];
  List<RenTalModel> renTalModels = [];
  List<ContractfModel> contractfModels = [];
  List<CustomerModel> customerModels = [];
  List<CustomerModel> customer_Models = [];
  List<ElectricityModel> electricityModels = [];
  List<CustomerModel> _customerModels = <CustomerModel>[];
  final _formKey = GlobalKey<FormState>();
  final Form_nameshop = TextEditingController();
  final Form_typeshop = TextEditingController();
  final Form_bussshop = TextEditingController();
  final Form_bussscontact = TextEditingController();
  final Form_address = TextEditingController();
  final Form_tel = TextEditingController();
  final Form_email = TextEditingController();
  final Form_tax = TextEditingController();
  final Form_wnote = TextEditingController();
  final rental_count_text = TextEditingController();
  final Form_area = TextEditingController();
  final Form_ln = TextEditingController();
  final Form_sdate = TextEditingController();
  final Form_ldate = TextEditingController();
  final Form_period = TextEditingController();
  final Form_rtname = TextEditingController();
  final Form_docno = TextEditingController();
  final Form_zn = TextEditingController();
  final Form_aser = TextEditingController();
  final Form_qty = TextEditingController();
  final Form_cdate = TextEditingController();

  final Form_User = TextEditingController();
  final Form_UserPass = TextEditingController();
  String tappedIndex_1 = ''; // รายละเอียดค่าบริการ
  String tappedIndex_2 = ''; // รายละเอียดค่าบริการ
  List<QuotxSelectModel> quotxSelectModels = [];
  List<TransModel> _TransModels = [];

  List<ContractPhotoModel> contractPhotoModels = [];

  String? _verticalGroupValue,
      foder,
      renTal_bill,
      renTal_name,
      renTal_user,
      fname_,
      Cust_no_;
  String File_Names = '';
  String? cxname_card,
      cxname_lease,
      cxname_other,
      cxname_card_ser,
      cxname_lease_ser,
      cxname_other_ser;
  int renTal_lavel = 0, ser_tabbarview_2 = 0;
  List<ContractfModel> Other_file = [];
  String? pic_tenant, pic_shop, pic_plan, fiew;
  String _ReportValue_type = "ไม่ระบุ";
  @override
  void initState() {
    super.initState();
    checkPreferance();
    read_customer();
  }

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

  Future<Null> checkPreferance() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      renTal_user = preferences.getString('renTalSer');
      renTal_name = preferences.getString('renTalName');
      fname_ = preferences.getString('fname');

      renTal_lavel = int.parse(preferences.getString('lavel').toString());

      read_data();
      red_report();
      red_reporttrans();
      read_GC_rental();
      GC_contractf();
      read_GC_photo();
    });
  }

  Future<Null> read_GC_photo() async {
    if (contractPhotoModels.isNotEmpty) {
      setState(() {
        contractPhotoModels.clear();
      });
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    var user = preferences.getString('ser');
    var ciddoc = widget.Get_Value_cid;
    var qutser = widget.Get_Value_NameShop_index;

    String url =
        '${MyConstant().domain}/GC_photo_cont.php?isAdd=true&ren=$ren&user=$user&ciddoc=$ciddoc&qutser=$qutser';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);
      if (result.toString() != 'null') {
        for (var map in result) {
          ContractPhotoModel contractPhotoModel =
              ContractPhotoModel.fromJson(map);

          var pic_tenantx = contractPhotoModel.pic_tenant!.trim();
          var pic_shopx = contractPhotoModel.pic_shop!.trim();
          var pic_planx = contractPhotoModel.pic_plan!.trim();
          setState(() {
            pic_tenant = pic_tenantx;
            pic_shop = pic_shopx;
            pic_plan = pic_planx;
            contractPhotoModels.add(contractPhotoModel);
          });
        }
      }
    } catch (e) {}
  }

  Future<Null> read_GC_rental() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var seruser = preferences.getString('ser');
    var utype = preferences.getString('utype');

    var ren = preferences.getString('renTalSer');
    String url =
        '${MyConstant().domain}/GC_rental_setring.php?isAdd=true&ren=$ren';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print('read_GC_rental///// $result');
      for (var map in result) {
        RenTalModel renTalModel = RenTalModel.fromJson(map);
        var foderx = renTalModel.dbn;
        setState(() {
          foder = foderx;
          renTal_bill = renTalModel.bill_name!;
          renTalModels.add(renTalModel);
        });
      }
    } catch (e) {}
  }

  // Future<Null> read_GC_rental() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();

  //   var seruser = preferences.getString('ser');
  //   var utype = preferences.getString('utype');
  //   String url =
  //       '${MyConstant().domain}/GC_rental.php?isAdd=true&ser=$seruser&type=$utype';

  //   try {
  //     var response = await http.get(Uri.parse(url));

  //     var result = json.decode(response.body);
  //     // print('read_GC_rental///// $result');
  //     for (var map in result) {
  //       RenTalModel renTalModel = RenTalModel.fromJson(map);
  //       var foderx = renTalModel.dbn;
  //       setState(() {
  //         foder = foderx;
  //         renTal_bill = renTalModel.bill_name!;
  //         renTalModels.add(renTalModel);
  //       });
  //     }
  //   } catch (e) {}
  // }

  ///------------------------------------------------------>
  Future<Null> red_report() async {
    if (quotxSelectModels.length != 0) {
      setState(() {
        quotxSelectModels.clear();
      });
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    var ciddoc = widget.Get_Value_cid;
    var qutser = widget.Get_Value_NameShop_index;

    String url =
        '${MyConstant().domain}/GC_quot_conx.php?isAdd=true&ren=$ren&ciddoc=$ciddoc&qutser=$qutser';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);
      if (result.toString() != 'null') {
        if (quotxSelectModels.isNotEmpty) {
          setState(() {
            quotxSelectModels.clear();
          });
        }
        for (var map in result) {
          QuotxSelectModel quotxSelectModel = QuotxSelectModel.fromJson(map);
          setState(() {
            quotxSelectModels.add(quotxSelectModel);
          });
        }
      } else {
        setState(() {
          quotxSelectModels.clear();
        });
      }
    } catch (e) {}
  }

  Future<Null> red_reporttrans() async {
    if (_TransModels.length != 0) {
      setState(() {
        _TransModels.clear();
      });
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    var ciddoc = widget.Get_Value_cid;
    var qutser = widget.Get_Value_NameShop_index;

    String url =
        '${MyConstant().domain}/GC_trans_x.php?isAdd=true&ren=$ren&ciddoc=$ciddoc&qutser=$qutser';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);
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

  Future<Null> read_data() async {
    if (teNantModels.length != 0) {
      setState(() {
        teNantModels.clear();
      });
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var ren = preferences.getString('renTalSer');
    var ciddoc = widget.Get_Value_cid;
    var qutser = widget.Get_Value_NameShop_index;
    print('Get_Value_NameShop_index >>>>>> $qutser');

    String url =
        '${MyConstant().domain}/GC_tenantlookAS.php?isAdd=true&ren=$ren&ciddoc=$ciddoc&qutser=$qutser';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);
      if (result != null) {
        for (var map in result) {
          TeNantModel teNantModel = TeNantModel.fromJson(map);
          setState(() {
            teNantModels.add(teNantModel);
            Cust_no_ = teNantModel.custno_1.toString();
            _verticalGroupValue = teNantModel.ctype;
            Form_nameshop.text = teNantModel.sname.toString();
            Form_typeshop.text = teNantModel.stype.toString();
            Form_bussshop.text = teNantModel.cname.toString();
            Form_bussscontact.text = teNantModel.attn.toString();
            Form_address.text = teNantModel.addr.toString();
            Form_tel.text = teNantModel.tel.toString();
            Form_email.text = teNantModel.email.toString();
            Form_tax.text =
                teNantModel.tax == null ? "-" : teNantModel.tax.toString();
            Form_area.text = teNantModel.area.toString();
            Form_ln.text = teNantModel.area_c.toString();
            Form_wnote.text = teNantModel.wnote.toString();
            Form_sdate.text = DateFormat('dd-MM-yyyy')
                .format(DateTime.parse('${teNantModel.sdate} 00:00:00'))
                .toString();
            Form_ldate.text = DateFormat('dd-MM-yyyy')
                .format(DateTime.parse('${teNantModel.ldate} 00:00:00'))
                .toString();
            Form_period.text = teNantModel.period.toString();
            Form_rtname.text = teNantModel.rtname.toString();
            Form_docno.text = teNantModel.docno.toString();
            Form_zn.text = teNantModel.zn.toString();
            Form_aser.text = teNantModel.aser.toString();
            Form_qty.text = teNantModel.qty.toString();
            Form_cdate.text = teNantModel.cdate.toString();
          });
        }
        red_coutumer();
      }
    } catch (e) {}
  }

  Future<Null> red_coutumer() async {
    if (customerModels.isNotEmpty) {
      setState(() {
        customerModels.clear();
      });
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? ren = preferences.getString('renTalSer');
    String url =
        '${MyConstant().domain}/GC_custo_informa.php?isAdd=true&ren=$ren&cusno=$Cust_no_';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      //print(result);
      List<int> encodedBytes = [];
      Uint8List decodedBytes;
      if (result.toString() != 'null') {
        for (var map in result) {
          CustomerModel customerModel = CustomerModel.fromJson(map);
          setState(() {
            customerModels.add(customerModel);

            Form_User.text = customerModel.user_name.toString();
            // encodedBytes = hex.decode(customerModel.passw!);
            // decodedBytes = Uint8List.fromList(encodedBytes);
            // const utf8Decoder = Utf8Decoder(allowMalformed: true);
            // Form_UserPass.text = utf8Decoder.convert(encodedBytes);
          });
        }
      }
    } catch (e) {}
  }

  ///--------------------------------------------->
  ScrollController _scrollController1 = ScrollController();
  ScrollController _scrollController2 = ScrollController();

  _moveUp1() {
    _scrollController1.animateTo(_scrollController1.offset - 250,
        curve: Curves.linear, duration: const Duration(milliseconds: 500));
  }

  _moveDown1() {
    _scrollController1.animateTo(_scrollController1.offset + 250,
        curve: Curves.linear, duration: const Duration(milliseconds: 500));
  }

  _moveUp2() {
    _scrollController2.animateTo(_scrollController2.offset - 250,
        curve: Curves.linear, duration: const Duration(milliseconds: 500));
  }

  _moveDown2() {
    _scrollController2.animateTo(_scrollController2.offset + 250,
        curve: Curves.linear, duration: const Duration(milliseconds: 500));
  }

///////------------------------------------------------------------->
  // String image_base64_IDcard = '';
  // Future<void> chooseImage_IDcard() async {
  //   final ImagePicker _picker = ImagePicker();
  //   // var choosedimage = await ImagePicker.pickImage(source: ImageSource.gallery);
  //   final XFile? photo = await _picker.pickImage(source: ImageSource.gallery);
  //   //set source: ImageSource.camera to get image from camera
  //   if (photo == null) return;
  //   // read picked image byte data.
  //   Uint8List imagebytes = await photo.readAsBytes();
  //   // using base64 encoder convert image into base64 string.
  //   String _base64String1 = base64.encode(imagebytes);

  //   setState(() {
  //     image_base64_IDcard = _base64String1;
  //   });
  //   print(image_base64_IDcard);
  // }

  // Future<void> _uploadFile_IDcard() async {
  //   String imageStep4_base64_new = '0';
  //   Random randomx = Random();
  //   int ix = randomx.nextInt(1000000);
  //   String uploadurl = "${MyConstant().domain}/xxxxxxx.php";
  //   String fileName4 = 'img_4_$ix.jpg';
  //   try {
  //     setState(() {
  //       imageStep4_base64_new = fileName4;
  //     });
  //     var response = await http.post(Uri.parse(uploadurl), body: {
  //       'image': image_base64_IDcard,
  //       'name': fileName4,
  //     });

  //     if (response.statusCode == 200) {
  //       var jsondata = json.decode(response.body);
  //       if (jsondata["error"]) {
  //         //  print(jsondata["msg"]);
  //       } else {
  //         //  print("Upload successful");
  //       }
  //     } else {
  //       // print("Error during connection to server");
  //     }
  //   } catch (e) {}
  // }

  ///------------------------------------------------------------>( รูปBase64 )
  Widget getImagenBase64(String photo) {
    String _imageBase64 = photo;

    const Base64Codec base64 = Base64Codec();
    var bytes = base64.decode(_imageBase64);
    if (_imageBase64 == null) {
      return const Text('Nodata');
    } else {
      return Image.memory(
        bytes,
        // width: MediaQuery.of(context).size.width * 0.2,
        // height: MediaQuery.of(context).size.width * 0.2,
        fit: BoxFit.fill,
      );
    }
  }

  ///---------------------------------------------------------->
  // Future<html.File> pickFile() async {
  //   final completer = Completer<html.File>();
  //   final input = html.FileUploadInputElement()..accept = '.pdf';
  //   input.click();

  //   await input.onChange.first;
  //   if (input.files!.isNotEmpty) {
  //     completer.complete(input.files!.first);
  //   } else {
  //     completer.complete(null);
  //   }

  //   return completer.future;
  // }
  // Future<html.File> pickFile_IDcard() async {
  //   final completer = Completer<html.File>();
  //   final input = html.FileUploadInputElement()..accept = '.pdf';
  //   input.click();

  //   await input.onChange.first;
  //   if (input.files!.isNotEmpty) {
  //     completer.complete(input.files!.first);
  //   } else {
  //     completer.complete(null);
  //   }

  //   return completer.future;
  // }
  // Future<FilePickerResult?> pickFile_IDcard() async {
  //   FilePickerResult? result = await FilePicker.platform.pickFiles(
  //     type: FileType.custom,
  //     allowedExtensions: ['pdf'],
  //   );
  //   return result;
  // }

  // Future<FilePickerResult?> pickFile_agreement() async {
  //   FilePickerResult? result = await FilePicker.platform.pickFiles(
  //     type: FileType.custom,
  //     allowedExtensions: ['pdf'],
  //   );
  //   return result;
  // }

  // Future<FilePickerResult?> pickFile_documentmore() async {
  //   FilePickerResult? result = await FilePicker.platform.pickFiles(
  //     type: FileType.custom,
  //     allowedExtensions: ['pdf'],
  //   );
  //   return result;
  // }

  Future<Null> GC_contractf() async {
    if (contractfModels.length != 0) {
      contractfModels.clear();
    }
    setState(() {
      Other_file = [];
      cxname_card = null;
      cxname_lease = null;
      cxname_other = null;
      cxname_card_ser = null;
      cxname_lease_ser = null;
      cxname_other_ser = null;
    });
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var ren = preferences.getString('renTalSer');
    var ser_user = preferences.getString('ser');
    String Namecid = '${widget.Get_Value_cid}';
    String url =
        '${MyConstant().domain}/GC_contractf.php?isAdd=true&ren=$ren&ser_user=$ser_user&namecid=$Namecid';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);
      if (result != null) {
        for (var map in result) {
          ContractfModel contractfModelss = ContractfModel.fromJson(map);
          setState(() {
            contractfModels.add(contractfModelss);
          });

          if (contractfModelss.cxname.toString() == 'contract/card') {
            setState(() {
              cxname_card = contractfModelss.filename.toString();
              cxname_card_ser = contractfModelss.ser.toString();
            });
          } else if (contractfModelss.cxname.toString() == 'contract/lease') {
            setState(() {
              cxname_lease = contractfModelss.filename.toString();
              cxname_lease_ser = contractfModelss.ser.toString();
            });
          } else if (contractfModelss.cxname.toString() == 'contract/other') {
            setState(() {
              cxname_other = contractfModelss.filename.toString();
              cxname_other_ser = contractfModelss.ser.toString();
            });

            //////////----------------------------------

            setState(() {
              Other_file.add(contractfModelss);
            });
          } else {}
        }

        // print('00000000>>>>>>>>>>>>>>>>> ${contractfModels.length}');
      } else {}
    } catch (e) {}
  }

  Future<Null> InsertFile_SQL(String FileName, String MixPath) async {
    String dateTimeNow = DateTime.now().toString();
    String date_ = DateFormat('yyyy-MM-dd')
        .format(DateTime.parse('${dateTimeNow}'))
        .toString();
///////////------------------------->
    final dateTimeNow2 = DateTime.now().toUtc().add(const Duration(hours: 7));
    final formatter = DateFormat(' HH:mm:ss');
    final formattedTime = formatter.format(dateTimeNow2);
    String Time_ = formattedTime.toString();
    ///////////------------------------->
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');

    String SerUser = '';
    String Namecid = '${widget.Get_Value_cid}';
    String Path_foder = MixPath;
    String fileName = FileName;

    String url =
        '${MyConstant().domain}/lnC_contractf.php?isAdd=true&ren=$ren&ser_user=$SerUser&namecid=$Namecid&namecxname=$Path_foder&fileNames=$fileName&dates=$date_&times=$Time_';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result.toString());
    } catch (e) {
      print(e);
    }
  }

  Future<Null> deletedFile_SQL(ser) async {
    ///////////------------------------->
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');

    String Namecid = '${widget.Get_Value_cid}';
    String Ser = ser;
    String url =
        '${MyConstant().domain}/DeC_contractf.php?isAdd=true&ren=$ren&ser_user=$Ser&namecid=$Namecid';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print('result deletedFile_SQL $Ser//$Namecid : ${result.toString()}');
    } catch (e) {
      print(e);
    }
    GC_contractf();
  }

  Future<void> deletedFile_(
      String fileName, String ser, String PathfoderSub) async {
    String Path_foder = 'contract';
    String Path_foderSub = PathfoderSub;
    String fileName_ = fileName;
    final deleteRequest = html.HttpRequest();
    deleteRequest.open('POST',
        '${MyConstant().domain}/File_Deleted.php?Foder=$foder&Pathfoder=$Path_foder&PathfoderSub=$Path_foderSub&name=$fileName_');
    deleteRequest.send();

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

  Future<void> uploadFile_IDcard(cxname_card, cxname_card_ser) async {
    String Path_foder = 'contract';
    String Path_foderSub = 'card';

    String dateTimeNow = DateTime.now().toString();
    String date_ = DateFormat('ddMMyyyy')
        .format(DateTime.parse('${dateTimeNow}'))
        .toString();
    // String fileName = 'card_${widget.Get_Value_cid}_$date_.pdf';
    String MixPath_ = '$Path_foder/$Path_foderSub';

    // InsertFile_SQL(fileName, MixPath_);
    // Open the file picker and get the selected file
    final input = html.FileUploadInputElement();
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
    String fileName = 'card_${widget.Get_Value_cid}_$date_.$extension';
    InsertFile_SQL(fileName, MixPath_);
    // Create a new FormData object and add the file to it
    final formData = html.FormData();
    formData.appendBlob('file', file, fileName);

    // Send the request
    final request = html.HttpRequest();
    request.open('POST',
        '${MyConstant().domain}/File_uploadTestTOTo.php?file=$base64&name=$fileName&Foder=$foder&Pathfoder=$Path_foder&PathfoderSub=$Path_foderSub');
    request.send(formData);
    GC_contractf();
    // Handle the response
    await request.onLoad.first;

    print(File_Names);
    if (request.status == 200) {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      var name = preferences.getString('fname');
      Insert_log.Insert_logs('สัญญาเช่า',
          '$name>สัญญา${widget.Get_Value_cid}>อัพโหลดสำเนาบัตรประชาชน');
      print('File uploaded successfully!');
    } else {
      print('File upload failed with status code: ${request.status}');
    }
  }

  Future<void> uploadFile_Agreement(cxname_lease, cxname_lease_ser) async {
    String Path_foder = 'contract';
    String Path_foderSub = 'lease';
    String dateTimeNow = DateTime.now().toString();
    String date_ =
        DateFormat('ddMMyyyy').format(DateTime.parse(dateTimeNow)).toString();
    String fileName = 'lease_${widget.Get_Value_cid}_$date_.pdf';
    String MixPath_ = '$Path_foder/$Path_foderSub';
    InsertFile_SQL(fileName, MixPath_);
    // Open the file picker and get the selected file
    final input = html.FileUploadInputElement();
    input..accept = 'application/pdf';
    input.click();
    await input.onChange.first;

    final file = input.files!.first;
    final reader = html.FileReader();
    reader.readAsArrayBuffer(file);
    await reader.onLoadEnd.first;

    // Create a new FormData object and add the file to it
    final formData = html.FormData();
    formData.appendBlob('file', file, fileName);

    // Send the request
    final request = html.HttpRequest();
    request.open('POST',
        '${MyConstant().domain}/File_uploadTestTOTo.php?file=$base64&name=$fileName&Foder=$foder&Pathfoder=$Path_foder&PathfoderSub=$Path_foderSub');
    request.send(formData);
    GC_contractf();
    // Handle the response
    await request.onLoad.first;
    if (request.status == 200) {
      setState(() {
        File_Names = fileName.toString();
      });
      print('File uploaded successfully!');
    } else {
      print('File upload failed with status code: ${request.status}');
    }
  }

  Future<void> uploadFile_Documentmore(cxname_other, cxname_other_ser) async {
    String Path_foder = 'contract';
    String Path_foderSub = 'other';
    String dateTimeNow = DateTime.now().toString();
    String date_ = DateFormat('ddMMyyyy')
        .format(DateTime.parse('${dateTimeNow}'))
        .toString();

    String fileName =
        'other_${widget.Get_Value_cid}_${date_}_${Other_file.length + 1}.pdf';
    String MixPath_ = '$Path_foder/$Path_foderSub';

    InsertFile_SQL(fileName, MixPath_);

    // Open the file picker and get the selected file
    final input = html.FileUploadInputElement();
    input..accept = 'application/pdf';
    input.click();
    await input.onChange.first;

    final file = input.files!.first;
    final reader = html.FileReader();
    reader.readAsArrayBuffer(file);
    await reader.onLoadEnd.first;

    // Create a new FormData object and add the file to it
    final formData = html.FormData();
    formData.appendBlob('file', file, fileName);

    // Send the request
    final request = html.HttpRequest();
    request.open('POST',
        '${MyConstant().domain}/File_uploadTestTOTo.php?file=$base64&name=$fileName&Foder=$foder&Pathfoder=$Path_foder&PathfoderSub=$Path_foderSub');
    request.send(formData);
    GC_contractf();
    // Handle the response
    await request.onLoad.first;
    if (request.status == 200) {
      setState(() {
        File_Names = fileName.toString();
      });
      print('File uploaded successfully!');
    } else {
      print('File upload failed with status code: ${request.status}');
    }
  }

  // Future<void> uploadFile_IDcard(FilePickerResult result) async {
  //   // Get the file bytes from the result
  //   final Uint8List bytes = result.files.first.bytes!;
  //   String dateTimeNow = DateTime.now().toString();
  //   String date_ = DateFormat('dd-MM-yyyy')
  //       .format(DateTime.parse('${dateTimeNow}'))
  //       .toString();
  //   String fileName = 'IDcard_${widget.Get_Value_cid}_$date_.pdf';

  //   // Convert the bytes to base64
  //   final String base64 = base64Encode(bytes);

  //   // Make the API request to upload the file to your server
  //   try {
  //     final response = await http.post(
  //       Uri.parse(
  //           '${MyConstant().domain}/File_uploadTestTOTo.php?file=$base64&name=$fileName'),
  //       body: {
  //         'file': base64,
  //         'name': fileName,
  //       },
  //     );

  //     if (response.statusCode == 200) {
  //       print('File uploaded successfully!');
  //     } else {
  //       print('File upload failed!');
  //     }
  //   } catch (e) {
  //     print('catch (e)');
  //     print(e);
  //   }
  // }

  // Future<void> uploadFile_Agreement(FilePickerResult result) async {
  //   ///////////////////------------------------------------>
  //   // Get the file bytes from the result
  //   final Uint8List bytes = result.files.first.bytes!;
  //   ///////////////////------------------------------------>

  //   String dateTimeNow = DateTime.now().toString();
  //   String date_ = DateFormat('dd-MM-yyyy')
  //       .format(DateTime.parse('${dateTimeNow}'))
  //       .toString();
  //   String fileName = 'Agreement_${widget.Get_Value_cid}_$date_.pdf';
  //   ///////////////////------------------------------------>
  //   // Convert the bytes to base64    'https://dzentric.com/chao_perty/chao_api/File_uploadTestTOTo.php?file=$base64&name=$fileName';
  //   final String base64 = base64Encode(bytes);
  //   String uploadurl =
  //       "${MyConstant().domain}/File_upload.php&file=$base64&name=$fileName";
  //   // String uploadurl =
  //   //     "${MyConstant().domain}/xxxxxxx.php&file=$base64&name=$fileName";
  //   print(base64);
  //   ///////////////////------------------------------------>
  //   // Make the API request to upload the file to your server
  //   try {
  //     final response = await http.post(
  //       Uri.parse(uploadurl),
  //       body: {
  //         "file": base64,
  //         "name": fileName,
  //       },
  //     );

  //     if (response.statusCode == 200) {
  //       print('File uploaded successfully!');
  //     } else {
  //       print('File upload failed!');
  //     }
  //   } catch (e) {}
  // }

  // Future<void> uploadFile_Documentmore(FilePickerResult result) async {
  //   ///////////////////------------------------------------>
  //   // Get the file bytes from the result
  //   final Uint8List bytes = result.files.first.bytes!;
  //   ///////////////////------------------------------------>
  //   var path = result.paths;
  //   String dateTimeNow = DateTime.now().toString();
  //   String date_ = DateFormat('dd-MM-yyyy')
  //       .format(DateTime.parse('${dateTimeNow}'))
  //       .toString();
  //   String fileName = 'Documentmore_${widget.Get_Value_cid}_$date_.pdf';
  //   ///////////////////------------------------------------>
  //   // Convert the bytes to base64
  //   final String base64 = base64Encode(bytes);
  //   String uploadurl =
  //       "${MyConstant().domain}/File_upload.php&file=$base64&name=$fileName";
  //   // String uploadurl =
  //   //     "${MyConstant().domain}/xxxxxxx.php&file=$base64&name=$fileName";
  //   // print(base64);
  //   ///////////////////------------------------------------>
  //   // Make the API request to upload the file to your server
  //   try {
  //     final response = await http.post(
  //       Uri.parse(uploadurl),
  //       body: {
  //         "path": path,
  //         "file": base64,
  //         "name": fileName,
  //       },
  //     );

  //     if (response.statusCode == 200) {
  //       print('File uploaded successfully!');
  //     } else {
  //       print('File upload failed!');
  //     }
  //   } catch (e) {}
  // }

  String? base64_Slip, fileName_Slip;
  var extension_;
  var file_;
  File? _file;

  Future<Null> chooseImage(ImageSource source) async {
    // ignore: deprecated_member_use
    var object = await ImagePicker()
        .getImage(source: source, maxWidth: 800.0, maxHeight: 800.0);
    Uint8List bytes = File(object!.path).readAsBytesSync();
    int timestamp = DateTime.now().millisecondsSinceEpoch;

    setState(() {
      fileName_Slip = '${fiew}_${widget.Get_Value_cid}_$timestamp';
      base64_Slip = base64Encode(bytes);
      _file = File(object.path);
      extension_ = 'jpg';
    });
    // try {
    //   var object = await ImagePicker().pickImage(source: source);
    //   Uint8List bytes = File(object!.path).readAsBytesSync();
    //   int timestamp = DateTime.now().millisecondsSinceEpoch;
    //   setState(() {
    //     fileName_Slip = '${fiew}_${widget.Get_Value_cid}_$timestamp';
    //     base64_Slip = base64Encode(bytes);
    //     _file = File(object.path);
    //     extension_ = 'jpg';
    //   });
    // } catch (e) {}
    // uploadImage();
  }

  Future<void> uploadImage(ImageSource source) async {
    int timestamp = DateTime.now().millisecondsSinceEpoch;
    setState(() {
      fileName_Slip = '${fiew}_${widget.Get_Value_cid}_$timestamp.jpg';
    });
    // print(fileName_Slip);
    // var name_ = 'testforweb_$timestamp';
    // var foder_ = 'kad_taii';
    // 1. Capture an image from the device's gallery or camera
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.getImage(source: source);

    if (pickedFile == null) {
      print('User canceled image selection');
      return;
    }

    try {
      // 2. Read the image as bytes
      final imageBytes = await pickedFile.readAsBytes();

      // 3. Encode the image as a base64 string
      final base64Image = base64Encode(imageBytes);

      // 4. Make an HTTP POST request to your server
      final url =
          '${MyConstant().domain}/File_photo.php?name=$fileName_Slip&Foder=$foder';

      final response = await http.post(
        Uri.parse(url),
        body: {
          'image': base64Image,
          'Foder': foder,
          'name': fileName_Slip
        }, // Send the image as a form field named 'image'
      );

      if (response.statusCode == 200) {
        print('Image uploaded successfully');
        up_photo_string();
      } else {
        print('Image upload failed');
      }
    } catch (e) {
      print('Error during image processing: $e');
    }
  }

  // Future<Null> uploadImage() async {
  //   if (base64_Slip != null) {
  //     try {
  //       final url =
  //           '${MyConstant().domain}/File_photo.php?name=$fileName_Slip&Foder=$foder';

  //       final response = await http.post(
  //         Uri.parse(url),
  //         body: {
  //           'image': base64_Slip,
  //           'Foder': foder,
  //           'name': fileName_Slip
  //         }, // Send the image as a form field named 'image'
  //       );

  //       if (response.statusCode == 200) {
  //         print('Image uploaded successfully');
  //         up_photo_string();
  //       } else {
  //         print('Image upload failed');
  //       }
  //     } catch (e) {
  //       print('Error during image processing: $e');
  //     }
  //   } else {
  //     print('ยังไม่ได้เลือกรูปภาพ');
  //   }

  //   // String Path_foder = 'contract';
  //   // int timestamp = DateTime.now().millisecondsSinceEpoch;
  //   // setState(() {
  //   //   fileName_Slip = '${fiew}_${widget.Get_Value_cid}_$timestamp.jpg';
  //   // });

  //   // // Random random = Random();
  //   // // int i = random.nextInt(1000000);
  //   // // String nameImage = 'image_$i.jpg';

  //   // print(fileName_Slip);
  //   // // String url =
  //   // //     '${MyConstant().domain}/File_photo.php?name=$fileName_Slip&Foder=$foder';
  //   // // try {
  //   // //   Map<String, dynamic> map = Map();
  //   // //   map['file'] =
  //   // //       await MultipartFile.fromFile(_file!.path, filename: fileName_Slip);
  //   // //   FormData formData = FormData.fromMap(map);
  //   // //   await http.post(Uri.parse(url), body: formData).then((value) {
  //   // //     up_photo_string();
  //   // //   });
  //   // // } catch (e) {
  //   // //   print('error $e');
  //   // // }
  //   // if (base64_Slip != null) {
  //   //   final formData = html.FormData();
  //   //   formData.appendBlob('file', file_, fileName_Slip);
  //   //   // Send the request
  //   //   final request = html.HttpRequest();
  //   //   request.open('POST',
  //   //       '${MyConstant().domain}/File_uploadPhoto.php?name=$fileName_Slip&Foder=$foder&Pathfoder=$Path_foder');
  //   //   request.send(formData);
  //   //   print(formData);

  //   //   // Handle the response
  //   //   await request.onLoad.first;

  //   //   if (request.status == 200) {
  //   //     print('File uploaded successfully!');
  //   //     up_photo_string();
  //   //   } else {
  //   //     print('File upload failed with status code: ${request.status}');
  //   //   }
  //   // } else {
  //   //   print('ยังไม่ได้เลือกรูปภาพ');
  //   // }
  // }

  Future<void> _getFromGallery2() async {
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
      base64_Slip = base64Encode(reader.result as Uint8List);
    });

    setState(() {
      extension_ = extension;
      file_ = file;
    });
    OKuploadFile_Phto();
  }

  Future<void> OKuploadFile_Phto() async {
    if (base64_Slip != null) {
      String Path_foder = 'contract';
      String dateTimeNow = DateTime.now().toString();
      String date = DateFormat('ddMMyyyy')
          .format(DateTime.parse('${dateTimeNow}'))
          .toString();
      final dateTimeNow2 = DateTime.now().toUtc().add(const Duration(hours: 7));
      final formatter2 = DateFormat('HHmmss');
      final formattedTime2 = formatter2.format(dateTimeNow2);
      String Time_ = formattedTime2.toString();
      int timestamp = DateTime.now().millisecondsSinceEpoch;
      setState(() {
        fileName_Slip =
            '${fiew}_${widget.Get_Value_cid}_$timestamp.$extension_';
      });
      // String fileName = 'slip_${widget.Get_Value_cid}_${date}_$Time_.$extension_';
      // InsertFile_SQL(fileName, MixPath_, formattedTime1);
      // Create a new FormData object and add the file to it
      final formData = html.FormData();
      formData.appendBlob('file', file_, fileName_Slip);
      // Send the request
      final request = html.HttpRequest();
      request.open('POST',
          '${MyConstant().domain}/File_uploadPhoto.php?name=$fileName_Slip&Foder=$foder&Pathfoder=$Path_foder');
      request.send(formData);
      print(formData);

      // Handle the response
      await request.onLoad.first;

      if (request.status == 200) {
        print('File uploaded successfully!');
        up_photo_string();
      } else {
        print('File upload failed with status code: ${request.status}');
      }
    } else {
      print('ยังไม่ได้เลือกรูปภาพ');
    }
  }

  Future<Null> up_photo_string() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    var user = preferences.getString('ser');
    var ciddoc = widget.Get_Value_cid;
    var qutser = widget.Get_Value_NameShop_index;
    var fiewx = fiew;
    String? fileName_Slip_ = fileName_Slip.toString().trim();

    String url =
        '${MyConstant().domain}/GC_tran_Kon_photo.php?isAdd=true&ren=$ren&user=$user&ciddoc=$ciddoc&qutser=$qutser&fiewx=$fiewx&fileName_Slip=$fileName_Slip_';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);
      if (result.toString() == 'true') {
        setState(() {
          fileName_Slip_ = null;
          base64_Slip = null;
          extension_ = null;
          file_ = null;
          _file = null;
          fiew = null;
          read_GC_photo();
        });
      }
    } catch (e) {}
  }
////////---------------------------------->

  Future<Null> read_customer() async {
    if (customer_Models.isNotEmpty) {
      setState(() {
        customer_Models.clear();
      });
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? ren = preferences.getString('renTalSer');
    String? serzone = preferences.getString('zoneSer');
    print('zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz>>>>>>>>>>>>>>>>>>>>>>>>> $serzone');
    String url =
        '${MyConstant().domain}/GC_custo_Information.php?isAdd=true&ren=$ren';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print(result);
      if (result.toString() != 'null') {
        for (var map in result) {
          CustomerModel customerModel = CustomerModel.fromJson(map);
          setState(() {
            customer_Models.add(customerModel);
          });
        }
      }
      print(customer_Models.map((e) => e.scname));
      setState(() {
        _customerModels = customer_Models;
      });
      print(_customerModels.map((e) => e.scname));
    } catch (e) {}
  }

  _searchBarAll() {
    return StreamBuilder(
        stream: Stream.periodic(const Duration(seconds: 0)),
        builder: (context, snapshot) {
          return TextField(
            autofocus: false,
            keyboardType: TextInputType.text,
            style: const TextStyle(
              // fontSize: 22.0,
              color: Colors.black,
            ),
            decoration: InputDecoration(
              filled: true,
              // fillColor: Colors.white,
              hintText: ' Search...',
              hintStyle: const TextStyle(
                color: PeopleChaoScreen_Color.Colors_Text1_,
                // fontWeight: FontWeight.bold,
                fontFamily: Font_.Fonts_T,
              ),
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
              text = text.toLowerCase();
              // print(text);

              setState(() {
                customer_Models = _customerModels.where((customer_Model) {
                  var notTitle = customer_Model.custno.toString().toLowerCase();
                  var notTitle2 = customer_Model.cname.toString().toLowerCase();
                  var notTitle3 =
                      customer_Model.scname.toString().toLowerCase();
                  var notTitle4 = customer_Model.tax.toString().toLowerCase();

                  return notTitle.contains(text) ||
                      notTitle2.contains(text) ||
                      notTitle3.contains(text) ||
                      notTitle4.contains(text);
                }).toList();
              });
            },
          );
        });
  }

  ///--------------------------------------------->
  Future<Null> select_coutumerAll(context) async {
    // if (customer_Models.isNotEmpty) {
    //   setState(() {
    //     customer_Models.clear();
    //     _customerModels.clear();
    //   });
    // }
    // SharedPreferences preferences = await SharedPreferences.getInstance();
    // String? ren = preferences.getString('renTalSer');
    // String url = '${MyConstant().domain}/GC_custo_se.php?isAdd=true&ren=$ren';

    // try {
    //   var response = await http.get(Uri.parse(url));

    //   var result = json.decode(response.body);
    //   print(result);
    //   if (result.toString() != 'null') {
    //     for (var map in result) {
    //       CustomerModel customerModel = CustomerModel.fromJson(map);
    //       setState(() {
    //         customerModels.add(customerModel);
    //       });
    //     }
    //   }
    //   setState(() {
    //     _customerModels = customerModels;
    //   });
    // } catch (e) {}

    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => StatefulBuilder(
          // stream: Stream.periodic(const Duration(seconds: 0)),
          builder: (context, snapshot) {
        String tappedIndex_ = '';
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: Column(
            children: [
              Center(
                child: Text(
                  'รายชื่อจากทะเบียน',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                // padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Expanded(
                      child: _searchBarAll(),
                    ),
                  ],
                ),
              ),
            ],
          ),
          content: StreamBuilder(
              stream: Stream.periodic(const Duration(seconds: 0)),
              builder: (context, snapshot) {
                return SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
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
                                // height:
                                //     MediaQuery.of(context).size.height /
                                //         1.5,
                                width: (!Responsive.isDesktop(context))
                                    ? 1000
                                    : MediaQuery.of(context).size.width / 1.2,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10)),
                                  // border: Border.all(color: Colors.white, width: 1),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade100,
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(15),
                                            topRight: Radius.circular(15),
                                            bottomLeft: Radius.circular(15),
                                            bottomRight: Radius.circular(15)),
                                      ),
                                      padding: const EdgeInsets.all(2.0),
                                      child: Column(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              color: Colors.grey.shade600,
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
                                            ),
                                            child: const Row(
                                              children: [
                                                Expanded(
                                                  flex: 2,
                                                  child: AutoSizeText(
                                                    minFontSize: 10,
                                                    maxFontSize: 18,
                                                    '...',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily:
                                                          FontWeight_.Fonts_T,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: AutoSizeText(
                                                    minFontSize: 10,
                                                    maxFontSize: 18,
                                                    'Img',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily:
                                                          FontWeight_.Fonts_T,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: AutoSizeText(
                                                    minFontSize: 10,
                                                    maxFontSize: 18,
                                                    'รหัสสมาชิก',
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily:
                                                          FontWeight_.Fonts_T,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 3,
                                                  child: AutoSizeText(
                                                    minFontSize: 10,
                                                    maxFontSize: 18,
                                                    'ชื่อร้าน',
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily:
                                                          FontWeight_.Fonts_T,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 3,
                                                  child: AutoSizeText(
                                                    minFontSize: 10,
                                                    maxFontSize: 18,
                                                    'ชื่อผู่เช่า/บริษัท',
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily:
                                                          FontWeight_.Fonts_T,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 3,
                                                  child: AutoSizeText(
                                                    minFontSize: 10,
                                                    maxFontSize: 18,
                                                    'ประเภทร้านค้า',
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily:
                                                          FontWeight_.Fonts_T,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: AutoSizeText(
                                                    minFontSize: 10,
                                                    maxFontSize: 18,
                                                    'TAX',
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily:
                                                          FontWeight_.Fonts_T,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: AutoSizeText(
                                                    minFontSize: 10,
                                                    maxFontSize: 18,
                                                    'ประเภท',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily:
                                                          FontWeight_.Fonts_T,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: AutoSizeText(
                                                    minFontSize: 10,
                                                    maxFontSize: 18,
                                                    'Select',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily:
                                                          FontWeight_.Fonts_T,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                              width: (!Responsive.isDesktop(
                                                      context))
                                                  ? 1000
                                                  : MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      1.2,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.4,
                                              child: ListView.builder(
                                                  physics:
                                                      const AlwaysScrollableScrollPhysics(),
                                                  shrinkWrap: true,
                                                  itemCount:
                                                      customer_Models.length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    return Material(
                                                      color: tappedIndex_ ==
                                                              index.toString()
                                                          ? tappedIndex_Color
                                                              .tappedIndex_Colors
                                                              .withOpacity(0.5)
                                                          : AppbackgroundColor
                                                              .Sub_Abg_Colors,
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5),
                                                        child: ListTile(
                                                          onTap: () async {
                                                            var NEW_Form_nameshop =
                                                                '${customer_Models[index].scname}';

                                                            var NEW_Form_sname =
                                                                '${customer_Models[index].sname}';
                                                            var NEW_Form_typeshop =
                                                                '${customer_Models[index].stype}';

                                                            var NEW_Form_bussshop =
                                                                '${customer_Models[index].cname}';
                                                            var NEW_Form_bussscontact =
                                                                '${customer_Models[index].attn}';
                                                            var NEW_Form_address =
                                                                '${customer_Models[index].addr1}';
                                                            var NEW_Form_tel =
                                                                '${customer_Models[index].tel}';
                                                            var NEW_Form_email =
                                                                '${customer_Models[index].email}';
                                                            var NEW_Form_tax =
                                                                customer_Models[index]
                                                                            .tax ==
                                                                        'null'
                                                                    ? "-"
                                                                    : '${customer_Models[index].tax}';
                                                            var ADDRx = '';
                                                            var NEW_Value_AreaSer_ =
                                                                int.parse(customer_Models[
                                                                            index]
                                                                        .typeser!) -
                                                                    1; // ser ประเภท
                                                            var NEW_verticalGroupValue =
                                                                '${customer_Models[index].type}'; // ประเภท

                                                            var NEW_number_custno =
                                                                customer_Models[
                                                                        index]
                                                                    .custno
                                                                    .toString();
                                                            var NEW_img_custno =
                                                                customer_Models[
                                                                        index]
                                                                    .addr2
                                                                    .toString();

                                                            print(
                                                                NEW_verticalGroupValue);
                                                            setState(() {
                                                              tappedIndex_ = index
                                                                  .toString();
                                                            });

                                                            ///--->UP_LE_Rental_Information

                                                            // Navigator.pop(
                                                            //     context);

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

                                                            showDialog<String>(
                                                              context: context,
                                                              builder: (BuildContext
                                                                      context) =>
                                                                  AlertDialog(
                                                                shape: const RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.all(
                                                                            Radius.circular(20.0))),
                                                                title:
                                                                    const Center(
                                                                        child:
                                                                            Text(
                                                                  'เปลี่ยนแปลงข้อมูล.. ?',
                                                                  style: TextStyle(
                                                                      color: AdminScafScreen_Color
                                                                          .Colors_Text1_,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontFamily:
                                                                          FontWeight_
                                                                              .Fonts_T),
                                                                )),
                                                                actions: <Widget>[
                                                                  Column(
                                                                    children: [
                                                                      const SizedBox(
                                                                        height:
                                                                            5.0,
                                                                      ),
                                                                      const Divider(
                                                                        color: Colors
                                                                            .grey,
                                                                        height:
                                                                            4.0,
                                                                      ),
                                                                      const SizedBox(
                                                                        height:
                                                                            5.0,
                                                                      ),
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(8.0),
                                                                        child:
                                                                            Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          children: [
                                                                            Padding(
                                                                              padding: const EdgeInsets.all(8.0),
                                                                              child: Container(
                                                                                width: 100,
                                                                                decoration: const BoxDecoration(
                                                                                  color: Colors.green,
                                                                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                                                                                ),
                                                                                padding: const EdgeInsets.all(8.0),
                                                                                child: TextButton(
                                                                                  onPressed: () async {
                                                                                    String url = '${MyConstant().domain}/UP_LE_Rental_Information.php?isAdd=true&ren=$ren&custno=$NEW_number_custno&ctype=$NEW_verticalGroupValue&scname=$NEW_Form_nameshop&sname=${customer_Models[index].scname}&stype=$NEW_Form_typeshop&cname=$NEW_Form_bussshop&attn=$NEW_Form_bussscontact&addr=$NEW_Form_address&addrx=$ADDRx&tax=$NEW_Form_tax&tel=$NEW_Form_tel&email=$NEW_Form_email&vLE=${widget.Get_Value_cid}&img=$NEW_img_custno';

                                                                                    try {
                                                                                      var response = await http.get(Uri.parse(url));

                                                                                      var result = json.decode(response.body);
                                                                                      print(result);
                                                                                      if (result.toString() == 'true') {
                                                                                        setState(() {
                                                                                          checkPreferance();
                                                                                          read_customer();
                                                                                        });
                                                                                        Insert_log.Insert_logs('ผู้เช่า', 'เรียกดู:${widget.Get_Value_cid} >> แก้ไขข้อมูลผู้เช่า : ${Form_nameshop.text} >> $NEW_Form_nameshop');
                                                                                        ScaffoldMessenger.of(context).showSnackBar(
                                                                                          const SnackBar(content: Text('แก้ไขข้อมูลผู้เช่าสำเร็จ')),
                                                                                        );
                                                                                        Navigator.pop(context);
                                                                                        Navigator.pop(context);
                                                                                      }
                                                                                    } catch (e) {
                                                                                      print(e);
                                                                                      ScaffoldMessenger.of(context).showSnackBar(
                                                                                        const SnackBar(content: Text(' ผิดพลาด กรุณาลองใหม่!', style: TextStyle(color: Colors.white, fontFamily: Font_.Fonts_T))),
                                                                                      );
                                                                                    }
                                                                                  },
                                                                                  child: const Text(
                                                                                    'ยืนยัน',
                                                                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontFamily: FontWeight_.Fonts_T),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Padding(
                                                                              padding: const EdgeInsets.all(8.0),
                                                                              child: Row(
                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                children: [
                                                                                  Container(
                                                                                    width: 100,
                                                                                    decoration: const BoxDecoration(
                                                                                      color: Colors.redAccent,
                                                                                      borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                                                                                    ),
                                                                                    padding: const EdgeInsets.all(8.0),
                                                                                    child: TextButton(
                                                                                      onPressed: () => Navigator.pop(context, 'OK'),
                                                                                      child: const Text(
                                                                                        'ยกเลิก',
                                                                                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontFamily: FontWeight_.Fonts_T),
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
                                                          },
                                                          title: Row(
                                                            children: [
                                                              Expanded(
                                                                flex: 2,
                                                                child:
                                                                    AutoSizeText(
                                                                  minFontSize:
                                                                      10,
                                                                  maxFontSize:
                                                                      18,
                                                                  '${index + 1}',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style:
                                                                      const TextStyle(
                                                                    color: PeopleChaoScreen_Color
                                                                        .Colors_Text2_,
                                                                    // fontWeight: FontWeight.bold,
                                                                    fontFamily:
                                                                        Font_
                                                                            .Fonts_T,
                                                                    // fontWeight: FontWeight.bold,
                                                                    // fontWeight: FontWeight.bold,
                                                                  ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                flex: 2,
                                                                child: (customer_Models[index].addr2 ==
                                                                            null ||
                                                                        customer_Models[index].addr2 ==
                                                                            '')
                                                                    ? Container(
                                                                        // padding:
                                                                        //     const EdgeInsets
                                                                        //             .all(
                                                                        //         2.0),
                                                                        // decoration: BoxDecoration(
                                                                        //     color: Colors
                                                                        //             .grey[
                                                                        //         200],
                                                                        //     borderRadius:
                                                                        //         BorderRadius.all(
                                                                        //             Radius.circular(100))),
                                                                        child:
                                                                            const Center(
                                                                          child:
                                                                              Icon(Icons.image_not_supported_rounded),
                                                                        ),
                                                                      )
                                                                    : InkWell(
                                                                        child:
                                                                            Container(
                                                                          // color: Colors
                                                                          //     .black,
                                                                          child:
                                                                              CircleAvatar(
                                                                            radius:
                                                                                30.0,
                                                                            backgroundImage:
                                                                                NetworkImage(
                                                                              '${MyConstant().domain}/files/$foder/contract/${customer_Models[index].addr2}',
                                                                            ),
                                                                            backgroundColor:
                                                                                Colors.transparent,
                                                                          ),
                                                                        ),
                                                                        onTap:
                                                                            () {
                                                                          setState(
                                                                              () {
                                                                            tappedIndex_ =
                                                                                index.toString();
                                                                          });
                                                                          showDialog<
                                                                              String>(
                                                                            context:
                                                                                context,
                                                                            builder: (BuildContext context) =>
                                                                                AlertDialog(
                                                                              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
                                                                              // title: Container(
                                                                              //     width: MediaQuery.of(context).size.width * 0.25,
                                                                              //     height: MediaQuery.of(context).size.width * 0.35,
                                                                              //     child: Image.network(
                                                                              //       '${MyConstant().domain}/files/$foder/contract/${customer_Models[index].addr2}',
                                                                              //       fit: BoxFit.contain,
                                                                              //     )),
                                                                              content: Container(
                                                                                // width: MediaQuery.of(context).size.width * 0.25,
                                                                                // height: MediaQuery.of(context).size.width * 0.32,
                                                                                child: SingleChildScrollView(
                                                                                  child: ListBody(
                                                                                    children: <Widget>[
                                                                                      Container(
                                                                                        width: MediaQuery.of(context).size.width * 0.25,
                                                                                        height: MediaQuery.of(context).size.width * 0.32,
                                                                                        child: Image.network(
                                                                                          '${MyConstant().domain}/files/$foder/contract/${customer_Models[index].addr2}',
                                                                                          fit: BoxFit.contain,
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
                                                                                      padding: const EdgeInsets.all(8.0),
                                                                                      child: Row(
                                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                                        children: [
                                                                                          Container(
                                                                                            width: 100,
                                                                                            decoration: const BoxDecoration(
                                                                                              color: Colors.redAccent,
                                                                                              borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                                                                                            ),
                                                                                            padding: const EdgeInsets.all(8.0),
                                                                                            child: TextButton(
                                                                                              onPressed: () => Navigator.pop(context, 'OK'),
                                                                                              child: const Text(
                                                                                                'ปิด',
                                                                                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontFamily: FontWeight_.Fonts_T),
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
                                                                          );
                                                                        },
                                                                      ),
                                                              ),
                                                              Expanded(
                                                                flex: 2,
                                                                child:
                                                                    AutoSizeText(
                                                                  minFontSize:
                                                                      10,
                                                                  maxFontSize:
                                                                      18,
                                                                  customer_Models[index]
                                                                              .custno ==
                                                                          null
                                                                      ? ''
                                                                      : '${customer_Models[index].custno}',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style:
                                                                      const TextStyle(
                                                                    color: PeopleChaoScreen_Color
                                                                        .Colors_Text2_,
                                                                    // fontWeight: FontWeight.bold,
                                                                    fontFamily:
                                                                        Font_
                                                                            .Fonts_T,
                                                                    // fontWeight: FontWeight.bold,
                                                                    // fontWeight: FontWeight.bold,
                                                                  ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                flex: 3,
                                                                child:
                                                                    AutoSizeText(
                                                                  minFontSize:
                                                                      10,
                                                                  maxFontSize:
                                                                      18,
                                                                  '${customer_Models[index].scname}',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .start,
                                                                  style:
                                                                      const TextStyle(
                                                                    color: PeopleChaoScreen_Color
                                                                        .Colors_Text2_,
                                                                    // fontWeight: FontWeight.bold,
                                                                    fontFamily:
                                                                        Font_
                                                                            .Fonts_T,
                                                                    // fontWeight: FontWeight.bold,
                                                                    // fontWeight: FontWeight.bold,
                                                                  ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                flex: 3,
                                                                child:
                                                                    AutoSizeText(
                                                                  minFontSize:
                                                                      10,
                                                                  maxFontSize:
                                                                      18,
                                                                  '${customer_Models[index].cname}',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .start,
                                                                  style:
                                                                      const TextStyle(
                                                                    color: PeopleChaoScreen_Color
                                                                        .Colors_Text2_,
                                                                    // fontWeight: FontWeight.bold,
                                                                    fontFamily:
                                                                        Font_
                                                                            .Fonts_T,
                                                                    // fontWeight: FontWeight.bold,
                                                                    // fontWeight: FontWeight.bold,
                                                                  ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                flex: 3,
                                                                child:
                                                                    AutoSizeText(
                                                                  minFontSize:
                                                                      10,
                                                                  maxFontSize:
                                                                      18,
                                                                  '${customer_Models[index].stype}',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .start,
                                                                  style:
                                                                      const TextStyle(
                                                                    color: PeopleChaoScreen_Color
                                                                        .Colors_Text2_,
                                                                    // fontWeight: FontWeight.bold,
                                                                    fontFamily:
                                                                        Font_
                                                                            .Fonts_T,
                                                                    // fontWeight: FontWeight.bold,
                                                                    // fontWeight: FontWeight.bold,
                                                                  ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                flex: 2,
                                                                child:
                                                                    AutoSizeText(
                                                                  minFontSize:
                                                                      10,
                                                                  maxFontSize:
                                                                      18,
                                                                  (customer_Models[index]
                                                                              .tax
                                                                              .toString() ==
                                                                          'null')
                                                                      ? '-'
                                                                      : '${customer_Models[index].tax}',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style:
                                                                      const TextStyle(
                                                                    color: PeopleChaoScreen_Color
                                                                        .Colors_Text2_,
                                                                    // fontWeight: FontWeight.bold,
                                                                    fontFamily:
                                                                        Font_
                                                                            .Fonts_T,
                                                                    // fontWeight: FontWeight.bold,
                                                                    // fontWeight: FontWeight.bold,
                                                                  ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                flex: 2,
                                                                child:
                                                                    AutoSizeText(
                                                                  minFontSize:
                                                                      10,
                                                                  maxFontSize:
                                                                      18,
                                                                  '${customer_Models[index].type}',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style:
                                                                      const TextStyle(
                                                                    color: PeopleChaoScreen_Color
                                                                        .Colors_Text2_,
                                                                    // fontWeight: FontWeight.bold,
                                                                    fontFamily:
                                                                        Font_
                                                                            .Fonts_T,
                                                                    // fontWeight: FontWeight.bold,
                                                                    // fontWeight: FontWeight.bold,
                                                                  ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                flex: 2,
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .end,
                                                                  children: [
                                                                    Container(
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: Colors
                                                                            .grey[500],
                                                                        borderRadius: BorderRadius.only(
                                                                            topLeft:
                                                                                Radius.circular(10),
                                                                            topRight: Radius.circular(10),
                                                                            bottomLeft: Radius.circular(10),
                                                                            bottomRight: Radius.circular(10)),
                                                                      ),
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              8.0),
                                                                      child:
                                                                          AutoSizeText(
                                                                        minFontSize:
                                                                            10,
                                                                        maxFontSize:
                                                                            18,
                                                                        'Select',
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              PeopleChaoScreen_Color.Colors_Text2_,
                                                                          // fontWeight: FontWeight.bold,
                                                                          fontFamily:
                                                                              Font_.Fonts_T,
                                                                          // fontWeight: FontWeight.bold,
                                                                          // fontWeight: FontWeight.bold,
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
                                                    );
                                                  })),
                                        ],
                                      )),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
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
                    mainAxisAlignment: MainAxisAlignment.end,
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
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'ยกเลิก',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: FontWeight_.Fonts_T,
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
        );
      }),
    );
  }

  Future<dynamic> showcountmiter(int index) async {
    var ser = quotxSelectModels[index].ele_ty;
    if (electricityModels.isNotEmpty) {
      electricityModels.clear();
    }

    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    String url =
        '${MyConstant().domain}/GC_electricity.php?isAdd=true&ren=$ren';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print(result);
      if (result != null) {
        for (var map in result) {
          ElectricityModel electricityModel = ElectricityModel.fromJson(map);

          if (electricityModel.ser == ser) {
            setState(() {
              electricityModels.add(electricityModel);
            });
          }
        }
      } else {}
    } catch (e) {}
  }
/////////////------------------------------------>
  // Future<Null> _select_Date_Daily(BuildContext context) async {
  //   final Future<DateTime?> picked = showDatePicker(
  //     // locale: const Locale('th', 'TH'),
  //     helpText: 'เลือกวันที่', confirmText: 'ตกลง',
  //     cancelText: 'ยกเลิก',
  //     context: context,
  //     initialDate: DateTime(
  //         DateTime.now().year, DateTime.now().month, DateTime.now().day - 1),
  //     initialDatePickerMode: DatePickerMode.day,
  //     firstDate: DateTime(2023, 1, 1),
  //     lastDate: DateTime(
  //         DateTime.now().year, DateTime.now().month, DateTime.now().day),
  //     // selectableDayPredicate: _decideWhichDayToEnable,
  //     builder: (context, child) {
  //       return Theme(
  //         data: Theme.of(context).copyWith(
  //           colorScheme: const ColorScheme.light(
  //             primary: AppBarColors.ABar_Colors, // header background color
  //             onPrimary: Colors.white, // header text color
  //             onSurface: Colors.black, // body text color
  //           ),
  //           textButtonTheme: TextButtonThemeData(
  //             style: TextButton.styleFrom(
  //               primary: Colors.black, // button text color
  //             ),
  //           ),
  //         ),
  //         child: child!,
  //       );
  //     },
  //   );
  //   picked.then((result) {
  //     if (picked != null) {
  //       // TransReBillModels = [];

  //       var formatter = DateFormat('yyyy-MM-dd');
  //       print("${formatter.format(result!)}");
  //       setState(() {
  //         Value_TransDate_Daily = "${formatter.format(result)}";
  //       });
  //     }
  //   });
  // }
  ////////////------------------------------------------------------>(Export file)
  Future<void> _showMyDialog_SAVE(
      context, tableData00, newValuePDFimg, ren, type) async {
    String _ReportValue_type_doc = "ปกติ";
    String _ReportValue_type_JSpace = "JSpace";
    String _ReportValue_type_docOttor = "อาคารพาณิชย์";
    String _ReportValue_type_Choice = "สัญญาเช่าที่ดิน";
    String _ReportValue_type_Ama = "สัญญาเช่าพื้นที่";
    String _verticalGroupValue_NameFile = "จากระบบ";
    String Value_Report = ' ';
    String NameFile_ = '';
    String Pre_and_Dow = '';
    String? TitleType_Default_Receipt_Name;
    final _formKey = GlobalKey<FormState>();
    final FormNameFile_text = TextEditingController();
    final Datex_text = TextEditingController();
    final Pri1_text = TextEditingController();
    final Pri2_text = TextEditingController();
    final Pri3_text = TextEditingController();
    var date_x = DateTime.now();
    var formatter = DateFormat('dd-MM-yyyy');
    setState(() {
      Datex_text.text = "${formatter.format(date_x)}";
      Pri1_text.text = '0.00';
      Pri2_text.text = '0.00';
      Pri3_text.text = '0.00';
    });
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return StreamBuilder(
          stream: Stream.periodic(const Duration(seconds: 0)),
          builder: (context, snapshot) {
            return Form(
              key: _formKey,
              child: AlertDialog(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0))),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      SizedBox(height: 2),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: const Text(
                          'วันที่ทำสัญญา :',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: ReportScreen_Color.Colors_Text2_,
                            // fontWeight: FontWeight.bold,
                            fontFamily: Font_.Fonts_T,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            Future<DateTime?> picked = showDatePicker(
                              // locale: const Locale('th', 'TH'),
                              helpText: 'เลือกวันที่',
                              confirmText: 'ตกลง',
                              cancelText: 'ยกเลิก',
                              context: context,
                              initialDate: DateTime(DateTime.now().year,
                                  DateTime.now().month, DateTime.now().day - 1),
                              initialDatePickerMode: DatePickerMode.day,
                              firstDate: DateTime(2023, 1, 1),
                              lastDate: DateTime(
                                  DateTime.now().year,
                                  DateTime.now().month,
                                  DateTime.now().day + 100),
                              // selectableDayPredicate: _decideWhichDayToEnable,
                              builder: (context, child) {
                                return Theme(
                                  data: Theme.of(context).copyWith(
                                    colorScheme: const ColorScheme.light(
                                      primary: AppBarColors
                                          .ABar_Colors, // header background color
                                      onPrimary:
                                          Colors.white, // header text color
                                      onSurface:
                                          Colors.black, // body text color
                                    ),
                                    textButtonTheme: TextButtonThemeData(
                                      style: TextButton.styleFrom(
                                        primary:
                                            Colors.black, // button text color
                                      ),
                                    ),
                                  ),
                                  child: child!,
                                );
                              },
                            );
                            picked.then((result) {
                              if (picked != null) {
                                // TransReBillModels = [];

                                var formatter = DateFormat('dd-MM-yyyy');
                                print("${formatter.format(result!)}");
                                setState(() {
                                  Datex_text.text =
                                      "${formatter.format(result)}";
                                });
                              }
                            });
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                color: AppbackgroundColor.Sub_Abg_Colors,
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10)),
                                border:
                                    Border.all(color: Colors.grey, width: 1),
                              ),
                              width: 200,
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Text(
                                  (Datex_text.text == null)
                                      ? 'เลือก'
                                      : '${Datex_text.text}',
                                  style: const TextStyle(
                                    color: ReportScreen_Color.Colors_Text2_,
                                    // fontWeight: FontWeight.bold,
                                    fontFamily: Font_.Fonts_T,
                                  ),
                                ),
                              )),
                        ),
                      ),
                      (ren.toString() == '106' ||
                              ren.toString() == '72' ||
                              ren.toString() == '92' ||
                              ren.toString() == '93' ||
                              ren.toString() == '94' ||
                              ren.toString() == '90')
                          ? SizedBox()
                          : Column(
                              children: [
                                const Text(
                                  'รูปแบบปกติ:',
                                  style: TextStyle(
                                    color: ReportScreen_Color.Colors_Text2_,
                                    // fontWeight: FontWeight.bold,
                                    fontFamily: Font_.Fonts_T,
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.3),
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      topRight: Radius.circular(15),
                                      bottomLeft: Radius.circular(15),
                                      bottomRight: Radius.circular(15),
                                    ),
                                    border: Border.all(
                                        color: Colors.grey, width: 1),
                                  ),
                                  padding: const EdgeInsets.all(8.0),
                                  child: RadioGroup<String>.builder(
                                    direction: Axis.horizontal,
                                    groupValue: _ReportValue_type_doc,
                                    horizontalAlignment:
                                        MainAxisAlignment.spaceAround,
                                    onChanged: (value) {
                                      // setState(() {
                                      //   FormNameFile_text.clear();
                                      // });
                                      setState(() {
                                        _ReportValue_type_doc = value ?? '';
                                      });

                                      // if (value == 'ไม่ระบุ') {
                                      //   setState(() {
                                      //     TitleType_Default_Receipt_Name = null;
                                      //   });
                                      // } else {
                                      //   setState(() {
                                      //     TitleType_Default_Receipt_Name = value;
                                      //   });
                                      // }
                                    },
                                    items: const <String>[
                                      'ปกติ',
                                    ],
                                    textStyle: const TextStyle(
                                      fontSize: 15,
                                      color: ReportScreen_Color.Colors_Text2_,
                                      // fontWeight: FontWeight.bold,
                                      fontFamily: Font_.Fonts_T,
                                    ),
                                    itemBuilder: (item) => RadioButtonBuilder(
                                      item,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                      SizedBox(height: 2),

                      if (ren.toString() == '72' ||
                          ren.toString() == '92' ||
                          ren.toString() == '93' ||
                          ren.toString() == '94')
                        Container(
                            child: Column(
                          children: [
                            SizedBox(height: 2),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: const Text(
                                'รูปแบบสัญญา อต. :',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: ReportScreen_Color.Colors_Text2_,
                                  // fontWeight: FontWeight.bold,
                                  fontFamily: Font_.Fonts_T,
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.3),
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15),
                                  bottomLeft: Radius.circular(15),
                                  bottomRight: Radius.circular(15),
                                ),
                                border:
                                    Border.all(color: Colors.grey, width: 1),
                              ),
                              padding: const EdgeInsets.all(8.0),
                              child: RadioGroup<String>.builder(
                                direction: Axis.horizontal,
                                groupValue: _ReportValue_type_docOttor,
                                horizontalAlignment:
                                    MainAxisAlignment.spaceAround,
                                onChanged: (value) {
                                  // setState(() {
                                  //   FormNameFile_text.clear();
                                  // });
                                  setState(() {
                                    _ReportValue_type_docOttor = value ?? '';
                                  });

                                  // if (value == 'ไม่ระบุ') {
                                  //   setState(() {
                                  //     TitleType_Default_Receipt_Name = null;
                                  //   });
                                  // } else {
                                  //   setState(() {
                                  //     TitleType_Default_Receipt_Name = value;
                                  //   });
                                  // }
                                },
                                items: <String>[
                                  'อาคารพาณิชย์',
                                  'แผงค้าจำหน่ายสัตว์น้ำ (แพปลา)',
                                  'แผงค้าดองสัตว์น้ำ (ดองปลา)',
                                  'แผงค้าแปรรูปสัตว์น้ำ (แปรรูปปลา)',
                                  // for (int index = 0;
                                  //     index < Type_Ortor.length;
                                  //     index)
                                  //   '${Type_Ortor[index]}',
                                ],
                                textStyle: const TextStyle(
                                  fontSize: 15,
                                  color: ReportScreen_Color.Colors_Text2_,
                                  // fontWeight: FontWeight.bold,
                                  fontFamily: Font_.Fonts_T,
                                ),
                                itemBuilder: (item) => RadioButtonBuilder(
                                  item,
                                ),
                              ),
                            ),
                            SizedBox(height: 2),
                          ],
                        )),

                      ///Type_Choice
                      if (ren.toString() == '106')
                        Container(
                            child: Column(
                          children: [
                            SizedBox(height: 2),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: const Text(
                                'รูปแบบสัญญา ชอยส์ มินิสโตร์. :',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: ReportScreen_Color.Colors_Text2_,
                                  // fontWeight: FontWeight.bold,
                                  fontFamily: Font_.Fonts_T,
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.3),
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15),
                                  bottomLeft: Radius.circular(15),
                                  bottomRight: Radius.circular(15),
                                ),
                                border:
                                    Border.all(color: Colors.grey, width: 1),
                              ),
                              padding: const EdgeInsets.all(8.0),
                              child: RadioGroup<String>.builder(
                                direction: Axis.horizontal,
                                groupValue: _ReportValue_type_Choice,
                                horizontalAlignment:
                                    MainAxisAlignment.spaceAround,
                                onChanged: (value) {
                                  // setState(() {
                                  //   FormNameFile_text.clear();
                                  // });
                                  setState(() {
                                    _ReportValue_type_Choice = value ?? '';
                                  });

                                  // if (value == 'ไม่ระบุ') {
                                  //   setState(() {
                                  //     TitleType_Default_Receipt_Name = null;
                                  //   });
                                  // } else {
                                  //   setState(() {
                                  //     TitleType_Default_Receipt_Name = value;
                                  //   });
                                  // }
                                },
                                items: <String>[
                                  'สัญญาเช่าที่ดิน',
                                  'สัญญาห้องเช่า',
                                  'สัญญาบริการ',
                                ],
                                textStyle: const TextStyle(
                                  fontSize: 15,
                                  color: ReportScreen_Color.Colors_Text2_,
                                  // fontWeight: FontWeight.bold,
                                  fontFamily: Font_.Fonts_T,
                                ),
                                itemBuilder: (item) => RadioButtonBuilder(
                                  item,
                                ),
                              ),
                            ),
                            SizedBox(height: 2),
                          ],
                        )),

                      ///Type_Choice
                      if (ren.toString() == '102')
                        Container(
                            child: Column(
                          children: [
                            SizedBox(height: 2),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: const Text(
                                'รูปแบบสัญญา อาม่า1000สุข. :',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: ReportScreen_Color.Colors_Text2_,
                                  // fontWeight: FontWeight.bold,
                                  fontFamily: Font_.Fonts_T,
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.3),
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15),
                                  bottomLeft: Radius.circular(15),
                                  bottomRight: Radius.circular(15),
                                ),
                                border:
                                    Border.all(color: Colors.grey, width: 1),
                              ),
                              padding: const EdgeInsets.all(8.0),
                              child: RadioGroup<String>.builder(
                                direction: Axis.horizontal,
                                groupValue: _ReportValue_type_Ama,
                                horizontalAlignment:
                                    MainAxisAlignment.spaceAround,
                                onChanged: (value) {
                                  // setState(() {
                                  //   FormNameFile_text.clear();
                                  // });
                                  setState(() {
                                    _ReportValue_type_Ama = value ?? '';
                                  });

                                  // if (value == 'ไม่ระบุ') {
                                  //   setState(() {
                                  //     TitleType_Default_Receipt_Name = null;
                                  //   });
                                  // } else {
                                  //   setState(() {
                                  //     TitleType_Default_Receipt_Name = value;
                                  //   });
                                  // }
                                },
                                items: <String>[
                                  'สัญญาเช่าพื้นที่',
                                ],
                                textStyle: const TextStyle(
                                  fontSize: 15,
                                  color: ReportScreen_Color.Colors_Text2_,
                                  // fontWeight: FontWeight.bold,
                                  fontFamily: Font_.Fonts_T,
                                ),
                                itemBuilder: (item) => RadioButtonBuilder(
                                  item,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: const Text(
                                '20.อื่นๆ :',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: ReportScreen_Color.Colors_Text2_,
                                  // fontWeight: FontWeight.bold,
                                  fontFamily: Font_.Fonts_T,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                keyboardType: TextInputType.text,
                                controller: FormNameFile_text,

                                // maxLength: 13,
                                cursorColor: Colors.green,
                                decoration: InputDecoration(
                                    fillColor: Colors.white.withOpacity(0.3),
                                    filled: true,
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
                                    // labelText:
                                    //     'วางเงินประกันตลอดอายุสัญญาเช่า : ',
                                    labelStyle: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.black54,
                                        fontFamily: Font_.Fonts_T)),
                                // inputFormatters: [
                                //   FilteringTextInputFormatter.deny(
                                //       RegExp(r'\s')),
                                //   // FilteringTextInputFormatter.deny(
                                //   //     RegExp(r'^0')),
                                //   FilteringTextInputFormatter.allow(
                                //       RegExp(r'[0-9 .]')),
                                // ],
                              ),
                            ),
                            SizedBox(height: 2),
                          ],
                        )),
                      if (ren.toString() == '90')
                        if (type == 1)
                          Column(
                            children: [
                              SizedBox(height: 2),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: const Text(
                                  'รูปแบบสัญญา JSpace. :',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: ReportScreen_Color.Colors_Text2_,
                                    // fontWeight: FontWeight.bold,
                                    fontFamily: Font_.Fonts_T,
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15),
                                    bottomLeft: Radius.circular(15),
                                    bottomRight: Radius.circular(15),
                                  ),
                                  border:
                                      Border.all(color: Colors.grey, width: 1),
                                ),
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.3),
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(15),
                                          topRight: Radius.circular(15),
                                          bottomLeft: Radius.circular(15),
                                          bottomRight: Radius.circular(15),
                                        ),
                                        border: Border.all(
                                            color: Colors.grey, width: 1),
                                      ),
                                      padding: const EdgeInsets.all(8.0),
                                      child: RadioGroup<String>.builder(
                                        direction: Axis.horizontal,
                                        groupValue: _ReportValue_type_JSpace,
                                        horizontalAlignment:
                                            MainAxisAlignment.spaceAround,
                                        onChanged: (value) {
                                          // setState(() {
                                          //   FormNameFile_text.clear();
                                          // });
                                          setState(() {
                                            _ReportValue_type_JSpace =
                                                value ?? '';
                                          });

                                          // if (value == 'ไม่ระบุ') {
                                          //   setState(() {
                                          //     TitleType_Default_Receipt_Name = null;
                                          //   });
                                          // } else {
                                          //   setState(() {
                                          //     TitleType_Default_Receipt_Name = value;
                                          //   });
                                          // }
                                        },
                                        items: const <String>[
                                          'JSpace',
                                          // 'แนบท้าย',
                                        ],
                                        textStyle: const TextStyle(
                                          fontSize: 15,
                                          color:
                                              ReportScreen_Color.Colors_Text2_,
                                          // fontWeight: FontWeight.bold,
                                          fontFamily: Font_.Fonts_T,
                                        ),
                                        itemBuilder: (item) =>
                                            RadioButtonBuilder(
                                          item,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 2),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: const Text(
                                        'อัตราค่าเช่าเดือนละ :',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          color:
                                              ReportScreen_Color.Colors_Text2_,
                                          // fontWeight: FontWeight.bold,
                                          fontFamily: Font_.Fonts_T,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        controller: Pri1_text,

                                        // maxLength: 13,
                                        cursorColor: Colors.green,
                                        decoration: InputDecoration(
                                          fillColor:
                                              Colors.white.withOpacity(0.3),
                                          filled: true,
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
                                          errorStyle: TextStyle(
                                              fontFamily: Font_.Fonts_T),
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
                                              color: Colors.black,
                                            ),
                                          ),
                                          // labelText: 'อัตราค่าเช่าเดือนละ : ',
                                          labelStyle: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.black54,
                                              fontFamily: Font_.Fonts_T),
                                        ),
                                        inputFormatters: [
                                          FilteringTextInputFormatter.deny(
                                              RegExp(r'\s')),
                                          // FilteringTextInputFormatter.deny(
                                          //     RegExp(r'^0')),
                                          FilteringTextInputFormatter.allow(
                                              RegExp(r'[0-9 .]')),
                                        ],
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: const Text(
                                        'วางเงินประกันตลอดอายุสัญญาเช่า :',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          color:
                                              ReportScreen_Color.Colors_Text2_,
                                          // fontWeight: FontWeight.bold,
                                          fontFamily: Font_.Fonts_T,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        controller: Pri2_text,

                                        // maxLength: 13,
                                        cursorColor: Colors.green,
                                        decoration: InputDecoration(
                                            fillColor:
                                                Colors.white.withOpacity(0.3),
                                            filled: true,
                                            focusedBorder:
                                                const OutlineInputBorder(
                                              borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(15),
                                                topLeft: Radius.circular(15),
                                                bottomRight:
                                                    Radius.circular(15),
                                                bottomLeft: Radius.circular(15),
                                              ),
                                              borderSide: BorderSide(
                                                width: 1,
                                                color: Colors.black,
                                              ),
                                            ),
                                            errorStyle: TextStyle(
                                                fontFamily: Font_.Fonts_T),
                                            enabledBorder:
                                                const OutlineInputBorder(
                                              borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(15),
                                                topLeft: Radius.circular(15),
                                                bottomRight:
                                                    Radius.circular(15),
                                                bottomLeft: Radius.circular(15),
                                              ),
                                              borderSide: BorderSide(
                                                width: 1,
                                                color: Colors.black,
                                              ),
                                            ),
                                            // labelText:
                                            //     'วางเงินประกันตลอดอายุสัญญาเช่า : ',
                                            labelStyle: const TextStyle(
                                                fontSize: 14,
                                                color: Colors.black54,
                                                fontFamily: Font_.Fonts_T)),
                                        inputFormatters: [
                                          FilteringTextInputFormatter.deny(
                                              RegExp(r'\s')),
                                          // FilteringTextInputFormatter.deny(
                                          //     RegExp(r'^0')),
                                          FilteringTextInputFormatter.allow(
                                              RegExp(r'[0-9 .]')),
                                        ],
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: const Text(
                                        'ผู้เช่าต้องชำระค่าส่วนกลางต่อเดือน :',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          color:
                                              ReportScreen_Color.Colors_Text2_,
                                          // fontWeight: FontWeight.bold,
                                          fontFamily: Font_.Fonts_T,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        controller: Pri3_text,

                                        // maxLength: 13,
                                        cursorColor: Colors.green,
                                        decoration: InputDecoration(
                                            fillColor:
                                                Colors.white.withOpacity(0.3),
                                            filled: true,
                                            focusedBorder:
                                                const OutlineInputBorder(
                                              borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(15),
                                                topLeft: Radius.circular(15),
                                                bottomRight:
                                                    Radius.circular(15),
                                                bottomLeft: Radius.circular(15),
                                              ),
                                              borderSide: BorderSide(
                                                width: 1,
                                                color: Colors.black,
                                              ),
                                            ),
                                            errorStyle: TextStyle(
                                                fontFamily: Font_.Fonts_T),
                                            enabledBorder:
                                                const OutlineInputBorder(
                                              borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(15),
                                                topLeft: Radius.circular(15),
                                                bottomRight:
                                                    Radius.circular(15),
                                                bottomLeft: Radius.circular(15),
                                              ),
                                              borderSide: BorderSide(
                                                width: 1,
                                                color: Colors.black,
                                              ),
                                            ),
                                            // labelText:
                                            //     'ผู้เช่าต้องชำระค่าส่วนกลางต่อเดือน : ',
                                            labelStyle: const TextStyle(
                                                fontSize: 14,
                                                color: Colors.black54,
                                                fontFamily: Font_.Fonts_T)),
                                        inputFormatters: [
                                          FilteringTextInputFormatter.deny(
                                              RegExp(r'\s')),
                                          // FilteringTextInputFormatter.deny(
                                          //     RegExp(r'^0')),
                                          FilteringTextInputFormatter.allow(
                                              RegExp(r'[0-9 .]')),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                      const Text(
                        'หัวบิล :',
                        style: TextStyle(
                          color: ReportScreen_Color.Colors_Text2_,
                          // fontWeight: FontWeight.bold,
                          fontFamily: Font_.Fonts_T,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.3),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                          ),
                          border: Border.all(color: Colors.grey, width: 1),
                        ),
                        padding: const EdgeInsets.all(8.0),
                        child: RadioGroup<String>.builder(
                          direction: Axis.horizontal,
                          groupValue: _ReportValue_type,
                          horizontalAlignment: MainAxisAlignment.spaceAround,
                          onChanged: (value) {
                            // setState(() {
                            //   FormNameFile_text.clear();
                            // });
                            setState(() {
                              _ReportValue_type = value ?? '';
                            });

                            if (value == 'ไม่ระบุ') {
                              setState(() {
                                TitleType_Default_Receipt_Name = null;
                              });
                            } else {
                              setState(() {
                                TitleType_Default_Receipt_Name = value;
                              });
                            }
                          },
                          items: const <String>[
                            'ไม่ระบุ',
                            'ต้นฉบับ',
                            'สำเนา',
                          ],
                          textStyle: const TextStyle(
                            fontSize: 15,
                            color: ReportScreen_Color.Colors_Text2_,
                            // fontWeight: FontWeight.bold,
                            fontFamily: Font_.Fonts_T,
                          ),
                          itemBuilder: (item) => RadioButtonBuilder(
                            item,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                actions: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: InkWell(
                          onTap: (type == 2)
                              ? () {
                                  Pdfgen_Agreement_JSpace2
                                      .exportPDF_Agreement_JSpace2(
                                          context,
                                          '${widget.Get_Value_NameShop_index}',
                                          '${widget.Get_Value_cid}',
                                          _verticalGroupValue,
                                          Form_nameshop.text,
                                          Form_typeshop.text,
                                          Form_bussshop.text,
                                          Form_bussscontact.text,
                                          Form_address.text,
                                          Form_tel.text,
                                          Form_email.text,
                                          Form_tax.text,
                                          Form_ln.text,
                                          Form_zn.text,
                                          Form_area.text,
                                          Form_qty.text,
                                          Form_sdate.text,
                                          Form_ldate.text,
                                          Form_period.text,
                                          Form_rtname.text,
                                          quotxSelectModels,
                                          _TransModels,
                                          '$renTal_name',
                                          '${renTalModels[0].bill_addr}',
                                          '${renTalModels[0].bill_email}',
                                          '${renTalModels[0].bill_tel}',
                                          '${renTalModels[0].bill_tax}',
                                          '${renTalModels[0].bill_name}',
                                          newValuePDFimg,
                                          tableData00,
                                          TitleType_Default_Receipt_Name,
                                          Datex_text,
                                          Pri1_text,
                                          Pri2_text,
                                          Pri3_text

                                          // (ser_user == null) ? '' : ser_user
                                          );
                                }
                              : () {
                                  String _ReportValue_type =
                                      (ren.toString() == '90')
                                          ? _ReportValue_type_JSpace
                                          : (ren.toString() == '72' ||
                                                  ren.toString() == '92' ||
                                                  ren.toString() == '93' ||
                                                  ren.toString() == '94')
                                              ? _ReportValue_type_docOttor
                                              : (ren.toString() == '102')
                                                  ? _ReportValue_type_Ama
                                                  : (ren.toString() == '106')
                                                      ? _ReportValue_type_Choice
                                                      : _ReportValue_type_doc;

                                  if (_ReportValue_type == 'ปกติ') {
                                    Pdfgen_Agreement.exportPDF_Agreement(
                                        context,
                                        '${widget.Get_Value_NameShop_index}',
                                        '${widget.Get_Value_cid}',
                                        _verticalGroupValue,
                                        Form_nameshop.text,
                                        Form_typeshop.text,
                                        Form_bussshop.text,
                                        Form_bussscontact.text,
                                        Form_address.text,
                                        Form_tel.text,
                                        Form_email.text,
                                        Form_tax.text,
                                        Form_ln.text,
                                        Form_zn.text,
                                        Form_area.text,
                                        Form_qty.text,
                                        Form_sdate.text,
                                        Form_ldate.text,
                                        Form_period.text,
                                        Form_rtname.text,
                                        quotxSelectModels,
                                        _TransModels,
                                        '$renTal_name',
                                        '${renTalModels[0].bill_addr}',
                                        '${renTalModels[0].bill_email}',
                                        '${renTalModels[0].bill_tel}',
                                        '${renTalModels[0].bill_tax}',
                                        '${renTalModels[0].bill_name}',
                                        newValuePDFimg,
                                        tableData00,
                                        TitleType_Default_Receipt_Name,
                                        Datex_text);
                                  } else if (_ReportValue_type == 'JSpace') {
                                    Pdfgen_Agreement_JSpace
                                        .exportPDF_Agreement_JSpace(
                                            context,
                                            '${widget.Get_Value_NameShop_index}',
                                            '${widget.Get_Value_cid}',
                                            _verticalGroupValue,
                                            Form_nameshop.text,
                                            Form_typeshop.text,
                                            Form_bussshop.text,
                                            Form_bussscontact.text,
                                            Form_address.text,
                                            Form_tel.text,
                                            Form_email.text,
                                            Form_tax.text,
                                            Form_ln.text,
                                            Form_zn.text,
                                            Form_area.text,
                                            Form_qty.text,
                                            Form_sdate.text,
                                            Form_ldate.text,
                                            Form_period.text,
                                            Form_rtname.text,
                                            quotxSelectModels,
                                            _TransModels,
                                            '$renTal_name',
                                            '${renTalModels[0].bill_addr}',
                                            '${renTalModels[0].bill_email}',
                                            '${renTalModels[0].bill_tel}',
                                            '${renTalModels[0].bill_tax}',
                                            '${renTalModels[0].bill_name}',
                                            newValuePDFimg,
                                            tableData00,
                                            TitleType_Default_Receipt_Name,
                                            Datex_text,
                                            Pri1_text,
                                            Pri2_text,
                                            Pri3_text

                                            // (ser_user == null) ? '' : ser_user
                                            );
                                  } else if (_ReportValue_type ==
                                      'สัญญาเช่าที่ดิน') {
                                    Pdfgen_Agreement_Choice
                                        .exportPDF_Agreement_Choice(
                                            context,
                                            '${widget.Get_Value_NameShop_index}',
                                            '${widget.Get_Value_cid}',
                                            _verticalGroupValue,
                                            Form_nameshop.text,
                                            Form_typeshop.text,
                                            Form_bussshop.text,
                                            Form_bussscontact.text,
                                            Form_address.text,
                                            Form_tel.text,
                                            Form_email.text,
                                            Form_tax.text,
                                            Form_ln.text,
                                            Form_zn.text,
                                            Form_area.text,
                                            Form_qty.text,
                                            Form_sdate.text,
                                            Form_ldate.text,
                                            Form_period.text,
                                            Form_rtname.text,
                                            quotxSelectModels,
                                            _TransModels,
                                            '$renTal_name',
                                            '${renTalModels[0].bill_addr}',
                                            '${renTalModels[0].bill_email}',
                                            '${renTalModels[0].bill_tel}',
                                            '${renTalModels[0].bill_tax}',
                                            '${renTalModels[0].bill_name}',
                                            newValuePDFimg,
                                            tableData00,
                                            TitleType_Default_Receipt_Name,
                                            Datex_text,
                                            _ReportValue_type_docOttor);
                                  } else if (_ReportValue_type ==
                                      'สัญญาห้องเช่า') {
                                    Pdfgen_Agreement_Choice2
                                        .exportPDF_Agreement_Choice2(
                                            context,
                                            '${widget.Get_Value_NameShop_index}',
                                            '${widget.Get_Value_cid}',
                                            _verticalGroupValue,
                                            Form_nameshop.text,
                                            Form_typeshop.text,
                                            Form_bussshop.text,
                                            Form_bussscontact.text,
                                            Form_address.text,
                                            Form_tel.text,
                                            Form_email.text,
                                            Form_tax.text,
                                            Form_ln.text,
                                            Form_zn.text,
                                            Form_area.text,
                                            Form_qty.text,
                                            Form_sdate.text,
                                            Form_ldate.text,
                                            Form_period.text,
                                            Form_rtname.text,
                                            quotxSelectModels,
                                            _TransModels,
                                            '$renTal_name',
                                            '${renTalModels[0].bill_addr}',
                                            '${renTalModels[0].bill_email}',
                                            '${renTalModels[0].bill_tel}',
                                            '${renTalModels[0].bill_tax}',
                                            '${renTalModels[0].bill_name}',
                                            newValuePDFimg,
                                            tableData00,
                                            TitleType_Default_Receipt_Name,
                                            Datex_text,
                                            _ReportValue_type_docOttor);
                                  } else if (_ReportValue_type ==
                                      'สัญญาบริการ') {
                                    Pdfgen_Agreement_Choice3
                                        .exportPDF_Agreement_Choice3(
                                            context,
                                            '${widget.Get_Value_NameShop_index}',
                                            '${widget.Get_Value_cid}',
                                            _verticalGroupValue,
                                            Form_nameshop.text,
                                            Form_typeshop.text,
                                            Form_bussshop.text,
                                            Form_bussscontact.text,
                                            Form_address.text,
                                            Form_tel.text,
                                            Form_email.text,
                                            Form_tax.text,
                                            Form_ln.text,
                                            Form_zn.text,
                                            Form_area.text,
                                            Form_qty.text,
                                            Form_sdate.text,
                                            Form_ldate.text,
                                            Form_period.text,
                                            Form_rtname.text,
                                            quotxSelectModels,
                                            _TransModels,
                                            '$renTal_name',
                                            '${renTalModels[0].bill_addr}',
                                            '${renTalModels[0].bill_email}',
                                            '${renTalModels[0].bill_tel}',
                                            '${renTalModels[0].bill_tax}',
                                            '${renTalModels[0].bill_name}',
                                            newValuePDFimg,
                                            tableData00,
                                            TitleType_Default_Receipt_Name,
                                            Datex_text,
                                            _ReportValue_type_docOttor);
                                  } else if (_ReportValue_type ==
                                      'สัญญาเช่าพื้นที่') {
                                    Pdfgen_Agreement_Ama1000.exportPDF_Agreement_Ama1000(
                                        context,
                                        '${widget.Get_Value_NameShop_index}',
                                        '${widget.Get_Value_cid}',
                                        _verticalGroupValue,
                                        Form_nameshop.text,
                                        Form_typeshop.text,
                                        Form_bussshop.text,
                                        Form_bussscontact.text,
                                        Form_address.text,
                                        Form_tel.text,
                                        Form_email.text,
                                        Form_tax.text,
                                        Form_ln.text,
                                        Form_zn.text,
                                        Form_area.text,
                                        Form_qty.text,
                                        Form_sdate.text,
                                        Form_ldate.text,
                                        Form_period.text,
                                        Form_rtname.text,
                                        quotxSelectModels,
                                        _TransModels,
                                        '$renTal_name',
                                        '${renTalModels[0].bill_addr}',
                                        '${renTalModels[0].bill_email}',
                                        '${renTalModels[0].bill_tel}',
                                        '${renTalModels[0].bill_tax}',
                                        '${renTalModels[0].bill_name}',
                                        'files/$foder/contract/${renTalModels[0].img}',
                                        'files/$foder/contract/${renTalModels[0].imglogo}',
                                        newValuePDFimg,
                                        tableData00,
                                        TitleType_Default_Receipt_Name,
                                        Datex_text,
                                        FormNameFile_text);
                                  } else if (_ReportValue_type ==
                                      'อาคารพาณิชย์') {
                                    Pdfgen_Agreement_Ortor
                                        .exportPDF_Agreement_Ortor(
                                            context,
                                            '${widget.Get_Value_NameShop_index}',
                                            '${widget.Get_Value_cid}',
                                            _verticalGroupValue,
                                            Form_nameshop.text,
                                            Form_typeshop.text,
                                            Form_bussshop.text,
                                            Form_bussscontact.text,
                                            Form_address.text,
                                            Form_tel.text,
                                            Form_email.text,
                                            Form_tax.text,
                                            Form_ln.text,
                                            Form_zn.text,
                                            Form_area.text,
                                            Form_qty.text,
                                            Form_sdate.text,
                                            Form_ldate.text,
                                            Form_period.text,
                                            Form_rtname.text,
                                            quotxSelectModels,
                                            _TransModels,
                                            '$renTal_name',
                                            '${renTalModels[0].bill_addr}',
                                            '${renTalModels[0].bill_email}',
                                            '${renTalModels[0].bill_tel}',
                                            '${renTalModels[0].bill_tax}',
                                            '${renTalModels[0].bill_name}',
                                            newValuePDFimg,
                                            tableData00,
                                            TitleType_Default_Receipt_Name,
                                            Datex_text,
                                            _ReportValue_type_docOttor);
                                  } else {}

                                  // (ren.toString() == '82')
                                  //     ?
                                  // Pdfgen_Agreement_Ekkamai
                                  //         .exportPDF_Agreement_Ekkamai(
                                  //             context,
                                  //             '${widget.Get_Value_NameShop_index}',
                                  //             '${widget.Get_Value_cid}',
                                  //             _verticalGroupValue,
                                  //             Form_nameshop.text,
                                  //             Form_typeshop.text,
                                  //             Form_bussshop.text,
                                  //             Form_bussscontact.text,
                                  //             Form_address.text,
                                  //             Form_tel.text,
                                  //             Form_email.text,
                                  //             Form_tax.text,
                                  //             Form_ln.text,
                                  //             Form_zn.text,
                                  //             Form_area.text,
                                  //             Form_qty.text,
                                  //             Form_sdate.text,
                                  //             Form_ldate.text,
                                  //             Form_period.text,
                                  //             Form_rtname.text,
                                  //             quotxSelectModels,
                                  //             _TransModels,
                                  //             '$renTal_name',
                                  //             '${renTalModels[0].bill_addr}',
                                  //             '${renTalModels[0].bill_email}',
                                  //             '${renTalModels[0].bill_tel}',
                                  //             '${renTalModels[0].bill_tax}',
                                  //             '${renTalModels[0].bill_name}',
                                  //             newValuePDFimg,
                                  //             tableData00)
                                  //     :
                                  //(ren.toString() == '90' ||
                                  //             ren.toString() == '50')
                                  //         ?
                                  // Pdfgen_Agreement_JSpace
                                  //             .exportPDF_Agreement_JSpace(
                                  //             context,
                                  //             '${widget.Get_Value_NameShop_index}',
                                  //             '${widget.Get_Value_cid}',
                                  //             _verticalGroupValue,
                                  //             Form_nameshop.text,
                                  //             Form_typeshop.text,
                                  //             Form_bussshop.text,
                                  //             Form_bussscontact.text,
                                  //             Form_address.text,
                                  //             Form_tel.text,
                                  //             Form_email.text,
                                  //             Form_tax.text,
                                  //             Form_ln.text,
                                  //             Form_zn.text,
                                  //             Form_area.text,
                                  //             Form_qty.text,
                                  //             Form_sdate.text,
                                  //             Form_ldate.text,
                                  //             Form_period.text,
                                  //             Form_rtname.text,
                                  //             quotxSelectModels,
                                  //             _TransModels,
                                  //             '$renTal_name',
                                  //             '${renTalModels[0].bill_addr}',
                                  //             '${renTalModels[0].bill_email}',
                                  //             '${renTalModels[0].bill_tel}',
                                  //             '${renTalModels[0].bill_tax}',
                                  //             '${renTalModels[0].bill_name}',
                                  //             newValuePDFimg,
                                  //             tableData00,

                                  //             // (ser_user == null) ? '' : ser_user
                                  //           )
                                  //         :
                                  // Pdfgen_Agreement.exportPDF_Agreement(
                                  //             context,
                                  //             '${widget.Get_Value_NameShop_index}',
                                  //             '${widget.Get_Value_cid}',
                                  //             _verticalGroupValue,
                                  //             Form_nameshop.text,
                                  //             Form_typeshop.text,
                                  //             Form_bussshop.text,
                                  //             Form_bussscontact.text,
                                  //             Form_address.text,
                                  //             Form_tel.text,
                                  //             Form_email.text,
                                  //             Form_tax.text,
                                  //             Form_ln.text,
                                  //             Form_zn.text,
                                  //             Form_area.text,
                                  //             Form_qty.text,
                                  //             Form_sdate.text,
                                  //             Form_ldate.text,
                                  //             Form_period.text,
                                  //             Form_rtname.text,
                                  //             quotxSelectModels,
                                  //             _TransModels,
                                  //             '$renTal_name',
                                  //             '${renTalModels[0].bill_addr}',
                                  //             '${renTalModels[0].bill_email}',
                                  //             '${renTalModels[0].bill_tel}',
                                  //             '${renTalModels[0].bill_tax}',
                                  //             '${renTalModels[0].bill_name}',
                                  //             newValuePDFimg,
                                  //             tableData00

                                  //             // (ser_user == null) ? '' : ser_user
                                  //             );
                                },
                          child: Container(
                            width: 100,
                            decoration: const BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10)),
                            ),
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Text(
                                'พิมพ์',
                                style: TextStyle(
                                  color: Colors.white,
                                  //fontWeight: FontWeight.bold, color:

                                  // fontWeight: FontWeight.bold,
                                  fontFamily: Font_.Fonts_T,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: InkWell(
                          onTap: () => Navigator.pop(context, 'OK'),
                          child: Container(
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
                            child: Center(
                              child: Text(
                                'ปิด',
                                style: TextStyle(
                                  color: Colors.white,
                                  //fontWeight: FontWeight.bold, color:

                                  // fontWeight: FontWeight.bold,
                                  fontFamily: Font_.Fonts_T,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        // color: Colors.red,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          // color: AppbackgroundColor.Sub_Abg_Colors,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
        ),
        padding: const EdgeInsets.all(2.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  colorFilter: new ColorFilter.mode(
                      Colors.white.withOpacity(0.05), BlendMode.dstATop),
                  image: AssetImage("images/BG_im.png"),
                  fit: BoxFit.cover,
                ),
                color: AppbackgroundColor.Sub_Abg_Colors,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                // border: Border.all(color: Colors.white, width: 1),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(children: [
                      Expanded(
                        child: Column(
                          children: [
                            Container(
                              width: 350,
                              // height: 135,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 3,
                                    blurRadius: 5,
                                    offset: const Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                                image: const DecorationImage(
                                  image: AssetImage("images/pngegg2.png"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: (pic_tenant == null ||
                                      pic_tenant.toString() == '')
                                  ? const SizedBox(
                                      height: 200,
                                    )
                                  : SizedBox(
                                      height: 200,
                                      child: GestureDetector(
                                        onTap: () {
                                          showDialog<String>(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                AlertDialog(
                                              shape:
                                                  const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  20.0))),
                                              title: Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.25,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.35,
                                                  child: Image.network(
                                                    '${MyConstant().domain}/files/$foder/contract/$pic_tenant',
                                                    fit: BoxFit.contain,
                                                  )),
                                              actions: <Widget>[
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
                                                          onPressed: () =>
                                                              Navigator.pop(
                                                                  context,
                                                                  'OK'),
                                                          child: const Text(
                                                            'ปิด',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily:
                                                                    FontWeight_
                                                                        .Fonts_T),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                        child: Image.network(
                                          '${MyConstant().domain}/files/$foder/contract/$pic_tenant',
                                          fit: BoxFit.cover,
                                        ),
                                      )),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const AutoSizeText(
                                  minFontSize: 10,
                                  maxFontSize: 15,
                                  'รูปผู้เช่า',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color:
                                          PeopleChaoScreen_Color.Colors_Text1_,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: FontWeight_.Fonts_T),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      fiew = 'pic_tenant';
                                    });
                                    uploadImage(ImageSource.gallery);
                                    // _getFromGallery2();
                                  },
                                  icon: const Icon(
                                    Icons.edit,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Container(
                              width: 350,
                              // height: 135,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 3,
                                    blurRadius: 5,
                                    offset: const Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                                image: const DecorationImage(
                                  image: AssetImage("images/pngegg2.png"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: (pic_shop == null ||
                                      pic_shop.toString() == '')
                                  ? const SizedBox(
                                      height: 200,
                                    )
                                  : SizedBox(
                                      height: 200,
                                      child: GestureDetector(
                                        onTap: () {
                                          showDialog<String>(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                AlertDialog(
                                              shape:
                                                  const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  20.0))),
                                              title: Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.25,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.35,
                                                  child: Image.network(
                                                    '${MyConstant().domain}/files/$foder/contract/$pic_shop',
                                                    fit: BoxFit.contain,
                                                  )),
                                              actions: <Widget>[
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
                                                          onPressed: () =>
                                                              Navigator.pop(
                                                                  context,
                                                                  'OK'),
                                                          child: const Text(
                                                            'ปิด',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily:
                                                                    FontWeight_
                                                                        .Fonts_T),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                        child: Image.network(
                                          '${MyConstant().domain}/files/$foder/contract/$pic_shop',
                                          fit: BoxFit.cover,
                                        ),
                                      )),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const AutoSizeText(
                                  minFontSize: 10,
                                  maxFontSize: 15,
                                  'รูปร้านค้า',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color:
                                          PeopleChaoScreen_Color.Colors_Text1_,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: FontWeight_.Fonts_T),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      fiew = 'pic_shop';
                                    });
                                    uploadImage(ImageSource.gallery);
                                    // _getFromGallery2();
                                  },
                                  icon: const Icon(
                                    Icons.edit,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Container(
                              width: 350,
                              // height: 135,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 3,
                                    blurRadius: 5,
                                    offset: const Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                                image: const DecorationImage(
                                  image: AssetImage("images/pngegg2.png"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: (pic_plan == null ||
                                      pic_plan.toString() == '')
                                  ? const SizedBox(
                                      height: 200,
                                    )
                                  : SizedBox(
                                      height: 200,
                                      child: GestureDetector(
                                        onTap: () {
                                          showDialog<String>(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                AlertDialog(
                                              shape:
                                                  const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  20.0))),
                                              title: Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.25,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.35,
                                                  child: Image.network(
                                                    '${MyConstant().domain}/files/$foder/contract/$pic_plan',
                                                    fit: BoxFit.contain,
                                                  )),
                                              actions: <Widget>[
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
                                                          onPressed: () =>
                                                              Navigator.pop(
                                                                  context,
                                                                  'OK'),
                                                          child: const Text(
                                                            'ปิด',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily:
                                                                    FontWeight_
                                                                        .Fonts_T),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                        child: Image.network(
                                          '${MyConstant().domain}/files/$foder/contract/$pic_plan',
                                          fit: BoxFit.cover,
                                        ),
                                      )),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const AutoSizeText(
                                  minFontSize: 10,
                                  maxFontSize: 15,
                                  'รูปแผนฝัง',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color:
                                          PeopleChaoScreen_Color.Colors_Text1_,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: FontWeight_.Fonts_T),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      fiew = 'pic_plan';
                                    });
                                    uploadImage(ImageSource.gallery);
                                    // _getFromGallery2();
                                  },
                                  icon: const Icon(
                                    Icons.edit,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ]),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            // _generatePdf();
                          },
                          child: const AutoSizeText(
                            minFontSize: 10,
                            maxFontSize: 15,
                            '1.ข้อมูลผู้เช่า',
                            style: TextStyle(
                                color: PeopleChaoScreen_Color.Colors_Text1_,
                                fontWeight: FontWeight.bold,
                                fontFamily: FontWeight_.Fonts_T),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const Expanded(
                          flex: 1,
                          child: Text(
                            'ประเภท',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: PeopleChaoScreen_Color.Colors_Text2_,
                                // fontWeight: FontWeight.bold,
                                fontFamily: Font_.Fonts_T
                                //fontSize: 10.0
                                ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.3),
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15),
                                  bottomLeft: Radius.circular(15),
                                  bottomRight: Radius.circular(15),
                                ),
                                border:
                                    Border.all(color: Colors.grey, width: 1),
                              ),
                              padding: const EdgeInsets.all(15),
                              child: Text(
                                '$_verticalGroupValue',
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                    color: PeopleChaoScreen_Color.Colors_Text2_,
                                    // fontWeight: FontWeight.bold,
                                    fontFamily: Font_.Fonts_T
                                    //fontSize: 10.0
                                    ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Row(
                            children: [
                              Text(
                                'บัตรผู้เช่า',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: PeopleChaoScreen_Color.Colors_Text2_,
                                    // fontWeight: FontWeight.bold,
                                    fontFamily: Font_.Fonts_T
                                    //fontSize: 10.0
                                    ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: AppbackgroundColor.Sub_Abg_Colors,
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10)),
                                  border:
                                      Border.all(color: Colors.grey, width: 1),
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
                                      color: Colors.green,
                                      fontFamily: Font_.Fonts_T),
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
                                        (color) =>
                                            color.value == selectedColor.value);
                                    setState(() {
                                      indexcardColor = index;
                                    });

                                    changeCardColor(colorList[index]);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 2,
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
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 300,
                                          // height: 135,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: const BorderRadius
                                                    .only(
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(0),
                                                bottomLeft: Radius.circular(10),
                                                bottomRight:
                                                    Radius.circular(0)),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.5),
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
                                                  '${Form_sdate.text} ถึง ${Form_ldate.text}',
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
                                                    padding: const EdgeInsets
                                                        .fromLTRB(4, 0, 0, 0),
                                                    child: Container(
                                                      color: Colors.white,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Center(
                                                              child: Container(
                                                            height: 84,
                                                            width: 84,
                                                            child:
                                                                SfBarcodeGenerator(
                                                              value:
                                                                  '${widget.Get_Value_cid}',
                                                              symbology:
                                                                  QRCode(),
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
                                                                    bottomLeft:
                                                                        Radius.circular(
                                                                            10),
                                                                    bottomRight:
                                                                        Radius.circular(
                                                                            10)),
                                                                // border: Border.all(color: Colors.grey, width: 1),
                                                              ),
                                                              padding:
                                                                  EdgeInsets
                                                                      .fromLTRB(
                                                                          2,
                                                                          2,
                                                                          2,
                                                                          0),
                                                              child: Text(
                                                                'ลงชื่อ.....................................',
                                                                maxLines: 1,
                                                                style:
                                                                    TextStyle(
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
                                                          //     size: 110,
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
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                4, 8, 0, 8),
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
                                                                '${widget.Get_Value_cid}',
                                                                maxLines: 1,
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize:
                                                                      11.0,
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
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 9.0,
                                                                  color: PeopleChaoScreen_Color
                                                                      .Colors_Text1_,
                                                                  //fontWeight: FontWeight.bold,
                                                                  fontFamily: Font_
                                                                      .Fonts_T,
                                                                ),
                                                              ),
                                                              Text(
                                                                '${Form_bussscontact.text}',
                                                                maxLines: 1,
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize:
                                                                      11.0,
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
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 9.0,
                                                                  color: PeopleChaoScreen_Color
                                                                      .Colors_Text1_,
                                                                  // fontWeight: FontWeight.bold,
                                                                  fontFamily: Font_
                                                                      .Fonts_T,
                                                                ),
                                                              ),
                                                              Text(
                                                                '${Form_nameshop.text}',
                                                                maxLines: 1,
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize:
                                                                      11.0,
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
                                                                'พื้นที่ : ${Form_ln.text} ',
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
                                                                'โซน : ${Form_zn.text}',
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
                                                              Icons.print,
                                                              color:
                                                                  Colors.white,
                                                            )),
                                                          ),
                                                          onTap: () async {
                                                            showDialog(
                                                                barrierDismissible:
                                                                    false,
                                                                context:
                                                                    context,
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
                                                                        stream: Stream.periodic(const Duration(seconds: 1)),
                                                                        builder: (context, snapshot) {
                                                                          return const SizedBox(
                                                                              // height: 20,
                                                                              width: 350,
                                                                              child: Padding(
                                                                                padding: EdgeInsets.all(20.0),
                                                                                child: Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                                  children: [
                                                                                    Padding(
                                                                                      padding: EdgeInsets.fromLTRB(0, 0, 8, 0),
                                                                                      child: SizedBox(height: 30, child: CircularProgressIndicator()),
                                                                                    ),
                                                                                    Text(
                                                                                      'กำลัง Download และแปลงไฟล์ PDF...  ',
                                                                                      style: TextStyle(
                                                                                        color: PeopleChaoScreen_Color.Colors_Text1_,
                                                                                        fontWeight: FontWeight.bold,
                                                                                        fontFamily: FontWeight_.Fonts_T,
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ));
                                                                        }),
                                                                  );
                                                                });
                                                            Pdfgen_QR_2.displayPdf_QR2(
                                                                context,
                                                                renTal_name,
                                                                widget
                                                                    .Get_Value_cid,
                                                                '${Form_bussscontact.text}',
                                                                '${Form_sdate.text} - ${Form_ldate.text}',
                                                                '${Form_nameshop.text}',
                                                                '${Form_ln.text}',
                                                                '${Form_zn.text}',
                                                                indexcardColor);
                                                          },
                                                        ),
                                                      )
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
                                            borderRadius:
                                                const BorderRadius.only(
                                                    topLeft: Radius.circular(0),
                                                    topRight:
                                                        Radius.circular(10),
                                                    bottomLeft:
                                                        Radius.circular(0),
                                                    bottomRight:
                                                        Radius.circular(10)),
                                          ),
                                          // child: Column(
                                          //   mainAxisAlignment:
                                          //       MainAxisAlignment.center,
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
                                ],
                              ),
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
                        const Expanded(
                          flex: 1,
                          child: Text(
                            'ชื่อร้านค้า',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: PeopleChaoScreen_Color.Colors_Text2_,
                                // fontWeight: FontWeight.bold,
                                fontFamily: Font_.Fonts_T
                                //fontSize: 10.0
                                ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
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
                              keyboardType: TextInputType.number,
                              showCursor: false, //add this line
                              readOnly: true,
                              controller: Form_nameshop,

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
                                      color: Colors.black54,

                                      // fontWeight: FontWeight.bold,
                                      fontFamily: Font_.Fonts_T
                                      //fontSize: 10.0
                                      )),
                            ),
                          ),
                        ),
                        const Expanded(
                          flex: 1,
                          child: Text(
                            'ประเภทร้านค้า',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: PeopleChaoScreen_Color.Colors_Text2_,
                                // fontWeight: FontWeight.bold,
                                fontFamily: Font_.Fonts_T
                                //fontSize: 10.0
                                ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
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
                              keyboardType: TextInputType.number,
                              showCursor: false, //add this line
                              readOnly: true,
                              controller: Form_typeshop,
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
                                  labelStyle: const TextStyle(
                                      color: Colors.black54,

                                      // fontWeight: FontWeight.bold,
                                      fontFamily: Font_.Fonts_T
                                      //fontSize: 10.0

                                      )),
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
                        const Expanded(
                          flex: 1,
                          child: Text(
                            'ชื่อผู้เช่า/บริษัท',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: PeopleChaoScreen_Color.Colors_Text2_,
                                // fontWeight: FontWeight.bold,
                                fontFamily: Font_.Fonts_T
                                //fontSize: 10.0
                                ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
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
                              keyboardType: TextInputType.number,
                              showCursor: false, //add this line
                              readOnly: true,
                              controller: Form_bussshop,
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
                                  labelStyle: const TextStyle(
                                      color: Colors.black54,

                                      // fontWeight: FontWeight.bold,
                                      fontFamily: Font_.Fonts_T
                                      //fontSize: 10.0

                                      )),
                            ),
                          ),
                        ),
                        const Expanded(
                          flex: 1,
                          child: Text(
                            'ชื่อบุคคลติดต่อ',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: PeopleChaoScreen_Color.Colors_Text2_,
                                // fontWeight: FontWeight.bold,
                                fontFamily: Font_.Fonts_T
                                //fontSize: 10.0
                                ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
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
                              keyboardType: TextInputType.number,
                              showCursor: false, //add this line
                              readOnly: true,
                              controller: Form_bussscontact,
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
                                  labelStyle: const TextStyle(
                                      color: Colors.black54,

                                      // fontWeight: FontWeight.bold,
                                      fontFamily: Font_.Fonts_T
                                      //fontSize: 10.0

                                      )),
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
                        const Expanded(
                          flex: 1,
                          child: Text(
                            'ที่อยู่',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: PeopleChaoScreen_Color.Colors_Text2_,
                                // fontWeight: FontWeight.bold,
                                fontFamily: Font_.Fonts_T
                                //fontSize: 10.0
                                ),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Container(
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
                              keyboardType: TextInputType.number,
                              showCursor: false, //add this line
                              readOnly: true,
                              controller: Form_address,
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
                                  labelStyle: const TextStyle(
                                      color: Colors.black54,

                                      // fontWeight: FontWeight.bold,
                                      fontFamily: Font_.Fonts_T
                                      //fontSize: 10.0

                                      )),
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
                        const Expanded(
                          flex: 1,
                          child: Text(
                            'เบอร์โทร',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: PeopleChaoScreen_Color.Colors_Text2_,
                                // fontWeight: FontWeight.bold,
                                fontFamily: Font_.Fonts_T
                                //fontSize: 10.0
                                ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
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
                              keyboardType: TextInputType.number,
                              showCursor: false, //add this line
                              readOnly: true,
                              controller: Form_tel,
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
                                  labelStyle: const TextStyle(
                                      color: Colors.black54,

                                      // fontWeight: FontWeight.bold,
                                      fontFamily: Font_.Fonts_T
                                      //fontSize: 10.0
                                      )),
                            ),
                          ),
                        ),
                        const Expanded(
                          flex: 1,
                          child: Text(
                            'อีเมล',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: PeopleChaoScreen_Color.Colors_Text2_,
                                // fontWeight: FontWeight.bold,
                                fontFamily: Font_.Fonts_T
                                //fontSize: 10.0
                                ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
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
                              keyboardType: TextInputType.number,
                              showCursor: false, //add this line
                              readOnly: true,
                              controller: Form_email,
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
                                  labelStyle: const TextStyle(
                                      color: Colors.black54,

                                      // fontWeight: FontWeight.bold,
                                      fontFamily: Font_.Fonts_T
                                      //fontSize: 10.0

                                      )),
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
                        const Expanded(
                          flex: 1,
                          child: Text(
                            'ID/TAX ID',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: PeopleChaoScreen_Color.Colors_Text2_,
                                // fontWeight: FontWeight.bold,
                                fontFamily: Font_.Fonts_T
                                //fontSize: 10.0
                                ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
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
                              keyboardType: TextInputType.number,
                              showCursor: false, //add this line
                              readOnly: true,
                              controller: Form_tax,
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
                                  labelStyle: const TextStyle(
                                      color: Colors.black54,

                                      // fontWeight: FontWeight.bold,
                                      fontFamily: Font_.Fonts_T
                                      //fontSize: 10.0

                                      )),
                            ),
                          ),
                        ),
                        const Expanded(
                          flex: 1,
                          child: Text(
                            'เลขที่อ้างอิง',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: PeopleChaoScreen_Color.Colors_Text2_,
                                // fontWeight: FontWeight.bold,
                                fontFamily: Font_.Fonts_T
                                //fontSize: 10.0
                                ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
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
                              // keyboardType: TextInputType.number,
                              // showCursor: false, //add this line
                              // readOnly: true,
                              controller: Form_wnote,
                              cursorColor: Colors.green,
                              onFieldSubmitted: (value) async {
                                print(value);

                                SharedPreferences preferences =
                                    await SharedPreferences.getInstance();
                                var ren = preferences.getString('renTalSer');
                                var ciddoc = widget.Get_Value_cid;
                                String url =
                                    '${MyConstant().domain}/UP_wnote.php?isAdd=true&ren=$ren&ciddoc=$ciddoc&value=$value';

                                try {
                                  var response = await http.get(Uri.parse(url));

                                  var result = json.decode(response.body);
                                  print(result);
                                  if (result.toString() == 'true') {
                                    setState(() {
                                      read_data();
                                    });
                                    Insert_log.Insert_logs('ผู้เช่า',
                                        'เรียกดู:${widget.Get_Value_cid} >> แก้ไขเลขอ้างอิงผู้เช่า : ${Form_wnote.text} >> $value');
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content:
                                              Text('แก้ไขข้อมูลผู้เช่าสำเร็จ')),
                                    );
                                  }
                                } catch (e) {
                                  print(e);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(' ผิดพลาด กรุณาลองใหม่!',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: Font_.Fonts_T))),
                                  );
                                }
                                read_data();
                              },
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
                                  labelStyle: const TextStyle(
                                      color: Colors.black54,

                                      // fontWeight: FontWeight.bold,
                                      fontFamily: Font_.Fonts_T
                                      //fontSize: 10.0

                                      )),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  renTal_lavel <= 3
                      ? SizedBox()
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: InkWell(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.red[300],
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(8),
                                            topRight: Radius.circular(8),
                                            bottomLeft: Radius.circular(8),
                                            bottomRight: Radius.circular(8)),
                                      ),
                                      padding: const EdgeInsets.all(8.0),
                                      child: const Text(
                                        'แก้ไขข้อมูลผู้เช่า',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: Font_.Fonts_T
                                            //fontSize: 10.0
                                            ),
                                      ),
                                    ),
                                    onTap: () {
                                      select_coutumerAll(context);
                                    })),
                          ],
                        ),
                ],
              ),
            ),

            Container(
              color: AppbackgroundColor.Sub_Abg_Colors,
              child: Column(
                children: [
                  const Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: AutoSizeText(
                          minFontSize: 10,
                          maxFontSize: 15,
                          '2.พื้นที่เช่า',
                          style: TextStyle(
                              color: PeopleChaoScreen_Color.Colors_Text1_,
                              fontWeight: FontWeight.bold,
                              fontFamily: FontWeight_.Fonts_T),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const Expanded(
                          flex: 1,
                          child: Text(
                            'รหัสพื้นที่เช่า',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: PeopleChaoScreen_Color.Colors_Text2_,
                                //fontWeight: FontWeight.bold,
                                fontFamily: Font_.Fonts_T),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
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
                              keyboardType: TextInputType.number,
                              showCursor: false, //add this line
                              readOnly: true,
                              controller: Form_ln,
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
                                  labelStyle: const TextStyle(
                                      color: Colors.black54,
                                      //fontWeight: FontWeight.bold,
                                      fontFamily: Font_.Fonts_T)),
                            ),
                          ),
                        ),
                        const Expanded(
                          flex: 1,
                          child: Text(
                            'โซนพื้นที่เช่า',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: PeopleChaoScreen_Color.Colors_Text2_,
                                //fontWeight: FontWeight.bold,
                                fontFamily: Font_.Fonts_T),
                          ),
                        ),
                        Expanded(
                            flex: 2,
                            child: Container(
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
                                keyboardType: TextInputType.number,
                                showCursor: false, //add this line
                                readOnly: true,
                                controller: Form_zn,
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
                                    labelStyle: const TextStyle(
                                        color: Colors.black54,
                                        fontFamily: Font_.Fonts_T)),
                              ),
                            )),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const Expanded(
                          flex: 1,
                          child: Text(
                            'รวมพื้นที่เช่า(ตร.ม.)',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: PeopleChaoScreen_Color.Colors_Text2_,
                                //fontWeight: FontWeight.bold,
                                fontFamily: Font_.Fonts_T),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
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
                              keyboardType: TextInputType.number,
                              showCursor: false, //add this line
                              readOnly: true,
                              controller: Form_area,
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
                                  labelStyle: const TextStyle(
                                      color: Colors.black54,
                                      fontFamily: Font_.Fonts_T)),
                            ),
                          ),
                        ),
                        const Expanded(
                          flex: 1,
                          child: Text(
                            'จำนวนพื้นที่',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: PeopleChaoScreen_Color.Colors_Text2_,
                                //fontWeight: FontWeight.bold,
                                fontFamily: Font_.Fonts_T),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
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
                              keyboardType: TextInputType.number,
                              showCursor: false, //add this line
                              readOnly: true,
                              controller: Form_qty,
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
                                  labelStyle: const TextStyle(
                                      color: Colors.black54,
                                      fontFamily: Font_.Fonts_T)),
                            ),
                          ),
                        ),
                        const Expanded(
                          flex: 1,
                          child: Text(
                            'ล็อค/ห้อง',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: PeopleChaoScreen_Color.Colors_Text2_,
                                //fontWeight: FontWeight.bold,
                                fontFamily: Font_.Fonts_T),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: AutoSizeText(
                          minFontSize: 10,
                          maxFontSize: 15,
                          '3.ข้อมูลสัญญา/เสนอราคา',
                          style: TextStyle(
                              color: PeopleChaoScreen_Color.Colors_Text1_,
                              fontWeight: FontWeight.bold,
                              fontFamily: FontWeight_.Fonts_T
                              //fontSize: 10.0
                              ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const Expanded(
                          flex: 1,
                          child: Text(
                            'วันเริ่มสัญญา/เสนอราคา',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: PeopleChaoScreen_Color.Colors_Text2_,
                                //fontWeight: FontWeight.bold,
                                fontFamily: Font_.Fonts_T),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
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
                              keyboardType: TextInputType.number,
                              showCursor: false, //add this line
                              readOnly: true,
                              controller: Form_sdate,
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
                                  labelStyle: const TextStyle(
                                      color: Colors.black54,
                                      fontFamily: Font_.Fonts_T)),
                            ),
                          ),
                        ),
                        const Expanded(
                          flex: 1,
                          child: Text(
                            'วันสิ้นสุดสัญญา/เสนอราคา',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: PeopleChaoScreen_Color.Colors_Text2_,
                                //fontWeight: FontWeight.bold,
                                fontFamily: Font_.Fonts_T),
                          ),
                        ),
                        Expanded(
                            flex: 2,
                            child: Container(
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
                                keyboardType: TextInputType.number,
                                showCursor: false, //add this line
                                readOnly: true,
                                controller: Form_ldate,
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
                                    labelStyle: const TextStyle(
                                        color: Colors.black54,
                                        fontFamily: Font_.Fonts_T)),
                              ),
                            )),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const Expanded(
                          flex: 1,
                          child: Text(
                            'ระยะเวลาการเช่า',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: PeopleChaoScreen_Color.Colors_Text2_,
                                //fontWeight: FontWeight.bold,
                                fontFamily: Font_.Fonts_T),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
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
                              keyboardType: TextInputType.number,
                              showCursor: false, //add this line
                              readOnly: true,
                              controller: Form_period,
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
                                  labelStyle: const TextStyle(
                                      color: Colors.black54,
                                      fontFamily: Font_.Fonts_T)),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            '${Form_rtname.text}',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: PeopleChaoScreen_Color.Colors_Text2_,
                                //fontWeight: FontWeight.bold,
                                fontFamily: Font_.Fonts_T),
                          ),
                        ),
                        Expanded(
                            flex: 2,
                            child: Container(
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
                            )),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          child: Container(
                            width: 200,
                            // height: 40,
                            decoration: BoxDecoration(
                              color: Colors.orange[300],
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10)),
                            ),

                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(4.0),
                                  child: Icon(
                                    Icons.print,
                                    color: Colors.black,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'ใบเสนอราคา',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: PeopleChaoScreen_Color
                                            .Colors_Text2_,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: Font_.Fonts_T),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          onTap: () async {
                            List newValuePDFimg = [];
                            for (int index = 0; index < 1; index++) {
                              if (renTalModels[0].imglogo!.trim() == '') {
                                // newValuePDFimg.add(
                                //     'https://png.pngtree.com/png-vector/20190820/ourmid/pngtree-no-image-vector-illustration-isolated-png-image_1694547.jpg');
                              } else {
                                newValuePDFimg.add(
                                    '${MyConstant().domain}/files/$foder/logo/${renTalModels[0].imglogo!.trim()}');
                              }
                            }
                            SharedPreferences preferences =
                                await SharedPreferences.getInstance();
                            var renTal_name =
                                preferences.getString('renTalName');
                            Pdfgen_RentalInforma.exportPDF_RentalInforma(
                              context,
                              '${widget.Get_Value_NameShop_index}',
                              '${widget.Get_Value_cid}',
                              _verticalGroupValue,
                              Form_nameshop.text,
                              Form_typeshop.text,
                              Form_bussshop.text,
                              Form_bussscontact.text,
                              Form_address.text,
                              Form_tel.text,
                              Form_email.text,
                              Form_tax.text,
                              Form_ln.text,
                              Form_zn.text,
                              Form_area.text,
                              Form_qty.text,
                              Form_sdate.text,
                              Form_ldate.text,
                              Form_period.text,
                              Form_rtname.text,
                              Form_cdate.text,
                              quotxSelectModels,
                              _TransModels,
                              '$renTal_name',
                              ' ${renTalModels[0].bill_addr}',
                              ' ${renTalModels[0].bill_email}',
                              ' ${renTalModels[0].bill_tel}',
                              ' ${renTalModels[0].bill_tax}',
                              ' ${renTalModels[0].bill_name}',
                              newValuePDFimg,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // const Row(
            //   children: [
            //     Padding(
            //       padding: EdgeInsets.all(8.0),
            //       child: AutoSizeText(
            //         minFontSize: 10,
            //         maxFontSize: 15,
            //         '4.User & Password ',
            //         style: TextStyle(
            //             color: PeopleChaoScreen_Color.Colors_Text1_,
            //             fontWeight: FontWeight.bold,
            //             fontFamily: FontWeight_.Fonts_T
            //             //fontSize: 10.0
            //             ),
            //       ),
            //     ),
            //   ],
            // ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Row(
            //     children: [
            //       const Text(
            //         'User & Password ของผู้เช่า ',
            //         textAlign: TextAlign.start,
            //         style: TextStyle(
            //             color: PeopleChaoScreen_Color.Colors_Text2_,
            //             // fontWeight: FontWeight.bold,
            //             fontFamily: Font_.Fonts_T
            //             //fontSize: 10.0
            //             ),
            //       ),
            //       Padding(
            //         padding: const EdgeInsets.all(4.0),
            //         child: InkWell(
            //           child: Container(
            //             decoration: const BoxDecoration(
            //               color: Colors.green,
            //               borderRadius: BorderRadius.only(
            //                   topLeft: Radius.circular(8),
            //                   topRight: Radius.circular(8),
            //                   bottomLeft: Radius.circular(8),
            //                   bottomRight: Radius.circular(8)),
            //             ),
            //             padding: const EdgeInsets.all(4.0),
            //             child: const Text(
            //               'แก้ไข / กำหนด',
            //               textAlign: TextAlign.start,
            //               style: TextStyle(
            //                   color: Colors.white,
            //                   // fontWeight: FontWeight.bold,
            //                   fontFamily: Font_.Fonts_T
            //                   //fontSize: 10.0
            //                   ),
            //             ),
            //           ),
            //           onTap: () {
            //             showDialog<String>(
            //               barrierDismissible: false,
            //               context: context,
            //               builder: (BuildContext context) => Form(
            //                 key: _formKey,
            //                 child: AlertDialog(
            //                   shape: const RoundedRectangleBorder(
            //                       borderRadius:
            //                           BorderRadius.all(Radius.circular(20.0))),
            //                   title: const Center(
            //                       child: Text(
            //                     'แก้ไข User & Password',
            //                     style: TextStyle(
            //                         color: AdminScafScreen_Color.Colors_Text1_,
            //                         fontWeight: FontWeight.bold,
            //                         fontFamily: FontWeight_.Fonts_T),
            //                   )),
            //                   actions: <Widget>[
            //                     Column(
            //                       children: [
            //                         const Align(
            //                           alignment: Alignment.centerLeft,
            //                           child: Padding(
            //                             padding: EdgeInsets.all(8.0),
            //                             child: Text(
            //                               'User',
            //                               textAlign: TextAlign.start,
            //                               style: TextStyle(
            //                                   color: PeopleChaoScreen_Color
            //                                       .Colors_Text2_,
            //                                   //fontWeight: FontWeight.bold,
            //                                   fontFamily: Font_.Fonts_T),
            //                             ),
            //                           ),
            //                         ),
            //                         Container(
            //                           decoration: const BoxDecoration(
            //                             // color: Colors.green,
            //                             borderRadius: BorderRadius.only(
            //                               topLeft: Radius.circular(6),
            //                               topRight: Radius.circular(6),
            //                               bottomLeft: Radius.circular(6),
            //                               bottomRight: Radius.circular(6),
            //                             ),
            //                             // border: Border.all(color: Colors.grey, width: 1),
            //                           ),
            //                           padding: const EdgeInsets.all(8.0),
            //                           child: TextFormField(
            //                             keyboardType: TextInputType.text,
            //                             showCursor: true, //add this line
            //                             readOnly: false,
            //                             controller: Form_User,
            //                             cursorColor: Colors.green,
            //                             validator: (value) {
            //                               if (value == null || value.isEmpty) {
            //                                 return 'ใส่ข้อมูลให้ครบถ้วน ';
            //                               }
            //                               // if (int.parse(value.toString()) < 13) {
            //                               //   return '< 13';
            //                               // }
            //                               return null;
            //                             },
            //                             decoration: InputDecoration(
            //                                 fillColor:
            //                                     Colors.white.withOpacity(0.3),
            //                                 // fillColor: Colors.green[100]!.withOpacity(0.5),
            //                                 filled: true,
            //                                 // labelText: 'User',
            //                                 // prefixIcon:
            //                                 //     const Icon(Icons.person, color: Colors.black),
            //                                 // suffixIcon: Icon(Icons.clear, color: Colors.black),
            //                                 focusedBorder:
            //                                     const OutlineInputBorder(
            //                                   borderRadius: BorderRadius.only(
            //                                     topRight: Radius.circular(15),
            //                                     topLeft: Radius.circular(15),
            //                                     bottomRight:
            //                                         Radius.circular(15),
            //                                     bottomLeft: Radius.circular(15),
            //                                   ),
            //                                   borderSide: BorderSide(
            //                                     width: 1,
            //                                     color: Colors.black,
            //                                   ),
            //                                 ),
            //                                 enabledBorder:
            //                                     const OutlineInputBorder(
            //                                   borderRadius: BorderRadius.only(
            //                                     topRight: Radius.circular(15),
            //                                     topLeft: Radius.circular(15),
            //                                     bottomRight:
            //                                         Radius.circular(15),
            //                                     bottomLeft: Radius.circular(15),
            //                                   ),
            //                                   borderSide: BorderSide(
            //                                     width: 1,
            //                                     color: Colors.grey,
            //                                   ),
            //                                 ),
            //                                 labelStyle: const TextStyle(
            //                                     color: Colors.black54,
            //                                     fontFamily: Font_.Fonts_T)),
            //                             inputFormatters: <TextInputFormatter>[
            //                               FilteringTextInputFormatter.deny(
            //                                   RegExp("[' ']")),
            //                               // for below version 2 use this
            //                               // FilteringTextInputFormatter.allow(
            //                               //     RegExp(r'[a-z A-Z 1-9]')),
            //                               // for version 2 and greater youcan also use this
            //                               // FilteringTextInputFormatter
            //                               //     .digitsOnly
            //                             ],
            //                             onChanged: (value) {
            //                               // print('User : ${value}');
            //                             },
            //                           ),
            //                         ),
            //                         const Align(
            //                           alignment: Alignment.centerLeft,
            //                           child: Padding(
            //                             padding: EdgeInsets.all(8.0),
            //                             child: Text(
            //                               'Password',
            //                               textAlign: TextAlign.start,
            //                               style: TextStyle(
            //                                   color: PeopleChaoScreen_Color
            //                                       .Colors_Text2_,
            //                                   //fontWeight: FontWeight.bold,
            //                                   fontFamily: Font_.Fonts_T),
            //                             ),
            //                           ),
            //                         ),
            //                         Container(
            //                           decoration: const BoxDecoration(
            //                             // color: Colors.green,
            //                             borderRadius: BorderRadius.only(
            //                               topLeft: Radius.circular(6),
            //                               topRight: Radius.circular(6),
            //                               bottomLeft: Radius.circular(6),
            //                               bottomRight: Radius.circular(6),
            //                             ),
            //                             // border: Border.all(color: Colors.grey, width: 1),
            //                           ),
            //                           padding: const EdgeInsets.all(8.0),
            //                           child: TextFormField(
            //                             keyboardType: TextInputType.text,
            //                             showCursor: true, //add this line
            //                             readOnly: false,
            //                             validator: (value) {
            //                               if (value == null || value.isEmpty) {
            //                                 return 'ใส่ข้อมูลให้ครบถ้วน ';
            //                               }
            //                               // if (int.parse(value.toString()) < 13) {
            //                               //   return '< 13';
            //                               // }
            //                               return null;
            //                             },
            //                             controller: Form_UserPass,
            //                             cursorColor: Colors.green,
            //                             decoration: InputDecoration(
            //                                 fillColor:
            //                                     Colors.white.withOpacity(0.3),
            //                                 // fillColor: Colors.green[100]!.withOpacity(0.5),
            //                                 filled: true,
            //                                 // labelText: 'Password',
            //                                 // prefixIcon:
            //                                 //     const Icon(Icons.person, color: Colors.black),
            //                                 // suffixIcon: Icon(Icons.clear, color: Colors.black),
            //                                 focusedBorder:
            //                                     const OutlineInputBorder(
            //                                   borderRadius: BorderRadius.only(
            //                                     topRight: Radius.circular(15),
            //                                     topLeft: Radius.circular(15),
            //                                     bottomRight:
            //                                         Radius.circular(15),
            //                                     bottomLeft: Radius.circular(15),
            //                                   ),
            //                                   borderSide: BorderSide(
            //                                     width: 1,
            //                                     color: Colors.black,
            //                                   ),
            //                                 ),
            //                                 enabledBorder:
            //                                     const OutlineInputBorder(
            //                                   borderRadius: BorderRadius.only(
            //                                     topRight: Radius.circular(15),
            //                                     topLeft: Radius.circular(15),
            //                                     bottomRight:
            //                                         Radius.circular(15),
            //                                     bottomLeft: Radius.circular(15),
            //                                   ),
            //                                   borderSide: BorderSide(
            //                                     width: 1,
            //                                     color: Colors.grey,
            //                                   ),
            //                                 ),
            //                                 labelStyle: const TextStyle(
            //                                     color: Colors.black54,
            //                                     fontFamily: Font_.Fonts_T)),
            //                             inputFormatters: <TextInputFormatter>[
            //                               FilteringTextInputFormatter.deny(
            //                                   RegExp("[' ']")),
            //                               // for below version 2 use this
            //                               // FilteringTextInputFormatter.allow(
            //                               //     RegExp(r'[a-z A-Z 1-9]')),
            //                               // for version 2 and greater youcan also use this
            //                               // FilteringTextInputFormatter
            //                               //     .digitsOnly
            //                             ],
            //                             onChanged: (value) {
            //                               // print('Pass_User : ${value}');
            //                             },
            //                           ),
            //                         ),
            //                         const SizedBox(
            //                           height: 5.0,
            //                         ),
            //                         const Divider(
            //                           color: Colors.grey,
            //                           height: 4.0,
            //                         ),
            //                         const SizedBox(
            //                           height: 5.0,
            //                         ),
            //                         Padding(
            //                           padding: const EdgeInsets.all(8.0),
            //                           child: Row(
            //                             mainAxisAlignment:
            //                                 MainAxisAlignment.center,
            //                             children: [
            //                               Padding(
            //                                 padding: const EdgeInsets.all(8.0),
            //                                 child: Container(
            //                                   width: 100,
            //                                   decoration: const BoxDecoration(
            //                                     color: Colors.green,
            //                                     borderRadius: BorderRadius.only(
            //                                         topLeft:
            //                                             Radius.circular(10),
            //                                         topRight:
            //                                             Radius.circular(10),
            //                                         bottomLeft:
            //                                             Radius.circular(10),
            //                                         bottomRight:
            //                                             Radius.circular(10)),
            //                                   ),
            //                                   padding:
            //                                       const EdgeInsets.all(8.0),
            //                                   child: TextButton(
            //                                     onPressed: () async {
            //                                       SharedPreferences
            //                                           preferences =
            //                                           await SharedPreferences
            //                                               .getInstance();
            //                                       String? ren = preferences
            //                                           .getString('renTalSer');
            //                                       String? ser_user = preferences
            //                                           .getString('ser');

            //                                       String Cid_ =
            //                                           '${widget.Get_Value_cid}';
            //                                       print(
            //                                           'User : ${Form_User.text}');
            //                                       print(
            //                                           'Cust_no_ : ${Cust_no_}');

            //                                       String password = md5
            //                                           .convert(utf8.encode(
            //                                               Form_UserPass.text))
            //                                           .toString();
            //                                       print(
            //                                           'password Md5 $password');
            //                                       if (_formKey.currentState!
            //                                           .validate()) {
            //                                         String url =
            //                                             '${MyConstant().domain}/UpC_custno_cid_Informa.php?isAdd=true&cust_no=$Cust_no_&user_U=${Form_User.text}&pass_U=$password&ren=$ren';
            //                                         try {
            //                                           var response = await http
            //                                               .get(Uri.parse(url));

            //                                           var result = json.decode(
            //                                               response.body);
            //                                           Insert_log.Insert_logs(
            //                                               'ผู้เช่า',
            //                                               'ข้อมูลผู้เช่า>>แก้ไขUser&password(${widget.Get_Value_cid})');
            //                                           setState(() {
            //                                             checkPreferance();
            //                                             read_data();
            //                                             red_report();
            //                                             red_reporttrans();
            //                                             read_GC_rental();
            //                                             GC_contractf();
            //                                             Form_UserPass.clear();
            //                                             Form_User.clear();
            //                                           });
            //                                           Navigator.pop(
            //                                               context, 'OK');
            //                                           ScaffoldMessenger.of(
            //                                                   context)
            //                                               .showSnackBar(const SnackBar(
            //                                                   content: Text(
            //                                                       'แก้ไขข้อมูลเสร็จสิ้น !!',
            //                                                       style: TextStyle(
            //                                                           color: Colors
            //                                                               .black,
            //                                                           fontFamily:
            //                                                               Font_
            //                                                                   .Fonts_T))));
            //                                         } catch (e) {
            //                                           Navigator.pop(
            //                                               context, 'OK');
            //                                           ScaffoldMessenger.of(
            //                                                   context)
            //                                               .showSnackBar(
            //                                             const SnackBar(
            //                                                 content: Text(
            //                                                     'เกิดข้อผิดพลาด',
            //                                                     style: TextStyle(
            //                                                         color: Colors
            //                                                             .black,
            //                                                         fontFamily:
            //                                                             Font_
            //                                                                 .Fonts_T))),
            //                                           );
            //                                         }
            //                                       }
            //                                     },
            //                                     child: const Text(
            //                                       'ยืนยัน',
            //                                       style: TextStyle(
            //                                           color: Colors.white,
            //                                           fontWeight:
            //                                               FontWeight.bold,
            //                                           fontFamily:
            //                                               FontWeight_.Fonts_T),
            //                                     ),
            //                                   ),
            //                                 ),
            //                               ),
            //                               Padding(
            //                                 padding: const EdgeInsets.all(8.0),
            //                                 child: Row(
            //                                   mainAxisAlignment:
            //                                       MainAxisAlignment.center,
            //                                   children: [
            //                                     Container(
            //                                       width: 100,
            //                                       decoration:
            //                                           const BoxDecoration(
            //                                         color: Colors.redAccent,
            //                                         borderRadius:
            //                                             BorderRadius.only(
            //                                                 topLeft:
            //                                                     Radius.circular(
            //                                                         10),
            //                                                 topRight:
            //                                                     Radius.circular(
            //                                                         10),
            //                                                 bottomLeft:
            //                                                     Radius.circular(
            //                                                         10),
            //                                                 bottomRight:
            //                                                     Radius.circular(
            //                                                         10)),
            //                                       ),
            //                                       padding:
            //                                           const EdgeInsets.all(8.0),
            //                                       child: TextButton(
            //                                         onPressed: () {
            //                                           setState(() {
            //                                             checkPreferance();
            //                                             read_data();
            //                                             red_report();
            //                                             red_reporttrans();
            //                                             read_GC_rental();
            //                                             GC_contractf();
            //                                             Form_UserPass.clear();
            //                                             Form_User.clear();
            //                                           });
            //                                           Navigator.pop(
            //                                               context, 'OK');
            //                                         },
            //                                         child: const Text(
            //                                           'ยกเลิก',
            //                                           style: TextStyle(
            //                                               color: Colors.white,
            //                                               fontWeight:
            //                                                   FontWeight.bold,
            //                                               fontFamily:
            //                                                   FontWeight_
            //                                                       .Fonts_T),
            //                                         ),
            //                                       ),
            //                                     ),
            //                                   ],
            //                                 ),
            //                               ),
            //                             ],
            //                           ),
            //                         ),
            //                       ],
            //                     ),
            //                   ],
            //                 ),
            //               ),
            //             );
            //           },
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Container(
            //     decoration: BoxDecoration(
            //       // color: AppbackgroundColor.Sub_Abg_Colors,
            //       borderRadius: const BorderRadius.only(
            //           topLeft: Radius.circular(10),
            //           topRight: Radius.circular(10),
            //           bottomLeft: Radius.circular(10),
            //           bottomRight: Radius.circular(10)),
            //       border: Border.all(color: Colors.grey, width: 1),
            //     ),
            //     padding: const EdgeInsets.all(8.0),
            //     child: Row(
            //       children: [
            //         const Expanded(
            //           flex: 1,
            //           child: Text(
            //             'User',
            //             textAlign: TextAlign.start,
            //             style: TextStyle(
            //                 color: PeopleChaoScreen_Color.Colors_Text2_,
            //                 //fontWeight: FontWeight.bold,
            //                 fontFamily: Font_.Fonts_T),
            //           ),
            //         ),
            //         Expanded(
            //           flex: 2,
            //           child: Container(
            //             decoration: const BoxDecoration(
            //               // color: Colors.green,
            //               borderRadius: BorderRadius.only(
            //                 topLeft: Radius.circular(6),
            //                 topRight: Radius.circular(6),
            //                 bottomLeft: Radius.circular(6),
            //                 bottomRight: Radius.circular(6),
            //               ),
            //               // border: Border.all(color: Colors.grey, width: 1),
            //             ),
            //             padding: const EdgeInsets.all(8.0),
            //             child: TextFormField(
            //               keyboardType: TextInputType.text,
            //               showCursor: false, //add this line
            //               readOnly: true,
            //               controller: Form_User,
            //               // cursorColor: Colors.grey,
            //               decoration: InputDecoration(
            //                   fillColor: Colors.white.withOpacity(0.3),
            //                   // fillColor: Colors.green[100]!.withOpacity(0.5),
            //                   filled: true,
            //                   // labelText: 'User',
            //                   // prefixIcon:
            //                   //     const Icon(Icons.person, color: Colors.black),
            //                   // suffixIcon: Icon(Icons.clear, color: Colors.black),
            //                   focusedBorder: const OutlineInputBorder(
            //                     borderRadius: BorderRadius.only(
            //                       topRight: Radius.circular(15),
            //                       topLeft: Radius.circular(15),
            //                       bottomRight: Radius.circular(15),
            //                       bottomLeft: Radius.circular(15),
            //                     ),
            //                     borderSide: BorderSide(
            //                       width: 1,
            //                       color: Colors.black,
            //                     ),
            //                   ),
            //                   enabledBorder: const OutlineInputBorder(
            //                     borderRadius: BorderRadius.only(
            //                       topRight: Radius.circular(15),
            //                       topLeft: Radius.circular(15),
            //                       bottomRight: Radius.circular(15),
            //                       bottomLeft: Radius.circular(15),
            //                     ),
            //                     borderSide: BorderSide(
            //                       width: 1,
            //                       color: Colors.grey,
            //                     ),
            //                   ),
            //                   labelStyle: const TextStyle(
            //                       color: Colors.black54,
            //                       fontFamily: Font_.Fonts_T)),
            //               inputFormatters: <TextInputFormatter>[
            //                 FilteringTextInputFormatter.deny(RegExp("[' ']")),
            //                 // for below version 2 use this
            //                 // FilteringTextInputFormatter.allow(
            //                 //     RegExp(r'[a-z A-Z 1-9]')),
            //                 // for version 2 and greater youcan also use this
            //                 // FilteringTextInputFormatter
            //                 //     .digitsOnly
            //               ],
            //               onChanged: (value) {
            //                 print('User : ${value}');
            //               },
            //             ),
            //           ),
            //         ),
            //         const Expanded(
            //           flex: 3,
            //           child: Text(
            //             '',
            //             textAlign: TextAlign.center,
            //             style: TextStyle(
            //                 color: PeopleChaoScreen_Color.Colors_Text2_,
            //                 //fontWeight: FontWeight.bold,
            //                 fontFamily: Font_.Fonts_T),
            //           ),
            //         ),
            //         // Expanded(
            //         //   flex: 2,
            //         //   child: Container(
            //         //     decoration: const BoxDecoration(
            //         //       // color: Colors.green,
            //         //       borderRadius: BorderRadius.only(
            //         //         topLeft: Radius.circular(6),
            //         //         topRight: Radius.circular(6),
            //         //         bottomLeft: Radius.circular(6),
            //         //         bottomRight: Radius.circular(6),
            //         //       ),
            //         //       // border: Border.all(color: Colors.grey, width: 1),
            //         //     ),
            //         //     padding: const EdgeInsets.all(8.0),
            //         //     child: TextFormField(
            //         //       keyboardType: TextInputType.text,
            //         //       showCursor: false, //add this line
            //         //       readOnly: true,

            //         //       controller: Form_UserPass,
            //         //       // cursorColor: Colors.grey,
            //         //       decoration: InputDecoration(
            //         //           fillColor: Colors.white.withOpacity(0.3),
            //         //           // fillColor: Colors.green[100]!.withOpacity(0.5),
            //         //           filled: true,
            //         //           // labelText: 'Password',
            //         //           // prefixIcon:
            //         //           //     const Icon(Icons.person, color: Colors.black),
            //         //           // suffixIcon: Icon(Icons.clear, color: Colors.black),
            //         //           focusedBorder: const OutlineInputBorder(
            //         //             borderRadius: BorderRadius.only(
            //         //               topRight: Radius.circular(15),
            //         //               topLeft: Radius.circular(15),
            //         //               bottomRight: Radius.circular(15),
            //         //               bottomLeft: Radius.circular(15),
            //         //             ),
            //         //             borderSide: BorderSide(
            //         //               width: 1,
            //         //               color: Colors.black,
            //         //             ),
            //         //           ),
            //         //           enabledBorder: const OutlineInputBorder(
            //         //             borderRadius: BorderRadius.only(
            //         //               topRight: Radius.circular(15),
            //         //               topLeft: Radius.circular(15),
            //         //               bottomRight: Radius.circular(15),
            //         //               bottomLeft: Radius.circular(15),
            //         //             ),
            //         //             borderSide: BorderSide(
            //         //               width: 1,
            //         //               color: Colors.grey,
            //         //             ),
            //         //           ),
            //         //           labelStyle: const TextStyle(
            //         //               color: Colors.black54,
            //         //               fontFamily: Font_.Fonts_T)),
            //         //       inputFormatters: <TextInputFormatter>[
            //         //         FilteringTextInputFormatter.deny(RegExp("[' ']")),
            //         //         // for below version 2 use this
            //         //         // FilteringTextInputFormatter.allow(
            //         //         //     RegExp(r'[a-z A-Z 1-9]')),
            //         //         // for version 2 and greater youcan also use this
            //         //         // FilteringTextInputFormatter
            //         //         //     .digitsOnly
            //         //       ],
            //         //       onChanged: (value) {
            //         //         print('Pass_User : ${value}');
            //         //       },
            //         //     ),
            //         //   ),
            //         // ),
            //       ],
            //     ),
            //   ),
            // ),
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  colorFilter: new ColorFilter.mode(
                      Colors.white.withOpacity(0.05), BlendMode.dstATop),
                  image: AssetImage("images/BG_im2.png"),
                  fit: BoxFit.cover,
                ),
                color: AppbackgroundColor.Sub_Abg_Colors,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(0),
                    topRight: Radius.circular(0),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                // border: Border.all(color: Colors.white, width: 1),
              ),
              child: Column(
                children: [
                  const Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: AutoSizeText(
                          minFontSize: 10,
                          maxFontSize: 15,
                          '4.เอกสาร',
                          style: TextStyle(
                              color: PeopleChaoScreen_Color.Colors_Text1_,
                              fontWeight: FontWeight.bold,
                              fontFamily: FontWeight_.Fonts_T
                              //fontSize: 10.0
                              ),
                        ),
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          'สำเนาบัตรประชาชนผู้เช่า',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              color: PeopleChaoScreen_Color.Colors_Text2_,
                              // fontWeight: FontWeight.bold,
                              fontFamily: Font_.Fonts_T
                              //fontSize: 10.0
                              ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 150,
                    decoration: BoxDecoration(
                      // color: AppbackgroundColor.Sub_Abg_Colors,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                      border: Border.all(color: Colors.grey, width: 1),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: (cxname_card != null)
                                    ? Stack(
                                        children: [
                                          Container(
                                              decoration: BoxDecoration(
                                                color: Colors.grey[300],
                                                borderRadius:
                                                    const BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(10),
                                                        topRight:
                                                            Radius.circular(10),
                                                        bottomLeft:
                                                            Radius.circular(10),
                                                        bottomRight:
                                                            Radius.circular(
                                                                10)),
                                              ),
                                              child: Image.network(
                                                '${MyConstant().domain}/files/$foder/contract/card/$cxname_card',
                                                // width: 200,
                                                // height: 160,
                                                fit: BoxFit.cover,
                                              )
                                              //  Center(
                                              //   child: Column(
                                              //     mainAxisAlignment: MainAxisAlignment.center,
                                              //     children: [
                                              //       Text(
                                              //         'พบเอกสาร',
                                              //         textAlign: TextAlign.center,
                                              //         style: TextStyle(
                                              //             color: PeopleChaoScreen_Color
                                              //                 .Colors_Text2_,
                                              //             // fontWeight: FontWeight.bold,
                                              //             fontFamily: Font_.Fonts_T

                                              //             //fontSize: 10.0
                                              //             ),
                                              //       ),
                                              //       Text(
                                              //         '$cxname_card',
                                              //         textAlign: TextAlign.center,
                                              //         style: TextStyle(
                                              //             color: Colors.blue[800],
                                              //             // fontWeight: FontWeight.bold,
                                              //             fontFamily: Font_.Fonts_T,
                                              //             fontSize: 8.0),
                                              //       ),
                                              //     ],
                                              //   ),
                                              // ),
                                              ),
                                          Positioned(
                                            top: 20,
                                            right: 10,
                                            child: InkWell(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.red[900]!
                                                      .withOpacity(0.8),
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
                                                child: const Center(
                                                  child: Text(
                                                    'ดูเอกสาร',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        // fontWeight: FontWeight.bold,
                                                        fontFamily:
                                                            Font_.Fonts_T

                                                        //fontSize: 10.0
                                                        ),
                                                  ),
                                                ),
                                              ),
                                              onTap: () {
                                                showDialog(
                                                  context: context,
                                                  builder: (_) => Dialog(
                                                    child: Stack(
                                                      children: [
                                                        SizedBox(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.8,
                                                          child: FittedBox(
                                                            fit: BoxFit.contain,
                                                            child: (cxname_card ==
                                                                        null ||
                                                                    cxname_card
                                                                            .toString() ==
                                                                        '')
                                                                ? const Icon(Icons
                                                                    .image_not_supported)
                                                                : Image.network(
                                                                    '${MyConstant().domain}/files/$foder/contract/card/$cxname_card'),
                                                          ),
                                                        ),
                                                        Positioned(
                                                            top: 10,
                                                            right: 10,
                                                            child: InkWell(
                                                              onTap: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                              child: const Icon(
                                                                Icons
                                                                    .cancel_outlined,
                                                                size: 40,
                                                                color:
                                                                    Colors.red,
                                                              ),
                                                            ))
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          )
                                        ],
                                      )
                                    : Container(
                                        decoration: BoxDecoration(
                                          color: Colors.grey[300],
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10),
                                              bottomLeft: Radius.circular(10),
                                              bottomRight: Radius.circular(10)),
                                        ),
                                        child: const Center(
                                          child: Text(
                                            'ไม่พบเอกสาร',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: PeopleChaoScreen_Color
                                                    .Colors_Text2_,
                                                // fontWeight: FontWeight.bold,
                                                fontFamily: Font_.Fonts_T

                                                //fontSize: 10.0
                                                ),
                                          ),
                                        ),
                                      ),
                              ),
                            ],
                          ),
                        ),
                        if (Responsive.isDesktop(context))
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: const BoxDecoration(
                                  // color: Colors.grey,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10)),
                                ),
                              ),
                            ),
                          ),
                        Expanded(
                          flex: 2,
                          child: Row(
                            children: [
                              // Expanded(
                              //   flex: 1,
                              //   child: Padding(
                              //     padding: const EdgeInsets.all(8.0),
                              //     child: Container(
                              //       decoration: const BoxDecoration(
                              //         color: Colors.red,
                              //         borderRadius: BorderRadius.only(
                              //             topLeft: Radius.circular(10),
                              //             topRight: Radius.circular(10),
                              //             bottomLeft: Radius.circular(10),
                              //             bottomRight: Radius.circular(10)),
                              //       ),
                              //     ),
                              //   ),
                              // ),

                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      // color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10)),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: InkWell(
                                            child: Container(
                                              height: 40,
                                              decoration: BoxDecoration(
                                                color: Colors.blue[300],
                                                borderRadius:
                                                    const BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(10),
                                                        topRight:
                                                            Radius.circular(10),
                                                        bottomLeft:
                                                            Radius.circular(10),
                                                        bottomRight:
                                                            Radius.circular(
                                                                10)),
                                              ),
                                              child: const Center(
                                                child: Text(
                                                  'อัพโหลดไฟล์ ( jpeg,png,jpg )',
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                      color:
                                                          PeopleChaoScreen_Color
                                                              .Colors_Text2_,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontFamily:
                                                          Font_.Fonts_T),
                                                ),
                                              ),
                                            ),
                                            onTap: () async {
                                              (cxname_card == null)
                                                  ? uploadFile_IDcard(
                                                      '${cxname_card}',
                                                      ' $cxname_card_ser',
                                                    )
                                                  : showDialog<void>(
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
                                                            'มีเอกสารสำเนาบัตรประชาชนอยู่แล้ว',
                                                            style: TextStyle(
                                                                color: PeopleChaoScreen_Color
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
                                                                  'มีเอกสารสำเนาบัตรประชาชนอยู่แล้ว หากต้องการอัพโหลดกรุณาลบเอกสารที่มีอยู่แล้วก่อน',
                                                                  style: TextStyle(
                                                                      color: PeopleChaoScreen_Color
                                                                          .Colors_Text2_,
                                                                      fontFamily:
                                                                          Font_
                                                                              .Fonts_T),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          actions: <Widget>[
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child:
                                                                      InkWell(
                                                                    child: Container(
                                                                        width: 100,
                                                                        decoration: BoxDecoration(
                                                                          color:
                                                                              Colors.red[600],
                                                                          borderRadius: const BorderRadius.only(
                                                                              topLeft: Radius.circular(10),
                                                                              topRight: Radius.circular(10),
                                                                              bottomLeft: Radius.circular(10),
                                                                              bottomRight: Radius.circular(10)),
                                                                          // border: Border.all(color: Colors.white, width: 1),
                                                                        ),
                                                                        padding: const EdgeInsets.all(8.0),
                                                                        child: const Center(
                                                                            child: Text(
                                                                          'ลบเอกสาร',
                                                                          style: TextStyle(
                                                                              color: PeopleChaoScreen_Color.Colors_Text3_,
                                                                              fontWeight: FontWeight.bold,
                                                                              fontFamily: Font_.Fonts_T),
                                                                        ))),
                                                                    onTap:
                                                                        () async {
                                                                      //String fileName, String ser, String Pathfoder,    String PathfoderSub

                                                                      deletedFile_(
                                                                          '${cxname_card}',
                                                                          ' $cxname_card_ser',
                                                                          'card');
                                                                      deletedFile_SQL(
                                                                          '$cxname_card_ser');

                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                    },
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child:
                                                                      InkWell(
                                                                    child: Container(
                                                                        width: 100,
                                                                        decoration: const BoxDecoration(
                                                                          color:
                                                                              Colors.black,
                                                                          borderRadius: BorderRadius.only(
                                                                              topLeft: Radius.circular(10),
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
                                                                              color: PeopleChaoScreen_Color.Colors_Text3_,
                                                                              fontWeight: FontWeight.bold,
                                                                              fontFamily: Font_.Fonts_T),
                                                                        ))),
                                                                    onTap: () {
                                                                      GC_contractf();
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                    },
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    );
                                            },
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            // Expanded(
                                            //   flex: 1,
                                            //   child: Padding(
                                            //     padding: const EdgeInsets.all(8.0),
                                            //     child: InkWell(
                                            //       child: Container(
                                            //         height: 40,
                                            //         decoration: BoxDecoration(
                                            //           color: Colors.red[400],
                                            //           borderRadius:
                                            //               const BorderRadius.only(
                                            //                   topLeft:
                                            //                       Radius.circular(10),
                                            //                   topRight:
                                            //                       Radius.circular(10),
                                            //                   bottomLeft:
                                            //                       Radius.circular(10),
                                            //                   bottomRight:
                                            //                       Radius.circular(
                                            //                           10)),
                                            //         ),
                                            //         child: const Center(
                                            //           child: Text(
                                            //             'ลบ(PDF)',
                                            //             textAlign: TextAlign.start,
                                            //             style: TextStyle(
                                            //                 color:
                                            //                     PeopleChaoScreen_Color
                                            //                         .Colors_Text2_,
                                            //                 // fontWeight: FontWeight.bold,
                                            //                 fontFamily: Font_.Fonts_T
                                            //                 //fontSize: 10.0
                                            //                 ),
                                            //           ),
                                            //         ),
                                            //       ),
                                            //       onTap: () async {
                                            //         // deletedFile_('${cxname_card}',
                                            //         //     ' $cxname_card_ser');

                                            //         // deletedFile_('${cxname_card}',
                                            //         //     ' $cxname_card_ser', 'card');
                                            //         // deletedFile_SQL(
                                            //         //     '$cxname_card_ser');
                                            //       },
                                            //     ),
                                            //   ),
                                            // ),
                                            Expanded(
                                              flex: 1,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: InkWell(
                                                  child: Container(
                                                    height: 40,
                                                    decoration: BoxDecoration(
                                                      color: Colors.orange[300],
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
                                                    child: const Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  4.0),
                                                          child: Icon(
                                                            Icons.print,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                        Text(
                                                          'พิมพ์',
                                                          textAlign:
                                                              TextAlign.start,
                                                          style: TextStyle(
                                                              color: PeopleChaoScreen_Color
                                                                  .Colors_Text2_,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontFamily: Font_
                                                                  .Fonts_T),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  onTap: () async {
                                                    String Url =
                                                        await '${MyConstant().domain}/files/$foder/contract/card/$cxname_card';
                                                    print(Url);
                                                    Idcard_(context, Url);
                                                    // String Url =
                                                    //     'https://www.etda.or.th/getattachment/78750426-4a58-4c36-85d3-d1c11c3db1f3/IUB-65-Final.pdf.aspx';
                                                    // if (Url == '') {
                                                    //   showDialog<void>(
                                                    //     context: context,
                                                    //     barrierDismissible:
                                                    //         false, // user must tap button!
                                                    //     builder:
                                                    //         (BuildContext context) {
                                                    //       return AlertDialog(
                                                    //         shape: const RoundedRectangleBorder(
                                                    //             borderRadius:
                                                    //                 BorderRadius.all(
                                                    //                     Radius.circular(
                                                    //                         10.0))),
                                                    //         title: const Center(
                                                    //             child: Text(
                                                    //           'ไม่พบสำเนาบัตรประชาชน',
                                                    //           style: TextStyle(
                                                    //               color: PeopleChaoScreen_Color
                                                    //                   .Colors_Text1_,
                                                    //               fontWeight:
                                                    //                   FontWeight.bold,
                                                    //               fontFamily:
                                                    //                   FontWeight_
                                                    //                       .Fonts_T),
                                                    //         )),
                                                    //         content:
                                                    //             SingleChildScrollView(
                                                    //           child: ListBody(
                                                    //             children: const <
                                                    //                 Widget>[
                                                    //               Text(
                                                    //                 'ไม่พบเอกสาร หรือ กรุณาอัพโหลดก่อน จึงจะสามารถพิมพ์ได้',
                                                    //                 style: TextStyle(
                                                    //                     color: PeopleChaoScreen_Color
                                                    //                         .Colors_Text2_,
                                                    //                     fontFamily: Font_
                                                    //                         .Fonts_T),
                                                    //               ),
                                                    //             ],
                                                    //           ),
                                                    //         ),
                                                    //         actions: <Widget>[
                                                    //           InkWell(
                                                    //             child: Container(
                                                    //                 width: 100,
                                                    //                 decoration:
                                                    //                     const BoxDecoration(
                                                    //                   color: Colors
                                                    //                       .black,
                                                    //                   borderRadius: BorderRadius.only(
                                                    //                       topLeft: Radius
                                                    //                           .circular(
                                                    //                               10),
                                                    //                       topRight: Radius
                                                    //                           .circular(
                                                    //                               10),
                                                    //                       bottomLeft:
                                                    //                           Radius.circular(
                                                    //                               10),
                                                    //                       bottomRight:
                                                    //                           Radius.circular(
                                                    //                               10)),
                                                    //                   // border: Border.all(color: Colors.white, width: 1),
                                                    //                 ),
                                                    //                 padding:
                                                    //                     const EdgeInsets
                                                    //                         .all(8.0),
                                                    //                 child:
                                                    //                     const Center(
                                                    //                         child:
                                                    //                             Text(
                                                    //                   'ปิด',
                                                    //                   style: TextStyle(
                                                    //                       color: PeopleChaoScreen_Color
                                                    //                           .Colors_Text3_,
                                                    //                       fontWeight:
                                                    //                           FontWeight
                                                    //                               .bold,
                                                    //                       fontFamily:
                                                    //                           Font_
                                                    //                               .Fonts_T),
                                                    //                 ))),
                                                    //             onTap: () {
                                                    //               Navigator.of(
                                                    //                       context)
                                                    //                   .pop();
                                                    //             },
                                                    //           ),
                                                    //           // TextButton(
                                                    //           //   child: const Text('ตกลง'),
                                                    //           //   onPressed: () {
                                                    //           //     Navigator.of(context).pop();
                                                    //           //   },
                                                    //           // ),
                                                    //         ],
                                                    //       );
                                                    //     },
                                                    //   );
                                                    // } else {
                                                    //   Navigator.push(
                                                    //       context,
                                                    //       MaterialPageRoute(
                                                    //         builder: (context) =>
                                                    //             PreviewScreenRental_(
                                                    //                 title:
                                                    //                     'สำเนาบัตรประชาชน',
                                                    //                 Url: Url),
                                                    //       ));
                                                    // }
                                                  },
                                                ),
                                              ),
                                            ),
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
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          'เอกสารสัญญาเช่า',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              color: PeopleChaoScreen_Color.Colors_Text2_,
                              // fontWeight: FontWeight.bold,
                              fontFamily: Font_.Fonts_T
                              //fontSize: 10.0
                              ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    // height: 150,
                    decoration: BoxDecoration(
                      // color: AppbackgroundColor.Sub_Abg_Colors,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                      border: Border.all(color: Colors.grey, width: 1),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            child: Column(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'เอกสารสัญญาเช่า(ต้นฉบับ)',
                                    maxLines: 2,
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        color: PeopleChaoScreen_Color
                                            .Colors_Text2_,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: FontWeight_.Fonts_T
                                        //fontSize: 10.0
                                        ),
                                  ),
                                ),
                                (renTal_user.toString() == '90' ||
                                        renTal_user.toString() == '50')
                                    ? SizedBox()
                                    : SizedBox(
                                        height: 125,
                                      ),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: InkWell(
                                          child: Container(
                                            height: 40,
                                            decoration: BoxDecoration(
                                              color: Colors.orange[300],
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
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const Padding(
                                                  padding: EdgeInsets.all(4.0),
                                                  child: Icon(
                                                    Icons.print,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                Text(
                                                  'พิมพ์',
                                                  textAlign: TextAlign.start,
                                                  style: const TextStyle(
                                                      color:
                                                          PeopleChaoScreen_Color
                                                              .Colors_Text2_,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontFamily:
                                                          Font_.Fonts_T),
                                                ),
                                              ],
                                            ),
                                          ),
                                          onTap: () async {
                                            print('base64Image');
                                            // print(base64Image);
                                            List newValuePDFimg = [];
                                            for (int index = 0;
                                                index < 1;
                                                index++) {
                                              if (renTalModels[0]
                                                      .imglogo!
                                                      .trim() ==
                                                  '') {
                                                // newValuePDFimg.add(
                                                //     'https://png.pngtree.com/png-vector/20190820/ourmid/pngtree-no-image-vector-illustration-isolated-png-image_1694547.jpg');
                                              } else {
                                                newValuePDFimg.add(
                                                    '${MyConstant().domain}/files/$foder/logo/${renTalModels[0].imglogo!.trim()}');
                                                newValuePDFimg.add(
                                                    '${MyConstant().domain}/files/$foder/contract/${renTalModels[0].img}');
                                              }
                                            }
                                            SharedPreferences preferences =
                                                await SharedPreferences
                                                    .getInstance();
                                            var ren = preferences
                                                .getString('renTalSer');
                                            var renTal_name = preferences
                                                .getString('renTalName');

                                            final tableData00 = [
                                              for (int index = 0;
                                                  index <
                                                      quotxSelectModels.length;
                                                  index++)
                                                [
                                                  '${quotxSelectModels[index].unit} / ${quotxSelectModels[index].term} (งวด)',
                                                  '${DateFormat('dd-MM-yyyy').format(DateTime.parse('${quotxSelectModels[index].sdate!} 00:00:00'))} - ${DateFormat('dd-MM-yyyy').format(DateTime.parse('${quotxSelectModels[index].ldate!} 00:00:00'))}',
                                                  '${quotxSelectModels[index].expname}',
                                                  '${nFormat.format(double.parse(quotxSelectModels[index].total!))}',
                                                  '${nFormat.format(int.parse(quotxSelectModels[index].term!) * double.parse(quotxSelectModels[index].total!))}',
                                                ],
                                            ];
                                            _showMyDialog_SAVE(
                                                context,
                                                tableData00,
                                                newValuePDFimg,
                                                ren,
                                                1);
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                if (renTal_user.toString() == '90' ||
                                    renTal_user.toString() == '50')
                                  Container(
                                    child: Column(
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                            'เอกสารแนบท้ายสัญญา (J Space)',
                                            maxLines: 2,
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                color: PeopleChaoScreen_Color
                                                    .Colors_Text2_,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: FontWeight_.Fonts_T
                                                //fontSize: 10.0
                                                ),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                  height: 25,
                                                  decoration:
                                                      const BoxDecoration(
                                                    // color: Colors.orange[600],
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
                                                  ),
                                                  child: const Center(
                                                    child: Text(
                                                      '',
                                                      textAlign:
                                                          TextAlign.start,
                                                      style: TextStyle(
                                                          color: Colors.green,
                                                          // fontWeight: FontWeight.bold,
                                                          fontFamily:
                                                              Font_.Fonts_T
                                                          //fontSize: 10.0
                                                          ),
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
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: InkWell(
                                                  child: Container(
                                                    height: 40,
                                                    decoration: BoxDecoration(
                                                      color:
                                                          Colors.blueGrey[300],
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
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        const Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  4.0),
                                                          child: Icon(
                                                            Icons.print,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                        Text(
                                                          'พิมพ์',
                                                          textAlign:
                                                              TextAlign.start,
                                                          style: const TextStyle(
                                                              color: PeopleChaoScreen_Color
                                                                  .Colors_Text2_,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontFamily: Font_
                                                                  .Fonts_T),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  onTap: () async {
                                                    print('base64Image');
                                                    // print(base64Image);
                                                    List newValuePDFimg = [];
                                                    for (int index = 0;
                                                        index < 1;
                                                        index++) {
                                                      if (renTalModels[0]
                                                              .imglogo!
                                                              .trim() ==
                                                          '') {
                                                        // newValuePDFimg.add(
                                                        //     'https://png.pngtree.com/png-vector/20190820/ourmid/pngtree-no-image-vector-illustration-isolated-png-image_1694547.jpg');
                                                      } else {
                                                        newValuePDFimg.add(
                                                            '${MyConstant().domain}/files/$foder/logo/${renTalModels[0].imglogo!.trim()}');
                                                        newValuePDFimg.add(
                                                            '${MyConstant().domain}/files/$foder/contract/${renTalModels[0].img}');
                                                      }
                                                    }
                                                    SharedPreferences
                                                        preferences =
                                                        await SharedPreferences
                                                            .getInstance();
                                                    var ren = preferences
                                                        .getString('renTalSer');
                                                    var renTal_name =
                                                        preferences.getString(
                                                            'renTalName');

                                                    final tableData00 = [
                                                      for (int index = 0;
                                                          index <
                                                              quotxSelectModels
                                                                  .length;
                                                          index++)
                                                        [
                                                          '${quotxSelectModels[index].unit} / ${quotxSelectModels[index].term} (งวด)',
                                                          '${DateFormat('dd-MM-yyyy').format(DateTime.parse('${quotxSelectModels[index].sdate!} 00:00:00'))} - ${DateFormat('dd-MM-yyyy').format(DateTime.parse('${quotxSelectModels[index].ldate!} 00:00:00'))}',
                                                          '${quotxSelectModels[index].expname}',
                                                          '${nFormat.format(double.parse(quotxSelectModels[index].total!))}',
                                                          '${nFormat.format(int.parse(quotxSelectModels[index].term!) * double.parse(quotxSelectModels[index].total!))}',
                                                        ],
                                                    ];
                                                    _showMyDialog_SAVE(
                                                        context,
                                                        tableData00,
                                                        newValuePDFimg,
                                                        ren,
                                                        2);
                                                  },
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
                        // Expanded(
                        //   flex: 1,
                        //   child: Text(''),
                        // ),
                        // Expanded(
                        //   flex: 2,
                        //   child: Container(
                        //     child: Column(
                        //       children: [
                        //         Padding(
                        //           padding: EdgeInsets.all(8.0),
                        //           child: Text(
                        //             'เอกสารสัญญาเช่า(เซ็นแล้ว)',
                        //             textAlign: TextAlign.start,
                        //             style: TextStyle(
                        //                 color: PeopleChaoScreen_Color.Colors_Text2_,
                        //                 fontWeight: FontWeight.bold,
                        //                 fontFamily: FontWeight_.Fonts_T
                        //                 //fontSize: 10.0
                        //                 ),
                        //           ),
                        //         ),
                        //         Row(
                        //           children: [
                        //             Expanded(
                        //               flex: 1,
                        //               child: Padding(
                        //                 padding: const EdgeInsets.all(8.0),
                        //                 child: Container(
                        //                   height: 60,
                        //                   decoration: const BoxDecoration(
                        //                     // color: Colors.orange[600],
                        //                     borderRadius: BorderRadius.only(
                        //                         topLeft: Radius.circular(10),
                        //                         topRight: Radius.circular(10),
                        //                         bottomLeft: Radius.circular(10),
                        //                         bottomRight: Radius.circular(10)),
                        //                   ),
                        //                   child: Center(
                        //                     child: Column(
                        //                       mainAxisAlignment:
                        //                           MainAxisAlignment.center,
                        //                       children: [
                        //                         Text(
                        //                           (cxname_lease != null)
                        //                               ? 'พบเอกสาร'
                        //                               : 'ไม่พบเอกสาร',
                        //                           textAlign: TextAlign.start,
                        //                           style: TextStyle(
                        //                               color: (cxname_lease != null)
                        //                                   ? Colors.black
                        //                                   : Colors.red,
                        //                               // fontWeight: FontWeight.bold,
                        //                               fontFamily: Font_.Fonts_T
                        //                               //fontSize: 10.0
                        //                               ),
                        //                         ),
                        //                         Text(
                        //                           (cxname_lease != null)
                        //                               ? '$cxname_lease'
                        //                               : '',
                        //                           textAlign: TextAlign.start,
                        //                           style: TextStyle(
                        //                               color: Colors.blue[800],
                        //                               // fontWeight: FontWeight.bold,
                        //                               fontFamily: Font_.Fonts_T,
                        //                               fontSize: 8.0),
                        //                         ),
                        //                       ],
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
                        //               child: Padding(
                        //                 padding: const EdgeInsets.all(8.0),
                        //                 child: InkWell(
                        //                   child: Container(
                        //                     height: 40,
                        //                     decoration: BoxDecoration(
                        //                       color: Colors.blue[400],
                        //                       borderRadius: const BorderRadius.only(
                        //                           topLeft: Radius.circular(10),
                        //                           topRight: Radius.circular(10),
                        //                           bottomLeft: Radius.circular(10),
                        //                           bottomRight: Radius.circular(10)),
                        //                     ),
                        //                     child: const Center(
                        //                       child: Text(
                        //                         'อัพโหลดไฟล์(PDF)',
                        //                         textAlign: TextAlign.start,
                        //                         style: TextStyle(
                        //                             color: PeopleChaoScreen_Color
                        //                                 .Colors_Text2_,
                        //                             // fontWeight: FontWeight.bold,
                        //                             fontFamily: Font_.Fonts_T
                        //                             //fontSize: 10.0
                        //                             ),
                        //                       ),
                        //                     ),
                        //                   ),
                        //                   onTap: () async {
                        //                     // uploadFile_Agreement();

                        //                     (cxname_lease == null)
                        //                         ? uploadFile_Agreement(
                        //                             '${cxname_lease}',
                        //                             ' $cxname_lease_ser',
                        //                           )
                        //                         : showDialog<void>(
                        //                             context: context,
                        //                             barrierDismissible:
                        //                                 false, // user must tap button!
                        //                             builder: (BuildContext context) {
                        //                               return AlertDialog(
                        //                                 shape:
                        //                                     const RoundedRectangleBorder(
                        //                                         borderRadius:
                        //                                             BorderRadius.all(
                        //                                                 Radius.circular(
                        //                                                     10.0))),
                        //                                 title: const Center(
                        //                                     child: Text(
                        //                                   'มีเอกสารสัญญาเช่า(เซ็นแล้ว)อยู่แล้ว',
                        //                                   style: TextStyle(
                        //                                       color:
                        //                                           PeopleChaoScreen_Color
                        //                                               .Colors_Text1_,
                        //                                       fontWeight:
                        //                                           FontWeight.bold,
                        //                                       fontFamily: FontWeight_
                        //                                           .Fonts_T),
                        //                                 )),
                        //                                 content:
                        //                                     SingleChildScrollView(
                        //                                   child: ListBody(
                        //                                     children: const <Widget>[
                        //                                       Text(
                        //                                         'มีเอกสารเอกสารสัญญาเช่า(เซ็นแล้ว)อยู่แล้ว หากต้องการอัพโหลดกรุณาลบเอกสารที่มีอยู่แล้วก่อน',
                        //                                         style: TextStyle(
                        //                                             color: PeopleChaoScreen_Color
                        //                                                 .Colors_Text2_,
                        //                                             fontFamily: Font_
                        //                                                 .Fonts_T),
                        //                                       ),
                        //                                     ],
                        //                                   ),
                        //                                 ),
                        //                                 actions: <Widget>[
                        //                                   Row(
                        //                                     mainAxisAlignment:
                        //                                         MainAxisAlignment
                        //                                             .center,
                        //                                     children: [
                        //                                       Padding(
                        //                                         padding:
                        //                                             const EdgeInsets
                        //                                                 .all(8.0),
                        //                                         child: InkWell(
                        //                                           child: Container(
                        //                                               width: 100,
                        //                                               decoration:
                        //                                                   BoxDecoration(
                        //                                                 color: Colors
                        //                                                     .red[600],
                        //                                                 borderRadius: const BorderRadius
                        //                                                         .only(
                        //                                                     topLeft:
                        //                                                         Radius.circular(
                        //                                                             10),
                        //                                                     topRight:
                        //                                                         Radius.circular(
                        //                                                             10),
                        //                                                     bottomLeft:
                        //                                                         Radius.circular(
                        //                                                             10),
                        //                                                     bottomRight:
                        //                                                         Radius.circular(
                        //                                                             10)),
                        //                                                 // border: Border.all(color: Colors.white, width: 1),
                        //                                               ),
                        //                                               padding:
                        //                                                   const EdgeInsets
                        //                                                           .all(
                        //                                                       8.0),
                        //                                               child:
                        //                                                   const Center(
                        //                                                       child:
                        //                                                           Text(
                        //                                                 'ลบเอกสาร',
                        //                                                 style: TextStyle(
                        //                                                     color: PeopleChaoScreen_Color
                        //                                                         .Colors_Text3_,
                        //                                                     fontWeight:
                        //                                                         FontWeight
                        //                                                             .bold,
                        //                                                     fontFamily:
                        //                                                         Font_
                        //                                                             .Fonts_T),
                        //                                               ))),
                        //                                           onTap: () async {
                        //                                             deletedFile_SQL(
                        //                                                 '$cxname_lease_ser');
                        //                                             deletedFile_(
                        //                                                 '${cxname_lease}',
                        //                                                 ' $cxname_lease_ser',
                        //                                                 'lease');

                        //                                             GC_contractf();
                        //                                             Navigator.of(
                        //                                                     context)
                        //                                                 .pop();
                        //                                           },
                        //                                         ),
                        //                                       ),
                        //                                       Padding(
                        //                                         padding:
                        //                                             const EdgeInsets
                        //                                                 .all(8.0),
                        //                                         child: InkWell(
                        //                                           child: Container(
                        //                                               width: 100,
                        //                                               decoration:
                        //                                                   const BoxDecoration(
                        //                                                 color: Colors
                        //                                                     .black,
                        //                                                 borderRadius: BorderRadius.only(
                        //                                                     topLeft:
                        //                                                         Radius.circular(
                        //                                                             10),
                        //                                                     topRight:
                        //                                                         Radius.circular(
                        //                                                             10),
                        //                                                     bottomLeft:
                        //                                                         Radius.circular(
                        //                                                             10),
                        //                                                     bottomRight:
                        //                                                         Radius.circular(
                        //                                                             10)),
                        //                                                 // border: Border.all(color: Colors.white, width: 1),
                        //                                               ),
                        //                                               padding:
                        //                                                   const EdgeInsets
                        //                                                           .all(
                        //                                                       8.0),
                        //                                               child:
                        //                                                   const Center(
                        //                                                       child:
                        //                                                           Text(
                        //                                                 'ปิด',
                        //                                                 style: TextStyle(
                        //                                                     color: PeopleChaoScreen_Color
                        //                                                         .Colors_Text3_,
                        //                                                     fontWeight:
                        //                                                         FontWeight
                        //                                                             .bold,
                        //                                                     fontFamily:
                        //                                                         Font_
                        //                                                             .Fonts_T),
                        //                                               ))),
                        //                                           onTap: () {
                        //                                             GC_contractf();
                        //                                             Navigator.of(
                        //                                                     context)
                        //                                                 .pop();
                        //                                           },
                        //                                         ),
                        //                                       ),
                        //                                     ],
                        //                                   ),
                        //                                 ],
                        //                               );
                        //                             },
                        //                           );
                        //                   },
                        //                 ),
                        //               ),
                        //             ),
                        //           ],
                        //         ),
                        //         Row(
                        //           children: [
                        //             // Expanded(
                        //             //   flex: 1,
                        //             //   child: Padding(
                        //             //     padding: const EdgeInsets.all(8.0),
                        //             //     child: InkWell(
                        //             //       child: Container(
                        //             //         height: 40,
                        //             //         decoration: BoxDecoration(
                        //             //           color: Colors.red[400],
                        //             //           borderRadius: const BorderRadius.only(
                        //             //               topLeft: Radius.circular(10),
                        //             //               topRight: Radius.circular(10),
                        //             //               bottomLeft: Radius.circular(10),
                        //             //               bottomRight: Radius.circular(10)),
                        //             //         ),
                        //             //         child: const Center(
                        //             //           child: Text(
                        //             //             'ลบ(PDF)',
                        //             //             textAlign: TextAlign.start,
                        //             //             style: TextStyle(
                        //             //                 color: PeopleChaoScreen_Color
                        //             //                     .Colors_Text2_,
                        //             //                 // fontWeight: FontWeight.bold,
                        //             //                 fontFamily: Font_.Fonts_T
                        //             //                 //fontSize: 10.0
                        //             //                 ),
                        //             //           ),
                        //             //         ),
                        //             //       ),
                        //             //       onTap: () async {
                        //             //         deletedFile_('${cxname_lease}',
                        //             //             ' $cxname_lease_ser');
                        //             //         // final file = await pickFile_agreement();
                        //             //         // if (file != null) {
                        //             //         //   // Upload the file to the server
                        //             //         //   uploadFile_Agreement(file);
                        //             //         // }
                        //             //       },
                        //             //     ),
                        //             //   ),
                        //             // ),
                        //             Expanded(
                        //               flex: 1,
                        //               child: Padding(
                        //                 padding: const EdgeInsets.all(8.0),
                        //                 child: InkWell(
                        //                   child: Container(
                        //                     height: 40,
                        //                     decoration: BoxDecoration(
                        //                       color: Colors.orange[400],
                        //                       borderRadius: const BorderRadius.only(
                        //                           topLeft: Radius.circular(10),
                        //                           topRight: Radius.circular(10),
                        //                           bottomLeft: Radius.circular(10),
                        //                           bottomRight: Radius.circular(10)),
                        //                     ),
                        //                     child: Row(
                        //                       mainAxisAlignment:
                        //                           MainAxisAlignment.center,
                        //                       children: const [
                        //                         Padding(
                        //                           padding: EdgeInsets.all(4.0),
                        //                           child: Icon(
                        //                             Icons.print,
                        //                             color: Colors.white,
                        //                           ),
                        //                         ),
                        //                         Text(
                        //                           'พิมพ์',
                        //                           textAlign: TextAlign.start,
                        //                           style: TextStyle(
                        //                               color: PeopleChaoScreen_Color
                        //                                   .Colors_Text2_,
                        //                               // fontWeight: FontWeight.bold,
                        //                               fontFamily: Font_.Fonts_T
                        //                               //fontSize: 10.0
                        //                               ),
                        //                         ),
                        //                       ],
                        //                     ),
                        //                   ),
                        //                   onTap: () async {
                        //                     // String Url =
                        //                     //     'https://www.etda.or.th/getattachment/78750426-4a58-4c36-85d3-d1c11c3db1f3/IUB-65-Final.pdf.aspx';
                        //                     String Url =
                        //                         await '${MyConstant().domain}/files/kad_taii/contract/lease/$cxname_lease';
                        //                     print(Url);
                        //                     if (Url == '') {
                        //                       showDialog<void>(
                        //                         context: context,
                        //                         barrierDismissible:
                        //                             false, // user must tap button!
                        //                         builder: (BuildContext context) {
                        //                           return AlertDialog(
                        //                             shape:
                        //                                 const RoundedRectangleBorder(
                        //                                     borderRadius:
                        //                                         BorderRadius.all(
                        //                                             Radius.circular(
                        //                                                 10.0))),
                        //                             title: const Center(
                        //                                 child: Text(
                        //                               'ไม่พบเอกสารสัญญาเช่า(เซ็นแล้ว)',
                        //                               style: TextStyle(
                        //                                   color:
                        //                                       PeopleChaoScreen_Color
                        //                                           .Colors_Text1_,
                        //                                   fontWeight: FontWeight.bold,
                        //                                   fontFamily:
                        //                                       FontWeight_.Fonts_T),
                        //                             )),
                        //                             content: SingleChildScrollView(
                        //                               child: ListBody(
                        //                                 children: const <Widget>[
                        //                                   Text(
                        //                                     'ไม่พบเอกสาร หรือ กรุณาอัพโหลดก่อน จึงจะสามารถพิมพ์ได้',
                        //                                     style: TextStyle(
                        //                                         color:
                        //                                             PeopleChaoScreen_Color
                        //                                                 .Colors_Text2_,
                        //                                         fontFamily:
                        //                                             Font_.Fonts_T),
                        //                                   ),
                        //                                 ],
                        //                               ),
                        //                             ),
                        //                             actions: <Widget>[
                        //                               InkWell(
                        //                                 child: Container(
                        //                                     width: 100,
                        //                                     decoration:
                        //                                         const BoxDecoration(
                        //                                       color: Colors.black,
                        //                                       borderRadius:
                        //                                           BorderRadius.only(
                        //                                               topLeft: Radius
                        //                                                   .circular(
                        //                                                       10),
                        //                                               topRight: Radius
                        //                                                   .circular(
                        //                                                       10),
                        //                                               bottomLeft: Radius
                        //                                                   .circular(
                        //                                                       10),
                        //                                               bottomRight: Radius
                        //                                                   .circular(
                        //                                                       10)),
                        //                                       // border: Border.all(color: Colors.white, width: 1),
                        //                                     ),
                        //                                     padding:
                        //                                         const EdgeInsets.all(
                        //                                             8.0),
                        //                                     child: const Center(
                        //                                         child: Text(
                        //                                       'ปิด',
                        //                                       style: TextStyle(
                        //                                           color: PeopleChaoScreen_Color
                        //                                               .Colors_Text3_,
                        //                                           fontWeight:
                        //                                               FontWeight.bold,
                        //                                           fontFamily:
                        //                                               Font_.Fonts_T),
                        //                                     ))),
                        //                                 onTap: () {
                        //                                   Navigator.of(context).pop();
                        //                                 },
                        //                               ),
                        //                               // TextButton(
                        //                               //   child: const Text('ตกลง'),
                        //                               //   onPressed: () {
                        //                               //     Navigator.of(context).pop();
                        //                               //   },
                        //                               // ),
                        //                             ],
                        //                           );
                        //                         },
                        //                       );
                        //                     } else {
                        //                       Navigator.push(
                        //                           context,
                        //                           MaterialPageRoute(
                        //                             builder: (context) =>
                        //                                 PreviewScreenRental_(
                        //                                     title:
                        //                                         'เอกสารสัญญาเช่า(เซ็นแล้ว)',
                        //                                     Url: Url),
                        //                           ));
                        //                     }
                        //                   },
                        //                 ),
                        //               ),
                        //             ),
                        //           ],
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'เอกสารอื่นๆ ${Other_file.length} รายการ',
                                    textAlign: TextAlign.start,
                                    style: const TextStyle(
                                        color: PeopleChaoScreen_Color
                                            .Colors_Text2_,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: FontWeight_.Fonts_T
                                        //fontSize: 10.0
                                        ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          height: 110,
                                          padding: const EdgeInsets.all(4.0),
                                          decoration: BoxDecoration(
                                            // color: Colors.green,
                                            borderRadius:
                                                const BorderRadius.only(
                                                    topLeft: Radius.circular(8),
                                                    topRight:
                                                        Radius.circular(8),
                                                    bottomLeft:
                                                        Radius.circular(8),
                                                    bottomRight:
                                                        Radius.circular(8)),
                                            border: Border.all(
                                                color: Colors.grey, width: 2),
                                          ),
                                          child: ScrollConfiguration(
                                            behavior:
                                                ScrollConfiguration.of(context)
                                                    .copyWith(dragDevices: {
                                              PointerDeviceKind.touch,
                                              PointerDeviceKind.mouse,
                                            }),
                                            child: SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Row(
                                                children: [
                                                  for (int index = 0;
                                                      index < Other_file.length;
                                                      index++)
                                                    Stack(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: InkWell(
                                                            onTap: () async {
                                                              // String Url =
                                                              //     'https://www.etda.or.th/getattachment/78750426-4a58-4c36-85d3-d1c11c3db1f3/IUB-65-Final.pdf.aspx';
                                                              String Url =
                                                                  await '${MyConstant().domain}/files/$foder/contract/other/${Other_file[index].filename}';
                                                              print(Url);
                                                              if (Url == '') {
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
                                                                      shape: const RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.all(Radius.circular(10.0))),
                                                                      title: const Center(
                                                                          child: Text(
                                                                        'ไม่พบเอกสารอื่นๆ',
                                                                        style: TextStyle(
                                                                            color:
                                                                                PeopleChaoScreen_Color.Colors_Text1_,
                                                                            fontWeight: FontWeight.bold,
                                                                            fontFamily: FontWeight_.Fonts_T),
                                                                      )),
                                                                      content:
                                                                          const SingleChildScrollView(
                                                                        child:
                                                                            ListBody(
                                                                          children: <Widget>[
                                                                            Text(
                                                                              'ไม่พบเอกสาร หรือ กรุณาอัพโหลดก่อน จึงจะสามารถพิมพ์ได้',
                                                                              style: TextStyle(color: PeopleChaoScreen_Color.Colors_Text2_, fontFamily: Font_.Fonts_T),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      actions: <Widget>[
                                                                        InkWell(
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
                                                                                style: TextStyle(color: PeopleChaoScreen_Color.Colors_Text3_, fontWeight: FontWeight.bold, fontFamily: Font_.Fonts_T),
                                                                              ))),
                                                                          onTap:
                                                                              () {
                                                                            Navigator.of(context).pop();
                                                                          },
                                                                        ),
                                                                        // TextButton(
                                                                        //   child: const Text('ตกลง'),
                                                                        //   onPressed: () {
                                                                        //     Navigator.of(context).pop();
                                                                        //   },
                                                                        // ),
                                                                      ],
                                                                    );
                                                                  },
                                                                );
                                                              } else {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                      builder: (context) => PreviewScreenRental_(
                                                                          title:
                                                                              'เอกสารอื่นๆ',
                                                                          Url:
                                                                              Url),
                                                                    ));
                                                              }
                                                            },
                                                            child: Container(
                                                                width: 150,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  borderRadius: const BorderRadius
                                                                          .only(
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
                                                                  border: Border.all(
                                                                      color: Colors
                                                                          .grey,
                                                                      width: 2),
                                                                ),
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: Text(
                                                                  '${Other_file[index].filename}',
                                                                  style: TextStyle(
                                                                      color: Colors.blue[800],
                                                                      // fontWeight: FontWeight.bold,
                                                                      fontFamily: Font_.Fonts_T,
                                                                      fontSize: 12.0),
                                                                )),
                                                          ),
                                                        ),
                                                        Positioned(
                                                            top: 0,
                                                            right: 2,
                                                            child: InkWell(
                                                              child: const Icon(
                                                                Icons
                                                                    .close_sharp,
                                                                color:
                                                                    Colors.red,
                                                              ),
                                                              onTap: () {
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
                                                                      shape: const RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.all(Radius.circular(10.0))),
                                                                      title: const Center(
                                                                          child: Text(
                                                                        'ลบเอกสาร',
                                                                        style: TextStyle(
                                                                            color:
                                                                                PeopleChaoScreen_Color.Colors_Text1_,
                                                                            fontWeight: FontWeight.bold,
                                                                            fontFamily: FontWeight_.Fonts_T),
                                                                      )),
                                                                      actions: <Widget>[
                                                                        Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          children: [
                                                                            Padding(
                                                                              padding: const EdgeInsets.all(8.0),
                                                                              child: InkWell(
                                                                                child: Container(
                                                                                    width: 100,
                                                                                    decoration: BoxDecoration(
                                                                                      color: Colors.red[600],
                                                                                      borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                                                                                      // border: Border.all(color: Colors.white, width: 1),
                                                                                    ),
                                                                                    padding: const EdgeInsets.all(8.0),
                                                                                    child: const Center(
                                                                                        child: Text(
                                                                                      'ลบเอกสาร',
                                                                                      style: TextStyle(color: PeopleChaoScreen_Color.Colors_Text3_, fontWeight: FontWeight.bold, fontFamily: Font_.Fonts_T),
                                                                                    ))),
                                                                                onTap: () async {
                                                                                  deletedFile_('${Other_file[index].filename}', ' ${Other_file[index].ser}', 'other');

                                                                                  deletedFile_SQL('${Other_file[index].ser}');
                                                                                  GC_contractf();
                                                                                  Navigator.of(context).pop();
                                                                                },
                                                                              ),
                                                                            ),
                                                                            Padding(
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
                                                                                      style: TextStyle(color: PeopleChaoScreen_Color.Colors_Text3_, fontWeight: FontWeight.bold, fontFamily: Font_.Fonts_T),
                                                                                    ))),
                                                                                onTap: () {
                                                                                  GC_contractf();
                                                                                  Navigator.of(context).pop();
                                                                                },
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    );
                                                                  },
                                                                );
                                                              },
                                                            ))
                                                      ],
                                                    ),
                                                ],
                                              ),
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
                                        child: InkWell(
                                          child: Container(
                                            height: 40,
                                            decoration: BoxDecoration(
                                              color: Colors.blue[300],
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
                                            child: const Center(
                                              child: Text(
                                                'อัพโหลดไฟล์(PDF)',
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                    color:
                                                        PeopleChaoScreen_Color
                                                            .Colors_Text2_,
                                                    fontWeight: FontWeight.w400,
                                                    fontFamily: Font_.Fonts_T
                                                    //fontSize: 10.0
                                                    ),
                                              ),
                                            ),
                                          ),
                                          onTap: () async {
                                            uploadFile_Documentmore(
                                              '${cxname_other}',
                                              ' $cxname_other_ser',
                                            );
                                            SharedPreferences preferences =
                                                await SharedPreferences
                                                    .getInstance();
                                            var name =
                                                preferences.getString('fname');
                                            Insert_log.Insert_logs('สัญญาเช่า',
                                                '$name>สัญญา${widget.Get_Value_cid}>อัพโหลดเอกสารอื่นๆ');
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(
              height: 20,
            ),

            renTal_lavel <= 3
                ? SizedBox()
                : widget.Get_Value_NameShop_index.toString() != '1'
                    ? SizedBox()
                    : Container(
                        // width: MediaQuery.of(context).size.width,
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
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () async {
                                setState(() {
                                  if (ser_tabbarview_2 == 2) {
                                    ser_tabbarview_2 = 0;
                                  } else {
                                    ser_tabbarview_2 = 2;
                                  }
                                });

                                SharedPreferences preferences =
                                    await SharedPreferences.getInstance();
                                String? ren =
                                    preferences.getString('renTalSer');
                                String? ser_user = preferences.getString('ser');
                                var name = preferences.getString('fname');
                                Insert_log.Insert_logs('สัญญาเช่า',
                                    '$name>สัญญา${widget.Get_Value_cid}>เพิ่มค่าบริการ');
                                String url2 =
                                    '${MyConstant().domain}/D_quotx.php?isAdd=true&ren=$ren&ser_user=$ser_user';

                                try {
                                  var response2 =
                                      await http.get(Uri.parse(url2));

                                  var result2 = json.decode(response2.body);
                                  print(result2);
                                  if (result2.toString() == 'true') {}
                                } catch (e) {}
                              },
                              child: Container(
                                width: 200,
                                decoration: BoxDecoration(
                                  color: Colors.blue[600],
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10)),
                                  border:
                                      Border.all(color: Colors.grey, width: 1),
                                ),
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  ser_tabbarview_2 == 2
                                      ? 'ยกเลิกเพิ่มค่าบริการ'
                                      : 'เพิ่มค่าบริการ',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: FontWeight_.Fonts_T
                                      // fontSize: 15.0,
                                      ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            InkWell(
                              onTap: () async {
                                setState(() {
                                  if (ser_tabbarview_2 == 1) {
                                    ser_tabbarview_2 = 0;
                                  } else {
                                    ser_tabbarview_2 = 1;
                                  }
                                });

                                SharedPreferences preferences =
                                    await SharedPreferences.getInstance();
                                var name = preferences.getString('fname');
                                Insert_log.Insert_logs('สัญญาเช่า',
                                    '$name>สัญญา${widget.Get_Value_cid}>ปรับตั้งหนี้');
                              },
                              child: Container(
                                width: 200,
                                decoration: BoxDecoration(
                                  color: Colors.orange[900],
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10)),
                                  border:
                                      Border.all(color: Colors.grey, width: 1),
                                ),
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  ser_tabbarview_2 == 1
                                      ? 'ยกเลิกปรับตั้งหนี้'
                                      : 'ปรับตั้งหนี้',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: FontWeight_.Fonts_T,
                                      fontSize: 15.0),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
            ser_tabbarview_2 == 0
                ? SizedBox(
                    width: 10,
                  )
                : ser_tabbarview_2 == 1
                    ? SettringListMenu(
                        Get_Value_cid: widget.Get_Value_cid,
                        Get_Value_NameShop_index:
                            widget.Get_Value_NameShop_index)
                    : ChaoReContactAdd(
                        Value_cid: widget.Get_Value_cid,
                      ),

            ser_tabbarview_2 != 0
                ? SizedBox()
                : const Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: AutoSizeText(
                          minFontSize: 10,
                          maxFontSize: 15,
                          'รายละเอียดค่าบริการ',
                          style: TextStyle(
                              color: PeopleChaoScreen_Color.Colors_Text1_,
                              fontWeight: FontWeight.bold,
                              fontFamily: FontWeight_.Fonts_T
                              //fontSize: 10.0
                              ),
                        ),
                      ),
                    ],
                  ),
            ser_tabbarview_2 != 0
                ? SizedBox()
                : Container(
                    child: Column(
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
                                SizedBox(
                                  child: Column(
                                    children: [
                                      Container(
                                          width: (Responsive.isDesktop(context))
                                              ? MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.84
                                              : 800,
                                          decoration: BoxDecoration(
                                            color: AppbackgroundColor
                                                .TiTile_Colors,
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(10),
                                                bottomLeft: Radius.circular(0),
                                                bottomRight:
                                                    Radius.circular(0)),
                                          ),
                                          padding: const EdgeInsets.all(8.0),
                                          child: const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                flex: 1,
                                                child: Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Text(
                                                    'งวด',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color:
                                                            PeopleChaoScreen_Color
                                                                .Colors_Text1_,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily:
                                                            FontWeight_.Fonts_T
                                                        //fontSize: 10.0
                                                        //fontSize: 10.0
                                                        ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Text(
                                                    'วันที่',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color:
                                                            PeopleChaoScreen_Color
                                                                .Colors_Text1_,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily:
                                                            FontWeight_.Fonts_T
                                                        //fontSize: 10.0
                                                        //fontSize: 10.0
                                                        ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Text(
                                                    'รายการ',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color:
                                                            PeopleChaoScreen_Color
                                                                .Colors_Text1_,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily:
                                                            FontWeight_.Fonts_T
                                                        //fontSize: 10.0
                                                        //fontSize: 10.0
                                                        ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Text(
                                                    'ยอด/งวด',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color:
                                                            PeopleChaoScreen_Color
                                                                .Colors_Text1_,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily:
                                                            FontWeight_.Fonts_T
                                                        //fontSize: 10.0
                                                        //fontSize: 10.0
                                                        ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Text(
                                                    'ยอด',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color:
                                                            PeopleChaoScreen_Color
                                                                .Colors_Text1_,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily:
                                                            FontWeight_.Fonts_T
                                                        //fontSize: 10.0
                                                        //fontSize: 10.0
                                                        ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )),
                                      Container(
                                        height: (Responsive.isDesktop(context))
                                            ? MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.2
                                            : 300,
                                        width: (Responsive.isDesktop(context))
                                            ? MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.84
                                            : 800,
                                        decoration: const BoxDecoration(
                                          color:
                                              AppbackgroundColor.Sub_Abg_Colors,
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(0),
                                              topRight: Radius.circular(0),
                                              bottomLeft: Radius.circular(0),
                                              bottomRight: Radius.circular(0)),
                                          // border: Border.all(color: Colors.grey, width: 1),
                                        ),
                                        child: ListView.builder(
                                          controller: _scrollController1,
                                          // itemExtent: 50,
                                          physics:
                                              const AlwaysScrollableScrollPhysics(), //NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: quotxSelectModels.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return Material(
                                              color: tappedIndex_1 ==
                                                      index.toString()
                                                  ? tappedIndex_Color
                                                      .tappedIndex_Colors
                                                  : AppbackgroundColor
                                                      .Sub_Abg_Colors,
                                              child: Container(
                                                // color:
                                                //     tappedIndex_1 == index.toString()
                                                //         ? tappedIndex_Color
                                                //             .tappedIndex_Colors
                                                //             .withOpacity(0.5)
                                                //         : null,
                                                child:
                                                    quotxSelectModels[index]
                                                                .etype ==
                                                            'F'
                                                        ? ListTile(
                                                            onTap: () {
                                                              setState(() {
                                                                tappedIndex_1 =
                                                                    index
                                                                        .toString();
                                                              });
                                                            },
                                                            title: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Expanded(
                                                                  flex: 1,
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Container(
                                                                        // decoration: BoxDecoration(
                                                                        //   color: Colors.grey.shade300,
                                                                        //   borderRadius:
                                                                        //       const BorderRadius.only(
                                                                        //           topLeft:
                                                                        //               Radius.circular(10),
                                                                        //           topRight:
                                                                        //               Radius.circular(10),
                                                                        //           bottomLeft:
                                                                        //               Radius.circular(10),
                                                                        //           bottomRight:
                                                                        //               Radius.circular(10)),
                                                                        //   // border: Border.all(color: Colors.grey, width: 1),
                                                                        // ),
                                                                        padding:
                                                                            const EdgeInsets.all(8.0),
                                                                        child:
                                                                            AutoSizeText(
                                                                          maxLines:
                                                                              2,
                                                                          minFontSize:
                                                                              8,
                                                                          // maxFontSize: 15,
                                                                          '${quotxSelectModels[index].expname}',
                                                                          textAlign:
                                                                              TextAlign.start,
                                                                          style:
                                                                              const TextStyle(
                                                                            color:
                                                                                PeopleChaoScreen_Color.Colors_Text2_,
                                                                            // fontWeight:
                                                                            //     FontWeight
                                                                            //         .bold,
                                                                            fontFamily:
                                                                                Font_.Fonts_T,

                                                                            //fontSize: 10.0
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                // Expanded(
                                                                //   flex: 1,
                                                                //   child: Padding(
                                                                //     padding:
                                                                //         const EdgeInsets
                                                                //             .all(8.0),
                                                                //     child: AutoSizeText(
                                                                //       maxLines: 2,
                                                                //       minFontSize: 8,
                                                                //       // maxFontSize: 15,
                                                                //       '', //'${double.parse(quotxSelectModels[index].qty!).toStringAsFixed(0)} วัน',
                                                                //       textAlign: TextAlign
                                                                //           .center,
                                                                //       style:
                                                                //           const TextStyle(
                                                                //         color: PeopleChaoScreen_Color
                                                                //             .Colors_Text2_,
                                                                //         // fontWeight: FontWeight.bold,
                                                                //         fontFamily:
                                                                //             Font_.Fonts_T,

                                                                //         //fontSize: 10.0
                                                                //       ),
                                                                //     ),
                                                                //   ),
                                                                // ),
                                                                Expanded(
                                                                  flex: 1,
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            8.0),
                                                                    child:
                                                                        AutoSizeText(
                                                                      maxLines:
                                                                          2,
                                                                      minFontSize:
                                                                          8,
                                                                      // maxFontSize: 15,
                                                                      widget.Get_Value_NameShop_index ==
                                                                              '1'
                                                                          ? quotxSelectModels[index].nvat == '0.00'
                                                                              ? '${double.parse(quotxSelectModels[index].qty!).toStringAsFixed(0)} วัน / ${nFormat.format(double.parse(quotxSelectModels[index].amt!))} บาท'
                                                                              : '${double.parse(quotxSelectModels[index].qty!).toStringAsFixed(0)} วัน / ${nFormat.format(double.parse(quotxSelectModels[index].nvat!))} %'
                                                                          : quotxSelectModels[index].fineCal == '0.00'
                                                                              ? '${double.parse(quotxSelectModels[index].qty!).toStringAsFixed(0)} วัน / ${nFormat.format(double.parse(quotxSelectModels[index].finePri!))} บาท'
                                                                              : '${double.parse(quotxSelectModels[index].qty!).toStringAsFixed(0)} วัน / ${nFormat.format(double.parse(quotxSelectModels[index].fineCal!))} %',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style:
                                                                          const TextStyle(
                                                                        color: PeopleChaoScreen_Color
                                                                            .Colors_Text2_,
                                                                        // fontWeight: FontWeight.bold,
                                                                        fontFamily:
                                                                            Font_.Fonts_T,

                                                                        //fontSize: 10.0
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                // Expanded(
                                                                //   flex: 1,
                                                                //   child: AutoSizeText(
                                                                //     maxLines: 2,
                                                                //     minFontSize: 8,
                                                                //     // maxFontSize: 15,
                                                                //     double.parse(quotxSelectModels[
                                                                //                         index]
                                                                //                     .fine!)
                                                                //                 .toStringAsFixed(
                                                                //                     0) ==
                                                                //             '0'
                                                                //         ? ''
                                                                //         : 'เกิน ${double.parse(quotxSelectModels[index].fine!).toStringAsFixed(0)} วัน',
                                                                //     textAlign:
                                                                //         TextAlign.right,
                                                                //     style:
                                                                //         const TextStyle(
                                                                //       color: PeopleChaoScreen_Color
                                                                //           .Colors_Text2_,
                                                                //       // fontWeight: FontWeight.bold,
                                                                //       fontFamily:
                                                                //           Font_.Fonts_T,

                                                                //       //fontSize: 10.0
                                                                //     ),
                                                                //   ),
                                                                // ),
                                                                Expanded(
                                                                  flex: 1,
                                                                  child:
                                                                      AutoSizeText(
                                                                    maxLines: 2,
                                                                    minFontSize:
                                                                        8,
                                                                    // maxFontSize: 15,
                                                                    widget.Get_Value_NameShop_index ==
                                                                            '1'
                                                                        ? double.parse(quotxSelectModels[index].vat!).toStringAsFixed(0) ==
                                                                                '0'
                                                                            ? ''
                                                                            : double.parse(quotxSelectModels[index].pvat!).toStringAsFixed(0) == '0'
                                                                                ? 'เกิน ${double.parse(quotxSelectModels[index].vat!).toStringAsFixed(0)} วัน / ${nFormat.format(double.parse(quotxSelectModels[index].total!))} บาท'
                                                                                : 'เกิน ${double.parse(quotxSelectModels[index].vat!).toStringAsFixed(0)} วัน / ${nFormat.format(double.parse(quotxSelectModels[index].pvat!))} %'
                                                                        : double.parse(quotxSelectModels[index].fine!).toStringAsFixed(0) == '0'
                                                                            ? ''
                                                                            : double.parse(quotxSelectModels[index].fineUnit!).toStringAsFixed(0) == '0'
                                                                                ? 'เกิน ${double.parse(quotxSelectModels[index].fine!).toStringAsFixed(0)} วัน / ${nFormat.format(double.parse(quotxSelectModels[index].fineLate!))} บาท'
                                                                                : 'เกิน ${double.parse(quotxSelectModels[index].fine!).toStringAsFixed(0)} วัน / ${nFormat.format(double.parse(quotxSelectModels[index].fineUnit!))} %',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .right,
                                                                    style:
                                                                        const TextStyle(
                                                                      color: PeopleChaoScreen_Color
                                                                          .Colors_Text2_,
                                                                      // fontWeight: FontWeight.bold,
                                                                      fontFamily:
                                                                          Font_
                                                                              .Fonts_T,

                                                                      //fontSize: 10.0
                                                                    ),
                                                                  ),
                                                                ),

                                                                Expanded(
                                                                  flex: 1,
                                                                  child:
                                                                      AutoSizeText(
                                                                    maxLines: 2,
                                                                    minFontSize:
                                                                        8,
                                                                    // maxFontSize: 15,
                                                                    widget.Get_Value_NameShop_index ==
                                                                            '1'
                                                                        ? double.parse(quotxSelectModels[index].fine_three!).toStringAsFixed(0) ==
                                                                                '0'
                                                                            ? ''
                                                                            : double.parse(quotxSelectModels[index].fine_cal_three!).toStringAsFixed(0) != '0'
                                                                                ? 'เกิน ${double.parse(quotxSelectModels[index].fine_three!).toStringAsFixed(0)} วัน / ${nFormat.format(double.parse(quotxSelectModels[index].fine_cal_three!))} บาท'
                                                                                : 'เกิน ${double.parse(quotxSelectModels[index].fine_three!).toStringAsFixed(0)} วัน / ${nFormat.format(double.parse(quotxSelectModels[index].fine_late_three!))} %'
                                                                        : double.parse(quotxSelectModels[index].fine_three!).toStringAsFixed(0) == '0'
                                                                            ? ''
                                                                            : double.parse(quotxSelectModels[index].fine_cal_three!).toStringAsFixed(0) != '0'
                                                                                ? 'เกิน ${double.parse(quotxSelectModels[index].fine_three!).toStringAsFixed(0)} วัน / ${nFormat.format(double.parse(quotxSelectModels[index].fine_cal_three!))} บาท'
                                                                                : 'เกิน ${double.parse(quotxSelectModels[index].fine_three!).toStringAsFixed(0)} วัน / ${nFormat.format(double.parse(quotxSelectModels[index].fine_late_three!))} %',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .right,
                                                                    style:
                                                                        const TextStyle(
                                                                      color: PeopleChaoScreen_Color
                                                                          .Colors_Text2_,
                                                                      // fontWeight: FontWeight.bold,
                                                                      fontFamily:
                                                                          Font_
                                                                              .Fonts_T,

                                                                      //fontSize: 10.0
                                                                    ),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  flex: 1,
                                                                  child:
                                                                      AutoSizeText(
                                                                    maxLines: 2,
                                                                    minFontSize:
                                                                        8,
                                                                    // maxFontSize: 15,
                                                                    double.parse(quotxSelectModels[index].fine_max!).toStringAsFixed(0) ==
                                                                            '0'
                                                                        ? ''
                                                                        : 'ไม่เกิน ${nFormat.format(double.parse(quotxSelectModels[index].fine_max!))} บาท',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .right,
                                                                    style:
                                                                        const TextStyle(
                                                                      color: PeopleChaoScreen_Color
                                                                          .Colors_Text2_,
                                                                      // fontWeight: FontWeight.bold,
                                                                      fontFamily:
                                                                          Font_
                                                                              .Fonts_T,

                                                                      //fontSize: 10.0
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ))
                                                        : ListTile(
                                                            onTap: () {
                                                              setState(() {
                                                                tappedIndex_1 =
                                                                    index
                                                                        .toString();
                                                              });
                                                            },
                                                            title: Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                // color: Colors.green[100]!
                                                                //     .withOpacity(0.5),
                                                                border: Border(
                                                                  bottom:
                                                                      BorderSide(
                                                                    color: Colors
                                                                        .black12,
                                                                    width: 1,
                                                                  ),
                                                                ),
                                                              ),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child:
                                                                        AutoSizeText(
                                                                      maxLines:
                                                                          2,
                                                                      minFontSize:
                                                                          8,
                                                                      // maxFontSize: 15,
                                                                      '${quotxSelectModels[index].unit} / ${quotxSelectModels[index].term} (งวด)',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .start,
                                                                      style: const TextStyle(
                                                                          color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                          //fontWeight: FontWeight.bold,
                                                                          fontFamily: Font_.Fonts_T),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child:
                                                                        AutoSizeText(
                                                                      maxLines:
                                                                          2,
                                                                      minFontSize:
                                                                          8,
                                                                      // maxFontSize: 15,
                                                                      '${DateFormat('dd-MM-yyyy').format(DateTime.parse('${quotxSelectModels[index].sdate!} 00:00:00'))} - ${DateFormat('dd-MM-yyyy').format(DateTime.parse('${quotxSelectModels[index].ldate!} 00:00:00'))}',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style: const TextStyle(
                                                                          color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                          //fontWeight: FontWeight.bold,
                                                                          fontFamily: Font_.Fonts_T),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child:
                                                                        Tooltip(
                                                                      richMessage:
                                                                          TextSpan(
                                                                        text:
                                                                            '${quotxSelectModels[index].expname}',
                                                                        style:
                                                                            const TextStyle(
                                                                          color:
                                                                              HomeScreen_Color.Colors_Text1_,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          fontFamily:
                                                                              FontWeight_.Fonts_T,
                                                                          //fontSize: 10.0
                                                                        ),
                                                                      ),
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(5),
                                                                        color: Colors
                                                                            .grey[200],
                                                                      ),
                                                                      child:
                                                                          AutoSizeText(
                                                                        maxLines:
                                                                            2,
                                                                        minFontSize:
                                                                            8,
                                                                        // maxFontSize: 15,
                                                                        '${quotxSelectModels[index].expname}',
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        style: const TextStyle(
                                                                            color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                            //fontWeight: FontWeight.bold,
                                                                            fontFamily: Font_.Fonts_T),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  quotxSelectModels[index]
                                                                              .ele_ty ==
                                                                          '0'
                                                                      ? Expanded(
                                                                          flex:
                                                                              1,
                                                                          child:
                                                                              AutoSizeText(
                                                                            maxLines:
                                                                                2,
                                                                            minFontSize:
                                                                                8,
                                                                            // maxFontSize: 15,
                                                                            quotxSelectModels[index].qty == '0.00'
                                                                                ? '${nFormat.format(double.parse(quotxSelectModels[index].total!))} / งวด'
                                                                                : '${nFormat.format(double.parse(quotxSelectModels[index].qty!))} / หน่วย',
                                                                            // '${nFormat.format(double.parse(quotxSelectModels[index].total!))}',
                                                                            textAlign:
                                                                                TextAlign.end,
                                                                            style: const TextStyle(
                                                                                color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                                //fontWeight: FontWeight.bold,
                                                                                fontFamily: Font_.Fonts_T),
                                                                          ),
                                                                        )
                                                                      : Expanded(
                                                                          flex:
                                                                              1,
                                                                          child:
                                                                              AutoSizeText(
                                                                            maxLines:
                                                                                2,
                                                                            minFontSize:
                                                                                8,
                                                                            // maxFontSize: 15,
                                                                            'อัตราพิเศษ',
                                                                            // '${nFormat.format(double.parse(quotxSelectModels[index].total!))}',
                                                                            textAlign:
                                                                                TextAlign.end,
                                                                            style: const TextStyle(
                                                                                color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                                //fontWeight: FontWeight.bold,
                                                                                fontFamily: Font_.Fonts_T),
                                                                          ),
                                                                        ),
                                                                  quotxSelectModels[index]
                                                                              .ele_ty ==
                                                                          '0'
                                                                      ? Expanded(
                                                                          flex:
                                                                              1,
                                                                          child:
                                                                              AutoSizeText(
                                                                            maxLines:
                                                                                2,
                                                                            minFontSize:
                                                                                8,
                                                                            // maxFontSize: 15,
                                                                            '${nFormat.format(int.parse(quotxSelectModels[index].term!) * double.parse(quotxSelectModels[index].total!))}',
                                                                            textAlign:
                                                                                TextAlign.end,
                                                                            style: const TextStyle(
                                                                                color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                                //fontWeight: FontWeight.bold,
                                                                                fontFamily: Font_.Fonts_T),
                                                                          ),
                                                                        )
                                                                      : Expanded(
                                                                          flex:
                                                                              1,
                                                                          child:
                                                                              GestureDetector(
                                                                            onTap:
                                                                                () {
                                                                              showcountmiter(index).then((value) => showDialog(
                                                                                  context: context,
                                                                                  builder: (_) {
                                                                                    return Dialog(
                                                                                      child: Container(
                                                                                        width: MediaQuery.of(context).size.width * 0.5,
                                                                                        height: MediaQuery.of(context).size.width * 0.2,
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
                                                                                                        'อัตราการคำนวณปัจจุบัน',
                                                                                                        textAlign: TextAlign.center,
                                                                                                        style: const TextStyle(color: PeopleChaoScreen_Color.Colors_Text2_, fontWeight: FontWeight.bold, fontSize: 25, fontFamily: Font_.Fonts_T),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ],
                                                                                              ),
                                                                                              Divider(),
                                                                                              (double.parse(electricityModels[0].eleMitOne!) + double.parse(electricityModels[0].eleGobOne!)) == 0.00
                                                                                                  ? SizedBox()
                                                                                                  : Row(
                                                                                                      children: [
                                                                                                        Expanded(flex: 1, child: Text('')),
                                                                                                        Expanded(
                                                                                                          flex: 2,
                                                                                                          child: Text(
                                                                                                            'หน่วยที่ 0 - ${electricityModels[0].eleOne}',
                                                                                                            textAlign: TextAlign.start,
                                                                                                            style: const TextStyle(color: PeopleChaoScreen_Color.Colors_Text2_, fontFamily: Font_.Fonts_T),
                                                                                                          ),
                                                                                                        ),
                                                                                                        Expanded(
                                                                                                          flex: 2,
                                                                                                          child: Text(
                                                                                                            double.parse(electricityModels[0].eleMitOne!) == 0.00 ? 'เหมาจ่าย' : 'หน่วยละ',
                                                                                                            textAlign: TextAlign.start,
                                                                                                            style: const TextStyle(color: PeopleChaoScreen_Color.Colors_Text2_, fontFamily: Font_.Fonts_T),
                                                                                                          ),
                                                                                                        ),
                                                                                                        Expanded(
                                                                                                          flex: 2,
                                                                                                          child: Text(
                                                                                                            double.parse(electricityModels[0].eleMitOne!) == 0.00 ? '${electricityModels[0].eleGobOne}' : '${electricityModels[0].eleMitOne}',
                                                                                                            textAlign: TextAlign.end,
                                                                                                            style: const TextStyle(color: PeopleChaoScreen_Color.Colors_Text2_, fontFamily: Font_.Fonts_T),
                                                                                                          ),
                                                                                                        ),
                                                                                                        Expanded(
                                                                                                          flex: 1,
                                                                                                          child: Text(
                                                                                                            'บาท',
                                                                                                            textAlign: TextAlign.center,
                                                                                                            style: const TextStyle(color: PeopleChaoScreen_Color.Colors_Text2_, fontFamily: Font_.Fonts_T),
                                                                                                          ),
                                                                                                        ),
                                                                                                      ],
                                                                                                    ),
                                                                                              SizedBox(
                                                                                                height: 10,
                                                                                              ),
                                                                                              (double.parse(electricityModels[0].eleMitTwo!) + double.parse(electricityModels[0].eleGobTwo!)) == 0.00
                                                                                                  ? SizedBox()
                                                                                                  : Row(
                                                                                                      children: [
                                                                                                        Expanded(flex: 1, child: Text('')),
                                                                                                        Expanded(
                                                                                                          flex: 2,
                                                                                                          child: Text(
                                                                                                            'หน่วยที่ ${int.parse(electricityModels[0].eleOne!) + 1} - ${electricityModels[0].eleTwo}',
                                                                                                            textAlign: TextAlign.start,
                                                                                                            style: const TextStyle(color: PeopleChaoScreen_Color.Colors_Text2_, fontFamily: Font_.Fonts_T),
                                                                                                          ),
                                                                                                        ),
                                                                                                        Expanded(
                                                                                                          flex: 2,
                                                                                                          child: Text(
                                                                                                            double.parse(electricityModels[0].eleMitTwo!) == 0.00 ? 'เหมาจ่าย' : 'หน่วยละ',
                                                                                                            textAlign: TextAlign.start,
                                                                                                            style: const TextStyle(color: PeopleChaoScreen_Color.Colors_Text2_, fontFamily: Font_.Fonts_T),
                                                                                                          ),
                                                                                                        ),
                                                                                                        Expanded(
                                                                                                          flex: 2,
                                                                                                          child: Text(
                                                                                                            double.parse(electricityModels[0].eleMitTwo!) == 0.00 ? '${electricityModels[0].eleGobTwo}' : '${electricityModels[0].eleMitTwo}',
                                                                                                            textAlign: TextAlign.end,
                                                                                                            style: const TextStyle(color: PeopleChaoScreen_Color.Colors_Text2_, fontFamily: Font_.Fonts_T),
                                                                                                          ),
                                                                                                        ),
                                                                                                        Expanded(
                                                                                                          flex: 1,
                                                                                                          child: Text(
                                                                                                            'บาท',
                                                                                                            textAlign: TextAlign.center,
                                                                                                            style: const TextStyle(color: PeopleChaoScreen_Color.Colors_Text2_, fontFamily: Font_.Fonts_T),
                                                                                                          ),
                                                                                                        ),
                                                                                                      ],
                                                                                                    ),
                                                                                              SizedBox(
                                                                                                height: 10,
                                                                                              ),
                                                                                              (double.parse(electricityModels[0].eleMitThree!) + double.parse(electricityModels[0].eleGobThree!)) == 0.00
                                                                                                  ? SizedBox()
                                                                                                  : Row(
                                                                                                      children: [
                                                                                                        Expanded(flex: 1, child: Text('')),
                                                                                                        Expanded(
                                                                                                          flex: 2,
                                                                                                          child: Text(
                                                                                                            'หน่วยที่ ${int.parse(electricityModels[0].eleTwo!) + 1} - ${electricityModels[0].eleThree}',
                                                                                                            textAlign: TextAlign.start,
                                                                                                            style: const TextStyle(color: PeopleChaoScreen_Color.Colors_Text2_, fontFamily: Font_.Fonts_T),
                                                                                                          ),
                                                                                                        ),
                                                                                                        Expanded(
                                                                                                          flex: 2,
                                                                                                          child: Text(
                                                                                                            double.parse(electricityModels[0].eleMitThree!) == 0.00 ? 'เหมาจ่าย' : 'หน่วยละ',
                                                                                                            textAlign: TextAlign.start,
                                                                                                            style: const TextStyle(color: PeopleChaoScreen_Color.Colors_Text2_, fontFamily: Font_.Fonts_T),
                                                                                                          ),
                                                                                                        ),
                                                                                                        Expanded(
                                                                                                          flex: 2,
                                                                                                          child: Text(
                                                                                                            double.parse(electricityModels[0].eleMitThree!) == 0.00 ? '${electricityModels[0].eleGobThree}' : '${electricityModels[0].eleMitThree}',
                                                                                                            textAlign: TextAlign.end,
                                                                                                            style: const TextStyle(color: PeopleChaoScreen_Color.Colors_Text2_, fontFamily: Font_.Fonts_T),
                                                                                                          ),
                                                                                                        ),
                                                                                                        Expanded(
                                                                                                          flex: 1,
                                                                                                          child: Text(
                                                                                                            'บาท',
                                                                                                            textAlign: TextAlign.center,
                                                                                                            style: const TextStyle(color: PeopleChaoScreen_Color.Colors_Text2_, fontFamily: Font_.Fonts_T),
                                                                                                          ),
                                                                                                        ),
                                                                                                      ],
                                                                                                    ),
                                                                                              SizedBox(
                                                                                                height: 10,
                                                                                              ),
                                                                                              (double.parse(electricityModels[0].eleMitTour!) + double.parse(electricityModels[0].eleGobTour!)) == 0.00
                                                                                                  ? SizedBox()
                                                                                                  : Row(
                                                                                                      children: [
                                                                                                        Expanded(flex: 1, child: Text('')),
                                                                                                        Expanded(
                                                                                                          flex: 2,
                                                                                                          child: Text(
                                                                                                            'หน่วยที่ ${int.parse(electricityModels[0].eleThree!) + 1} - ${electricityModels[0].eleTour}',
                                                                                                            textAlign: TextAlign.start,
                                                                                                            style: const TextStyle(color: PeopleChaoScreen_Color.Colors_Text2_, fontFamily: Font_.Fonts_T),
                                                                                                          ),
                                                                                                        ),
                                                                                                        Expanded(
                                                                                                          flex: 2,
                                                                                                          child: Text(
                                                                                                            double.parse(electricityModels[0].eleMitTour!) == 0.00 ? 'เหมาจ่าย' : 'หน่วยละ',
                                                                                                            textAlign: TextAlign.start,
                                                                                                            style: const TextStyle(color: PeopleChaoScreen_Color.Colors_Text2_, fontFamily: Font_.Fonts_T),
                                                                                                          ),
                                                                                                        ),
                                                                                                        Expanded(
                                                                                                          flex: 2,
                                                                                                          child: Text(
                                                                                                            double.parse(electricityModels[0].eleMitTour!) == 0.00 ? '${electricityModels[0].eleGobTour}' : '${electricityModels[0].eleMitTour}',
                                                                                                            textAlign: TextAlign.end,
                                                                                                            style: const TextStyle(color: PeopleChaoScreen_Color.Colors_Text2_, fontFamily: Font_.Fonts_T),
                                                                                                          ),
                                                                                                        ),
                                                                                                        Expanded(
                                                                                                          flex: 1,
                                                                                                          child: Text(
                                                                                                            'บาท',
                                                                                                            textAlign: TextAlign.center,
                                                                                                            style: const TextStyle(color: PeopleChaoScreen_Color.Colors_Text2_, fontFamily: Font_.Fonts_T),
                                                                                                          ),
                                                                                                        ),
                                                                                                      ],
                                                                                                    ),
                                                                                              SizedBox(
                                                                                                height: 10,
                                                                                              ),
                                                                                              (double.parse(electricityModels[0].eleMitFive!) + double.parse(electricityModels[0].eleGobFive!)) == 0.00
                                                                                                  ? SizedBox()
                                                                                                  : Row(
                                                                                                      children: [
                                                                                                        Expanded(flex: 1, child: Text('')),
                                                                                                        Expanded(
                                                                                                          flex: 2,
                                                                                                          child: Text(
                                                                                                            'หน่วยที่ ${int.parse(electricityModels[0].eleTour!) + 1} - ${electricityModels[0].eleFive}',
                                                                                                            textAlign: TextAlign.start,
                                                                                                            style: const TextStyle(color: PeopleChaoScreen_Color.Colors_Text2_, fontFamily: Font_.Fonts_T),
                                                                                                          ),
                                                                                                        ),
                                                                                                        Expanded(
                                                                                                          flex: 2,
                                                                                                          child: Text(
                                                                                                            double.parse(electricityModels[0].eleMitFive!) == 0.00 ? 'เหมาจ่าย' : 'หน่วยละ',
                                                                                                            textAlign: TextAlign.start,
                                                                                                            style: const TextStyle(color: PeopleChaoScreen_Color.Colors_Text2_, fontFamily: Font_.Fonts_T),
                                                                                                          ),
                                                                                                        ),
                                                                                                        Expanded(
                                                                                                          flex: 2,
                                                                                                          child: Text(
                                                                                                            double.parse(electricityModels[0].eleMitFive!) == 0.00 ? '${electricityModels[0].eleGobFive}' : '${electricityModels[0].eleMitFive}',
                                                                                                            textAlign: TextAlign.end,
                                                                                                            style: const TextStyle(color: PeopleChaoScreen_Color.Colors_Text2_, fontFamily: Font_.Fonts_T),
                                                                                                          ),
                                                                                                        ),
                                                                                                        Expanded(
                                                                                                          flex: 1,
                                                                                                          child: Text(
                                                                                                            'บาท',
                                                                                                            textAlign: TextAlign.center,
                                                                                                            style: const TextStyle(color: PeopleChaoScreen_Color.Colors_Text2_, fontFamily: Font_.Fonts_T),
                                                                                                          ),
                                                                                                        ),
                                                                                                      ],
                                                                                                    ),
                                                                                              SizedBox(
                                                                                                height: 10,
                                                                                              ),
                                                                                              (double.parse(electricityModels[0].eleMitSix!) + double.parse(electricityModels[0].eleGobSix!)) == 0.00
                                                                                                  ? SizedBox()
                                                                                                  : Row(
                                                                                                      children: [
                                                                                                        Expanded(flex: 1, child: Text('')),
                                                                                                        Expanded(
                                                                                                          flex: 2,
                                                                                                          child: Text(
                                                                                                            'หน่วยที่ ${electricityModels[0].eleSix} ขึ้นไป',
                                                                                                            textAlign: TextAlign.start,
                                                                                                            style: const TextStyle(color: PeopleChaoScreen_Color.Colors_Text2_, fontFamily: Font_.Fonts_T),
                                                                                                          ),
                                                                                                        ),
                                                                                                        Expanded(
                                                                                                          flex: 2,
                                                                                                          child: Text(
                                                                                                            double.parse(electricityModels[0].eleMitSix!) == 0.00 ? 'เหมาจ่าย' : 'หน่วยละ',
                                                                                                            textAlign: TextAlign.start,
                                                                                                            style: const TextStyle(color: PeopleChaoScreen_Color.Colors_Text2_, fontFamily: Font_.Fonts_T),
                                                                                                          ),
                                                                                                        ),
                                                                                                        Expanded(
                                                                                                          flex: 2,
                                                                                                          child: Text(
                                                                                                            double.parse(electricityModels[0].eleMitSix!) == 0.00 ? '${electricityModels[0].eleGobSix}' : '${electricityModels[0].eleMitSix}',
                                                                                                            textAlign: TextAlign.end,
                                                                                                            style: const TextStyle(color: PeopleChaoScreen_Color.Colors_Text2_, fontFamily: Font_.Fonts_T),
                                                                                                          ),
                                                                                                        ),
                                                                                                        Expanded(
                                                                                                          flex: 1,
                                                                                                          child: Text(
                                                                                                            'บาท',
                                                                                                            textAlign: TextAlign.center,
                                                                                                            style: const TextStyle(color: PeopleChaoScreen_Color.Colors_Text2_, fontFamily: Font_.Fonts_T),
                                                                                                          ),
                                                                                                        ),
                                                                                                      ],
                                                                                                    ),
                                                                                              Divider(),
                                                                                              Row(
                                                                                                mainAxisAlignment: MainAxisAlignment.end,
                                                                                                children: [
                                                                                                  Expanded(
                                                                                                    child: Padding(
                                                                                                      padding: const EdgeInsets.all(15.0),
                                                                                                      child: Text(
                                                                                                        // ignore: unnecessary_string_interpolations
                                                                                                        '* อัตราคำนวณปัจจุบันอาจไม่ตรงกับยอดชำระ ณ วันที่บันทึก',
                                                                                                        textAlign: TextAlign.end,
                                                                                                        style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 12, fontFamily: Font_.Fonts_T),
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
                                                                                  }));
                                                                            },
                                                                            child:
                                                                                AutoSizeText(
                                                                              maxLines: 2,
                                                                              minFontSize: 8,
                                                                              // maxFontSize: 15,
                                                                              'ดูอัตราคำนวณ',
                                                                              // '${nFormat.format(double.parse(quotxSelectModels[index].total!))}',
                                                                              textAlign: TextAlign.end,
                                                                              style: const TextStyle(
                                                                                  color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                                  //fontWeight: FontWeight.bold,
                                                                                  fontFamily: Font_.Fonts_T),
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
                                      ),
                                    ],
                                  ),
                                ),
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
                                                    color: Colors.grey,
                                                    width: 1),
                                              ),
                                              padding:
                                                  const EdgeInsets.all(3.0),
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
                                                      topLeft:
                                                          Radius.circular(6),
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
                                            'Scroll',
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 10.0,
                                                fontFamily:
                                                    FontWeight_.Fonts_T),
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
            ser_tabbarview_2 != 0
                ? SizedBox()
                : const Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: AutoSizeText(
                          minFontSize: 10,
                          maxFontSize: 15,
                          'ตารางสรุปรายละเอียดค่าบริการ',
                          style: TextStyle(
                              color: PeopleChaoScreen_Color.Colors_Text1_,
                              fontWeight: FontWeight.bold,
                              fontFamily: FontWeight_.Fonts_T
                              //fontSize: 10.0
                              ),
                        ),
                      ),
                    ],
                  ),
            ///////////////------------------------------------------------->
            ser_tabbarview_2 != 0
                ? SizedBox()
                : Container(
                    child: Column(
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
                                SizedBox(
                                  child: Column(
                                    children: [
                                      Container(
                                          width: (Responsive.isDesktop(context))
                                              ? MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.84
                                              : 800,
                                          decoration: BoxDecoration(
                                            color: AppbackgroundColor
                                                .TiTile_Colors,
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(10),
                                                bottomLeft: Radius.circular(0),
                                                bottomRight:
                                                    Radius.circular(0)),
                                          ),
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              const Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Expanded(
                                                    flex: 1,
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.all(8.0),
                                                      child: Text(
                                                        'ประเภทค่าบริการ',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            color: PeopleChaoScreen_Color
                                                                .Colors_Text1_,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontFamily:
                                                                FontWeight_
                                                                    .Fonts_T
                                                            //fontSize: 10.0
                                                            //fontSize: 10.0
                                                            ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  widget.Get_Value_NameShop_index ==
                                                          '1'
                                                      ? const SizedBox()
                                                      : const Expanded(
                                                          flex: 1,
                                                          child: AutoSizeText(
                                                            maxLines: 1,
                                                            minFontSize: 8,
                                                            maxFontSize: 20,
                                                            'งวด',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                color: PeopleChaoScreen_Color
                                                                    .Colors_Text1_,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily:
                                                                    FontWeight_
                                                                        .Fonts_T),
                                                          ),
                                                        ),
                                                  const Expanded(
                                                    flex: 1,
                                                    child: AutoSizeText(
                                                      maxLines: 1,
                                                      minFontSize: 8,
                                                      maxFontSize: 20,
                                                      'วันที่ชำระ',
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
                                                                  .Fonts_T),
                                                    ),
                                                  ),
                                                  const Expanded(
                                                    flex: 1,
                                                    child: AutoSizeText(
                                                      maxLines: 1,
                                                      minFontSize: 8,
                                                      maxFontSize: 20,
                                                      'ประเภทค่าบริการ',
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
                                                                  .Fonts_T),
                                                    ),
                                                  ),
                                                  const Expanded(
                                                    flex: 1,
                                                    child: AutoSizeText(
                                                      maxLines: 1,
                                                      minFontSize: 8,
                                                      maxFontSize: 20,
                                                      'VAT',
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
                                                                  .Fonts_T),
                                                    ),
                                                  ),
                                                  const Expanded(
                                                    flex: 1,
                                                    child: AutoSizeText(
                                                      maxLines: 1,
                                                      minFontSize: 8,
                                                      maxFontSize: 20,
                                                      'VAT(%)',
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
                                                                  .Fonts_T),
                                                    ),
                                                  ),
                                                  const Expanded(
                                                    flex: 1,
                                                    child: AutoSizeText(
                                                      maxLines: 1,
                                                      minFontSize: 8,
                                                      maxFontSize: 20,
                                                      'VAT(฿)',
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
                                                                  .Fonts_T),
                                                    ),
                                                  ),
                                                  const Expanded(
                                                    flex: 1,
                                                    child: AutoSizeText(
                                                      maxLines: 1,
                                                      minFontSize: 8,
                                                      maxFontSize: 20,
                                                      '',
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
                                                                  .Fonts_T),
                                                    ),
                                                  ),
                                                  const Expanded(
                                                    flex: 1,
                                                    child: AutoSizeText(
                                                      maxLines: 1,
                                                      minFontSize: 8,
                                                      maxFontSize: 20,
                                                      'WHT (%)',
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
                                                                  .Fonts_T),
                                                    ),
                                                  ),
                                                  const Expanded(
                                                    flex: 1,
                                                    child: AutoSizeText(
                                                      maxLines: 1,
                                                      minFontSize: 8,
                                                      maxFontSize: 20,
                                                      'WHT (฿)',
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
                                                                  .Fonts_T),
                                                    ),
                                                  ),
                                                  const Expanded(
                                                    flex: 1,
                                                    child: AutoSizeText(
                                                      maxLines: 1,
                                                      minFontSize: 8,
                                                      maxFontSize: 20,
                                                      'ยอดสุทธิ',
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
                                                                  .Fonts_T),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          )),
                                      Container(
                                        height: (Responsive.isDesktop(context))
                                            ? MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.2
                                            : 300,
                                        width: (Responsive.isDesktop(context))
                                            ? MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.84
                                            : 800,
                                        decoration: const BoxDecoration(
                                          color:
                                              AppbackgroundColor.Sub_Abg_Colors,
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(0),
                                              topRight: Radius.circular(0),
                                              bottomLeft: Radius.circular(0),
                                              bottomRight: Radius.circular(0)),
                                          // border: Border.all(color: Colors.grey, width: 1),
                                        ),
                                        child: widget
                                                    .Get_Value_NameShop_index ==
                                                '1'
                                            ? ListView.builder(
                                                controller: _scrollController2,
                                                // itemExtent: 50,
                                                physics:
                                                    const AlwaysScrollableScrollPhysics(), // const NeverScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                itemCount: _TransModels.length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return Material(
                                                    color: tappedIndex_2 ==
                                                            index.toString()
                                                        ? tappedIndex_Color
                                                            .tappedIndex_Colors
                                                        : AppbackgroundColor
                                                            .Sub_Abg_Colors,
                                                    child: Container(
                                                      // color: tappedIndex_2 ==
                                                      //         index.toString()
                                                      //     ? tappedIndex_Color
                                                      //         .tappedIndex_Colors
                                                      //         .withOpacity(0.5)
                                                      //     : null,
                                                      child: ListTile(
                                                          onTap: () {
                                                            setState(() {
                                                              tappedIndex_2 =
                                                                  index
                                                                      .toString();
                                                            });
                                                          },
                                                          title: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              // color: Colors.green[100]!
                                                              //     .withOpacity(0.5),
                                                              border: Border(
                                                                bottom:
                                                                    BorderSide(
                                                                  color: Colors
                                                                      .black12,
                                                                  width: 1,
                                                                ),
                                                              ),
                                                            ),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                // Expanded(
                                                                //   flex: 1,
                                                                //   child: AutoSizeText(
                                                                //     maxLines: 1,
                                                                //     minFontSize: 8,
                                                                //     maxFontSize: 20,
                                                                //     '${(index + 1)}',
                                                                //     textAlign:
                                                                //         TextAlign.center,
                                                                //     style: const TextStyle(
                                                                //       color: TextHome_Color
                                                                //           .TextHome_Colors,
                                                                //     ),
                                                                //   ),
                                                                // ),
                                                                Expanded(
                                                                  flex: 1,
                                                                  child:
                                                                      AutoSizeText(
                                                                    maxLines: 1,
                                                                    minFontSize:
                                                                        8,
                                                                    maxFontSize:
                                                                        20,
                                                                    '${DateFormat('dd-MM-yyyy').format(DateTime.parse('${_TransModels[index].duedate!} 00:00:00'))}',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: const TextStyle(
                                                                        color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                        //fontWeight: FontWeight.bold,
                                                                        fontFamily: Font_.Fonts_T),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  flex: 1,
                                                                  child:
                                                                      Tooltip(
                                                                    richMessage:
                                                                        TextSpan(
                                                                      text:
                                                                          '${_TransModels[index].name!}',
                                                                      style:
                                                                          const TextStyle(
                                                                        color: HomeScreen_Color
                                                                            .Colors_Text1_,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        fontFamily:
                                                                            FontWeight_.Fonts_T,
                                                                        //fontSize: 10.0
                                                                      ),
                                                                    ),
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              5),
                                                                      color: Colors
                                                                              .grey[
                                                                          200],
                                                                    ),
                                                                    child:
                                                                        AutoSizeText(
                                                                      maxLines:
                                                                          1,
                                                                      minFontSize:
                                                                          8,
                                                                      maxFontSize:
                                                                          20,
                                                                      '${_TransModels[index].name!}',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style: const TextStyle(
                                                                          color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                          //fontWeight: FontWeight.bold,
                                                                          fontFamily: Font_.Fonts_T),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  flex: 1,
                                                                  child:
                                                                      AutoSizeText(
                                                                    maxLines: 1,
                                                                    minFontSize:
                                                                        8,
                                                                    maxFontSize:
                                                                        20,
                                                                    '${_TransModels[index].vtype!}',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: const TextStyle(
                                                                        color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                        //fontWeight: FontWeight.bold,
                                                                        fontFamily: Font_.Fonts_T),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  flex: 1,
                                                                  child:
                                                                      AutoSizeText(
                                                                    maxLines: 1,
                                                                    minFontSize:
                                                                        8,
                                                                    maxFontSize:
                                                                        20,
                                                                    '${_TransModels[index].nvat!} %',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .right,
                                                                    style: const TextStyle(
                                                                        color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                        //fontWeight: FontWeight.bold,
                                                                        fontFamily: Font_.Fonts_T),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  flex: 1,
                                                                  child:
                                                                      AutoSizeText(
                                                                    maxLines: 1,
                                                                    minFontSize:
                                                                        8,
                                                                    maxFontSize:
                                                                        20,
                                                                    '${_TransModels[index].vat!}',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .right,
                                                                    style: const TextStyle(
                                                                        color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                        //fontWeight: FontWeight.bold,
                                                                        fontFamily: Font_.Fonts_T),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  flex: 1,
                                                                  child:
                                                                      AutoSizeText(
                                                                    maxLines: 1,
                                                                    minFontSize:
                                                                        8,
                                                                    maxFontSize:
                                                                        20,
                                                                    '${_TransModels[index].pvat!}',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .right,
                                                                    style: const TextStyle(
                                                                        color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                        //fontWeight: FontWeight.bold,
                                                                        fontFamily: Font_.Fonts_T),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  flex: 1,
                                                                  child:
                                                                      AutoSizeText(
                                                                    maxLines: 1,
                                                                    minFontSize:
                                                                        8,
                                                                    maxFontSize:
                                                                        20,
                                                                    '${nFormat.format(double.parse(_TransModels[index].nwht!))}',
                                                                    //'${_TransModels[index].nwht!}',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .right,
                                                                    style: const TextStyle(
                                                                        color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                        //fontWeight: FontWeight.bold,
                                                                        fontFamily: Font_.Fonts_T),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  flex: 1,
                                                                  child:
                                                                      AutoSizeText(
                                                                    maxLines: 1,
                                                                    minFontSize:
                                                                        8,
                                                                    maxFontSize:
                                                                        20,
                                                                    '${nFormat.format(double.parse(_TransModels[index].wht!))}',
                                                                    //  '${_TransModels[index].wht!}',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .right,
                                                                    style: const TextStyle(
                                                                        color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                        //fontWeight: FontWeight.bold,
                                                                        fontFamily: Font_.Fonts_T),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  flex: 1,
                                                                  child:
                                                                      AutoSizeText(
                                                                    maxLines: 1,
                                                                    minFontSize:
                                                                        8,
                                                                    maxFontSize:
                                                                        20,
                                                                    '${nFormat.format(double.parse(_TransModels[index].total!))}',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .right,
                                                                    style: const TextStyle(
                                                                        color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                        //fontWeight: FontWeight.bold,
                                                                        fontFamily: Font_.Fonts_T),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          )),
                                                    ),
                                                  );
                                                },
                                              )
                                            : ListView.builder(
                                                controller: _scrollController2,
                                                // itemExtent: 50,
                                                physics:
                                                    const AlwaysScrollableScrollPhysics(), // const NeverScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                itemCount:
                                                    quotxSelectModels.length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return Container(
                                                    color: tappedIndex_2 ==
                                                            index.toString()
                                                        ? tappedIndex_Color
                                                            .tappedIndex_Colors
                                                            .withOpacity(0.5)
                                                        : null,
                                                    child: ListTile(
                                                        onTap: () {
                                                          setState(() {
                                                            tappedIndex_2 =
                                                                index
                                                                    .toString();
                                                          });
                                                        },
                                                        title: Column(
                                                          children: [
                                                            for (var i = 0;
                                                                i <
                                                                    int.parse(quotxSelectModels[
                                                                            index]
                                                                        .term!);
                                                                i++)
                                                              Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  // color: Colors.green[100]!
                                                                  //     .withOpacity(0.5),
                                                                  border:
                                                                      Border(
                                                                    bottom:
                                                                        BorderSide(
                                                                      color: Colors
                                                                          .black12,
                                                                      width: 1,
                                                                    ),
                                                                  ),
                                                                ),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Expanded(
                                                                      flex: 1,
                                                                      child:
                                                                          AutoSizeText(
                                                                        maxLines:
                                                                            1,
                                                                        minFontSize:
                                                                            8,
                                                                        maxFontSize:
                                                                            20,
                                                                        '${(i + 1)}',
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        style: const TextStyle(
                                                                            color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                            //fontWeight: FontWeight.bold,
                                                                            fontFamily: Font_.Fonts_T),
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      flex: 1,
                                                                      child:
                                                                          AutoSizeText(
                                                                        maxLines:
                                                                            1,
                                                                        minFontSize:
                                                                            8,
                                                                        maxFontSize:
                                                                            20,
                                                                        '${DateFormat('dd').format(DateTime.parse('${quotxSelectModels[index].sdate!} 00:00:00'))}-${DateFormat('MM-yyyy').format(DateTime.parse('${quotxSelectModels[index].sdate!} 00:00:00').add(Duration(days: int.parse('${quotxSelectModels[index].sday}') * i)))}',
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        style: const TextStyle(
                                                                            color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                            //fontWeight: FontWeight.bold,
                                                                            fontFamily: Font_.Fonts_T),
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      flex: 1,
                                                                      child:
                                                                          AutoSizeText(
                                                                        maxLines:
                                                                            1,
                                                                        minFontSize:
                                                                            8,
                                                                        maxFontSize:
                                                                            20,
                                                                        '${quotxSelectModels[index].expname!}',
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        style: const TextStyle(
                                                                            color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                            //fontWeight: FontWeight.bold,
                                                                            fontFamily: Font_.Fonts_T),
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      flex: 1,
                                                                      child:
                                                                          AutoSizeText(
                                                                        maxLines:
                                                                            1,
                                                                        minFontSize:
                                                                            8,
                                                                        maxFontSize:
                                                                            20,
                                                                        '${quotxSelectModels[index].vtype!}',
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        style: const TextStyle(
                                                                            color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                            //fontWeight: FontWeight.bold,
                                                                            fontFamily: Font_.Fonts_T),
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      flex: 1,
                                                                      child:
                                                                          AutoSizeText(
                                                                        maxLines:
                                                                            1,
                                                                        minFontSize:
                                                                            8,
                                                                        maxFontSize:
                                                                            20,
                                                                        '${quotxSelectModels[index].nvat!} %',
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        style: const TextStyle(
                                                                            color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                            //fontWeight: FontWeight.bold,
                                                                            fontFamily: Font_.Fonts_T),
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      flex: 1,
                                                                      child:
                                                                          AutoSizeText(
                                                                        maxLines:
                                                                            1,
                                                                        minFontSize:
                                                                            8,
                                                                        maxFontSize:
                                                                            20,
                                                                        '${quotxSelectModels[index].vat!}',
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        style: const TextStyle(
                                                                            color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                            //fontWeight: FontWeight.bold,
                                                                            fontFamily: Font_.Fonts_T),
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      flex: 1,
                                                                      child:
                                                                          AutoSizeText(
                                                                        maxLines:
                                                                            1,
                                                                        minFontSize:
                                                                            8,
                                                                        maxFontSize:
                                                                            20,
                                                                        '${quotxSelectModels[index].pvat!}',
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        style: const TextStyle(
                                                                            color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                            //fontWeight: FontWeight.bold,
                                                                            fontFamily: Font_.Fonts_T),
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      flex: 1,
                                                                      child:
                                                                          AutoSizeText(
                                                                        maxLines:
                                                                            1,
                                                                        minFontSize:
                                                                            8,
                                                                        maxFontSize:
                                                                            20,
                                                                        '${quotxSelectModels[index].nwht!}',
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        style: const TextStyle(
                                                                            color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                            //fontWeight: FontWeight.bold,
                                                                            fontFamily: Font_.Fonts_T),
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      flex: 1,
                                                                      child:
                                                                          AutoSizeText(
                                                                        maxLines:
                                                                            1,
                                                                        minFontSize:
                                                                            8,
                                                                        maxFontSize:
                                                                            20,
                                                                        '${quotxSelectModels[index].wht!}',
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        style: const TextStyle(
                                                                            color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                            //fontWeight: FontWeight.bold,
                                                                            fontFamily: Font_.Fonts_T),
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      flex: 1,
                                                                      child:
                                                                          AutoSizeText(
                                                                        maxLines:
                                                                            1,
                                                                        minFontSize:
                                                                            8,
                                                                        maxFontSize:
                                                                            20,
                                                                        '${nFormat.format(double.parse(quotxSelectModels[index].total!))}',
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        style: const TextStyle(
                                                                            color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                            //fontWeight: FontWeight.bold,
                                                                            fontFamily: Font_.Fonts_T),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                          ],
                                                        )),
                                                  );
                                                },
                                              ),
                                      ),
                                    ],
                                  ),
                                ),
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
                                            _scrollController2.animateTo(
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
                                                    color: Colors.grey,
                                                    width: 1),
                                              ),
                                              padding:
                                                  const EdgeInsets.all(3.0),
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
                                          if (_scrollController2.hasClients) {
                                            final position = _scrollController2
                                                .position.maxScrollExtent;
                                            _scrollController2.animateTo(
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
                                                      topLeft:
                                                          Radius.circular(6),
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
                                        onTap: _moveUp2,
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
                                            'Scroll',
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 10.0,
                                                fontFamily:
                                                    FontWeight_.Fonts_T),
                                          )),
                                      InkWell(
                                        onTap: _moveDown2,
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
            )
          ],
        ),
      ),
    );
  }

  Future<void> Idcard_(context, Url) async {
    final pdf = pw.Document();
    final netImage = await networkImage('$Url');

    pdf.addPage(pw.Page(build: (pw.Context context) {
      return pw.Center(
        child: pw.Image(netImage),
      ); // Center
    }));

    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PreviewScreenIDcard(doc: pdf, netImage_: Url),
        ));
  }
}

class PreviewScreenIDcard extends StatelessWidget {
  final pw.Document doc;
  final netImage_;
  PreviewScreenIDcard({Key? key, required this.doc, this.netImage_})
      : super(key: key);

  static const customSwatch = MaterialColor(
    0xFF8DB95A,
    <int, Color>{
      50: Color(0xFFC2FD7F),
      100: Color(0xFFB6EE77),
      200: Color(0xFFB2E875),
      300: Color(0xFFACDF71),
      400: Color(0xFFA7DA6E),
      500: Color(0xFFA1D16A),
      600: Color(0xFF94BF62),
      700: Color(0xFF90B961),
      800: Color(0xFF85AB5A),
      900: Color(0xFF7A9B54),
    },
  );
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  Future<void> downloadImage(String imageUrl) async {
    final extension = path.extension(imageUrl);
    print(extension); // print the file extension
    final request = html.HttpRequest();
    request.open('GET', imageUrl);
    request.responseType = 'blob';
    request.send();

    final completer = Completer<html.Blob>();
    request.onLoadEnd.listen((event) {
      completer.complete(request.response);
    });

    final blob = await completer.future;
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.document.createElement('a') as html.AnchorElement
      ..href = url
      ..download = 'image.$extension';
    html.document.body?.append(anchor);
    anchor.click();
    html.Url.revokeObjectUrl(url);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: customSwatch,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          // backgroundColor: Color.fromARGB(255, 141, 185, 90),
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back_outlined,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          title: const Text(
            'สำเนาบัตรประชาชน',
            style: TextStyle(
              color: Colors.white,
              fontFamily: Font_.Fonts_T,
            ),
          ),
          // actions: <Widget>[
          //   IconButton(
          //     icon: Icon(
          //       Icons.zoom_in,
          //       color: Colors.white,
          //     ),
          //     onPressed: () async {
          //       // String pdfUrl = Url.toString();
          //       downloadPdf(Url);
          //     },
          //   ),
          // ],
        ),
        body: PdfPreview(
          build: (format) => doc.save(),
          allowSharing: false,
          allowPrinting: true, canDebug: false,
          canChangeOrientation: false, canChangePageFormat: false,
          maxPageWidth: MediaQuery.of(context).size.width * 0.6,
          // scrollViewDecoration:,
          initialPageFormat: PdfPageFormat.a4,
          pdfFileName: "ข้อมูลผู้เช่า.pdf",
          actions: [
            IconButton(
              icon: const Icon(Icons.share),
              onPressed: () {
                downloadImage(netImage_);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class RentalInforman_Agreement extends StatelessWidget {
  final pw.Document doc;
  final context;
  ///////////-------------------------------------->
  final Get_Value_NameShop_index;
  final Get_Value_cid;
  final verticalGroupValue;
  final Form_nameshop;
  final Form_typeshop;
  final Form_bussshop;
  final Form_bussscontact;
  final Form_address;
  final Form_tel;
  final Form_email;
  final Form_tax;
  final Form_ln;
  final Form_zn;
  final Form_area;
  final Form_qty;
  final Form_sdate;
  final Form_ldate;
  final Form_period;
  final Form_rtname;
  final quotxSelectModels;
  final TransModels;
  final renTal_name;
  final bill_addr;
  final bill_email;
  final bill_tel;
  final bill_tax;
  final bill_name;
  final newValuePDFimg;

  ///
  //////////////-------------------------------->
  RentalInforman_Agreement(
      {Key? key,
      required this.doc,
      this.context,
      this.Get_Value_NameShop_index,
      this.Get_Value_cid,
      this.verticalGroupValue,
      this.Form_nameshop,
      this.Form_typeshop,
      this.Form_bussshop,
      this.Form_bussscontact,
      this.Form_address,
      this.Form_tel,
      this.Form_email,
      this.Form_tax,
      this.Form_ln,
      this.Form_zn,
      this.Form_area,
      this.Form_qty,
      this.Form_sdate,
      this.Form_ldate,
      this.Form_period,
      this.Form_rtname,
      this.quotxSelectModels,
      this.TransModels,
      this.renTal_name,
      this.bill_addr,
      this.bill_email,
      this.bill_tel,
      this.bill_tax,
      this.bill_name,
      this.newValuePDFimg
///////////-------------------------------->

      })
      : super(key: key);

  static const customSwatch = MaterialColor(
    0xFF8DB95A,
    <int, Color>{
      50: Color(0xFFC2FD7F),
      100: Color(0xFFB6EE77),
      200: Color(0xFFB2E875),
      300: Color(0xFFACDF71),
      400: Color(0xFFA7DA6E),
      500: Color(0xFFA1D16A),
      600: Color(0xFF94BF62),
      700: Color(0xFF90B961),
      800: Color(0xFF85AB5A),
      900: Color(0xFF7A9B54),
    },
  );
  // GlobalKey<SfSignaturePadState> _signaturePadKey1 = GlobalKey();
  // GlobalKey<SfSignaturePadState> _signaturePadKey2 = GlobalKey();
  // GlobalKey<SfSignaturePadState> _signaturePadKey3 = GlobalKey();
  // GlobalKey<SfSignaturePadState> _signaturePadKey4 = GlobalKey();
  final _formKey = GlobalKey<FormState>();
  final _Form1 = TextEditingController();
  final _Form2 = TextEditingController();
  final _Form3 = TextEditingController();
  final _Form4 = TextEditingController();
  var base64Image_1;
  var base64Image_2;
  var base64Image_3;
  var base64Image_4;
  String CheckBase =
      'iVBORw0KGgoAAAANSUhEUgAAAMgAAABkCAYAAADDhn8LAAAAAXNSR0IArs4c6QAAAARzQklUCAgICHwIZIgAAABkSURBVHic7cExAQAAAMKg9U9tDB+gAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADgYzjzAAF6bUzDAAAAAElFTkSuQmCC';

//   Future<void> _saveSignature() async {
//     SharedPreferences preferences = await SharedPreferences.getInstance();
//     //////////-------------------------------------->
//     final ui.Image image = await _signaturePadKey1.currentState!.toImage();
//     final ByteData? byteData =
//         await image.toByteData(format: ui.ImageByteFormat.png);

//     if (byteData != null) {
//       final Uint8List pngBytes1 = byteData.buffer.asUint8List();
//       // final String base64Image = base64Encode(pngBytes1);
//       // print(base64Image);
//       base64Image_1 = pngBytes1;

//       // preferences.setString('base64Image1', base64Image_1.toString());
//       // String? base64Image1_ = preferences.getString('base64Image1');
//       // print('base64Image1_');
//       // print(base64Image1_);
//       // Navigator.pop(context);

//       // Navigator.push(
//       //     context,
//       //     MaterialPageRoute(
//       //       builder: (context) =>
//       //           RentalInforman_Agreement2(doc: doc, context: context),
//       //     ));
//     } else {
//       base64Image_1 = null;
//     }
// //////////-------------------------------------->
//     final ui.Image image2 = await _signaturePadKey2.currentState!.toImage();
//     final ByteData? byteData2 =
//         await image2.toByteData(format: ui.ImageByteFormat.png);
//     if (byteData2 != null) {
//       final Uint8List pngBytes2 = byteData2.buffer.asUint8List();
//       // final String base64Image = base64Encode(pngBytes1);
//       // print(base64Image);
//       base64Image_2 = pngBytes2;

//       // preferences.setString('base64Image1', base64Image_1.toString());
//       // String? base64Image1_ = preferences.getString('base64Image1');
//       // print('base64Image1_');
//       // print(base64Image1_);
//       // Navigator.pop(context);

//       // Navigator.push(
//       //     context,
//       //     MaterialPageRoute(
//       //       builder: (context) =>
//       //           RentalInforman_Agreement2(doc: doc, context: context),
//       //     ));
//     } else {
//       base64Image_2 = null;
//     }

//     //////////-------------------------------------->
//     final ui.Image image3 = await _signaturePadKey3.currentState!.toImage();
//     final ByteData? byteData3 =
//         await image3.toByteData(format: ui.ImageByteFormat.png);
//     if (byteData3 != null) {
//       final Uint8List pngBytes3 = byteData3.buffer.asUint8List();
//       final String base64Image3 = base64Encode(pngBytes3);
//       // print(base64Image);
//       base64Image_3 = pngBytes3;

//       // preferences.setString('base64Image3', base64Image_3.toString());
//       // String? base64Image3_ = preferences.getString('base64Image3');
//       // print('base64Image3_');
//       // print(base64Image3_);
//     } else {
//       base64Image_3 = null;
//     }
//     //////////-------------------------------------->
//     // final ui.Image image4 = await _signaturePadKey4.currentState!.toImage();
//     final ByteData? byteData4 =
//         await image4.toByteData(format: ui.ImageByteFormat.png);
//     if (byteData4 != null) {
//       final Uint8List pngBytes4 = byteData4.buffer.asUint8List();
//       final String base64Image4 = base64Encode(pngBytes4);
//       // print(base64Image);
//       base64Image_4 = pngBytes4;

//       // preferences.setString('base64Image4', base64Image_4.toString());
//       // String? base64Image4_ = preferences.getString('base64Image4');
//       // print('base64Image4_');
//       // print(base64Image4_);
//     } else {
//       base64Image_4 = '';
//     }
//     print(base64Image_1);
//     // Navigator.pop(context);
//   }

  // HandSignatureControl control1 = new HandSignatureControl(
  //   threshold: 0.01,
  //   smoothRatio: 0.65,
  //   velocityRange: 2.0,
  // );
  // HandSignatureControl control2 = new HandSignatureControl(
  //   threshold: 0.01,
  //   smoothRatio: 0.65,
  //   velocityRange: 2.0,
  // );
  // HandSignatureControl control3 = new HandSignatureControl(
  //   threshold: 0.01,
  //   smoothRatio: 0.65,
  //   velocityRange: 2.0,
  // );
  // HandSignatureControl control4 = new HandSignatureControl(
  //   threshold: 0.01,
  //   smoothRatio: 0.65,
  //   velocityRange: 2.0,
  // );
  ValueNotifier<ByteData?> rawImage1 = ValueNotifier<ByteData?>(null);
  ValueNotifier<ByteData?> rawImage2 = ValueNotifier<ByteData?>(null);
  ValueNotifier<ByteData?> rawImage3 = ValueNotifier<ByteData?>(null);
  ValueNotifier<ByteData?> rawImage4 = ValueNotifier<ByteData?>(null);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: customSwatch,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: AppBarColors.hexColor,
          // backgroundColor: Color.fromARGB(255, 141, 185, 90),
          leading: IconButton(
            onPressed: () async {
              // SharedPreferences preferences =
              //     await SharedPreferences.getInstance();
              // preferences.remove('base64Image1');
              // preferences.remove('base64Image2');
              // preferences.remove('base64Image3');
              // preferences.remove('base64Image4');
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_outlined,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          title: const Text(
            "เอกสารเช่า(ต้นฉบับ/ยังไม่ประทับลายมือชื่อดิจิทัล)",
            style: TextStyle(
              color: Colors.white,
              fontFamily: Font_.Fonts_T,
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: PdfPreview(
                build: (format) {
                  final pdf = pw.Document();
                  // pdf.addPage(pw.Page(
                  //   pageFormat: PdfPageFormat.a4,
                  //   build: (pw.Context context) {
                  //     return pw.Column(
                  //       children: [
                  //         pw.Text(
                  //           'qqq:',
                  //           maxLines: 1,
                  //           textAlign: pw.TextAlign.right,
                  //           style: pw.TextStyle(
                  //               fontSize: 10.0, color: PdfColors.black),
                  //         ),
                  //         pw.Center(
                  //           child: pw.Image(pw.MemoryImage(base64Image_)),
                  //         )
                  //       ],
                  //     );
                  //   },
                  // ));
                  return doc.save();
                },
                allowSharing: true,
                allowPrinting: true,
                canDebug: false,
                canChangeOrientation: false,
                canChangePageFormat: false,
                maxPageWidth: MediaQuery.of(context).size.width * 0.6,
                initialPageFormat: PdfPageFormat.a4,
                pdfFileName: "เอกสารเช่า.pdf",
              ),
            ),
            // Container(
            //   color: Color.fromARGB(255, 192, 223, 157),
            //   child: Align(
            //     alignment: Alignment.center,
            //     child: Padding(
            //       padding: const EdgeInsets.all(8.0),
            //       child: Container(
            //         width: 200,
            //         decoration: const BoxDecoration(
            //           color: Colors.black,
            //           borderRadius: BorderRadius.only(
            //               topLeft: Radius.circular(10),
            //               topRight: Radius.circular(10),
            //               bottomLeft: Radius.circular(10),
            //               bottomRight: Radius.circular(10)),
            //         ),
            //         padding: const EdgeInsets.all(8.0),
            //         child: TextButton(
            //           onPressed: () {
            //             showModalBottomSheet(
            //                 enableDrag: false,
            //                 isDismissible: false,
            //                 context: context,
            //                 builder: (context) {
            //                   return Form(
            //                     key: _formKey,
            //                     child: Column(
            //                       mainAxisSize: MainAxisSize.min,
            //                       children: <Widget>[
            //                         Padding(
            //                           padding: const EdgeInsets.all(8.0),
            //                           child: Center(
            //                             child: Text(
            //                               'ลายมือชื่อดิจิทัล ',
            //                               textAlign: TextAlign.justify,
            //                               style: TextStyle(
            //                                 fontSize: 20.0,
            //                                 fontWeight: FontWeight.bold,
            //                               ),
            //                             ),
            //                           ),
            //                         ),
            //                         Container(
            //                           width: (!Responsive.isDesktop(context))
            //                               ? MediaQuery.of(context).size.width
            //                               : MediaQuery.of(context).size.width,
            //                           height: 250,
            //                           child: ScrollConfiguration(
            //                             behavior:
            //                                 ScrollConfiguration.of(context)
            //                                     .copyWith(dragDevices: {
            //                               PointerDeviceKind.touch,
            //                               PointerDeviceKind.mouse,
            //                             }),
            //                             child: Center(
            //                               child: SingleChildScrollView(
            //                                 scrollDirection: Axis.horizontal,
            //                                 dragStartBehavior:
            //                                     DragStartBehavior.start,
            //                                 child: Row(
            //                                   mainAxisAlignment:
            //                                       MainAxisAlignment
            //                                           .spaceBetween,
            //                                   children: [
            //                                     Padding(
            //                                       padding:
            //                                           const EdgeInsets.all(8.0),
            //                                       child: Column(
            //                                         children: [
            //                                           Text(
            //                                             '( ผู้ให้เช่า )',
            //                                             textAlign:
            //                                                 TextAlign.justify,
            //                                             style: TextStyle(
            //                                                 fontSize: 10.0,
            //                                                 color: PeopleChaoScreen_Color
            //                                                     .Colors_Text2_,
            //                                                 fontWeight:
            //                                                     FontWeight.bold,
            //                                                 fontFamily:
            //                                                     Font_.Fonts_T),
            //                                           ),
            //                                           Container(
            //                                             color: Colors.grey[200],
            //                                             // decoration: BoxDecoration(

            //                                             //   image: DecorationImage(
            //                                             //     image: NetworkImage(
            //                                             //         "https://png.pngtree.com/png-clipart/20210311/original/pngtree-over-text-effect-editable-png-image_5995995.jpg"),
            //                                             //     fit: BoxFit.cover,
            //                                             //   ),
            //                                             // ),
            //                                             child: HandSignature(
            //                                               control: control1,
            //                                               color: Colors
            //                                                   .lightBlue
            //                                                   .withGreen(200),
            //                                               type:
            //                                                   SignatureDrawType
            //                                                       .shape,
            //                                             ),
            //                                             // SfSignaturePad(
            //                                             //   key:
            //                                             //       _signaturePadKey1,
            //                                             //   strokeColor: Colors
            //                                             //       .lightBlue
            //                                             //       .withGreen(200),
            //                                             // ),
            //                                             height: 100,
            //                                             width: 200,
            //                                           ),
            //                                           Padding(
            //                                             padding:
            //                                                 const EdgeInsets
            //                                                     .all(8.0),
            //                                             child: SizedBox(
            //                                               width: 200,
            //                                               child: TextFormField(
            //                                                 keyboardType:
            //                                                     TextInputType
            //                                                         .number,
            //                                                 controller: _Form1,
            //                                                 validator: (value) {
            //                                                   if (value ==
            //                                                           null ||
            //                                                       value
            //                                                           .isEmpty) {
            //                                                     return 'ใส่ข้อมูลให้ครบถ้วน ';
            //                                                   }
            //                                                   // if (int.parse(value.toString()) < 13) {
            //                                                   //   return '< 13';
            //                                                   // }
            //                                                   return null;
            //                                                 },
            //                                                 // maxLength: 13,
            //                                                 cursorColor:
            //                                                     Colors.green,
            //                                                 decoration:
            //                                                     InputDecoration(
            //                                                         fillColor: Colors
            //                                                             .white
            //                                                             .withOpacity(
            //                                                                 0.3),
            //                                                         filled:
            //                                                             true,
            //                                                         // prefixIcon:
            //                                                         //     const Icon(Icons.person_pin, color: Colors.black),
            //                                                         // suffixIcon: Icon(Icons.clear, color: Colors.black),
            //                                                         focusedBorder:
            //                                                             const OutlineInputBorder(
            //                                                           borderRadius:
            //                                                               BorderRadius
            //                                                                   .only(
            //                                                             topRight:
            //                                                                 Radius.circular(10),
            //                                                             topLeft:
            //                                                                 Radius.circular(10),
            //                                                             bottomRight:
            //                                                                 Radius.circular(10),
            //                                                             bottomLeft:
            //                                                                 Radius.circular(10),
            //                                                           ),
            //                                                           borderSide:
            //                                                               BorderSide(
            //                                                             width:
            //                                                                 1,
            //                                                             color: Colors
            //                                                                 .black,
            //                                                           ),
            //                                                         ),
            //                                                         enabledBorder:
            //                                                             const OutlineInputBorder(
            //                                                           borderRadius:
            //                                                               BorderRadius
            //                                                                   .only(
            //                                                             topRight:
            //                                                                 Radius.circular(10),
            //                                                             topLeft:
            //                                                                 Radius.circular(10),
            //                                                             bottomRight:
            //                                                                 Radius.circular(10),
            //                                                             bottomLeft:
            //                                                                 Radius.circular(10),
            //                                                           ),
            //                                                           borderSide:
            //                                                               BorderSide(
            //                                                             width:
            //                                                                 1,
            //                                                             color: Colors
            //                                                                 .grey,
            //                                                           ),
            //                                                         ),
            //                                                         labelText:
            //                                                             'ผู้ให้เช่า :',
            //                                                         labelStyle: const TextStyle(
            //                                                             fontSize:
            //                                                                 10,
            //                                                             color: PeopleChaoScreen_Color
            //                                                                 .Colors_Text2_,
            //                                                             fontFamily:
            //                                                                 Font_.Fonts_T)),
            //                                                 // inputFormatters: <TextInputFormatter>[
            //                                                 //   FilteringTextInputFormatter.deny(
            //                                                 //       RegExp("[' ']")),
            //                                                 //   // for below version 2 use this
            //                                                 //   // FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
            //                                                 //   // for version 2 and greater youcan also use this
            //                                                 //   // FilteringTextInputFormatter.digitsOnly
            //                                                 // ],
            //                                               ),
            //                                             ),
            //                                           ),
            //                                           ElevatedButton(
            //                                               style: ElevatedButton
            //                                                   .styleFrom(
            //                                                 primary: Colors.red,
            //                                               ),
            //                                               child: Text(
            //                                                 "เคลีย์ค่า",
            //                                                 style: TextStyle(
            //                                                     // fontSize: 10.0,
            //                                                     color: Colors
            //                                                         .white,
            //                                                     fontWeight:
            //                                                         FontWeight
            //                                                             .bold,
            //                                                     fontFamily: Font_
            //                                                         .Fonts_T),
            //                                               ),
            //                                               onPressed: () async {
            //                                                 control1.clear();
            //                                                 rawImage1.value =
            //                                                     null;

            //                                                 // _signaturePadKey1
            //                                                 //     .currentState!
            //                                                 //     .clear();
            //                                               }),
            //                                         ],
            //                                       ),
            //                                     ),
            //                                     Padding(
            //                                       padding:
            //                                           const EdgeInsets.all(8.0),
            //                                       child: Column(
            //                                         children: [
            //                                           const Text(
            //                                             '( ชื่อผู้เช่า )',
            //                                             textAlign:
            //                                                 TextAlign.justify,
            //                                             style: TextStyle(
            //                                                 fontSize: 10.0,
            //                                                 color: PeopleChaoScreen_Color
            //                                                     .Colors_Text2_,
            //                                                 fontWeight:
            //                                                     FontWeight.bold,
            //                                                 fontFamily:
            //                                                     Font_.Fonts_T),
            //                                           ),
            //                                           Container(
            //                                             color: Colors.grey[200],
            //                                             child: HandSignature(
            //                                               control: control2,
            //                                               color: Colors
            //                                                   .lightBlue
            //                                                   .withGreen(200),
            //                                               type:
            //                                                   SignatureDrawType
            //                                                       .shape,
            //                                             ),
            //                                             //  SfSignaturePad(
            //                                             //   key:
            //                                             //       _signaturePadKey2,
            //                                             //   strokeColor: Colors
            //                                             //       .lightBlue
            //                                             //       .withGreen(200),
            //                                             // ),
            //                                             height: 100,
            //                                             width: 200,
            //                                           ),
            //                                           Padding(
            //                                             padding:
            //                                                 const EdgeInsets
            //                                                     .all(8.0),
            //                                             child: SizedBox(
            //                                               width: 200,
            //                                               child: TextFormField(
            //                                                 keyboardType:
            //                                                     TextInputType
            //                                                         .number,
            //                                                 controller: _Form2,
            //                                                 validator: (value) {
            //                                                   if (value ==
            //                                                           null ||
            //                                                       value
            //                                                           .isEmpty) {
            //                                                     return 'ใส่ข้อมูลให้ครบถ้วน ';
            //                                                   }
            //                                                   // if (int.parse(value.toString()) < 13) {
            //                                                   //   return '< 13';
            //                                                   // }
            //                                                   return null;
            //                                                 },
            //                                                 // maxLength: 13,
            //                                                 cursorColor:
            //                                                     Colors.green,
            //                                                 decoration:
            //                                                     InputDecoration(
            //                                                   fillColor: Colors
            //                                                       .white
            //                                                       .withOpacity(
            //                                                           0.3),
            //                                                   filled: true,
            //                                                   // prefixIcon:
            //                                                   //     const Icon(Icons.person_pin, color: Colors.black),
            //                                                   // suffixIcon: Icon(Icons.clear, color: Colors.black),
            //                                                   focusedBorder:
            //                                                       const OutlineInputBorder(
            //                                                     borderRadius:
            //                                                         BorderRadius
            //                                                             .only(
            //                                                       topRight: Radius
            //                                                           .circular(
            //                                                               10),
            //                                                       topLeft: Radius
            //                                                           .circular(
            //                                                               10),
            //                                                       bottomRight: Radius
            //                                                           .circular(
            //                                                               10),
            //                                                       bottomLeft: Radius
            //                                                           .circular(
            //                                                               10),
            //                                                     ),
            //                                                     borderSide:
            //                                                         BorderSide(
            //                                                       width: 1,
            //                                                       color: Colors
            //                                                           .black,
            //                                                     ),
            //                                                   ),
            //                                                   enabledBorder:
            //                                                       const OutlineInputBorder(
            //                                                     borderRadius:
            //                                                         BorderRadius
            //                                                             .only(
            //                                                       topRight: Radius
            //                                                           .circular(
            //                                                               10),
            //                                                       topLeft: Radius
            //                                                           .circular(
            //                                                               10),
            //                                                       bottomRight: Radius
            //                                                           .circular(
            //                                                               10),
            //                                                       bottomLeft: Radius
            //                                                           .circular(
            //                                                               10),
            //                                                     ),
            //                                                     borderSide:
            //                                                         BorderSide(
            //                                                       width: 1,
            //                                                       color: Colors
            //                                                           .grey,
            //                                                     ),
            //                                                   ),
            //                                                   labelText:
            //                                                       'ชื่อผู้เช่า :',
            //                                                   labelStyle: const TextStyle(
            //                                                       fontSize: 10,
            //                                                       color: PeopleChaoScreen_Color
            //                                                           .Colors_Text2_,
            //                                                       fontFamily: Font_
            //                                                           .Fonts_T),
            //                                                 ),
            //                                                 // inputFormatters: <TextInputFormatter>[
            //                                                 //   FilteringTextInputFormatter.deny(
            //                                                 //       RegExp("[' ']")),0631143542
            //                                                 //   // for below version 2 use this
            //                                                 //   // FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
            //                                                 //   // for version 2 and greater youcan also use this
            //                                                 //   // FilteringTextInputFormatter.digitsOnly
            //                                                 // ],
            //                                               ),
            //                                             ),
            //                                           ),
            //                                           ElevatedButton(
            //                                               style: ElevatedButton
            //                                                   .styleFrom(
            //                                                 primary: Colors.red,
            //                                               ),
            //                                               child: Text(
            //                                                 "เคลีย์ค่า",
            //                                                 style: TextStyle(
            //                                                     // fontSize: 10.0,
            //                                                     color: Colors
            //                                                         .white,
            //                                                     fontWeight:
            //                                                         FontWeight
            //                                                             .bold,
            //                                                     fontFamily: Font_
            //                                                         .Fonts_T),
            //                                               ),
            //                                               onPressed: () async {
            //                                                 control2.clear();
            //                                                 rawImage2.value =
            //                                                     null;
            //                                                 // _signaturePadKey2
            //                                                 //     .currentState!
            //                                                 //     .clear();
            //                                               }),
            //                                         ],
            //                                       ),
            //                                     ),
            //                                     Padding(
            //                                       padding:
            //                                           const EdgeInsets.all(8.0),
            //                                       child: Column(
            //                                         children: [
            //                                           Text(
            //                                             '( พยานที่ 1 )',
            //                                             textAlign:
            //                                                 TextAlign.justify,
            //                                             style: TextStyle(
            //                                                 fontSize: 10.0,
            //                                                 color: PeopleChaoScreen_Color
            //                                                     .Colors_Text2_,
            //                                                 fontWeight:
            //                                                     FontWeight.bold,
            //                                                 fontFamily:
            //                                                     Font_.Fonts_T),
            //                                           ),
            //                                           Container(
            //                                             color: Colors.grey[200],
            //                                             child: HandSignature(
            //                                               control: control3,
            //                                               color: Colors
            //                                                   .lightBlue
            //                                                   .withGreen(200),
            //                                               type:
            //                                                   SignatureDrawType
            //                                                       .shape,
            //                                             ),

            //                                             // SfSignaturePad(
            //                                             //   key:
            //                                             //       _signaturePadKey3,
            //                                             //   strokeColor: Colors
            //                                             //       .lightBlue
            //                                             //       .withGreen(200),
            //                                             // ),
            //                                             height: 100,
            //                                             width: 200,
            //                                           ),
            //                                           Padding(
            //                                             padding:
            //                                                 const EdgeInsets
            //                                                     .all(8.0),
            //                                             child: SizedBox(
            //                                               width: 200,
            //                                               child: TextFormField(
            //                                                 keyboardType:
            //                                                     TextInputType
            //                                                         .number,
            //                                                 controller: _Form3,
            //                                                 validator: (value) {
            //                                                   if (value ==
            //                                                           null ||
            //                                                       value
            //                                                           .isEmpty) {
            //                                                     return 'ใส่ข้อมูลให้ครบถ้วน ';
            //                                                   }
            //                                                   // if (int.parse(value.toString()) < 13) {
            //                                                   //   return '< 13';
            //                                                   // }
            //                                                   return null;
            //                                                 },
            //                                                 // maxLength: 13,
            //                                                 cursorColor:
            //                                                     Colors.green,
            //                                                 decoration:
            //                                                     InputDecoration(
            //                                                         fillColor: Colors
            //                                                             .white
            //                                                             .withOpacity(
            //                                                                 0.3),
            //                                                         filled:
            //                                                             true,
            //                                                         // prefixIcon:
            //                                                         //     const Icon(Icons.person_pin, color: Colors.black),
            //                                                         // suffixIcon: Icon(Icons.clear, color: Colors.black),
            //                                                         focusedBorder:
            //                                                             const OutlineInputBorder(
            //                                                           borderRadius:
            //                                                               BorderRadius
            //                                                                   .only(
            //                                                             topRight:
            //                                                                 Radius.circular(10),
            //                                                             topLeft:
            //                                                                 Radius.circular(10),
            //                                                             bottomRight:
            //                                                                 Radius.circular(10),
            //                                                             bottomLeft:
            //                                                                 Radius.circular(10),
            //                                                           ),
            //                                                           borderSide:
            //                                                               BorderSide(
            //                                                             width:
            //                                                                 1,
            //                                                             color: Colors
            //                                                                 .black,
            //                                                           ),
            //                                                         ),
            //                                                         enabledBorder:
            //                                                             const OutlineInputBorder(
            //                                                           borderRadius:
            //                                                               BorderRadius
            //                                                                   .only(
            //                                                             topRight:
            //                                                                 Radius.circular(10),
            //                                                             topLeft:
            //                                                                 Radius.circular(10),
            //                                                             bottomRight:
            //                                                                 Radius.circular(10),
            //                                                             bottomLeft:
            //                                                                 Radius.circular(10),
            //                                                           ),
            //                                                           borderSide:
            //                                                               BorderSide(
            //                                                             width:
            //                                                                 1,
            //                                                             color: Colors
            //                                                                 .grey,
            //                                                           ),
            //                                                         ),
            //                                                         labelText:
            //                                                             'ชื่อพยานที่ 1 :',
            //                                                         labelStyle: const TextStyle(
            //                                                             fontSize:
            //                                                                 10,
            //                                                             color: PeopleChaoScreen_Color
            //                                                                 .Colors_Text2_,
            //                                                             fontFamily:
            //                                                                 Font_.Fonts_T)),
            //                                                 // inputFormatters: <TextInputFormatter>[
            //                                                 //   FilteringTextInputFormatter.deny(
            //                                                 //       RegExp("[' ']")),
            //                                                 //   // for below version 2 use this
            //                                                 //   // FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
            //                                                 //   // for version 2 and greater youcan also use this
            //                                                 //   // FilteringTextInputFormatter.digitsOnly
            //                                                 // ],
            //                                               ),
            //                                             ),
            //                                           ),
            //                                           ElevatedButton(
            //                                               style: ElevatedButton
            //                                                   .styleFrom(
            //                                                 primary: Colors.red,
            //                                               ),
            //                                               child: Text(
            //                                                 "เคลีย์ค่า",
            //                                                 style: TextStyle(
            //                                                     // fontSize: 10.0,
            //                                                     color: Colors
            //                                                         .white,
            //                                                     fontWeight:
            //                                                         FontWeight
            //                                                             .bold,
            //                                                     fontFamily: Font_
            //                                                         .Fonts_T),
            //                                               ),
            //                                               onPressed: () async {
            //                                                 control3.clear();
            //                                                 rawImage3.value =
            //                                                     null;
            //                                                 // _signaturePadKey3
            //                                                 //     .currentState!
            //                                                 //     .clear();
            //                                               }),
            //                                         ],
            //                                       ),
            //                                     ),
            //                                     Padding(
            //                                       padding:
            //                                           const EdgeInsets.all(8.0),
            //                                       child: Column(
            //                                         children: [
            //                                           const Text(
            //                                             '( พยานที่ 2 ) ',
            //                                             textAlign:
            //                                                 TextAlign.justify,
            //                                             style: TextStyle(
            //                                                 fontSize: 10.0,
            //                                                 color: PeopleChaoScreen_Color
            //                                                     .Colors_Text2_,
            //                                                 fontWeight:
            //                                                     FontWeight.bold,
            //                                                 fontFamily:
            //                                                     Font_.Fonts_T),
            //                                           ),
            //                                           Container(
            //                                             color: Colors.grey[200],
            //                                             child: HandSignature(
            //                                               control: control4,
            //                                               color: Colors
            //                                                   .lightBlue
            //                                                   .withGreen(200),
            //                                               type:
            //                                                   SignatureDrawType
            //                                                       .shape,
            //                                             ),

            //                                             // SfSignaturePad(
            //                                             //   key:
            //                                             //       _signaturePadKey4,
            //                                             //   strokeColor: Colors
            //                                             //       .lightBlue
            //                                             //       .withGreen(200),
            //                                             // ),
            //                                             height: 100,
            //                                             width: 200,
            //                                           ),
            //                                           Padding(
            //                                             padding:
            //                                                 const EdgeInsets
            //                                                     .all(8.0),
            //                                             child: SizedBox(
            //                                               width: 200,
            //                                               child: TextFormField(
            //                                                 keyboardType:
            //                                                     TextInputType
            //                                                         .number,
            //                                                 controller: _Form4,
            //                                                 validator: (value) {
            //                                                   if (value ==
            //                                                           null ||
            //                                                       value
            //                                                           .isEmpty) {
            //                                                     return 'ใส่ข้อมูลให้ครบถ้วน ';
            //                                                   }
            //                                                   // if (int.parse(value.toString()) < 13) {
            //                                                   //   return '< 13';
            //                                                   // }
            //                                                   return null;
            //                                                 },
            //                                                 // maxLength: 13,
            //                                                 cursorColor:
            //                                                     Colors.green,
            //                                                 decoration:
            //                                                     InputDecoration(
            //                                                         fillColor: Colors
            //                                                             .white
            //                                                             .withOpacity(
            //                                                                 0.3),
            //                                                         filled:
            //                                                             true,
            //                                                         // prefixIcon:
            //                                                         //     const Icon(Icons.person_pin, color: Colors.black),
            //                                                         // suffixIcon: Icon(Icons.clear, color: Colors.black),
            //                                                         focusedBorder:
            //                                                             const OutlineInputBorder(
            //                                                           borderRadius:
            //                                                               BorderRadius
            //                                                                   .only(
            //                                                             topRight:
            //                                                                 Radius.circular(10),
            //                                                             topLeft:
            //                                                                 Radius.circular(10),
            //                                                             bottomRight:
            //                                                                 Radius.circular(10),
            //                                                             bottomLeft:
            //                                                                 Radius.circular(10),
            //                                                           ),
            //                                                           borderSide:
            //                                                               BorderSide(
            //                                                             width:
            //                                                                 1,
            //                                                             color: Colors
            //                                                                 .black,
            //                                                           ),
            //                                                         ),
            //                                                         enabledBorder:
            //                                                             const OutlineInputBorder(
            //                                                           borderRadius:
            //                                                               BorderRadius
            //                                                                   .only(
            //                                                             topRight:
            //                                                                 Radius.circular(10),
            //                                                             topLeft:
            //                                                                 Radius.circular(10),
            //                                                             bottomRight:
            //                                                                 Radius.circular(10),
            //                                                             bottomLeft:
            //                                                                 Radius.circular(10),
            //                                                           ),
            //                                                           borderSide:
            //                                                               BorderSide(
            //                                                             width:
            //                                                                 1,
            //                                                             color: Colors
            //                                                                 .grey,
            //                                                           ),
            //                                                         ),
            //                                                         labelText:
            //                                                             'ชื่อพยานที่ 2 :',
            //                                                         labelStyle: const TextStyle(
            //                                                             fontSize:
            //                                                                 10,
            //                                                             color: PeopleChaoScreen_Color
            //                                                                 .Colors_Text2_,
            //                                                             fontFamily:
            //                                                                 Font_.Fonts_T)),
            //                                                 // inputFormatters: <TextInputFormatter>[
            //                                                 //   FilteringTextInputFormatter.deny(
            //                                                 //       RegExp("[' ']")),
            //                                                 //   // for below version 2 use this
            //                                                 //   // FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
            //                                                 //   // for version 2 and greater youcan also use this
            //                                                 //   // FilteringTextInputFormatter.digitsOnly
            //                                                 // ],
            //                                               ),
            //                                             ),
            //                                           ),
            //                                           ElevatedButton(
            //                                               style: ElevatedButton
            //                                                   .styleFrom(
            //                                                 primary: Colors.red,
            //                                               ),
            //                                               child: Text(
            //                                                 "เคลีย์ค่า",
            //                                                 style: TextStyle(
            //                                                     // fontSize: 10.0,
            //                                                     color: Colors
            //                                                         .white,
            //                                                     fontWeight:
            //                                                         FontWeight
            //                                                             .bold,
            //                                                     fontFamily: Font_
            //                                                         .Fonts_T),
            //                                               ),
            //                                               onPressed: () async {
            //                                                 control4.clear();
            //                                                 rawImage4.value =
            //                                                     null;
            //                                                 // _signaturePadKey4
            //                                                 //     .currentState!
            //                                                 //     .clear();
            //                                               }),
            //                                         ],
            //                                       ),
            //                                     ),
            //                                     SizedBox(),
            //                                   ],
            //                                 ),
            //                               ),
            //                             ),
            //                           ),
            //                         ),
            //                         // if (base64Image_1 == CheckBase ||
            //                         //     base64Image_2 == CheckBase ||
            //                         //     base64Image_3 == CheckBase ||
            //                         //     base64Image_4 == CheckBase)
            //                         //   Text('data'),
            //                         SizedBox(height: 10),
            //                         Row(
            //                           mainAxisAlignment:
            //                               MainAxisAlignment.center,
            //                           children: [
            //                             Padding(
            //                               padding: const EdgeInsets.all(8.0),
            //                               child: Container(
            //                                 width: 100,
            //                                 decoration: const BoxDecoration(
            //                                   color: Colors.green,
            //                                   borderRadius: BorderRadius.only(
            //                                       topLeft: Radius.circular(10),
            //                                       topRight: Radius.circular(10),
            //                                       bottomLeft:
            //                                           Radius.circular(10),
            //                                       bottomRight:
            //                                           Radius.circular(10)),
            //                                 ),
            //                                 padding: const EdgeInsets.all(8.0),
            //                                 child: TextButton(
            //                                   onPressed: () async {
            //                                     rawImage1.value =
            //                                         await control1.toImage(
            //                                       color: Colors.blueAccent,
            //                                       // background:
            //                                       //     Colors.greenAccent,
            //                                       fit: false,
            //                                     );

            //                                     rawImage2.value =
            //                                         await control2.toImage(
            //                                       color: Colors.blueAccent,
            //                                       // background:
            //                                       //     Colors.greenAccent,
            //                                       fit: false,
            //                                     );

            //                                     rawImage3.value =
            //                                         await control3.toImage(
            //                                       color: Colors.blueAccent,
            //                                       // background:
            //                                       //     Colors.greenAccent,
            //                                       fit: false,
            //                                     );

            //                                     rawImage4.value =
            //                                         await control4.toImage(
            //                                       color: Colors.blueAccent,
            //                                       // background:
            //                                       //     Colors.greenAccent,
            //                                       fit: false,
            //                                     );
            //                                     // _showMyDialog();
            //                                     if (_formKey.currentState!
            //                                         .validate()) {
            //                                       if (rawImage1.value != null &&
            //                                           rawImage2.value != null &&
            //                                           rawImage3.value != null &&
            //                                           rawImage4.value != null) {
            //                                         Navigator.pop(context);
            //                                         _showMyDialog();
            //                                       } else {
            //                                         showDialog<void>(
            //                                           context: context,
            //                                           barrierDismissible:
            //                                               false, // user must tap button!
            //                                           builder: (BuildContext
            //                                               context) {
            //                                             return AlertDialog(
            //                                               title: const Center(
            //                                                 child: Text(
            //                                                     'ลายเซ็นไม่ครบถ้วน !!',
            //                                                     style: TextStyle(
            //                                                         color: Colors
            //                                                             .black,
            //                                                         fontWeight:
            //                                                             FontWeight
            //                                                                 .bold,
            //                                                         fontFamily:
            //                                                             FontWeight_
            //                                                                 .Fonts_T)),
            //                                               ),
            //                                               content:
            //                                                   SingleChildScrollView(
            //                                                 child: ListBody(
            //                                                   children: const <
            //                                                       Widget>[
            //                                                     Text(
            //                                                         'กรุณาเซ็นต์ลายเซ็นให้ครบถ้วน',
            //                                                         style: TextStyle(
            //                                                             // fontSize: 10.0,
            //                                                             color: Colors.black,
            //                                                             fontFamily: Font_.Fonts_T)),
            //                                                   ],
            //                                                 ),
            //                                               ),
            //                                               actions: <Widget>[
            //                                                 Container(
            //                                                   width: 100,
            //                                                   decoration:
            //                                                       const BoxDecoration(
            //                                                     color: Colors
            //                                                         .black,
            //                                                     borderRadius: BorderRadius.only(
            //                                                         topLeft: Radius
            //                                                             .circular(
            //                                                                 10),
            //                                                         topRight: Radius
            //                                                             .circular(
            //                                                                 10),
            //                                                         bottomLeft:
            //                                                             Radius.circular(
            //                                                                 10),
            //                                                         bottomRight:
            //                                                             Radius.circular(
            //                                                                 10)),
            //                                                   ),
            //                                                   padding:
            //                                                       const EdgeInsets
            //                                                           .all(8.0),
            //                                                   child: TextButton(
            //                                                     onPressed: () =>
            //                                                         Navigator.pop(
            //                                                             context,
            //                                                             'OK'),
            //                                                     child:
            //                                                         const Text(
            //                                                       'ปิด',
            //                                                       style: TextStyle(
            //                                                           color: Colors
            //                                                               .white,
            //                                                           fontWeight:
            //                                                               FontWeight
            //                                                                   .bold,
            //                                                           fontFamily:
            //                                                               FontWeight_
            //                                                                   .Fonts_T),
            //                                                     ),
            //                                                   ),
            //                                                 ),
            //                                               ],
            //                                             );
            //                                           },
            //                                         );
            //                                       }
            //                                     } else {
            //                                       // ScaffoldMessenger.of(context).showSnackBar(
            //                                       //   const SnackBar(
            //                                       //       content: Text('ข้อมูลไม่ครบถ้วน')),
            //                                       // );
            //                                     }

            //                                     // Navigator.pop(context);
            //                                   },
            //                                   child: const Text(
            //                                     'บันทึก',
            //                                     style: TextStyle(
            //                                         color: Colors.white,
            //                                         fontWeight: FontWeight.bold,
            //                                         fontFamily:
            //                                             FontWeight_.Fonts_T),
            //                                   ),
            //                                 ),
            //                               ),
            //                             ),
            //                             Padding(
            //                               padding: const EdgeInsets.all(8.0),
            //                               child: Container(
            //                                 width: 100,
            //                                 decoration: const BoxDecoration(
            //                                   color: Colors.black,
            //                                   borderRadius: BorderRadius.only(
            //                                       topLeft: Radius.circular(10),
            //                                       topRight: Radius.circular(10),
            //                                       bottomLeft:
            //                                           Radius.circular(10),
            //                                       bottomRight:
            //                                           Radius.circular(10)),
            //                                 ),
            //                                 padding: const EdgeInsets.all(8.0),
            //                                 child: TextButton(
            //                                   onPressed: () =>
            //                                       Navigator.pop(context, 'OK'),
            //                                   child: const Text(
            //                                     'ปิด',
            //                                     style: TextStyle(
            //                                         color: Colors.white,
            //                                         fontWeight: FontWeight.bold,
            //                                         fontFamily:
            //                                             FontWeight_.Fonts_T),
            //                                   ),
            //                                 ),
            //                               ),
            //                             ),
            //                           ],
            //                         ),
            //                         SizedBox(height: 30),
            //                       ],
            //                     ),
            //                   );
            //                 });
            //           },
            //           child: Row(
            //             mainAxisAlignment: MainAxisAlignment.center,
            //             children: [
            //               Icon(Icons.edit, color: Colors.white),
            //               const Text(
            //                 'เพิ่มลายมือชื่อดิจิทัล',
            //                 style: TextStyle(
            //                     color: Colors.white,
            //                     fontWeight: FontWeight.bold,
            //                     fontFamily: FontWeight_.Fonts_T),
            //               ),
            //             ],
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
        // floatingActionButton: FloatingActionButton.extended(
        //   onPressed: () {},
        //   // backgroundColor: Colors.green,
        //   // child: const Icon(Icons.edit),
        //   label: const Text(
        //     'ปิด',
        //     style: TextStyle(
        //       color: Colors.white,
        //       fontFamily: Font_.Fonts_T,
        //     ),
        //   ),
        //   icon: const Icon(
        //     Icons.edit,
        //     color: Colors.white,
        //   ),
        //   backgroundColor: Colors.black,
        // ),
      ),
    );
  }

  Future<void> _showMyDialog() async {
    final ByteData? imageData1 = rawImage1.value;
    final ByteData? imageData2 = rawImage2.value;
    final ByteData? imageData3 = rawImage3.value;
    final ByteData? imageData4 = rawImage4.value;
    // Uint8List imageBytes;
    // if (imageData != null) {
    //   imageBytes = Uint8List.fromList(imageData.buffer.asUint8List());
    // }
    ///////
    final pdf = pw.Document();
    final font = await rootBundle.load("fonts/Sarabun-Medium.ttf");
    final ttf = pw.Font.ttf(font);
    DateTime date = DateTime.now();
    String date_string = '${date.day}/${date.month}/${date.year}';
    var formatter = new DateFormat.MMMMd('th_TH');
    String thaiDate = formatter.format(date);
    var nFormat = NumberFormat("#,##0.00", "en_US");
    var nFormat2 = NumberFormat("###0.00", "en_US");
    final iconImage =
        (await rootBundle.load('images/LOGO.png')).buffer.asUint8List();
    List netImage = [];
    for (int i = 0; i < newValuePDFimg.length; i++) {
      netImage.add(await networkImage('${newValuePDFimg[i]}'));
    }
    double Sumtotal = 0;
    for (int index = 0; index < quotxSelectModels.length; index++)
      Sumtotal = Sumtotal +
          (int.parse(quotxSelectModels[index].term!) *
              double.parse(quotxSelectModels[index].total!));
    ///////////////////////------------------------------------------------->
    final List<String> _digitThai = [
      'ศูนย์',
      'หนึ่ง',
      'สอง',
      'สาม',
      'สี่',
      'ห้า',
      'หก',
      'เจ็ด',
      'แปด',
      'เก้า'
    ];

    final List<String> _positionThai = [
      '',
      'สิบ',
      'ร้อย',
      'พัน',
      'หมื่น',
      'แสน',
      'ล้าน'
    ];
/////////////////////////////------------------------>(จำนวนเต็ม)
    String convertNumberToText(int number) {
      String result = '';
      int numberIntPart = number.toInt();
      int numberDecimalPart = ((number - numberIntPart) * 100).toInt();
      final List<String> digits = numberIntPart.toString().split('');
      int position = digits.length - 1;
      for (int i = 0; i < digits.length; i++) {
        final int digit = int.parse(digits[i]);
        if (digit != 0) {
          if (position == 6) {
            result = '$result${_positionThai[6]}';
          }
          if (position != 6 && position != 8) {
            if (digit == 1 && position == 1) {
              // result = '$resultเอ็ด';
              result = '$resultสิบ';
            } else {
              result =
                  '$result${_digitThai[digit]}${_positionThai[position % 6]}';
            }
          } else if (position == 8) {
            result = '$result${_digitThai[digit]}${_positionThai[6]}';
          }
        }
        position--;
      }
      // final String decimalText =
      //     convertNumberToText(numberDecimalPart).replaceAll(_digitThai[0], "");
      return result;
    }

/////////////////////////////------------------------>(จำนวนทศนิยม สตางค์)
    String convertNumberToText2(int number2) {
      String result = '';
      int numberIntPart = number2.toInt();
      int numberDecimalPart = ((number2 - numberIntPart) * 100).toInt();
      final List<String> digits = numberIntPart.toString().split('');
      int position = digits.length - 1;
      for (int i = 0; i < digits.length; i++) {
        final int digit = int.parse(digits[i]);
        if (digit != 0) {
          if (position == 6) {
            result = '$result${_positionThai[6]}';
          }
          if (position != 6 && position != 8) {
            if (digit == 1 && position == 1) {
              // result = '$resultเอ็ด';
              result = '$resultสิบ';
            } else {
              result =
                  '$result${_digitThai[digit]}${_positionThai[position % 6]}';
            }
          } else if (position == 8) {
            result = '$result${_digitThai[digit]}${_positionThai[6]}';
          }
        }
        position--;
      }
      // final String decimalText =
      //     convertNumberToText(numberDecimalPart).replaceAll(_digitThai[0], "");
      return result;
    }

////////////////----------------------------->(ตัด หน้าจุดกับหลังจุดออกจากกัน)
    var number_ = "${nFormat2.format(Sumtotal)}";
    var parts = number_.split('.');
    var front = parts[0];
    var back = parts[1];

////////////////--------------------------------->(บาท)
    double number = double.parse(front);
    final int numberIntPart = number.toInt();
    final double numberDecimalPart = (number - numberIntPart) * 100;
    final String numberText = convertNumberToText(numberIntPart);
    final String decimalText = convertNumberToText(numberDecimalPart.toInt());
////////////////---------------------------------->(สตางค์)
    double number2 = double.parse(number_);
    final int numberIntPart2 = number.toInt();
    final int numberDecimalPart2 = ((number2 - numberIntPart2) * 100).round();
    final String numberText2 = convertNumberToText2(numberIntPart2);
    final String decimalText2 =
        convertNumberToText2(numberDecimalPart2.toInt());
////////////////------------------------------->(เช็คและเพิ่มตัวอักษร)
    final String formattedNumber = (decimalText2.replaceAll(
                _digitThai[0], "") ==
            '')
        ? '$numberTextบาทถ้วน'
        : (back[0].toString() == '0')
            ? '$numberTextบาทศูนย์${decimalText2.replaceAll(_digitThai[0], "")}สตางค์'
            : '$numberTextบาท${decimalText2.replaceAll(_digitThai[0], "")}สตางค์';

    String text_Number1 = formattedNumber;
    RegExp exp1 = RegExp(r"สองสิบ");
    if (exp1.hasMatch(text_Number1)) {
      text_Number1 = text_Number1.replaceAll(exp1, 'ยี่สิบ');
    }
    String text_Number2 = text_Number1;
    RegExp exp2 = RegExp(r"สิบหนึ่ง");
    if (exp2.hasMatch(text_Number2)) {
      text_Number2 = text_Number2.replaceAll(exp2, 'สิบเอ็ด');
    }
///////////////////////------------------------------------------------->
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Center(
            child: Text(
              "เอกสารเช่า(ต้นฉบับ/ประทับลายมือชื่อดิจิทัลแล้ว)",
            ),
          ),
          content: Container(
            width: 1000,
            height: 500,
            child: PdfPreview(
              build: (format) async {
                ///////////////////////------------------------------------------------->
                pdf.addPage(
                  pw.MultiPage(
                    // header: (context) {
                    //   return pw.Text(
                    //     'Flutter Approach',
                    //     style: pw.TextStyle(
                    //       fontWeight: pw.FontWeight.bold,
                    //       fontSize: 15.0,
                    //     ),
                    //   );
                    // },
                    build: (context) {
                      return [
                        pw.Row(
                          children: [
                            (netImage.isEmpty)
                                ? pw.Container(
                                    height: 72,
                                    width: 70,
                                    color: PdfColors.grey200,
                                    child: pw.Center(
                                      child: pw.Text(
                                        '$renTal_name ',
                                        maxLines: 1,
                                        style: pw.TextStyle(
                                          fontSize: 8,
                                          font: ttf,
                                          color: PdfColors.grey300,
                                        ),
                                      ),
                                    ))

                                // pw.Image(
                                //     pw.MemoryImage(iconImage),
                                //     height: 72,
                                //     width: 70,
                                //   )
                                : pw.Image(
                                    (netImage[0]),
                                    height: 72,
                                    width: 70,
                                  ),
                            pw.SizedBox(width: 1 * PdfPageFormat.mm),
                            pw.Container(
                              width: 200,
                              child: pw.Column(
                                mainAxisSize: pw.MainAxisSize.min,
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.Text(
                                    '$renTal_name',
                                    maxLines: 2,
                                    style: pw.TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: pw.FontWeight.bold,
                                      font: ttf,
                                    ),
                                  ),
                                  pw.Text(
                                    '$bill_addr',
                                    maxLines: 3,
                                    style: pw.TextStyle(
                                      fontSize: 10.0,
                                      color: PdfColors.grey800,
                                      font: ttf,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            pw.Spacer(),
                            pw.Container(
                              width: 180,
                              child: pw.Column(
                                mainAxisSize: pw.MainAxisSize.min,
                                crossAxisAlignment: pw.CrossAxisAlignment.end,
                                children: [
                                  // pw.Text(
                                  //   'ใบเสนอราคา',
                                  //   style: pw.TextStyle(
                                  //     fontSize: 12.00,
                                  //     fontWeight: pw.FontWeight.bold,
                                  //     font: ttf,
                                  //   ),
                                  // ),
                                  // pw.Text(
                                  //   'ที่อยู่,\n1/1-8 ถ.รัตนโกสินทร์ ต.ศรีภูมิ อ.เมือง จ.เชียงใหม่ 50200',
                                  //   textAlign: pw.TextAlign.right,
                                  //   style: pw.TextStyle(
                                  //       fontSize: 10.0, font: ttf, color: PdfColors.grey),
                                  // ),
                                  pw.Text(
                                    'โทรศัพท์: $bill_tel',
                                    textAlign: pw.TextAlign.right,
                                    maxLines: 1,
                                    style: pw.TextStyle(
                                        fontSize: 10.0,
                                        font: ttf,
                                        color: PdfColors.grey800),
                                  ),
                                  pw.Text(
                                    'อีเมล: $bill_email',
                                    maxLines: 1,
                                    textAlign: pw.TextAlign.right,
                                    style: pw.TextStyle(
                                        fontSize: 10.0,
                                        font: ttf,
                                        color: PdfColors.grey800),
                                  ),
                                  pw.Text(
                                    'เลขประจำตัวผู้เสียภาษี: $bill_tax',
                                    maxLines: 2,
                                    style: pw.TextStyle(
                                        fontSize: 10.0,
                                        font: ttf,
                                        color: PdfColors.grey800),
                                  ),
                                  pw.Text(
                                    'ณ วันที่:  $thaiDate ${DateTime.now().year + 543}',
                                    maxLines: 2,
                                    style: pw.TextStyle(
                                        fontSize: 10.0,
                                        font: ttf,
                                        color: PdfColors.grey800),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        pw.SizedBox(height: 1 * PdfPageFormat.mm),
                        pw.Divider(),
                        pw.SizedBox(height: 1 * PdfPageFormat.mm),
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.center,
                          children: [
                            pw.Text(
                              'สัญญาเช่าพื้นที่ $renTal_name ',
                              textAlign: pw.TextAlign.center,
                              style: pw.TextStyle(
                                fontSize: 11.0,
                                fontWeight: pw.FontWeight.bold,
                                font: ttf,
                              ),
                            ),
                          ],
                        ),
                        pw.Row(
                          children: [
                            pw.Spacer(),
                            pw.Container(
                              width: 180,
                              child: pw.Column(
                                mainAxisSize: pw.MainAxisSize.min,
                                crossAxisAlignment: pw.CrossAxisAlignment.end,
                                children: [
                                  pw.Text(
                                    'เลขที่สัญญา.........$Get_Value_cid................ ',
                                    textAlign: pw.TextAlign.right,
                                    style: pw.TextStyle(
                                        fontSize: 10.0,
                                        font: ttf,
                                        color: PdfColors.black),
                                  ),
                                  pw.Text(
                                    'ทำที่ $renTal_name ',
                                    textAlign: pw.TextAlign.right,
                                    style: pw.TextStyle(
                                        fontSize: 10.0,
                                        font: ttf,
                                        color: PdfColors.black),
                                  ),
                                  pw.Text(
                                    'วันที่ทำสัญญา ............. ',
                                    style: pw.TextStyle(
                                        fontSize: 10.0,
                                        font: ttf,
                                        color: PdfColors.black),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        pw.SizedBox(height: 5 * PdfPageFormat.mm),
                        pw.Text(
                          'สัญญานี้ทำขึ้นระหว่าง $renTal_name  โดย  นายณรงค์  ตนานุวัฒน์   และ    นางรัตนา  ตนานุวัฒน์ \nกรรมการผู้จัดการผู้มีอำนาจกระทำการแทน $renTal_name สำนักงานตั้งอยู่ที่ $bill_addr   ซึ่งต่อไปนี้ในสัญญาฉบับนี้เรียกว่า  ผู้ให้เช่า  ฝ่ายหนึ่งกับ     ',
                          textAlign: pw.TextAlign.justify,
                          style: pw.TextStyle(
                              fontSize: 10.0,
                              font: ttf,
                              color: PdfColors.black),
                        ),
                        pw.SizedBox(height: 2 * PdfPageFormat.mm),
                        pw.Text(
                          '$Form_bussshop........โดย.....$Form_bussscontact............................................',
                          textAlign: pw.TextAlign.justify,
                          style: pw.TextStyle(
                              fontSize: 10.0,
                              font: ttf,
                              color: PdfColors.black),
                        ),
                        pw.Text(
                          'ที่อยู่..............$Form_address.................. ',
                          textAlign: pw.TextAlign.justify,
                          style: pw.TextStyle(
                              fontSize: 10.0,
                              font: ttf,
                              color: PdfColors.black),
                        ),
                        pw.Text(
                          'เบอร์โทรศัพท์.....$Form_tel...........Email........$Form_email................................... ',
                          textAlign: pw.TextAlign.justify,
                          style: pw.TextStyle(
                              fontSize: 10.0,
                              font: ttf,
                              color: PdfColors.black),
                        ),
                        pw.SizedBox(height: 2 * PdfPageFormat.mm),
                        pw.Text(
                          'ซึ่งต่อไปนี้ในสัญญาฉบับนี้เรียกว่า ผู้เช่า อีกฝ่ายหนึ่งได้ตกลงให้ผู้เช่าและผู้ให้เช่าใช้ที่อยู่ของแต่ละฝ่ายตามสัญญานี้ \nสำหรับการติดต่อส่งหนังสือถึงกันและตกลงทำสัญญาเช่าต่อกันมีข้อความดังต่อไปนี้ ',
                          textAlign: pw.TextAlign.justify,
                          style: pw.TextStyle(
                              fontSize: 10.0,
                              font: ttf,
                              color: PdfColors.black),
                        ),
                        pw.SizedBox(height: 2 * PdfPageFormat.mm),
                        pw.Text(
                          'ข้อ 1. ทรัพย์สินที่เช่า และอายุสัญญาเช่า ',
                          textAlign: pw.TextAlign.justify,
                          style: pw.TextStyle(
                            fontSize: 10.0,
                            font: ttf,
                            color: PdfColors.black,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                        pw.SizedBox(height: 2 * PdfPageFormat.mm),
                        pw.Text(
                          'ผู้เช่าตกลงเช่าและผู้ให้เช่าตกลงให้เช่าพื้นที่บางส่วนใน....$renTal_name............ ',
                          textAlign: pw.TextAlign.justify,
                          style: pw.TextStyle(
                              fontSize: 10.0,
                              font: ttf,
                              color: PdfColors.black),
                        ),
                        pw.Text(
                          'ซึ่งเป็นพื้นที่ล๊อค........$Form_ln($Form_zn)..............พื้นที่ประมาณ...$Form_area.....ตารางเมตร  ตั้งอยู่ที่....$bill_addr..........',
                          textAlign: pw.TextAlign.justify,
                          style: pw.TextStyle(
                              fontSize: 10.0,
                              font: ttf,
                              color: PdfColors.black),
                        ),
                        pw.Text(
                          'เริ่มเช่าตั้งแต่วันที่.......$Form_sdate......สิ้นสุดสัญญาเช่าวันที่....$Form_ldate.....ประเภทการเช่า...$Form_rtname....ระยะเวลา.....$Form_period.. ดังรายละเอียดแบบแปลนแนบท้ายสัญญาซึ่งถือเป็นส่วนหนึ่งของสัญญาฉบับนี้ ',
                          textAlign: pw.TextAlign.justify,
                          style: pw.TextStyle(
                              fontSize: 10.0,
                              font: ttf,
                              color: PdfColors.black),
                        ),
                        pw.SizedBox(height: 2 * PdfPageFormat.mm),
                        pw.Text(
                          'ข้อ 2.  ค่าเช่า  ',
                          textAlign: pw.TextAlign.justify,
                          style: pw.TextStyle(
                            fontSize: 10.0,
                            font: ttf,
                            color: PdfColors.black,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                        pw.SizedBox(height: 2 * PdfPageFormat.mm),
                        pw.Text(
                          '2.1  อัตราค่าเช่าเดือนละ.....${nFormat.format(Sumtotal).toString()}....บาท..(....~${text_Number2}~....)..โดยผู้เช่าต้องชำระค่าเช่าเป็นรายเดือน ไม่เกิน วันที่ 5 ของทุกเดือน โดยผู้เช่าจะต้องนำเงินค่าเช่าเข้าบัญชีเงินฝากของ    ผู้ให้เช่า ธนาคารกรุงเทพ สาขาตลาดมีโชค ชื่อบัญชี บจ.ขันแก้ว บัญชีเลขที่ 675-0-22186-0 หรือบัญชีอื่นใดที่ทางผู้ให้เช่าแจ้งเปลี่ยนแปลงภายหลังจากวันทำสัญญา',
                          textAlign: pw.TextAlign.justify,
                          style: pw.TextStyle(
                              fontSize: 10.0,
                              font: ttf,
                              color: PdfColors.black),
                        ),
                        pw.SizedBox(height: 2 * PdfPageFormat.mm),
                        pw.Text(
                          'กรณีผู้ให้เช่าไม่สามารถเรียกเก็บเงินค่าเช่าตามเช็คได้ภายในกำหนดเวลาผู้เช่ายินยอมชำระดอกเบี้ยอัตรา ร้อยละ 15 ต่อปี ผู้เช่าตกลงให้ผู้ให้เช่าปรับขึ้นอัตราค่าเช่าเพิ่มขึ้นเมื่อครบสัญญาเช่าฉบับนี้โดยผู้ให้เช่าจะมีหนังสือแจ้งเป็น ลายลักษณ์อักษรให้ผู้เช่าได้รับทราบทุกครั้งที่มีการปรับขึ้นราคาค่าเช่า ',
                          textAlign: pw.TextAlign.justify,
                          style: pw.TextStyle(
                              fontSize: 10.0,
                              font: ttf,
                              color: PdfColors.black),
                        ),
                        pw.SizedBox(height: 2 * PdfPageFormat.mm),
                        pw.Text(
                          '2.2  ผู้เช่าตกลงยินยอมจ่ายค่าตอบแทนในการได้สิทธิการเช่าให้แก่ผู้ให้เช่าในวันทำสัญญาเช่าเป็นจำนวน',
                          textAlign: pw.TextAlign.justify,
                          style: pw.TextStyle(
                              fontSize: 10.0,
                              font: ttf,
                              color: PdfColors.black),
                        ),
                        pw.Text(
                          'เงิน.........280,800.00.........บาท(...สองแสนแปดหมื่นแปดร้อยบาทถ้วน...)ซึ่งเงินจำนวนดังกล่าวผู้ให้เช่าจะ ไม่คืนให้ผู้เช่าไม่ว่ากรณีใด ๆทั้งสิ้น  ',
                          textAlign: pw.TextAlign.justify,
                          style: pw.TextStyle(
                              fontSize: 10.0,
                              font: ttf,
                              color: PdfColors.black),
                        ),
                        pw.SizedBox(height: 2 * PdfPageFormat.mm),
                        pw.Text(
                          '2.3  เงินประกันค่าเสียหาย ผู้เช่าได้วางเงินประกันค่าเสียหายไว้กับผู้ให้เช่า ตลอดอายุสัญญาเช่ารวมถึงที่ ',
                          textAlign: pw.TextAlign.justify,
                          style: pw.TextStyle(
                              fontSize: 10.0,
                              font: ttf,
                              color: PdfColors.black),
                        ),
                        pw.Text(
                          'ได้ต่อสัญญาเช่าไปด้วยแล้ว เป็นจำนวนเงิน...39,000.00..บาท..............(...สามหมื่นเก้าพันบาทถ้วน..........) ',
                          textAlign: pw.TextAlign.justify,
                          style: pw.TextStyle(
                              fontSize: 10.0,
                              font: ttf,
                              color: PdfColors.black),
                        ),
                        pw.Text(
                          'เงินประกันค่าเสียหายดังกล่าวผู้ให้เช่าจะคืนให้เท่ากับจำนวนเดิม เมื่อครบกำหนดอายุสัญญาเช่าโดยผู้ให้เช่าไม่คิด',
                          textAlign: pw.TextAlign.justify,
                          style: pw.TextStyle(
                              fontSize: 10.0,
                              font: ttf,
                              color: PdfColors.black),
                        ),
                        pw.Text(
                          'ดอกเบี้ยจากเงินประกันดังกล่าวข้างต้นหรือคืนให้ตามส่วนหรือให้ถือเป็นการชดใช้ค่าเสียหาย  บางส่วนเมื่อผู้เช่าผิด  ',
                          textAlign: pw.TextAlign.justify,
                          style: pw.TextStyle(
                              fontSize: 10.0,
                              font: ttf,
                              color: PdfColors.black),
                        ),
                        pw.Text(
                          'สัญญาหรือกรณีที่ผู้เช่าจะต้องรับผิดในความเสียหายที่เกิดขึ้นแก่ทรัพย์สินที่เช่า และหากเงินประกันไม่เพียงพอ ผู้ให้ ',
                          textAlign: pw.TextAlign.justify,
                          style: pw.TextStyle(
                              fontSize: 10.0,
                              font: ttf,
                              color: PdfColors.black),
                        ),
                        pw.Text(
                          'เช่ามีสิทธิที่จะเรียกร้องค่าเสียหายจากผู้เช่าให้จนครบจำนวนและเงินประกันนี้ไม่สามารถชำระเป็นค่าเช่าล่วงหน้า หรือไม่ถือเป็นค่าเช่ารายเดือนได้  ',
                          textAlign: pw.TextAlign.justify,
                          style: pw.TextStyle(
                              fontSize: 10.0,
                              font: ttf,
                              color: PdfColors.black),
                        ),
                        pw.SizedBox(height: 2 * PdfPageFormat.mm),
                        pw.Text(
                          '2.4  ในกรณีสุดวิสัยไม่ว่าด้วยเหตุใดภายหลังจากวันทำสัญญาเช่าภายในศูนย์การค้าฉบับนี้ ทำให้ผู้เช่าไม่ ',
                          textAlign: pw.TextAlign.justify,
                          style: pw.TextStyle(
                              fontSize: 10.0,
                              font: ttf,
                              color: PdfColors.black),
                        ),
                        pw.Text(
                          'สามารถเปิดธุรกิจได้ทั้งหมด หรือส่วนหนึ่งส่วนใด หรือมีการแก้ไขปรับปรุงแบบ ซึ่งทำให้ทรัพย์สินที่เช่าเปลี่ยนแปลง ',
                          textAlign: pw.TextAlign.justify,
                          style: pw.TextStyle(
                              fontSize: 10.0,
                              font: ttf,
                              color: PdfColors.black),
                        ),
                        pw.Text(
                          'ไปไม่ว่าจะเป็นสาระสำคัญหรือไม่ก็ตาม และทำให้วัตถุประสงค์ในการนำศูนย์การค้าออกให้เช่าเปลี่ยนแปลงไปและ ',
                          textAlign: pw.TextAlign.justify,
                          style: pw.TextStyle(
                              fontSize: 10.0,
                              font: ttf,
                              color: PdfColors.black),
                        ),
                        pw.Text(
                          'ผู้ให้เช่าได้แจ้งยกเลิกการเช่าให้ผู้เช่าทราบแล้วในกรณีนี้ให้ถือว่าสัญญาเช่าฉบับนี้สิ้นสุดลง  โดยผู้เช่ายินยอมสละ ',
                          textAlign: pw.TextAlign.justify,
                          style: pw.TextStyle(
                              fontSize: 10.0,
                              font: ttf,
                              color: PdfColors.black),
                        ),
                        pw.Text(
                          'สิทธิที่จะเรียกร้องค่าเสียหายใด ๆ จากผู้ให้เช่า ',
                          textAlign: pw.TextAlign.justify,
                          style: pw.TextStyle(
                              fontSize: 10.0,
                              font: ttf,
                              color: PdfColors.black),
                        ),
                        pw.SizedBox(height: 15 * PdfPageFormat.mm),
                        pw.Text(
                          'ข้อ 3. เงื่อนไขและรายละเอียดการเช่า ',
                          textAlign: pw.TextAlign.justify,
                          style: pw.TextStyle(
                            fontSize: 10.0,
                            font: ttf,
                            color: PdfColors.black,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                        pw.SizedBox(height: 2 * PdfPageFormat.mm),
                        pw.Text(
                          '3.1  ผู้เช่าต้องทำสัญญาอย่างน้อย.....36......ถ้าผู้เช่าอยู่ไม่ครบกำหนดสัญญาเช่า......36.....เดือน หรือ',
                          textAlign: pw.TextAlign.left,
                          style: pw.TextStyle(
                              fontSize: 10.0,
                              font: ttf,
                              color: PdfColors.black),
                        ),
                        pw.Text(
                          'ถ้าผู้เช่าผิดสัญญาเช่านี้ ผู้เช่ายอมให้ผู้ให้เช่าบอกเลิกสัญญาได้ทันที ',
                          textAlign: pw.TextAlign.left,
                          style: pw.TextStyle(
                              fontSize: 10.0,
                              font: ttf,
                              color: PdfColors.black),
                        ),
                        pw.SizedBox(height: 2 * PdfPageFormat.mm),
                        pw.Text(
                          '3.2  ภาษีโรงเรือน ผู้ให้เช่าจะเรียกเก็บค่าภาษีโรงเรือน และที่ดินหรือภาษี หรือค่าธรรมเนียม หรือเงินได ',
                          textAlign: pw.TextAlign.left,
                          style: pw.TextStyle(
                              fontSize: 10.0,
                              font: ttf,
                              color: PdfColors.black),
                        ),
                        pw.Text(
                          'อื่นใดที่รัฐบาลเรียกเก็บที่เกี่ยวข้องกับทรัพย์สินที่เช่า จากผู้เช่าในอัตราร้อยละ 12.50 ของค่าเช่าทั้งปี.................',
                          textAlign: pw.TextAlign.left,
                          style: pw.TextStyle(
                              fontSize: 10.0,
                              font: ttf,
                              color: PdfColors.black),
                        ),
                        pw.Text(
                          'หมายเหตุ  รอเอกสารจากทางเทศบาล ',
                          textAlign: pw.TextAlign.left,
                          style: pw.TextStyle(
                              fontSize: 10.0,
                              font: ttf,
                              color: PdfColors.black),
                        ),
                        pw.Text(
                          'ผู้ให้เช่ายินยอมให้ผู้เช่าติดตั้งแผ่นป้ายโฆษณาของผู้เช่าได้ โดยหากมีภาษีป้ายในส่วนนี้ผู้เช่าต้องรับผิดชอบเป็นผู้ชำระเอง ',
                          textAlign: pw.TextAlign.left,
                          style: pw.TextStyle(
                              fontSize: 10.0,
                              font: ttf,
                              color: PdfColors.black),
                        ),
                        pw.SizedBox(height: 2 * PdfPageFormat.mm),
                        pw.Text(
                          '3.3  ผู้เช่าจะใช้พื้นที่นี้ประกอบกิจการค้าประเภท...............$Form_typeshop .............เท่านั้นห้ามผู้เช่าใช้สถาน   ',
                          textAlign: pw.TextAlign.left,
                          style: pw.TextStyle(
                              fontSize: 10.0,
                              font: ttf,
                              color: PdfColors.black),
                        ),
                        pw.Text(
                          'ที่นี้ในการเก็บสารหรือวัตถุไวไฟทุกชนิด และยอมให้ความสะดวกแก่ผู้ให้เช่าตรวจพื้นที่ ที่เช่านี้ได้เสมอผู้เช่าจะใช้พื้นที่นี้',
                          textAlign: pw.TextAlign.left,
                          style: pw.TextStyle(
                              fontSize: 10.0,
                              font: ttf,
                              color: PdfColors.black),
                        ),
                        pw.Text(
                          'เพื่อเป็นที่พักอย่างเดียวโดยไม่ประกอบกิจการค้าไม่ได้และจะดูแลสภาพตัวอาคารให้ดีหากเกิดความเสียหายในระหว่างการเช่าผู้เช่าต้องเข้าซ่อมแซมแก้ไขทันทีและเมื่อเลิกเช่าต้องส่งมอบพื้นที่คืนในสภาพที่ดีเหมือนตอนที่ได้รับมอบไปจากผู้ให้เช่าหากผู้เช่าประสงค์จะเปลี่ยนแปลงกิจการค้าในภายหลังต้องขออนุญาตเป็นหนังสือจากผู้ให้เช่าหากผู้ให้เช่าอนุญาตจะมี หนังสือแจ้งให้ทราบผู้เช่าต้องไม่กระทำการใดอันเป็นการรบกวนผู้เช่ารายอื่น',
                          textAlign: pw.TextAlign.left,
                          style: pw.TextStyle(
                              fontSize: 10.0,
                              font: ttf,
                              color: PdfColors.black),
                        ),
                        pw.SizedBox(height: 2 * PdfPageFormat.mm),
                        pw.Text(
                          '3.4  ผู้เช่าต้องประกอบกิจการค้าอย่างจริงจัง โดยเริ่มเปิดหน้าร้านไม่เกิน 9.00 น.  และปิดหน้าร้านหลังเวลา 20.00 น.    ',
                          textAlign: pw.TextAlign.left,
                          style: pw.TextStyle(
                              fontSize: 10.0,
                              font: ttf,
                              color: PdfColors.black),
                        ),
                        pw.Text(
                          'ทุกวันและต้องมีการตกแต่งหน้าร้านและจัดทำป้ายชื่อร้านจัดวางสินค้าหรืออุปกรณ์ให้เป็นระเบียบไม่วางสินค้าหรืออุปกรณ์วัตถุใดลงบนทางเท้าหรือลงบนถนนหน้าอาคารหรือบนทางเดินด้านหลังอาคารและจัดให้มีพนักงานประจำร้านตามปกติวิสัยของการประกอบการค้า ',
                          textAlign: pw.TextAlign.justify,
                          style: pw.TextStyle(
                              fontSize: 10.0,
                              font: ttf,
                              color: PdfColors.black),
                        ),
                        pw.SizedBox(height: 2 * PdfPageFormat.mm),
                        pw.Text(
                          'ห้ามผู้เช่าปิดร้านเกินสัปดาห์ละ..1..วันแต่ยกเว้นวันหยุดตามประกาศของทางโครงการ...แคนนาส...หากเช่าปิดร้านเกินกว่าที่กำหนดไว้ผู้เช่ายินยอมเสียค่าปรับเป็นวันละ...1,000.-...บาท..(..หนึ่งพันบาทถ้วน..)ยกเว้นมีเหตุจำเป็นผู้เช่าต้องบอกกล่าวให้ผู้ให้เช่าทราบถึงความจำเป็นนั้นก่อนล่วงหน้า   ',
                          textAlign: pw.TextAlign.left,
                          style: pw.TextStyle(
                              fontSize: 10.0,
                              font: ttf,
                              color: PdfColors.black),
                        ),
                        pw.SizedBox(height: 2 * PdfPageFormat.mm),
                        pw.Text(
                          '3.5  หากผู้เช่าทอดทิ้งสถานที่เช่าทั้งหมดหรือส่วนใหญ่ ให้อยู่ในสภาพปราศจากการครอบครองหรือปราศจากการ ทำประโยชน์เป็นระยะเวลาเกิน 7 วันติดต่อกันโดยไม่ได้รับความยินยอมจากผู้ให้เช่าผู้ให้เช่ามีสิทธิบอกเลิกสัญญาได้ โดยส่งคำบอกกล่าวเป็นหนังสือไปยังผู้เช่า ',
                          textAlign: pw.TextAlign.left,
                          style: pw.TextStyle(
                              fontSize: 10.0,
                              font: ttf,
                              color: PdfColors.black),
                        ),
                        pw.SizedBox(height: 2 * PdfPageFormat.mm),
                        pw.Text(
                          'ข้อ 4. ถ้าผู้เช่าต้องการโอนสิทธิตามสัญญาเช่านี้แก่บุคคลอื่นหรือต้องการเปลี่ยนตัวผู้เช่าเป็นบุคคลอื่นผู้เช่าต้องแจ้ง ให้ผู้ให้เช่าพิจารณาหากผู้ให้เช่าให้ความยินยอมเปลี่ยนสัญญาเช่าให้ผู้เช่าต้องเสียค่าใช้จ่ายในการเปลี่ยนสัญญาจำนวน  ',
                          textAlign: pw.TextAlign.left,
                          style: pw.TextStyle(
                            fontSize: 10.0,
                            font: ttf,
                            color: PdfColors.black,
                          ),
                        ),
                        pw.Text(
                          '.............................บาท  (...  ...............................-...........................)ผู้เช่าจะติดป้ายให้เช่า หรือให้เซ้ง หรือป้ายอื่นใดที่มี  ',
                          textAlign: pw.TextAlign.left,
                          style: pw.TextStyle(
                            fontSize: 10.0,
                            font: ttf,
                            color: PdfColors.black,
                          ),
                        ),
                        pw.Text(
                          'ข้อความทำนองดังกล่าวไม่ได้ ยกเว้นจะได้รับอนุญาตจากผู้ให้เช่าก่อน ผู้เช่าจะนำพื้นที่นี้ไปให้เช่าช่วงต่อหรือมีภาระผูกพัน ใดๆกับบุคคลอื่นไม่ว่าบางส่วนหรือทั้งหมดโดยไม่มีหนังสือยินยอมจากผู้ให้เช่าไม่ได้  ',
                          textAlign: pw.TextAlign.left,
                          style: pw.TextStyle(
                            fontSize: 10.0,
                            font: ttf,
                            color: PdfColors.black,
                          ),
                        ),
                        pw.SizedBox(height: 2 * PdfPageFormat.mm),
                        pw.Text(
                          'ข้อ 5. . การตกแต่งปรับปรุงเปลี่ยนแปลง นับตั้งแต่วันที่ผู้เช่าได้รับหนังสือมอบการครอบครองทรัพย์สินที่เช่าผู้เช่ามีสิทธิเข้า ปรับปรุงตกแต่งเพื่อใช้ประโยชน์ในทรัพย์สินที่เช่าซึ่งรวมถึงการติดป้ายหรือข้อความอย่างอื่นภายในทรัพย์สินที่เช่าได้ โดยผู้เช่าจะต้องเสนอรายละเอียดในการปรับปรุงตกแต่งเป็นหนังสือและต้องให้ผู้ให้เช่าเห็นชอบด้วยก่อนการปรับปรุงตกแต่งจะต้องไม่ทำให้เกิดความเสียหายใดๆแก่ตัวอาคารถ้าเกิดความเสียหายผู้เช่าต้องรับผิดชอบความเสียหายที่เกิดขึ้นทั้งสิ้น   ',
                          textAlign: pw.TextAlign.left,
                          style: pw.TextStyle(
                            fontSize: 10.0,
                            font: ttf,
                            color: PdfColors.black,
                          ),
                        ),
                        pw.SizedBox(height: 2 * PdfPageFormat.mm),
                        pw.Text(
                          'อนึ่ง สิ่งที่ตกแต่งและ / หรือปรับปรุงที่ติดตรึงตรากับทรัพย์สินที่เช่าซึ่งสามารถจะเคลื่อนย้ายโดยไม่ก่อให้เกิดความ ความเสียหายแก่ทรัพย์สินที่เช่านั้นไม่ว่าจะเป็นส่วนควบหรืออุปกรณ์ให้คงเป็นกรรมสิทธิ์ของผู้เช่าในระหว่างที่สัญญาเช่านี้มีผลบังคับ และเมื่อสิ้นสุดสัญญาไม่ว่ากรณีใด ๆ ทั้งสิ้น   ',
                          textAlign: pw.TextAlign.left,
                          style: pw.TextStyle(
                            fontSize: 10.0,
                            font: ttf,
                            color: PdfColors.black,
                          ),
                        ),
                        pw.SizedBox(height: 2 * PdfPageFormat.mm),
                        pw.Text(
                          'ข้อ 6.  หากผู้เช่าประสงค์ต่อสัญญาเช่าคราวต่อไป ให้แจ้งแก่ผู้ให้เช่าทราบไม่น้อยกว่า 90 วัน ก่อนวันครบสัญญา เช่า หากผู้ให้เช่าตกลงให้เช่าต่อผู้เช่าต้องเข้าทำสัญญาเช่าใหม่ก่อนสัญญาเช่านี้ครบกำหนดไม่น้อยกว่า 90 วันแต่ทั้งนี้ให้  ปฏิบัติตามเงื่อนไขและอัตราค่าเช่าในสัญญาเช่าฉบับใหม่ด้วยหากพ้นกำหนดนี้ถือว่าผู้เช่าไม่ประสงค์จะเช่าต่อผู้เช่าต้อง ทำการส่งมอบพื้นที่คืนแก่ผู้ให้เช่าโดยการที่ผู้เช่าต้องขนย้ายทรัพย์สินและบริวารออกจากสถานที่เช่าและทำการซ่อมแซมอาคารให้มีสภาพดังเดิมเหมือนสภาพที่ได้รับมอบไปจากผู้ให้เช่าให้เสร็จเรียบร้อยในวันที่สิ้นสุดสัญญาเช่าพร้อมทั้งนำกุญแจไปคืนแก่ผู้ให้เช่าหากเกินกำหนดนี้ผู้เช่าต้องรับผิดชอบค่าเสียหายและปฏิบัติตามข้อความในสัญญาข้อ 11. อีก     ',
                          textAlign: pw.TextAlign.left,
                          style: pw.TextStyle(
                            fontSize: 10.0,
                            font: ttf,
                            color: PdfColors.black,
                          ),
                        ),
                        pw.SizedBox(height: 2 * PdfPageFormat.mm),
                        pw.Text(
                          'ข้อ 7.  เมื่อผู้ให้เช่าต้องการสถานที่คืน ผู้ให้เช่าจะแจ้งให้ผู้เช่าทราบล่วงหน้า 3 เดือน โดยผู้เช่าจะไม่เรียกร้องค่าขนย้ายใด ๆ ทั้งสิ้น ',
                          textAlign: pw.TextAlign.left,
                          style: pw.TextStyle(
                            fontSize: 10.0,
                            font: ttf,
                            color: PdfColors.black,
                          ),
                        ),
                        pw.SizedBox(height: 2 * PdfPageFormat.mm),
                        pw.Text(
                          'ข้อ 8.  เมื่อครบกำหนดสัญญาเช่าแล้ว  ผู้เช่ายังไม่ออกจากสถานที่ให้เช่า  ผู้เช่ายินยอมให้ผู้ให้เช่าปรับวันละ \n5,000.- บาท ( ห้าพันบาทถ้วน )  ',
                          textAlign: pw.TextAlign.left,
                          style: pw.TextStyle(
                            fontSize: 10.0,
                            font: ttf,
                            color: PdfColors.black,
                          ),
                        ),
                        pw.SizedBox(height: 2 * PdfPageFormat.mm),
                        pw.Text(
                          'ข้อ 9. เมื่อผู้เช่ายกเลิกสัญญาเช่าแล้ว ผู้เช่าจะรับผิดชอบรื้อถอนตู้เซฟ หรือประตูห้องนิรภัยออกไปให้เรียบร้อย (สำหรับผู้ประกอบธุรกิจธนาคารหรือธุรกิจที่เกี่ยวข้อง)และทำการซ่อมแซมอาคารให้มีสภาพดังเดิมเหมือนสภาพที่ได้\nรับมอบไปจากผู้ให้เช่าให้เสร็จเรียบร้อยในวันที่สิ้นสุดสัญญาเช่า ',
                          textAlign: pw.TextAlign.left,
                          style: pw.TextStyle(
                            fontSize: 10.0,
                            font: ttf,
                            color: PdfColors.black,
                          ),
                        ),
                        pw.SizedBox(height: 2 * PdfPageFormat.mm),
                        pw.Text(
                          'ข้อ 10. หากผู้เช่าประสงค์จะเลิกเช่าก่อนที่จะครบกำหนดตามสัญญาเช่าผู้เช่าต้องมีหนังสือแจ้งให้ผู้ให้เช่าทราบล่วง หน้าไม่น้อยกว่า 90 วัน และผู้เช่าต้องส่งมอบห้องคืนตามข้อ 11. ด้วย    ',
                          textAlign: pw.TextAlign.left,
                          style: pw.TextStyle(
                            fontSize: 10.0,
                            font: ttf,
                            color: PdfColors.black,
                          ),
                        ),
                        pw.SizedBox(height: 2 * PdfPageFormat.mm),
                        pw.Text(
                          'ข้อ 11. ผู้เช่าต้องส่งมอบพื้นที่นี้คืนแก่ผู้ให้เช่าเมื่อสิ้นสุดสัญญาเช่าหรือเมื่อผู้ให้เช่าบอกเลิกสัญญาเช่าหรือผู้เช่าบอกเลิก สัญญาเช่าหากผู้เช่าไม่ยอมหรือไม่ยินยอมขนย้ายทรัพย์สินและบริวารออกไปหรือไม่ส่งมอบพื้นที่นี้ผู้เช่ายอมให้ ผู้ให้เช่ากระทำการต่อไปนี้ได้โดยผู้เช่าจะไม่เอาผิดกับผู้ให้เช่าไม่ว่าในทางแพ่งหรือทางอาญาคือ       ',
                          textAlign: pw.TextAlign.left,
                          style: pw.TextStyle(
                            fontSize: 10.0,
                            font: ttf,
                            color: PdfColors.black,
                          ),
                        ),
                        pw.SizedBox(height: 2 * PdfPageFormat.mm),
                        pw.Text(
                          'ข้อ 11.1  ผู้เช่ายอมให้ผู้ให้เช่าริบเงินประกันในข้อ 2.3 ได้ทันทีและผู้เช่าต้องรับผิดชอบชดใช้ค่าปรับแก่ผู้ให้เช่าเดือน \nละ 2เท่าของอัตราค่าเช่าที่ใช้อยู่ในสัญญาฉบับนี้นับจากวันที่สิ้นสุดสัญญาเช่าหรือเมื่อผู้ให้เช่าบอกเลิกสัญญาเช่าหรือ ไปจนถึงวันที่ผู้เช่ากระทำการส่งมอบพื้นที่คืนแก่ผู้ให้เช่าเป็นที่เรียบร้อยเพื่อให้ผู้ให้เช่าจะได้ครอบครองและเข้าไปใช้ ประโยชน์ในพื้นที่นี้ได้อย่างสมบูรณ์           ',
                          textAlign: pw.TextAlign.left,
                          style: pw.TextStyle(
                            fontSize: 10.0,
                            font: ttf,
                            color: PdfColors.black,
                          ),
                        ),
                        pw.SizedBox(height: 2 * PdfPageFormat.mm),
                        pw.Text(
                          'ข้อ 11.2 ผู้เช่ายอมให้ผู้ให้เช่านำกุญแจเข้าปิด เปิด หรือทำลายกุญแจหรือสิ่งกีดขวางใดที่เป็นของผู้เช่าหรือบริวาร อันเป็นอุปสรรคในการเข้าครอบครองพื้นที่นี้ของผู้ให้เช่าและขนย้ายทรัพย์สินเหล่านั้นกลับไปภายใน7 วัน นับจากวันที่ ผู้ให้เช่าได้มีหนังสือส่งไปและหากเกิดความเสียหายหรือสูญหายของทรัพย์สินอันใดไม่ว่าในระหว่างการขนย้ายหรือระหว่างการรอให้ผู้เช่าเข้ามาขนย้ายก็ตามผู้ให้เช่าไม่ต้องรับผิดชอบทุกกรณีค่าใช้จ่ายในการขนย้ายและค่าใช้จ่ายในการเก็บทรัพย์สินของผู้เช่าที่ผู้ให้เช่าได้ใช้จ่ายไปผู้เช่าต้องเป็นผู้รับผิดชอบชำระให้แก่ผู้ให้เช่าทั้งหมดหากพ้นกำหนดนี้ไปให้ถือว่าผู้เช่า สละสิทธิ์ในทรัพย์เหล่านั้นโดยยินยอมให้ตกเป็นของผู้ให้เช่าโดยผู้เช่าจะไม่ติดใจเอาความหรือเรียกร้องสิ่งใดจากผู้ให้เช่าอีกทั้งนั้น           ',
                          textAlign: pw.TextAlign.left,
                          style: pw.TextStyle(
                            fontSize: 10.0,
                            font: ttf,
                            color: PdfColors.black,
                          ),
                        ),
                        pw.SizedBox(height: 2 * PdfPageFormat.mm),
                        pw.Text(
                          'ข้อ 12. ผู้เช่ายอมปฏิบัติตามกฎระเบียบของผู้ให้เช่าในการรักษาความเป็นระเบียบเรียบร้อยความสะอาดต้องจัดการภายใน บริเวณสถานที่เช่าโดยกำจัดสิ่งโสโครกและกลิ่นเหม็นและนำไปทิ้งยังสถานที่ที่ผู้ให้เช่าจัดไว้และไม่กระทำการอึกทึกเป็น ประจำจนคนอื่นได้รับความรำคาญจากความปกติสุขและความสะดวกสบายของลูกค้าหรือผู้มาติดต่อการค้าทั้ง ของผู้เช่าเองและของผู้เช่ารายอื่นด้วยเช่นกัน       ',
                          textAlign: pw.TextAlign.left,
                          style: pw.TextStyle(
                            fontSize: 10.0,
                            font: ttf,
                            color: PdfColors.black,
                          ),
                        ),
                        pw.SizedBox(height: 2 * PdfPageFormat.mm),
                        pw.Text(
                          'ข้อ 12.1 พื้นที่ทางเดินบริเวณทางเท้าด้านหน้า และด้านหลังของพื้นที่ที่เช่าเป็นกรรมสิทธิ์ของผู้ให้เช่าเท่านั้นห้ามมิให้ มีการนำสินค้าหรืออุปกรณ์ทุกชนิดมาวางหรือติดตั้งเป็นการชั่วคราวหรือถาวรไม่ว่ากรณีใด ๆ ทั้งสิ้น     ',
                          textAlign: pw.TextAlign.left,
                          style: pw.TextStyle(
                            fontSize: 10.0,
                            font: ttf,
                            color: PdfColors.black,
                          ),
                        ),
                        pw.SizedBox(height: 2 * PdfPageFormat.mm),
                        pw.Text(
                          'ข้อ 12.2 รถยนต์หรือพาหนะอื่น ๆ ของผู้เช่า ผู้เช่ายอมให้ความร่วมมือในการนำไปจอดบริเวณลานจอดรถที่ผู้ให้เช่าจัด ให้เพื่อความสะดวกในการจอดรถของลูกค้าของศูนย์การค้า ในวันเสาร์ หรือวันอาทิตย์หรือวันอื่นที่ผู้ให้เช่าได้จัดตลาดนัด หรือจัดงานต่าง ๆ ผู้เช่ายอมนำรถไปจอดบริเวณที่จะจัดให้แต่ละคราวไป       ',
                          textAlign: pw.TextAlign.left,
                          style: pw.TextStyle(
                            fontSize: 10.0,
                            font: ttf,
                            color: PdfColors.black,
                          ),
                        ),
                        pw.SizedBox(height: 2 * PdfPageFormat.mm),
                        pw.Text(
                          'ข้อ 13. ถ้าผู้ให้เช่าบอกเลิกสัญญาเช่านี้ก่อนวันสิ้นสุดสัญญาเช่าโดยผู้เช่ามิได้เป็นฝ่ายผิดสัญญาก่อนผู้ให้เช่าต้องคืนเงินประกันแก่ ผู้เช่าภายใน 30 วัน นับจากวันที่ผู้เช่าได้ส่งมอบพื้นที่เช่าคืนตามข้อ 11. เรียบร้อย         ',
                          textAlign: pw.TextAlign.left,
                          style: pw.TextStyle(
                            fontSize: 10.0,
                            font: ttf,
                            color: PdfColors.black,
                          ),
                        ),
                        pw.SizedBox(height: 2 * PdfPageFormat.mm),
                        pw.Text(
                          'ข้อ 14. ในกรณีเกิดอัคคีภัยหรือภัยพิบัติอย่างอื่นใดทั้งหมดหรือแต่บางส่วนจนไม่เหมาะสมที่จะเช่าต่อไปอีกตามความ เป็นจริงให้ถือว่าเป็นการสิ้นสุดสัญญาเช่าลง           ',
                          textAlign: pw.TextAlign.left,
                          style: pw.TextStyle(
                            fontSize: 10.0,
                            font: ttf,
                            color: PdfColors.black,
                          ),
                        ),
                        pw.SizedBox(height: 2 * PdfPageFormat.mm),
                        pw.Text(
                          'ข้อ 15. ในกรณีที่เกิดอุบัติเหตุขัดข้องสำหรับการให้บริการส่วนกลางเฉพาะส่วนพื้นที่เช่าของผู้เช่าบกพร่องในบางครั้งผู้เช่า จะไม่ถือเป็นเหตุที่จะลดอัตราค่าบริการตามที่กำหนดไว้             ',
                          textAlign: pw.TextAlign.left,
                          style: pw.TextStyle(
                            fontSize: 10.0,
                            font: ttf,
                            color: PdfColors.black,
                          ),
                        ),
                        pw.SizedBox(height: 2 * PdfPageFormat.mm),
                        pw.Text(
                          'ข้อ 16. พื้นที่ถนนในส่วนต่าง ๆ และทางเท้าเป็นกรรมสิทธิ์ของผู้ให้เช่าเท่านั้น ',
                          textAlign: pw.TextAlign.left,
                          style: pw.TextStyle(
                            fontSize: 10.0,
                            font: ttf,
                            color: PdfColors.black,
                          ),
                        ),
                        pw.SizedBox(height: 2 * PdfPageFormat.mm),
                        pw.Text(
                          'ข้อ 17. ผู้เช่าสัญญาว่าจะไม่ใช้สถานที่เช่า ทำการค้าอย่างใดอันมิชอบด้วยกฎหมายหรือเป็นที่น่ารังเกียจหรืออาจจะเป็น เชื้อเพลิงหรือทำให้สถานที่เช่าชำรุดเป็นอันตรายไปโดยเร็วพลันทั้งจะไม่ยอมให้ผู้อื่นกระทำการใด ๆ ดังกล่าวด้วย   ',
                          textAlign: pw.TextAlign.left,
                          style: pw.TextStyle(
                            fontSize: 10.0,
                            font: ttf,
                            color: PdfColors.black,
                          ),
                        ),
                        pw.SizedBox(height: 2 * PdfPageFormat.mm),
                        pw.Text(
                          'ข้อ 18. หากผู้เช่าผิดสัญญาข้อหนึ่งข้อใด ผู้ให้เช่าสามารถทำการเอาผิดกับผู้เช่าได้ทั้งทางแพ่งและทางอาญา    ',
                          textAlign: pw.TextAlign.left,
                          style: pw.TextStyle(
                            fontSize: 10.0,
                            font: ttf,
                            color: PdfColors.black,
                          ),
                        ),
                        pw.SizedBox(height: 40 * PdfPageFormat.mm),
                        pw.SizedBox(height: 10 * PdfPageFormat.mm),
                        pw.Text(
                          'สัญญาฉบับนี้ทำเป็นสองฉบับมีข้อความถูกต้องตรงกันคู่สัญญาได้อ่านและเข้าใจข้อความนี้โดยตลอดแล้วเห็นว่า ถูกต้องตามเจตนาของคู่สัญญาทุกประการ จึงได้ลงลายมือชื่อไว้เป็นหลักฐานต่อหน้าพยาน  ',
                          textAlign: pw.TextAlign.left,
                          style: pw.TextStyle(
                            fontSize: 10.0,
                            font: ttf,
                            color: PdfColors.black,
                          ),
                        ),
                        pw.SizedBox(height: 30 * PdfPageFormat.mm),
                        pw.Row(
                            mainAxisAlignment: pw.MainAxisAlignment.center,
                            children: [
                              (imageData1 == null)
                                  ? pw.Text(
                                      'ลงชื่อ.............................................ผู้ให้เช่า   ',
                                      textAlign: pw.TextAlign.justify,
                                      style: pw.TextStyle(
                                        fontSize: 10.0,
                                        font: ttf,
                                        fontWeight: pw.FontWeight.bold,
                                      ),
                                    )
                                  : pw.Column(
                                      mainAxisAlignment:
                                          pw.MainAxisAlignment.center,
                                      children: [
                                        pw.SizedBox(
                                          height: 100,
                                          width: 200,
                                          child: pw.Padding(
                                            padding:
                                                const pw.EdgeInsets.fromLTRB(
                                                    8, 0, 8, 0),
                                            child: pw.Center(
                                              child: (imageData1 != null)
                                                  ? pw.Image(pw.MemoryImage(
                                                      Uint8List.fromList(
                                                          imageData1.buffer
                                                              .asUint8List())))
                                                  : pw.Container(),
                                            ),
                                          ),
                                        ),
                                        pw.Text(
                                          'ลงชื่อ.............................................ผู้ให้เช่า   ',
                                          textAlign: pw.TextAlign.justify,
                                          style: pw.TextStyle(
                                            fontSize: 10.0,
                                            font: ttf,
                                            fontWeight: pw.FontWeight.bold,
                                          ),
                                        )
                                      ],
                                    )
                            ]),
                        pw.SizedBox(height: 2 * PdfPageFormat.mm),
                        pw.Row(
                            mainAxisAlignment: pw.MainAxisAlignment.center,
                            children: [
                              pw.Text(
                                '( ${_Form1.text} ) ',
                                textAlign: pw.TextAlign.justify,
                                style: pw.TextStyle(
                                  fontSize: 10.0,
                                  font: ttf,
                                  fontWeight: pw.FontWeight.bold,
                                ),
                              ),
                            ]),
                        // pw.SizedBox(height: 2 * PdfPageFormat.mm),
                        // pw.Row(
                        //     mainAxisAlignment: pw.MainAxisAlignment.center,
                        //     children: [
                        //       pw.Text(
                        //         'บริษัท ขันแก้ว จำกัด ',
                        //         textAlign: pw.TextAlign.justify,
                        //         style: pw.TextStyle(
                        //           fontSize: 10.0,
                        //           font: ttf,
                        //           fontWeight: pw.FontWeight.bold,
                        //         ),
                        //       ),
                        //     ]),
                        pw.SizedBox(height: 2 * PdfPageFormat.mm),
                        pw.Row(
                            mainAxisAlignment: pw.MainAxisAlignment.center,
                            children: [
                              pw.Text(
                                'วันที่ $date_string ',
                                textAlign: pw.TextAlign.justify,
                                style: pw.TextStyle(
                                  fontSize: 10.0,
                                  font: ttf,
                                  fontWeight: pw.FontWeight.bold,
                                ),
                              ),
                            ]),
                        pw.SizedBox(height: 15 * PdfPageFormat.mm),
                        pw.Row(
                            mainAxisAlignment: pw.MainAxisAlignment.center,
                            children: [
                              (imageData2 == null)
                                  ? pw.Text(
                                      'ลงชื่อ.............................................ผู้เช่า   ',
                                      textAlign: pw.TextAlign.justify,
                                      style: pw.TextStyle(
                                        fontSize: 10.0,
                                        font: ttf,
                                        fontWeight: pw.FontWeight.bold,
                                      ),
                                    )
                                  : pw.Column(
                                      mainAxisAlignment:
                                          pw.MainAxisAlignment.center,
                                      children: [
                                        pw.SizedBox(
                                          height: 100,
                                          width: 200,
                                          child: pw.Padding(
                                            padding:
                                                const pw.EdgeInsets.fromLTRB(
                                                    8, 0, 8, 0),
                                            child: pw.Center(
                                              child: (imageData2 != null)
                                                  ? pw.Image(pw.MemoryImage(
                                                      Uint8List.fromList(
                                                          imageData2.buffer
                                                              .asUint8List())))
                                                  : pw.Container(),
                                            ),
                                          ),
                                        ),
                                        pw.Text(
                                          'ลงชื่อ.............................................ผู้เช่า   ',
                                          textAlign: pw.TextAlign.justify,
                                          style: pw.TextStyle(
                                            fontSize: 10.0,
                                            font: ttf,
                                            fontWeight: pw.FontWeight.bold,
                                          ),
                                        )
                                      ],
                                    )
                            ]),
                        pw.SizedBox(height: 2 * PdfPageFormat.mm),
                        pw.Row(
                            mainAxisAlignment: pw.MainAxisAlignment.center,
                            children: [
                              pw.Text(
                                '( ${_Form2.text} ) ',
                                textAlign: pw.TextAlign.justify,
                                style: pw.TextStyle(
                                  fontSize: 10.0,
                                  font: ttf,
                                  fontWeight: pw.FontWeight.bold,
                                ),
                              ),
                            ]),
                        // pw.SizedBox(height: 2 * PdfPageFormat.mm),
                        // pw.Row(
                        //     mainAxisAlignment: pw.MainAxisAlignment.center,
                        //     children: [
                        //       pw.Text(
                        //         'ห้างหุ้นส่วนจำกัด ลาแปงคาเฟ่ ',
                        //         textAlign: pw.TextAlign.justify,
                        //         style: pw.TextStyle(
                        //           fontSize: 10.0,
                        //           font: ttf,
                        //           fontWeight: pw.FontWeight.bold,
                        //         ),
                        //       ),
                        //     ]),
                        pw.SizedBox(height: 2 * PdfPageFormat.mm),
                        pw.Row(
                            mainAxisAlignment: pw.MainAxisAlignment.center,
                            children: [
                              pw.Text(
                                'วันที่ $date_string ',
                                textAlign: pw.TextAlign.justify,
                                style: pw.TextStyle(
                                  fontSize: 10.0,
                                  font: ttf,
                                  fontWeight: pw.FontWeight.bold,
                                ),
                              ),
                            ]),
                        pw.SizedBox(height: 20 * PdfPageFormat.mm),
                        pw.Row(children: [
                          pw.Expanded(
                              flex: 1,
                              child: pw.Column(
                                children: [
                                  (imageData3 == null)
                                      ? pw.Text(
                                          'ลงชื่อ.............................................พยาน 1   ',
                                          textAlign: pw.TextAlign.justify,
                                          style: pw.TextStyle(
                                            fontSize: 10.0,
                                            font: ttf,
                                            fontWeight: pw.FontWeight.bold,
                                          ),
                                        )
                                      : pw.Column(
                                          mainAxisAlignment:
                                              pw.MainAxisAlignment.center,
                                          children: [
                                            pw.SizedBox(
                                              height: 100,
                                              width: 200,
                                              child: pw.Padding(
                                                padding: const pw
                                                        .EdgeInsets.fromLTRB(
                                                    8, 0, 8, 0),
                                                child: pw.Center(
                                                  child: (imageData3 != null)
                                                      ? pw.Image(pw.MemoryImage(
                                                          Uint8List.fromList(
                                                              imageData3.buffer
                                                                  .asUint8List())))
                                                      : pw.Container(),
                                                ),
                                              ),
                                            ),
                                            pw.Text(
                                              'ลงชื่อ.............................................พยานที่   ',
                                              textAlign: pw.TextAlign.justify,
                                              style: pw.TextStyle(
                                                fontSize: 10.0,
                                                font: ttf,
                                                fontWeight: pw.FontWeight.bold,
                                              ),
                                            )
                                          ],
                                        ),
                                  pw.SizedBox(height: 2 * PdfPageFormat.mm),
                                  pw.Text(
                                    '( ${_Form3.text} ) ',
                                    textAlign: pw.TextAlign.justify,
                                    style: pw.TextStyle(
                                      fontSize: 10.0,
                                      font: ttf,
                                      fontWeight: pw.FontWeight.bold,
                                    ),
                                  ),
                                  pw.SizedBox(height: 2 * PdfPageFormat.mm),
                                  pw.Text(
                                    'วันที่ $date_string ',
                                    textAlign: pw.TextAlign.justify,
                                    style: pw.TextStyle(
                                      fontSize: 10.0,
                                      font: ttf,
                                      fontWeight: pw.FontWeight.bold,
                                    ),
                                  ),
                                ],
                              )),
                          pw.SizedBox(width: 5 * PdfPageFormat.mm),
                          pw.Expanded(
                              flex: 1,
                              child: pw.Column(
                                children: [
                                  (imageData4 == null)
                                      ? pw.Text(
                                          'ลงชื่อ.............................................พยาน   ',
                                          textAlign: pw.TextAlign.justify,
                                          style: pw.TextStyle(
                                            fontSize: 10.0,
                                            font: ttf,
                                            fontWeight: pw.FontWeight.bold,
                                          ),
                                        )
                                      : pw.Column(
                                          mainAxisAlignment:
                                              pw.MainAxisAlignment.center,
                                          children: [
                                            pw.SizedBox(
                                              height: 100,
                                              width: 200,
                                              child: pw.Padding(
                                                padding: const pw
                                                        .EdgeInsets.fromLTRB(
                                                    8, 0, 8, 0),
                                                child: pw.Center(
                                                  child: (imageData4 != null)
                                                      ? pw.Image(pw.MemoryImage(
                                                          Uint8List.fromList(
                                                              imageData4.buffer
                                                                  .asUint8List())))
                                                      : pw.Container(),
                                                ),
                                              ),
                                            ),
                                            pw.Text(
                                              'ลงชื่อ.............................................พยานที่2   ',
                                              textAlign: pw.TextAlign.justify,
                                              style: pw.TextStyle(
                                                fontSize: 10.0,
                                                font: ttf,
                                                fontWeight: pw.FontWeight.bold,
                                              ),
                                            )
                                          ],
                                        ),
                                  pw.SizedBox(height: 2 * PdfPageFormat.mm),
                                  pw.Text(
                                    '( ${_Form4.text} ) ',
                                    textAlign: pw.TextAlign.justify,
                                    style: pw.TextStyle(
                                      fontSize: 10.0,
                                      font: ttf,
                                      fontWeight: pw.FontWeight.bold,
                                    ),
                                  ),
                                  pw.SizedBox(height: 2 * PdfPageFormat.mm),
                                  pw.Text(
                                    'วันที่ $date_string ',
                                    textAlign: pw.TextAlign.justify,
                                    style: pw.TextStyle(
                                      fontSize: 10.0,
                                      font: ttf,
                                      fontWeight: pw.FontWeight.bold,
                                    ),
                                  ),
                                ],
                              )),
                        ]),
                        pw.SizedBox(height: 2 * PdfPageFormat.mm),
                      ];
                    },
                  ),
                );
                return pdf.save();
              },

              allowSharing: false,
              allowPrinting: false, canDebug: false,
              canChangeOrientation: false, canChangePageFormat: false,
              maxPageWidth: MediaQuery.of(context).size.width * 0.6,
              // scrollViewDecoration:,
              initialPageFormat: PdfPageFormat.a4,
              pdfFileName: "เอกสารเช่า.pdf",
            ),
          ),
          actions: <Widget>[
            // Container(
            //   width: 100,
            //   decoration: const BoxDecoration(
            //     color: Colors.blue,
            //     borderRadius: BorderRadius.only(
            //         topLeft: Radius.circular(10),
            //         topRight: Radius.circular(10),
            //         bottomLeft: Radius.circular(10),
            //         bottomRight: Radius.circular(10)),
            //   ),
            //   padding: const EdgeInsets.all(8.0),
            //   child: TextButton(
            //     onPressed: () async {
            //       final List<int> bytes = await pdf.save();
            //       final Uint8List data = Uint8List.fromList(bytes);
            //       await Printing.layoutPdf(
            //         bytes: data,
            //       );
            //     },
            //     child: const Text(
            //       'Print ',
            //       style: TextStyle(
            //           color: Colors.white,
            //           fontWeight: FontWeight.bold,
            //           fontFamily: FontWeight_.Fonts_T),
            //     ),
            //   ),
            // ),
            Container(
              width: 120,
              decoration: const BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
              ),
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                onPressed: () async {
                  final List<int> bytes = await pdf.save();
                  final Uint8List data = Uint8List.fromList(bytes);
                  MimeType type = MimeType.PDF;
                  final dir = await FileSaver.instance
                      .saveFile("เอกสารเช่า", data, "pdf", mimeType: type);
                },
                child: const Text(
                  'download ',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: FontWeight_.Fonts_T),
                ),
              ),
            ),
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
                  'ยกเลิก',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: FontWeight_.Fonts_T),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class RentalInforman_Agreement2 extends StatelessWidget {
  final pw.Document doc;
  final context;

  const RentalInforman_Agreement2({Key? key, required this.doc, this.context})
      : super(key: key);

  static const customSwatch = MaterialColor(
    0xFF8DB95A,
    <int, Color>{
      50: Color(0xFFC2FD7F),
      100: Color(0xFFB6EE77),
      200: Color(0xFFB2E875),
      300: Color(0xFFACDF71),
      400: Color(0xFFA7DA6E),
      500: Color(0xFFA1D16A),
      600: Color(0xFF94BF62),
      700: Color(0xFF90B961),
      800: Color(0xFF85AB5A),
      900: Color(0xFF7A9B54),
    },
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: customSwatch,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          // backgroundColor: Color.fromARGB(255, 141, 185, 90),
          leading: IconButton(
            onPressed: () async {
              // SharedPreferences preferences =
              //     await SharedPreferences.getInstance();
              // preferences.remove('base64Image1');
              // preferences.remove('base64Image2');
              // preferences.remove('base64Image3');
              // preferences.remove('base64Image4');
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_outlined,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          title: const Text(
            "เอกสารเช่า(ต้นฉบับ/ประทับลายมือชื่อดิจิทัลแล้ว)",
            style: TextStyle(
              color: Colors.white,
              fontFamily: Font_.Fonts_T,
            ),
          ),
        ),
        body: PdfPreview(
          build: (format) => doc.save(),
          allowSharing: true,
          allowPrinting: true, canDebug: false,
          canChangeOrientation: false, canChangePageFormat: false,
          maxPageWidth: MediaQuery.of(context).size.width * 0.6,
          // scrollViewDecoration:,
          initialPageFormat: PdfPageFormat.a4,
          pdfFileName: "เอกสารเช่า.pdf",
        ),
      ),
    );
  }
}

class PreviewScreenRentalInforma extends StatelessWidget {
  final pw.Document doc;
  final netImage_;

  const PreviewScreenRentalInforma(
      {Key? key, required this.doc, this.netImage_})
      : super(key: key);

  static const customSwatch = MaterialColor(
    0xFF8DB95A,
    <int, Color>{
      50: Color(0xFFC2FD7F),
      100: Color(0xFFB6EE77),
      200: Color(0xFFB2E875),
      300: Color(0xFFACDF71),
      400: Color(0xFFA7DA6E),
      500: Color(0xFFA1D16A),
      600: Color(0xFF94BF62),
      700: Color(0xFF90B961),
      800: Color(0xFF85AB5A),
      900: Color(0xFF7A9B54),
    },
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: customSwatch,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          // backgroundColor: Color.fromARGB(255, 141, 185, 90),
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back_outlined,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          title: const Text(
            "ข้อมูลผู้เช่า",
            style: TextStyle(
              color: Colors.white,
              fontFamily: Font_.Fonts_T,
            ),
          ),
        ),
        body: PdfPreview(
          build: (format) => doc.save(),
          allowSharing: true,
          allowPrinting: true, canDebug: false,
          canChangeOrientation: false, canChangePageFormat: false,
          maxPageWidth: MediaQuery.of(context).size.width * 0.6,
          // scrollViewDecoration:,
          initialPageFormat: PdfPageFormat.a4,
          pdfFileName: "ข้อมูลผู้เช่า.pdf",
        ),
      ),
    );
  }
}

class PreviewScreenRental_ extends StatelessWidget {
  final title;
  final Url;

  PreviewScreenRental_({Key? key, this.title, this.Url}) : super(key: key);

  static const customSwatch = MaterialColor(
    0xFF8DB95A,
    <int, Color>{
      50: Color(0xFFC2FD7F),
      100: Color(0xFFB6EE77),
      200: Color(0xFFB2E875),
      300: Color(0xFFACDF71),
      400: Color(0xFFA7DA6E),
      500: Color(0xFFA1D16A),
      600: Color(0xFF94BF62),
      700: Color(0xFF90B961),
      800: Color(0xFF85AB5A),
      900: Color(0xFF7A9B54),
    },
  );
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();

  Future<void> downloadPdf(String pdfUrl) async {
    var response = await http.get(Uri.parse(pdfUrl));
    var blob = html.Blob([response.bodyBytes]);
    var url = html.Url.createObjectUrlFromBlob(blob);
    var anchor = html.document.createElement('a') as html.AnchorElement
      ..href = url
      ..download = '$title.pdf';
    html.document.body?.append(anchor);
    anchor.click();
    html.Url.revokeObjectUrl(url);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: customSwatch,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          // backgroundColor: Color.fromARGB(255, 141, 185, 90),
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back_outlined,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          title: Text(
            title.toString(),
            style: const TextStyle(
              color: Colors.white,
              fontFamily: Font_.Fonts_T,
            ),
          ),
          // actions: <Widget>[
          //   IconButton(
          //     icon: Icon(
          //       Icons.zoom_in,
          //       color: Colors.white,
          //     ),
          //     onPressed: () async {
          //       // String pdfUrl = Url.toString();
          //       downloadPdf(Url);
          //     },
          //   ),
          // ],
        ),
        body: Column(
          children: [
            Expanded(
              child: SfPdfViewer.network(
                Url.toString(),
                enableDocumentLinkAnnotation: false,
                key: _pdfViewerKey,
                canShowScrollHead: false,
                canShowScrollStatus: false,
                pageLayoutMode: PdfPageLayoutMode.continuous,
              ),
            ),
            // SizedBox(height: 16),
            AppBar(
              // foregroundColor: Color.fromARGB(255, 141, 185, 90),
              // surfaceTintColor: Color.fromARGB(255, 141, 185, 90),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(),
                  IconButton(
                    icon: const Icon(Icons.print),
                    onPressed: _launchUrl,
                  ),
                  const SizedBox(),
                  IconButton(
                      icon: const Icon(Icons.share),
                      onPressed: () {
                        downloadPdf(Url);
                      }),
                  const SizedBox(),
                ],
              ),
              centerTitle: true,
              elevation: 0,
              backgroundColor: const Color.fromARGB(255, 141, 185, 90),
            ),
          ],
        ),

        // floatingActionButton: Container(
        //   color: Color.fromARGB(255, 141, 185, 90),
        //   width: MediaQuery.of(context).size.width,
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //     children: [
        //       SizedBox(),
        //       IconButton(
        //         icon: Icon(Icons.print),
        //         onPressed: () {
        //           html.window.print();
        //         },
        //       ),
        //       SizedBox(),
        //       IconButton(
        //         icon: Icon(Icons.download),
        //         onPressed: () {
        //           downloadPdf(Url.toString());
        //         },
        //       ),
        //       SizedBox(),
        //     ],
        //   ),
        // ),
      ),
    );
  }

  Future<void> _launchUrl() async {
    // const url = Url;
    // const url = "https://flutter.io";
    js.context.callMethod('open', ['$Url']);
  }
}
