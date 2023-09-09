// ignore_for_file: unused_import, unused_local_variable, unnecessary_null_comparison, unused_field, override_on_non_overriding_member, duplicate_import, must_be_immutable, body_might_complete_normally_nullable
import 'dart:convert';
import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:grouped_buttons_ns/grouped_buttons_ns.dart';
import 'package:im_stepper/stepper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:printing/printing.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../AdminScaffold/AdminScaffold.dart';
import '../Constant/Myconstant.dart';
import '../INSERT_Log/Insert_log.dart';
import '../Model/GetArea_IMG_model.dart';
import '../Model/GetArea_Model.dart';
import '../Model/GetC_Quot_Model.dart';
import '../Model/GetC_Quot_Select_Model.dart';
import '../Model/GetCustomer_Model.dart';
import '../Model/GetExpType_Model.dart';
import '../Model/GetExp_Model.dart';
import '../Model/GetExp_type_auto.dart';
import '../Model/GetQuotx_Model.dart';
import '../Model/GetRenTal_Model.dart';
import '../Model/GetRentalType_Model.dart';
import '../Model/GetType_Model.dart';
import '../Model/GetUnit_Model.dart';
import '../Model/GetUnitx_Model.dart';
import '../Model/GetVat_Model.dart';
import '../Model/GetWht_Model.dart';
import '../PDF/pdf_DataChaoArea.dart';
import '../PDF/pdf_Quotation2.dart';
import '../Responsive/responsive.dart';
import '../Style/colors.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class ChaoAreaBidScreen extends StatefulWidget {
  final Get_Value_area_index;
  final Get_Value_area_ln;
  final Get_Value_area_sum;
  final Get_Value_rent_sum;
  final Get_Value_page;

  const ChaoAreaBidScreen({
    super.key,
    this.Get_Value_area_index,
    this.Get_Value_area_ln,
    this.Get_Value_area_sum,
    this.Get_Value_rent_sum,
    this.Get_Value_page,
  });

  @override
  State<ChaoAreaBidScreen> createState() => _ChaoAreaBidScreenState();
}

class _ChaoAreaBidScreenState extends State<ChaoAreaBidScreen> {
  ///------------------------------------------------------------>
  var nFormat = NumberFormat("#,##0.00", "en_US");
  final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);

  List<Map<String, dynamic>> newValuePDF = [];

  List newValuePDFimg = [];
  DateTime _dateTime = DateTime.now();
  List<AreaModel> areaModels = [];
  List<AreaModel> _areaModels = <AreaModel>[];
  String? renTal_user,
      renTal_name,
      zone_ser,
      zone_name,
      number_custno,
      fname_user,
      lname_user,
      Value_D_read;

  List _selecteSer = [];
  List<String> _selecteSerbool = [];
  List<TypeModel> typeModels = [];
  List<CQuotModel> cQuotModels = [];
  List<ExpTypeModel> expTypeModels = [];
  List<ExpModel> expModels = [];
  List<AreaIMGModel> areaIMGModels = [];
  List<QuotxSelectModel> quotxSelectModels = [];
  List<UnitModel> unitModels = [];
  List<UnitxModel> unitxModels = [];
  List<VatModel> vatModels = [];
  List<WhtModel> whtModels = [];
  List<RentalTypeModel> rental_type_ = [];
  List<CustomerModel> customerModels = [];
  List<CustomerModel> _customerModels = <CustomerModel>[];
  double _area_sum = 0;
  double _area_rent_sum = 0;
  int select_coutumerindex = 0;
  String? se_ser;
  int unit_ser = 0;
  List<String> dates =
      ('01,02,03,04,05,06,07,08,09,10,11,12,13,14,15,16,18,17,19,20,21,22,23,24,25,26,27,28,29,30,31'
          .split(','));
  List<String> dateselect = [];
  List<RenTalModel> renTalModels = [];
  List<ExpAutoModel> expAutoModels = [];
  String? teNantcid, teNantsname, teNantnamenew;
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
      numinvoice;
  @override
  void initState() {
    super.initState();
    read_GC_areaSelect();
    read_customer();
    read_GC_type();
    read_GC_ExpType();
    read_GC_unit();
    read_GC_vat();
    read_GC_wht();
    read_rental_type();
    read_GC_rental();
    read_GC_ExpAuto();
    Value_D_read = DateFormat('yyyy-MM-dd').format(_dateTime);
    _areaModels = areaModels;
    _customerModels = customerModels;
    for (int i = 0; i < dates.length; i++) {
      dateselect.add(dates[i]);
    }
    if (widget.Get_Value_page == '1') {
      _area_sum = _area_sum + double.parse(widget.Get_Value_area_sum);
      _area_rent_sum = _area_rent_sum + double.parse(widget.Get_Value_rent_sum);
      _selecteSer.add('${widget.Get_Value_area_index}');
      _selecteSerbool.add('${widget.Get_Value_area_ln}');
    }
    print('ssss>>>> $_area_sum    $_area_rent_sum');
    print(
        'aaaa>>>> ${_selecteSerbool.map((e) => e)}    ${_selecteSer.map((e) => e)} ');
  }

  Future<Null> read_GC_ExpAuto() async {
    if (expAutoModels.isNotEmpty) {
      expAutoModels.clear();
      ser_exp = null;
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
          ExpAutoModel expAutoModel = ExpAutoModel.fromJson(map);

          setState(() {
            expAutoModels.add(expAutoModel);
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
    renTal_name = preferences.getString('renTalName');
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print(result);
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
            if (bill_defaultx == 'P') {
              bills_name_ = 'บิลธรรมดา';
            } else {
              bills_name_ = 'ใบกำกับภาษี';
            }
          });
        }
      } else {}
    } catch (e) {}
    print('name>>>>>  $renname');
  }

  Future<Null> read_customer() async {
    if (customerModels.isNotEmpty) {
      setState(() {
        customerModels.clear();
      });
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? ren = preferences.getString('renTalSer');
    String url = '${MyConstant().domain}/GC_custo_se.php?isAdd=true&ren=$ren';
    fname_user = preferences.getString('fname');
    renTal_name = preferences.getString('renTalName');

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print(result);
      if (result.toString() != 'null') {
        for (var map in result) {
          CustomerModel customerModel = CustomerModel.fromJson(map);
          setState(() {
            customerModels.add(customerModel);
          });
        }
      }
      print(customerModels.map((e) => e.scname));
      setState(() {
        _customerModels = customerModels;
      });
      print(_customerModels.map((e) => e.scname));
    } catch (e) {}
  }

  Future<Null> read_rental_type() async {
    if (rental_type_.isNotEmpty) {
      rental_type_.clear();
    }

    String url = '${MyConstant().domain}/GC_rental_type.php?isAdd=true';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print(result);
      if (result != null) {
        for (var map in result) {
          RentalTypeModel rentalTypeModel = RentalTypeModel.fromJson(map);
          setState(() {
            rental_type_.add(rentalTypeModel);
          });
        }
      } else {}
    } catch (e) {}
  }

  Future<Null> read_GC_wht() async {
    if (whtModels.isNotEmpty) {
      whtModels.clear();
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    String url = '${MyConstant().domain}/GC_wht.php?isAdd=true&ren=$ren';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print(result);
      if (result != null) {
        for (var map in result) {
          WhtModel whtModel = WhtModel.fromJson(map);
          setState(() {
            whtModels.add(whtModel);
          });
        }
      } else {}
    } catch (e) {}
  }

  Future<Null> read_GC_vat() async {
    if (vatModels.isNotEmpty) {
      vatModels.clear();
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    String url = '${MyConstant().domain}/GC_vat.php?isAdd=true&ren=$ren';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print(result);
      if (result != null) {
        for (var map in result) {
          VatModel vatModel = VatModel.fromJson(map);
          setState(() {
            vatModels.add(vatModel);
          });
        }
      } else {}
    } catch (e) {}
  }

  Future<Null> read_GC_unit() async {
    if (unitModels.isNotEmpty) {
      unitModels.clear();
      unitxModels.clear();
    }

    String url = '${MyConstant().domain}/GC_unit.php?isAdd=true';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print(result);
      if (result != null) {
        for (var map in result) {
          UnitModel unitModel = UnitModel.fromJson(map);
          UnitxModel unitxModel = UnitxModel.fromJson(map);

          setState(() {
            if (unitModel.ser == '1' ||
                unitModel.ser == '2' ||
                unitModel.ser == '3' ||
                unitModel.ser == '4' ||
                unitModel.ser == '5') {
              unitModels.add(unitModel);
            }
            // unitModels.add(unitModel);
            if (unitxModel.ser == '5' ||
                unitxModel.ser == '6' ||
                unitxModel.ser == '7') {
              unitxModels.add(unitxModel);
            }
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

  Future<Null> read_GC_ExpType() async {
    if (expTypeModels.isNotEmpty) {
      expTypeModels.clear();
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var ren = preferences.getString('renTalSer');

    String url = '${MyConstant().domain}/GC_exptype.php?isAdd=true&ren=$ren';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print(result);
      if (result != null) {
        for (var map in result) {
          ExpTypeModel expTypeModel = ExpTypeModel.fromJson(map);
          setState(() {
            expTypeModels.add(expTypeModel);
          });
        }
        setState(() {
          _scrollControllers =
              List.generate(expTypeModels.length, (_) => ScrollController());
        });
      } else {}
    } catch (e) {}
  }

  String? ser_exp;

  Future<Null> read_GC_Exp(serx) async {
    if (expModels.isNotEmpty) {
      expModels.clear();
      ser_exp = null;
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var ren = preferences.getString('renTalSer');

    String url =
        '${MyConstant().domain}/GC_exp.php?isAdd=true&ren=$ren&serx=$serx';

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

  Future<Null> read_GC_areaSelectSer() async {
    if (cQuotModels.length != 0) {
      cQuotModels.clear();
      se_ser = null;
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var ren = preferences.getString('renTalSer');
    var zone = preferences.getString('zoneSer');

    for (var i = 0; i < _selecteSer.length; i++) {
      var sAser = _selecteSer[i];
      String url =
          '${MyConstant().domain}/GC_areaSelect.php?isAdd=true&ren=$ren&sAser=$sAser';

      try {
        var response = await http.get(Uri.parse(url));

        var result = json.decode(response.body);
        print(result);
        if (result != null) {
          for (var map in result) {
            CQuotModel cQuotModel = CQuotModel.fromJson(map);
            print('ddddddd>>>>>>>ddd$se_ser');
            if (se_ser == null) {
              setState(() {
                se_ser = cQuotModel.docno;
                cQuotModels.add(cQuotModel);
              });
            } else if (se_ser != cQuotModel.docno) {
              setState(() {
                se_ser = cQuotModel.docno;
                cQuotModels.add(cQuotModel);
              });
            } else {
              // setState(() {
              //   se_ser = cQuotModel.docno;
              //   cQuotModels.add(cQuotModel);
              // });
              // break;
            }
          }
        }
      } catch (e) {}
    }
    setState(() {
      read_GC_areaSelectSerimg();
    });
  }

  Future<Null> read_GC_areaSelectSerimg() async {
    if (areaIMGModels.length != 0) {
      areaIMGModels.clear();
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var ren = preferences.getString('renTalSer');
    var zone = preferences.getString('zoneSer');

    for (var i = 0; i < _selecteSer.length; i++) {
      var sAser = _selecteSer[i];
      String url =
          '${MyConstant().domain}/GC_areaSelectIMG.php?isAdd=true&ren=$ren&sAser=$sAser';

      try {
        var response = await http.get(Uri.parse(url));

        var result = json.decode(response.body);
        print(result);
        if (result != null) {
          for (var map in result) {
            AreaIMGModel areaIMGModel = AreaIMGModel.fromJson(map);

            setState(() {
              areaIMGModels.add(areaIMGModel);
            });
          }
        }
      } catch (e) {}
    }
  }

  Future<Null> read_GC_areaSelect() async {
    if (areaModels.length != 0) {
      areaModels.clear();
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var ren = preferences.getString('renTalSer');
    var zone = preferences.getString('zoneSer');

    String url = zone == null
        ? '${MyConstant().domain}/GC_areaAll.php?isAdd=true&ren=$ren&zone=$zone'
        : zone == '0'
            ? '${MyConstant().domain}/GC_areaAll.php?isAdd=true&ren=$ren&zone=$zone'
            : '${MyConstant().domain}/GC_area.php?isAdd=true&ren=$ren&zone=$zone';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print(result);
      if (result != null) {
        for (var map in result) {
          AreaModel areaModel = AreaModel.fromJson(map);
          if (areaModel.quantity != '1' && areaModel.quantity != '3') {
            setState(() {
              areaModels.add(areaModel);
            });
          }
        }
      } else {
        setState(() {
          if (areaModels.isEmpty) {
            preferences.remove('zoneSer');
            preferences.remove('zonesName');
            zone_ser = null;
            zone_name = null;
          }
        });
      }
      setState(() {
        _areaModels = areaModels;
        zone_ser = preferences.getString('zoneSer');
        zone_name = preferences.getString('zonesName');
      });
    } catch (e) {}
  }

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

  ///------------------------------------------------------------>(stepper)
  int activeStep = 0; // stepper

  ///------------------------------------------------------------>(stepper1)

  String _verticalGroupValue = '';
  int Value_AreaSer_ = 0;

  ///------------------------------------------------------------>(stepper2)

  Future<void> chooseImageStep2() async {
    final ImagePicker _picker = ImagePicker();
    // var choosedimage = await ImagePicker.pickImage(source: ImageSource.gallery);
    final XFile? photo = await _picker.pickImage(source: ImageSource.gallery);
    //set source: ImageSource.camera to get image from camera
    if (photo == null) return;
    // read picked image byte data.
    Uint8List imagebytes = await photo.readAsBytes();
    // using base64 encoder convert image into base64 string.
    String _base64String1 = base64.encode(imagebytes);
    // print(_base64String1);
    setState(() {
      imageStep2_base64 = _base64String1;
    });
  }

  Future<void> _uploadFile_Step2() async {
    String imageStep2_base64_new = '0';
    Random randomx = Random();
    int ix = randomx.nextInt(1000000);
    String uploadurl = "${MyConstant().domain}/xxxxxxx.php";
    String fileName1 = 'img_2_$ix.jpg';
    try {
      setState(() {
        imageStep2_base64_new = fileName1;
      });
      var response = await http.post(Uri.parse(uploadurl), body: {
        'image': imageStep2_base64,
        'name': fileName1,
      });

      if (response.statusCode == 200) {
        var jsondata = json.decode(response.body);
        if (jsondata["error"]) {
          //  print(jsondata["msg"]);
        } else {
          //  print("Upload successful");
        }
      } else {
        // print("Error during connection to server");
      }
    } catch (e) {}
  }

  ///------------------------------------------------------------>(stepper3)
  ///------------------------------------------------------------>(stepper3)
  late List<ScrollController> _scrollControllers;
  List<String> Step3_tappedIndex_ = List.generate(5, (index) => '');
  ScrollController _scrollController6 =
      ScrollController(); // ตารางสรุปค่าบริการ
  String Strp3_tappedIndex6 = ''; // ตารางสรุปค่าบริการ

  ///----------------->
  _moveUp6() {
    // ตารางสรุปค่าบริการ
    _scrollController6.animateTo(_scrollController6.offset - 220,
        curve: Curves.linear, duration: const Duration(milliseconds: 500));
  }

  _moveDown6() {
    // ตารางสรุปค่าบริการ
    _scrollController6.animateTo(_scrollController6.offset + 220,
        curve: Curves.linear, duration: const Duration(milliseconds: 500));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: Color(0xfff3f3ee),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const AutoSizeText(
                          minFontSize: 10,
                          maxFontSize: 15,
                          'รหัสพื้นที่ ',
                          style: TextStyle(
                            color: PeopleChaoScreen_Color.Colors_Text1_,
                            // fontWeight: FontWeight.bold,
                            fontFamily: FontWeight_.Fonts_T,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        InkWell(
                          child: Container(
                            width: 150,
                            decoration: BoxDecoration(
                              color: AppbackgroundColor.TiTile_Colors,
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10)),
                              border: Border.all(color: Colors.black, width: 1),
                            ),
                            padding: const EdgeInsets.all(8.0),
                            child: AutoSizeText(
                              minFontSize: 10,
                              maxFontSize: 15,
                              maxLines: 1,
                              _selecteSer.length == 0
                                  ? 'เลือก'
                                  : '${_selecteSerbool.map((e) => e).toString().substring(1, _selecteSerbool.map((e) => e).toString().length - 1)}',
                              style: const TextStyle(
                                color: PeopleChaoScreen_Color.Colors_Text1_,
                                // fontWeight: FontWeight.bold,
                                fontFamily: FontWeight_.Fonts_T,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          onTap: () {
                            showDialog<String>(
                              barrierDismissible: false,
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(20.0))),
                                title: const Center(
                                    child: Text(
                                  'เลือกพื้นที่',
                                  style: TextStyle(
                                    color: PeopleChaoScreen_Color.Colors_Text1_,
                                    // fontWeight: FontWeight.bold,
                                    fontFamily: FontWeight_.Fonts_T,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                                content: SingleChildScrollView(
                                  child: ListBody(children: <Widget>[
                                    Container(
                                        // width: 400,
                                        child: StreamBuilder(
                                            stream: Stream.periodic(
                                                const Duration(seconds: 0)),
                                            builder: (context, snapshot) {
                                              return CheckboxGroup(
                                                  checked: _selecteSerbool,
                                                  activeColor: Colors.red,
                                                  checkColor: Colors.white,
                                                  labels: <String>[
                                                    for (var i = 0;
                                                        i < areaModels.length;
                                                        i++)
                                                      '${areaModels[i].lncode}',
                                                  ],
                                                  onChange: (isChecked, label,
                                                      index) {
                                                    if (isChecked == false) {
                                                      _selecteSer.remove(
                                                          areaModels[index]
                                                              .ser);

                                                      double areax =
                                                          double.parse(
                                                              areaModels[index]
                                                                  .area!);
                                                      double rentx =
                                                          double.parse(
                                                              areaModels[index]
                                                                  .rent!);
                                                      _area_sum =
                                                          _area_sum - areax;
                                                      _area_rent_sum =
                                                          _area_rent_sum -
                                                              rentx;

                                                      if (isChecked == true) {
                                                        setState(() {
                                                          _area_sum =
                                                              _area_sum + areax;
                                                          _area_rent_sum =
                                                              _area_rent_sum +
                                                                  rentx;
                                                          _selecteSer.add(
                                                              areaModels[index]
                                                                  .ser);
                                                        });
                                                      }
                                                    } else {
                                                      double areax =
                                                          double.parse(
                                                              areaModels[index]
                                                                  .area!);
                                                      double rentx =
                                                          double.parse(
                                                              areaModels[index]
                                                                  .rent!);
                                                      if (isChecked == true) {
                                                        setState(() {
                                                          _area_sum =
                                                              _area_sum + areax;
                                                          _area_rent_sum =
                                                              _area_rent_sum +
                                                                  rentx;
                                                          _selecteSer.add(
                                                              areaModels[index]
                                                                  .ser);
                                                        });
                                                      }
                                                    }
                                                    print(
                                                        'เลือกพื้นที่ :  ${_selecteSer.map((e) => e)}  : _area_sum = $_area_sum _area_rent_sum = $_area_rent_sum ');
                                                  },
                                                  onSelected:
                                                      (List<String> selected) {
                                                    setState(() {
                                                      _selecteSerbool =
                                                          selected;
                                                    });
                                                    print(
                                                        'SerGetBankModels_ : ${_selecteSerbool}');
                                                  });
                                            }))
                                  ]),
                                ),
                                actions: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: 100,
                                                decoration: const BoxDecoration(
                                                  color: Colors.green,
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
                                                ),
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: TextButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      read_GC_areaSelectSer();
                                                    });
                                                    Navigator.pop(
                                                        context, 'OK');
                                                  },
                                                  child: const Text(
                                                    'บันทึก',
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
                                            ],
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
                                                bottomRight:
                                                    Radius.circular(10)),
                                          ),
                                          padding: const EdgeInsets.all(8.0),
                                          child: TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                              setState(() {
                                                cQuotModels.clear();
                                                _selecteSer.clear();
                                                _selecteSerbool.clear();
                                              });
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
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            const AutoSizeText(
                              minFontSize: 10,
                              maxFontSize: 15,
                              'วันที่ ',
                              maxLines: 1,
                              style: TextStyle(
                                color: PeopleChaoScreen_Color.Colors_Text1_,
                                // fontWeight: FontWeight.bold,
                                fontFamily: FontWeight_.Fonts_T,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                                width: 150,
                                decoration: BoxDecoration(
                                  color: AppbackgroundColor.TiTile_Colors,
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10)),
                                  border:
                                      Border.all(color: Colors.black, width: 1),
                                ),
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: () async {
                                    DateTime? newDate = await showDatePicker(
                                      // locale: const Locale('th', 'TH'),
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1000, 1, 01),
                                      lastDate: DateTime.now()
                                          .add(const Duration(days: 50)),
                                      builder: (context, child) {
                                        return Theme(
                                          data: Theme.of(context).copyWith(
                                            colorScheme:
                                                const ColorScheme.light(
                                              primary: AppBarColors
                                                  .ABar_Colors, // header background color
                                              onPrimary: Colors
                                                  .white, // header text color
                                              onSurface: Colors
                                                  .black, // body text color
                                            ),
                                            textButtonTheme:
                                                TextButtonThemeData(
                                              style: TextButton.styleFrom(
                                                primary: Colors
                                                    .black, // button text color
                                              ),
                                            ),
                                          ),
                                          child: child!,
                                        );
                                      },
                                    );

                                    if (newDate == null) {
                                      return;
                                    } else {
                                      print('$newDate');
                                      String start = DateFormat('yyyy-MM-dd')
                                          .format(newDate);
                                      setState(() {
                                        Value_D_read = start;
                                      });
                                    }
                                  },
                                  child: Container(
                                    child: AutoSizeText(
                                      Value_D_read == ''
                                          ? '${DateFormat('dd').format(_dateTime)}/${DateFormat('MM').format(_dateTime)}/${(int.parse(DateFormat('yyyy').format(_dateTime))) + 543}'
                                          : '${DateFormat('dd').format(DateTime.parse('$Value_D_read 00:00:00'))}/${DateFormat('MM').format(DateTime.parse('$Value_D_read 00:00:00'))}/${(int.parse(DateFormat('yyyy').format(DateTime.parse('$Value_D_read 00:00:00')))) + 543}',
                                      minFontSize: 9,
                                      maxFontSize: 16,
                                      textAlign: TextAlign.start,
                                      style: const TextStyle(
                                        color: PeopleChaoScreen_Color
                                            .Colors_Text2_,

                                        fontFamily: FontWeight_.Fonts_T,
                                        //fontWeight: FontWeight.bold,
                                        //fontSize: 10.0
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                )
                                // AutoSizeText(
                                //   minFontSize: 10,
                                //   maxFontSize: 15,
                                //   maxLines: 1,
                                //   '${DateFormat('dd').format(_dateTime)}/${DateFormat('MM').format(_dateTime)}/${(int.parse(DateFormat('yyyy').format(_dateTime))) + 543}',
                                //   style: const TextStyle(
                                //     color: PeopleChaoScreen_Color.Colors_Text1_,
                                //     // fontWeight: FontWeight.bold,
                                //     fontFamily: FontWeight_.Fonts_T,
                                //     fontWeight: FontWeight.bold,
                                //   ),
                                // ),
                                ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              cQuotModels.length == 0
                  ? const SizedBox()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          height: 400,
                          width: 1000,
                          child: Column(children: [
                            Container(
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(0),
                                    bottomRight: Radius.circular(0)),
                                border:
                                    Border.all(color: Colors.grey, width: 1),
                              ),
                              child: Table(children: const [
                                TableRow(children: [
                                  TableCell(
                                    child: AutoSizeText(
                                      'ร้านค้า',
                                      minFontSize: 10,
                                      maxFontSize: 20,
                                      maxLines: 1,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: PeopleChaoScreen_Color
                                            .Colors_Text1_,
                                        // fontWeight: FontWeight.bold,
                                        fontFamily: FontWeight_.Fonts_T,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  TableCell(
                                      child: AutoSizeText(
                                    'ชื่อผู้ติดต่อ',
                                    minFontSize: 10,
                                    maxFontSize: 20,
                                    maxLines: 1,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color:
                                          PeopleChaoScreen_Color.Colors_Text1_,
                                      // fontWeight: FontWeight.bold,
                                      fontFamily: FontWeight_.Fonts_T,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )),
                                  TableCell(
                                      child: AutoSizeText(
                                    'โซน',
                                    minFontSize: 10,
                                    maxFontSize: 20,
                                    maxLines: 1,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color:
                                          PeopleChaoScreen_Color.Colors_Text1_,
                                      // fontWeight: FontWeight.bold,
                                      fontFamily: FontWeight_.Fonts_T,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )),
                                  TableCell(
                                      child: AutoSizeText(
                                    'รหัสพื้นที่',
                                    minFontSize: 10,
                                    maxFontSize: 20,
                                    maxLines: 1,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color:
                                          PeopleChaoScreen_Color.Colors_Text1_,
                                      // fontWeight: FontWeight.bold,
                                      fontFamily: FontWeight_.Fonts_T,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )),
                                  TableCell(
                                      child: AutoSizeText(
                                    'เลขที่เอกสาร',
                                    minFontSize: 10,
                                    maxFontSize: 20,
                                    maxLines: 1,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color:
                                          PeopleChaoScreen_Color.Colors_Text1_,
                                      // fontWeight: FontWeight.bold,
                                      fontFamily: FontWeight_.Fonts_T,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )),
                                  TableCell(
                                      child: AutoSizeText(
                                    'เรียกดู',
                                    minFontSize: 10,
                                    maxFontSize: 20,
                                    maxLines: 1,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color:
                                          PeopleChaoScreen_Color.Colors_Text1_,
                                      // fontWeight: FontWeight.bold,
                                      fontFamily: FontWeight_.Fonts_T,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )),
                                ]),
                              ]),
                            ),
                            SizedBox(
                                height: 300,
                                child: ListView.builder(
                                  itemCount: cQuotModels.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Table(children: [
                                      TableRow(children: [
                                        TableCell(
                                          child: Container(
                                            padding: const EdgeInsets.all(10),
                                            child: AutoSizeText(
                                              '${cQuotModels[index].sname}',
                                              minFontSize: 10,
                                              maxFontSize: 20,
                                              maxLines: 1,
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                color: PeopleChaoScreen_Color
                                                    .Colors_Text1_,
                                                // fontWeight: FontWeight.bold,
                                                fontFamily: FontWeight_.Fonts_T,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                        TableCell(
                                            child: Container(
                                          padding: const EdgeInsets.all(10),
                                          child: AutoSizeText(
                                            '${cQuotModels[index].attn}',
                                            minFontSize: 10,
                                            maxFontSize: 20,
                                            maxLines: 1,
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              color: PeopleChaoScreen_Color
                                                  .Colors_Text1_,
                                              // fontWeight: FontWeight.bold,
                                              fontFamily: FontWeight_.Fonts_T,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        )),
                                        TableCell(
                                            child: Container(
                                          padding: const EdgeInsets.all(10),
                                          child: AutoSizeText(
                                            '${cQuotModels[index].zn}',
                                            minFontSize: 10,
                                            maxFontSize: 20,
                                            maxLines: 1,
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              color: PeopleChaoScreen_Color
                                                  .Colors_Text1_,
                                              // fontWeight: FontWeight.bold,
                                              fontFamily: FontWeight_.Fonts_T,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        )),
                                        TableCell(
                                            child: Container(
                                          padding: const EdgeInsets.all(10),
                                          child: AutoSizeText(
                                            '${cQuotModels[index].ln}',
                                            minFontSize: 10,
                                            maxFontSize: 20,
                                            maxLines: 1,
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              color: PeopleChaoScreen_Color
                                                  .Colors_Text1_,
                                              // fontWeight: FontWeight.bold,
                                              fontFamily: FontWeight_.Fonts_T,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        )),
                                        TableCell(
                                            child: Container(
                                          padding: const EdgeInsets.all(10),
                                          child: AutoSizeText(
                                            '${cQuotModels[index].docno}',
                                            minFontSize: 10,
                                            maxFontSize: 20,
                                            maxLines: 1,
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              color: PeopleChaoScreen_Color
                                                  .Colors_Text1_,
                                              // fontWeight: FontWeight.bold,
                                              fontFamily: FontWeight_.Fonts_T,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        )),
                                        TableCell(
                                            child: GestureDetector(
                                          onTap: () async {
                                            print('view $index');

                                            var CQuotModels =
                                                cQuotModels[index];

                                            // _displayPdf(CQuotModels);
                                            // generatePdf();
                                          },
                                          child: Container(
                                            color: const Color(0xFFD9D9B7),
                                            padding: const EdgeInsets.all(10),
                                            child: const AutoSizeText(
                                              'view',
                                              minFontSize: 10,
                                              maxFontSize: 20,
                                              maxLines: 1,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: PeopleChaoScreen_Color
                                                    .Colors_Text1_,
                                                // fontWeight: FontWeight.bold,
                                                fontFamily: FontWeight_.Fonts_T,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        )),
                                      ]),
                                    ]);
                                  },
                                )),
                            const Divider(),
                          ]),
                        ),
                      ],
                    ),
              Center(
                child: Text(headerText(),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                    style: const TextStyle(
                      fontSize: 30,
                      color: PeopleChaoScreen_Color.Colors_Text1_,
                      // fontWeight: FontWeight.bold,
                      fontFamily: FontWeight_.Fonts_T,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              const SizedBox(
                height: 20,
              ),
              IconStepper(
                enableNextPreviousButtons: false,
                enableStepTapping: false,
                icons: const [
                  Icon(Icons.filter_1),
                  Icon(Icons.filter_2),
                  Icon(Icons.filter_3),
                ],

                // activeStep property set to activeStep variable defined above.
                activeStep: activeStep,

                // This ensures step-tapping updates the activeStep.
                onStepReached: (index) {
                  setState(() {
                    activeStep = index;
                  });
                },
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // (activeStep == 2)
                    //     ? InkWell(
                    //         onTap: () async {
                    //           setState(() {
                    //             newValuePDF = [];
                    //           });
                    //           setState(() {
                    //             newValuePDFimg.clear();
                    //             newValuePDFimg = [];
                    //           });

                    //           for (int index = 0;
                    //               index < areaIMGModels.length;
                    //               index++) {
                    //             print('${areaIMGModels[index].img!.trim()}');
                    //             if (areaIMGModels[index].img!.trim() == '') {
                    //               newValuePDFimg.add(
                    //                   'https://png.pngtree.com/png-vector/20190820/ourmid/pngtree-no-image-vector-illustration-isolated-png-image_1694547.jpg');
                    //             } else {
                    //               newValuePDFimg.add(
                    //                   '${MyConstant().domain}/${areaIMGModels[index].img!.trim()}');
                    //             }
                    //           }

                    //           ///-------------------->
                    //           List newValuePDFimg2 = [];
                    //           for (int index = 0; index < 1; index++) {
                    //             if (renTalModels[0].imglogo!.trim() == '' ||
                    //                 renTalModels[0].imglogo!.trim() == 'null' ||
                    //                 renTalModels[0].imglogo!.trim() == 'Null') {
                    //               // newValuePDFimg.add(
                    //               //     'https://png.pngtree.com/png-vector/20190820/ourmid/pngtree-no-image-vector-illustration-isolated-png-image_1694547.jpg');
                    //             } else {
                    //               newValuePDFimg2.add(
                    //                   '${MyConstant().domain}/files/$foder/logo/${renTalModels[0].imglogo!.trim()}');
                    //             }
                    //           }

                    //           ///-------------------->
                    //           for (int index = 0;
                    //               index < quotxSelectModels.length;
                    //               index++) {
                    //             for (var i = 0;
                    //                 i <
                    //                     int.parse(
                    //                         quotxSelectModels[index].term!);
                    //                 i++) {
                    //               Map<String, dynamic> valueMap = {
                    //                 'serial': i + 1,
                    //                 'date':
                    //                     '${DateFormat('dd').format(DateTime.parse('${quotxSelectModels[index].sdate!} 00:00:00'))}-${DateFormat('MM-yyyy').format(DateTime.parse('${quotxSelectModels[index].sdate!} 00:00:00').add(Duration(days: int.parse('${quotxSelectModels[index].day}') * i)))}',
                    //                 'expname':
                    //                     '${quotxSelectModels[index].expname!}',
                    //                 'vtype':
                    //                     '${quotxSelectModels[index].vtype!}',
                    //                 'nvat':
                    //                     '${quotxSelectModels[index].nvat!} %',
                    //                 'vat': '${quotxSelectModels[index].vat!}',
                    //                 'pvat':
                    //                     '${nFormat.format(double.parse(quotxSelectModels[index].pvat!))}',
                    //                 'nwht': '${quotxSelectModels[index].nwht!}',
                    //                 'wht': '${quotxSelectModels[index].wht!}',
                    //                 'total':
                    //                     '${nFormat.format(double.parse(quotxSelectModels[index].total!))}',
                    //               };
                    //               newValuePDF.add(valueMap);
                    //             }
                    //           }
                    //           // for (int i = 0; i < newValue.length; i++) {
                    //           //   print(
                    //           //       '${newValue[i]['serial']},${newValue[i]['expname']}');
                    //           // }
                    //           Pdfgen_Quotation2.exportPDF_Quotation2(
                    //               context,
                    //               '${_selecteSerbool.map((e) => e).toString().substring(1, _selecteSerbool.map((e) => e).toString().length - 1)}',
                    //               '${nFormat.format(_area_sum)}',
                    //               '$Value_DateTime_Step2',
                    //               '$Value_DateTime_end',
                    //               '$Value_rental_count_',
                    //               '$Value_rental_type_',
                    //               '${Form_nameshop.text}',
                    //               '${Form_bussshop.text}',
                    //               '${_Form_address}',
                    //               '${Form_tel.text}',
                    //               '${Form_email.text}',
                    //               '${Form_tax.text}',
                    //               expTypeModels,
                    //               quotxSelectModels,
                    //               fname_user,
                    //               renTal_name,
                    //               newValuePDF,
                    //               newValuePDFimg,
                    //               newValuePDFimg2,
                    //               '${renTalModels[0].bill_addr}',
                    //               '${renTalModels[0].bill_email}',
                    //               '${renTalModels[0].bill_tel}',
                    //               '${renTalModels[0].bill_tax}',
                    //               '{cQuotModel.docno}',
                    //               '');
                    //         },
                    //         child: Container(
                    //           width: 150,
                    //           height: 50,
                    //           decoration: const BoxDecoration(
                    //             color: Colors.blue,
                    //             borderRadius: BorderRadius.only(
                    //                 topLeft: Radius.circular(10),
                    //                 topRight: Radius.circular(10),
                    //                 bottomLeft: Radius.circular(10),
                    //                 bottomRight: Radius.circular(10)),
                    //           ),
                    //           child: const Center(
                    //             child: Text('พิมพ์ใบเสนอราคา',
                    //                 maxLines: 3,
                    //                 overflow: TextOverflow.ellipsis,
                    //                 softWrap: false,
                    //                 style: TextStyle(
                    //                     fontSize: 15,
                    //                     color: Colors.white,
                    //                     fontWeight: FontWeight.bold,
                    //                     fontFamily: FontWeight_.Fonts_T)),
                    //           ),
                    //         ),
                    //       )
                    //     : const SizedBox(),
                    (activeStep == 1)
                        ? InkWell(
                            onTap: () async {
                              setState(() {
                                newValuePDFimg.clear();
                                newValuePDFimg = [];
                              });

                              for (int index = 0;
                                  index < areaIMGModels.length;
                                  index++) {
                                print('${areaIMGModels[index].img!.trim()}');
                                if (areaIMGModels[index].img!.trim() == '') {
                                  newValuePDFimg.add(
                                      'https://png.pngtree.com/png-vector/20190820/ourmid/pngtree-no-image-vector-illustration-isolated-png-image_1694547.jpg');
                                } else {
                                  newValuePDFimg.add(
                                      '${MyConstant().domain}/${areaIMGModels[index].img!.trim()}');
                                }
                              }

                              ///-------------------->
                              List newValuePDFimg2 = [];
                              for (int index = 0; index < 1; index++) {
                                if (renTalModels[0].imglogo!.trim() == '' ||
                                    renTalModels[0].imglogo!.trim() == 'null' ||
                                    renTalModels[0].imglogo!.trim() == 'Null') {
                                  // newValuePDFimg.add(
                                  //     'https://png.pngtree.com/png-vector/20190820/ourmid/pngtree-no-image-vector-illustration-isolated-png-image_1694547.jpg');
                                } else {
                                  newValuePDFimg2.add(
                                      '${MyConstant().domain}/files/$foder/logo/${renTalModels[0].imglogo!.trim()}');
                                }
                              }

                              ///-------------------->
                              Pdfgen_DataChaoArea.exportPDF_DataChaoArea(
                                  context,
                                  '${_selecteSerbool.map((e) => e).toString().substring(1, _selecteSerbool.map((e) => e).toString().length - 1)}',
                                  '${nFormat.format(_area_sum)}',
                                  fname_user,
                                  renTal_name,
                                  newValuePDFimg,
                                  newValuePDFimg2,
                                  '${renTalModels[0].bill_addr}',
                                  '${renTalModels[0].bill_email}',
                                  '${renTalModels[0].bill_tel}',
                                  '${renTalModels[0].bill_tax}',
                                  '${bill_name}');
                            },
                            child: Container(
                              width: 150,
                              height: 50,
                              decoration: const BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10)),
                              ),
                              child: const Center(
                                child: Text('พิมพ์ข้อมูลพื้นที่',
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: false,
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: FontWeight_.Fonts_T)),
                              ),
                            ),
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
              Manbody(),
            ],
          ),
        ),
      ),
    );
  }

  void _displayPdf(CQuotModel CQuotModels) async {
    final font = await rootBundle.load("fonts/Saysettha-OT.ttf");
    final ttf = pw.Font.ttf(font.buffer.asByteData());
    final doc = pw.Document();
    doc.addPage(
      pw.Page(
        pageFormat:
            // PdfPageFormat.a4,
            PdfPageFormat(PdfPageFormat.a4.width, PdfPageFormat.a4.height,
                marginAll: 20),
        build: (pw.Context context) {
          return pw.Stack(
            children: [
              pw.Column(
                mainAxisAlignment: pw.MainAxisAlignment.start,
                children: [
                  pw.Row(
                    children: [
                      pw.Expanded(
                        // flex: 2,
                        child: pw.Container(
                          padding: const pw.EdgeInsets.all(5),
                          child: pw.Text(
                            '${CQuotModels.sname}',
                            style: pw.TextStyle(
                              font: ttf,
                              fontSize: 12,
                              // fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      pw.Expanded(
                        // flex: 2,
                        child: pw.Container(
                          padding: const pw.EdgeInsets.all(5),
                          child: pw.Text(
                            '${CQuotModels.attn}',
                            style: pw.TextStyle(
                              font: ttf,
                              fontSize: 12,
                              // fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      pw.Expanded(
                        // flex: 2,
                        child: pw.Container(
                          padding: const pw.EdgeInsets.all(5),
                          child: pw.Text(
                            '${CQuotModels.zn}',
                            style: pw.TextStyle(
                              font: ttf,
                              fontSize: 12,
                              // fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      pw.Expanded(
                        // flex: 2,
                        child: pw.Container(
                          padding: const pw.EdgeInsets.all(5),
                          child: pw.Text(
                            '${CQuotModels.ln}',
                            style: pw.TextStyle(
                              font: ttf,
                              fontSize: 12,
                              // fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      pw.Expanded(
                        // flex: 2,
                        child: pw.Container(
                          padding: const pw.EdgeInsets.all(5),
                          child: pw.Text(
                            '${CQuotModels.docno}',
                            style: pw.TextStyle(
                              font: ttf,
                              fontSize: 12,
                              // fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              pw.Column(
                mainAxisAlignment: pw.MainAxisAlignment.end,
                children: [
                  pw.Center(
                    child: pw.Text(
                      'Hello Dzentric',
                      // style: pw.TextStyle(fontSize: 30),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
    // await Printing.layoutPdf(
    //     onLayout: (PdfPageFormat format) async => doc.save());

    // open Preview Screen
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              PreviewScreen(doc: doc, cQuotModel: CQuotModels),
        ));
  }
  //////////////------------------------------------------------------>

  //////////////------------------------------------------------------>

  Widget Manbody() {
    switch (activeStep) {
      case 0:
        return Body1(); //Stepper 1

      case 1:
        return Body2(); //Stepper 2

      case 2:
        return Body3(); //Stepper 3

      default:
        return Body2();
    }
  }

  final _formKey = GlobalKey<FormState>();
  final Form_nameshop = TextEditingController();
  final Form_typeshop = TextEditingController();
  final Form_bussshop = TextEditingController();
  final Form_bussscontact = TextEditingController();
  final Form_address = TextEditingController();
  final Form_tel = TextEditingController();
  final Form_email = TextEditingController();
  final Form_tax = TextEditingController();

  String? _Form_nameshop,
      _Form_typeshop,
      _Form_bussshop,
      _Form_bussscontact,
      _Form_address,
      _Form_tel,
      _Form_email,
      _Form_tax;

//////////////-------------------------------------------------->(Stepper 1)
  Widget Body1() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: select_coutumerindex == 0
          ? Form(
              key: _formKey,
              child: Container(
                // color: Colors.red,
                width: MediaQuery.of(context).size.width,
                // height: 450,
                child: Column(
                  children: [
                    Row(
                      children: const [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: AutoSizeText(
                            minFontSize: 10,
                            maxFontSize: 15,
                            '1.ข้อมูลผู้เช่า',
                            style: TextStyle(
                              color: PeopleChaoScreen_Color.Colors_Text1_,
                              // fontWeight: FontWeight.bold,
                              fontFamily: FontWeight_.Fonts_T,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    // _searchBar(),
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
                                fontFamily: Font_.Fonts_T,
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
                                    border: Border.all(
                                        color: Colors.grey, width: 1),
                                  ),
                                  padding: const EdgeInsets.all(8.0),
                                  child: StreamBuilder(
                                      stream: Stream.periodic(
                                          const Duration(seconds: 0)),
                                      builder: (context, snapshot) {
                                        return RadioGroup<TypeModel>.builder(
                                          direction: Axis.horizontal,
                                          groupValue: typeModels
                                              .elementAt(Value_AreaSer_),
                                          horizontalAlignment:
                                              MainAxisAlignment.spaceAround,
                                          onChanged: (value) {
                                            setState(() {
                                              Value_AreaSer_ =
                                                  int.parse(value!.ser!) - 1;
                                              _verticalGroupValue = value.type!;
                                            });
                                          },
                                          items: typeModels,
                                          textStyle: const TextStyle(
                                            fontSize: 15,
                                            color: PeopleChaoScreen_Color
                                                .Colors_Text2_,
                                          ),
                                          itemBuilder: (typeXModels) =>
                                              RadioButtonBuilder(
                                            typeXModels.type!,
                                          ),
                                        );
                                      })),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child:
                                  InkWell(onTap: () {}, child: const Text('')),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {},
                                child: Container(
                                  padding: const EdgeInsets.all(8.0),
                                  child: const Text(
                                    '',
                                    maxLines: 5,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color:
                                          PeopleChaoScreen_Color.Colors_Text1_,
                                      // fontWeight: FontWeight.bold,
                                      fontFamily: FontWeight_.Fonts_T,
                                      //fontSize: 10.0
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {
                                  // setState(() {
                                  //   select_coutumerindex = 1;
                                  // });
                                  select_coutumer();
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                    ),
                                    border: Border.all(
                                        color: Colors.black, width: 1),
                                  ),
                                  padding: const EdgeInsets.all(8.0),
                                  child: const Text(
                                    'ค้นจากทะเบียน',
                                    maxLines: 5,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color:
                                          PeopleChaoScreen_Color.Colors_Text1_,
                                      // fontWeight: FontWeight.bold,
                                      fontFamily: FontWeight_.Fonts_T,
                                      fontWeight: FontWeight.bold,
                                      //fontSize: 10.0
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // Expanded(
                          //   flex: 1,
                          //   child: Padding(
                          //     padding: const EdgeInsets.all(8.0),
                          //     child: InkWell(
                          //       onTap: () {},
                          //       child: Container(
                          //         decoration: BoxDecoration(
                          //           color: Colors.green,
                          //           borderRadius: const BorderRadius.only(
                          //             topLeft: Radius.circular(10),
                          //             topRight: Radius.circular(10),
                          //             bottomLeft: Radius.circular(10),
                          //             bottomRight: Radius.circular(10),
                          //           ),
                          //           border: Border.all(color: Colors.black, width: 1),
                          //         ),
                          //         padding: const EdgeInsets.all(8.0),
                          //         child: const Text(
                          //           'เพิ่มผู้เช่า',
                          //           maxLines: 5,
                          //           textAlign: TextAlign.center,
                          //           style: TextStyle(
                          //             color: TextHome_Color.TextHome_Colors,
                          //             fontWeight: FontWeight.bold,
                          //             //fontSize: 10.0
                          //           ),
                          //         ),
                          //       ),
                          //     ),
                          //   ),
                          // ),
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
                                fontFamily: Font_.Fonts_T,
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
                                // keyboardType: TextInputType.name,
                                controller: Form_nameshop,
                                onChanged: (value) =>
                                    _Form_nameshop = value.trim(),
                                //initialValue: _Form_nameshop,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
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
                                    labelText: 'ระบุชื่อร้านค้า',
                                    labelStyle: const TextStyle(
                                      color:
                                          PeopleChaoScreen_Color.Colors_Text2_,
                                      // fontWeight: FontWeight.bold,
                                      fontFamily: Font_.Fonts_T,
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
                          const Expanded(
                            flex: 1,
                            child: Text(
                              'ประเภทร้านค้า',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: PeopleChaoScreen_Color.Colors_Text2_,
                                // fontWeight: FontWeight.bold,
                                fontFamily: Font_.Fonts_T,
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
                                //keyboardType: TextInputType.none,
                                controller: Form_typeshop,
                                onChanged: (value) =>
                                    _Form_typeshop = value.trim(),
                                //initialValue: _Form_typeshop,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
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
                                    labelText: 'ระบุประเภทร้านค้า',
                                    labelStyle: const TextStyle(
                                      color:
                                          PeopleChaoScreen_Color.Colors_Text2_,
                                      // fontWeight: FontWeight.bold,
                                      fontFamily: Font_.Fonts_T,
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
                                fontFamily: Font_.Fonts_T,
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
                                //keyboardType: TextInputType.none,
                                controller: (Value_AreaSer_ + 1) == 1
                                    ? Form_bussshop
                                    : Form_bussscontact,
                                onChanged: (value) => (Value_AreaSer_ + 1) == 1
                                    ? _Form_bussshop = value.trim()
                                    : _Form_bussscontact = value.trim(),
                                //initialValue: _Form_bussshop,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
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
                                    labelText: 'ระบุชื่อผู้เช่า/บริษัท',
                                    labelStyle: const TextStyle(
                                      color:
                                          PeopleChaoScreen_Color.Colors_Text2_,
                                      // fontWeight: FontWeight.bold,
                                      fontFamily: Font_.Fonts_T,
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
                          const Expanded(
                            flex: 1,
                            child: Text(
                              'ชื่อบุคคลติดต่อ',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: PeopleChaoScreen_Color.Colors_Text2_,
                                // fontWeight: FontWeight.bold,
                                fontFamily: Font_.Fonts_T,
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
                                //keyboardType: TextInputType.none,
                                controller: Form_bussshop,
                                onChanged: (value) =>
                                    _Form_bussshop = value.trim(),
                                //initialValue: _Form_bussshop,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
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
                                    labelText: 'ระบุชื่อบุคคลติดต่อ',
                                    labelStyle: const TextStyle(
                                      color:
                                          PeopleChaoScreen_Color.Colors_Text2_,
                                      // fontWeight: FontWeight.bold,
                                      fontFamily: Font_.Fonts_T,
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
                                fontFamily: Font_.Fonts_T,
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
                                //keyboardType: TextInputType.none,
                                controller: Form_address,
                                onChanged: (value) =>
                                    _Form_address = value.trim(),
                                //initialValue: _Form_address,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
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
                                    labelText: 'ระบุที่อยู่',
                                    labelStyle: const TextStyle(
                                      color:
                                          PeopleChaoScreen_Color.Colors_Text2_,
                                      // fontWeight: FontWeight.bold,
                                      fontFamily: Font_.Fonts_T,
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
                                fontFamily: Font_.Fonts_T,
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
                                //keyboardType: TextInputType.none,
                                controller: Form_tel,
                                onChanged: (value) => _Form_tel = value.trim(),
                                //initialValue: _Form_tel,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
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
                                    labelText: 'ระบุเบอร์โทร',
                                    labelStyle: const TextStyle(
                                      color:
                                          PeopleChaoScreen_Color.Colors_Text2_,
                                      // fontWeight: FontWeight.bold,
                                      fontFamily: Font_.Fonts_T,
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
                          const Expanded(
                            flex: 1,
                            child: Text(
                              'อีเมล',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: PeopleChaoScreen_Color.Colors_Text2_,
                                // fontWeight: FontWeight.bold,
                                fontFamily: Font_.Fonts_T,
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
                                //keyboardType: TextInputType.none,
                                controller: Form_email,
                                onChanged: (value) =>
                                    _Form_email = value.trim(),
                                //initialValue: _Form_email,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
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
                                    labelText: 'ระบุอีเมล',
                                    labelStyle: const TextStyle(
                                      color:
                                          PeopleChaoScreen_Color.Colors_Text2_,
                                      // fontWeight: FontWeight.bold,
                                      fontFamily: Font_.Fonts_T,
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
                                fontFamily: Font_.Fonts_T,
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
                                //keyboardType: TextInputType.none,
                                controller: Form_tax,
                                onChanged: (value) => _Form_tax = value.trim(),
                                //initialValue: _Form_tax,
                                validator: (value) {
                                  if (Value_AreaSer_ + 1 != 1) {
                                    if (value == null || value.isEmpty) {
                                      return 'กรอกข้อมูลให้ครบถ้วน ';
                                    }
                                    // if (int.parse(value.toString()) < 13) {
                                    //   return '< 13';
                                    // }
                                    return null;
                                  } else {}
                                },
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
                                    labelText: 'ระบุID/TAX ID',
                                    labelStyle: const TextStyle(
                                      color:
                                          PeopleChaoScreen_Color.Colors_Text2_,
                                      // fontWeight: FontWeight.bold,
                                      fontFamily: Font_.Fonts_T,
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
                          const Expanded(
                            flex: 1,
                            child: Text(
                              '',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: PeopleChaoScreen_Color.Colors_Text2_,
                                // fontWeight: FontWeight.bold,
                                fontFamily: Font_.Fonts_T,
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
                              // child: const Icon(Icons.check_box_outline_blank)
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            //----------------------------------->
                            // _selecteSer.map((e) => e).toString().substring(
                            //     1, _selecteSer.map((e) => e).toString().length - 1);

                            if (_formKey.currentState!.validate()) {
                              if (_selecteSer.isNotEmpty) {
                                setState(() {
                                  activeStep = activeStep + 1;

                                  Form_nameshop.text =
                                      _Form_nameshop.toString();
                                  Form_typeshop.text =
                                      _Form_typeshop.toString();
                                  Form_bussshop.text =
                                      _Form_bussshop.toString();
                                  Form_bussscontact.text =
                                      _Form_bussscontact.toString();
                                  Form_address.text = _Form_address.toString();
                                  Form_tel.text = _Form_tel.toString();
                                  Form_email.text = _Form_email.toString();
                                  Form_tax.text = _Form_tax == null
                                      ? "-"
                                      : _Form_tax.toString();
                                });
                              } else {
                                setState(() {
                                  Form_nameshop.text =
                                      _Form_nameshop.toString();
                                  Form_typeshop.text =
                                      _Form_typeshop.toString();
                                  Form_bussshop.text =
                                      _Form_bussshop.toString();
                                  Form_bussscontact.text =
                                      _Form_bussscontact.toString();
                                  Form_address.text = _Form_address.toString();
                                  Form_tel.text = _Form_tel.toString();
                                  Form_email.text = _Form_email.toString();
                                  Form_tax.text = _Form_tax == null
                                      ? "-"
                                      : _Form_tax.toString();
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                    'กรุณาเลือกพื้นที่',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: Font_.Fonts_T),
                                  )),
                                );
                              }
                            }

                            // setState(() {
                            //   activeStep = activeStep + 1;
                            // });
                          },
                          child: Container(
                            width: 130,
                            height: 50,
                            decoration: const BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20)),
                            ),
                            child: const Center(
                              child: Text('Continue',
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: false,
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: FontWeight_.Fonts_T,
                                  )),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 50,
                    )
                  ],
                ),
              ),
            )
          : Column(
              children: [
                const Center(
                  child: Text(
                    'เลือกรายชื่อจากทะเบียน',
                    style: TextStyle(
                        color: PeopleChaoScreen_Color.Colors_Text1_,
                        fontWeight: FontWeight.bold,
                        fontFamily: FontWeight_.Fonts_T),
                  ),
                ),
                Container(
                  // height:
                  //     MediaQuery.of(context).size.height /
                  //         1.5,
                  width: MediaQuery.of(context).size.width / 1.2,
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
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15)),
                        ),
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Container(
                              // padding: EdgeInsets.all(10),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: _searchBar(),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(10),
                              color: Colors.grey.shade600,
                              child: Row(
                                children: [
                                  const Expanded(
                                    flex: 2,
                                    child: AutoSizeText(
                                      minFontSize: 10,
                                      maxFontSize: 18,
                                      'รหัสใบเสนอราคา',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: FontWeight_.Fonts_T),
                                    ),
                                  ),
                                  const Expanded(
                                    flex: 2,
                                    child: AutoSizeText(
                                      minFontSize: 10,
                                      maxFontSize: 18,
                                      'รหัสใบสัญญา',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: FontWeight_.Fonts_T),
                                    ),
                                  ),
                                  const Expanded(
                                    flex: 3,
                                    child: AutoSizeText(
                                      minFontSize: 10,
                                      maxFontSize: 18,
                                      'ชื่อร้าน',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: FontWeight_.Fonts_T),
                                    ),
                                  ),
                                  const Expanded(
                                    flex: 3,
                                    child: AutoSizeText(
                                      minFontSize: 10,
                                      maxFontSize: 18,
                                      'ชื่อผู่เช่า/บริษัท',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: FontWeight_.Fonts_T),
                                    ),
                                  ),
                                  const Expanded(
                                    flex: 3,
                                    child: AutoSizeText(
                                      minFontSize: 10,
                                      maxFontSize: 18,
                                      'ประเภท',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: FontWeight_.Fonts_T),
                                    ),
                                  ),
                                  const Expanded(
                                    flex: 1,
                                    child: AutoSizeText(
                                      minFontSize: 10,
                                      maxFontSize: 18,
                                      'Select',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: FontWeight_.Fonts_T),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 1.1,
                              height: MediaQuery.of(context).size.width * 0.28,
                              child: ListView.builder(
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: customerModels.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Container(
                                      padding: const EdgeInsets.all(5),
                                      child: ListTile(
                                        onTap: () {
                                          setState(() {
                                            Form_nameshop.text =
                                                '${customerModels[index].scname}';
                                            Form_typeshop.text =
                                                '${customerModels[index].stype}';
                                            Form_bussshop.text =
                                                '${customerModels[index].cname}';
                                            Form_bussscontact.text =
                                                '${customerModels[index].attn}';
                                            Form_address.text =
                                                '${customerModels[index].addr1}';
                                            Form_tel.text =
                                                '${customerModels[index].tel}';
                                            Form_email.text =
                                                '${customerModels[index].email}';
                                            Form_tax
                                                .text = customerModels[index]
                                                        .tax ==
                                                    'null'
                                                ? "-"
                                                : '${customerModels[index].tax}';

                                            Value_AreaSer_ = int.parse(
                                                    customerModels[index]
                                                        .typeser!) -
                                                1; // ser ประเภท
                                            _verticalGroupValue =
                                                '${customerModels[index].type}'; // ประเภท

                                            _Form_nameshop =
                                                '${customerModels[index].scname}';
                                            _Form_typeshop =
                                                '${customerModels[index].stype}';
                                            _Form_bussshop =
                                                '${customerModels[index].cname}';
                                            _Form_bussscontact =
                                                '${customerModels[index].attn}';
                                            _Form_address =
                                                '${customerModels[index].addr1}';
                                            _Form_tel =
                                                '${customerModels[index].tel}';
                                            _Form_email =
                                                '${customerModels[index].email}';
                                            _Form_tax = customerModels[index]
                                                        .tax ==
                                                    'null'
                                                ? "-"
                                                : '${customerModels[index].tax}';

                                            select_coutumerindex = 0;
                                          });
                                        },
                                        title: Row(
                                          children: [
                                            Expanded(
                                              flex: 2,
                                              child: AutoSizeText(
                                                minFontSize: 10,
                                                maxFontSize: 18,
                                                customerModels[index].docno ==
                                                        null
                                                    ? ''
                                                    : '${customerModels[index].docno}',
                                                style: const TextStyle(
                                                    color:
                                                        PeopleChaoScreen_Color
                                                            .Colors_Text2_,
                                                    // fontWeight: FontWeight.bold,
                                                    fontFamily: Font_.Fonts_T),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: AutoSizeText(
                                                minFontSize: 10,
                                                maxFontSize: 18,
                                                customerModels[index].cid ==
                                                        null
                                                    ? ''
                                                    : '${customerModels[index].cid}',
                                                style: const TextStyle(
                                                    color:
                                                        PeopleChaoScreen_Color
                                                            .Colors_Text2_,
                                                    // fontWeight: FontWeight.bold,
                                                    fontFamily: Font_.Fonts_T),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: AutoSizeText(
                                                minFontSize: 10,
                                                maxFontSize: 18,
                                                '${customerModels[index].scname}',
                                                style: const TextStyle(
                                                    color:
                                                        PeopleChaoScreen_Color
                                                            .Colors_Text2_,
                                                    // fontWeight: FontWeight.bold,
                                                    fontFamily: Font_.Fonts_T),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: AutoSizeText(
                                                minFontSize: 10,
                                                maxFontSize: 18,
                                                '${customerModels[index].cname}',
                                                style: const TextStyle(
                                                    color:
                                                        PeopleChaoScreen_Color
                                                            .Colors_Text2_,
                                                    // fontWeight: FontWeight.bold,
                                                    fontFamily: Font_.Fonts_T),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: AutoSizeText(
                                                minFontSize: 10,
                                                maxFontSize: 18,
                                                '${customerModels[index].type}',
                                                style: const TextStyle(
                                                    color:
                                                        PeopleChaoScreen_Color
                                                            .Colors_Text2_,
                                                    // fontWeight: FontWeight.bold,
                                                    fontFamily: Font_.Fonts_T),
                                              ),
                                            ),
                                            const Expanded(
                                              flex: 1,
                                              child: AutoSizeText(
                                                minFontSize: 10,
                                                maxFontSize: 18,
                                                'Select',
                                                style: TextStyle(
                                                    color:
                                                        PeopleChaoScreen_Color
                                                            .Colors_Text2_,
                                                    // fontWeight: FontWeight.bold,
                                                    fontFamily: Font_.Fonts_T),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
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
                                        setState(() {
                                          select_coutumerindex = 0;
                                        });
                                        // Navigator.pop(context);
                                      },
                                      child: const Text(
                                        'ยกเลิก',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            // fontWeight: FontWeight.bold,
                                            fontFamily: FontWeight_.Fonts_T),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )),
                  ),
                ),
              ],
            ),
    );
  }

  _searchBar() {
    return StreamBuilder(
        stream: Stream.periodic(const Duration(seconds: 0)),
        builder: (context, snapshot) {
          return TextField(
            autofocus: false,
            keyboardType: TextInputType.text,
            style: const TextStyle(
              // fontSize: 22.0,
              color: TextHome_Color.TextHome_Colors,
            ),
            decoration: InputDecoration(
              filled: true,
              // fillColor: Colors.white,
              hintText: ' Search...',
              hintStyle: const TextStyle(
                  color: PeopleChaoScreen_Color.Colors_Text2_,
                  // fontWeight: FontWeight.bold,
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
              text = text.toLowerCase();
              print(text);

              print(customerModels.map((e) => e.docno));
              print(_customerModels.map((e) => e.docno));

              setState(() {
                customerModels = _customerModels.where((customerModel) {
                  var notTitle = customerModel.custno.toString().toLowerCase();
                  // var notTitle2 = customerModel.docno.toString().toLowerCase();
                  var notTitle3 = customerModel.scname.toString().toLowerCase();
                  return notTitle.contains(text) ||
                      // notTitle2.contains(text) ||
                      notTitle3.contains(text);
                }).toList();
              });

              print(customerModels.map((e) => e.scname));
              print(_customerModels.map((e) => e.scname));
            },
          );
        });
  }

  Future<Null> select_coutumer() async {
    if (customerModels.isNotEmpty) {
      setState(() {
        customerModels.clear();
        _customerModels.clear();
      });
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? ren = preferences.getString('renTalSer');
    String url = '${MyConstant().domain}/GC_custo_se.php?isAdd=true&ren=$ren';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print(result);
      if (result.toString() != 'null') {
        for (var map in result) {
          CustomerModel customerModel = CustomerModel.fromJson(map);
          setState(() {
            customerModels.add(customerModel);
          });
        }
      }
      setState(() {
        _customerModels = customerModels;
      });
    } catch (e) {}

    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => StatefulBuilder(
          // stream: Stream.periodic(const Duration(seconds: 0)),
          builder: (context, snapshot) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: Column(
            children: const [
              Center(
                child: Text(
                  'เลือกรายชื่อจากทะเบียน',
                  style: TextStyle(
                      color: PeopleChaoScreen_Color.Colors_Text1_,
                      fontWeight: FontWeight.bold,
                      fontFamily: FontWeight_.Fonts_T),
                ),
              ),
            ],
          ),
          content: (!Responsive.isDesktop(context))
              ? Container(
                  height: MediaQuery.of(context).size.height / 1.5,
                  width: MediaQuery.of(context).size.width,
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
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15)),
                        ),
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              // padding: EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: _searchBar(),
                                  ),
                                ],
                              ),
                            ),
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
                                      width: 800,
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
                                            child: Row(
                                              children: const [
                                                Expanded(
                                                  flex: 2,
                                                  child: AutoSizeText(
                                                    minFontSize: 10,
                                                    maxFontSize: 18,
                                                    'รหัสสมาชิก',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily: FontWeight_
                                                            .Fonts_T),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 3,
                                                  child: AutoSizeText(
                                                    minFontSize: 10,
                                                    maxFontSize: 18,
                                                    'ชื่อร้าน',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily: FontWeight_
                                                            .Fonts_T),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 3,
                                                  child: AutoSizeText(
                                                    minFontSize: 10,
                                                    maxFontSize: 18,
                                                    'ชื่อผู่เช่า/บริษัท',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily: FontWeight_
                                                            .Fonts_T),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 3,
                                                  child: AutoSizeText(
                                                    minFontSize: 10,
                                                    maxFontSize: 18,
                                                    'ประเภท',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily: FontWeight_
                                                            .Fonts_T),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: AutoSizeText(
                                                    minFontSize: 10,
                                                    maxFontSize: 18,
                                                    'Select',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily: FontWeight_
                                                            .Fonts_T),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                              width: 800,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height -
                                                  350,
                                              child: StreamBuilder(
                                                  stream: Stream.periodic(
                                                      const Duration(
                                                          seconds: 0)),
                                                  builder: (context, snapshot) {
                                                    return ListView.builder(
                                                        physics:
                                                            const AlwaysScrollableScrollPhysics(),
                                                        shrinkWrap: true,
                                                        itemCount:
                                                            customerModels
                                                                .length,
                                                        itemBuilder:
                                                            (BuildContext
                                                                    context,
                                                                int index) {
                                                          return Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(5),
                                                            child: ListTile(
                                                              onTap: () {
                                                                setState(() {
                                                                  Form_nameshop
                                                                          .text =
                                                                      '${customerModels[index].scname}';
                                                                  Form_typeshop
                                                                          .text =
                                                                      '${customerModels[index].stype}';
                                                                  Form_bussshop
                                                                          .text =
                                                                      '${customerModels[index].cname}';
                                                                  Form_bussscontact
                                                                          .text =
                                                                      '${customerModels[index].attn}';
                                                                  Form_address
                                                                          .text =
                                                                      '${customerModels[index].addr1}';
                                                                  Form_tel.text =
                                                                      '${customerModels[index].tel}';
                                                                  Form_email
                                                                          .text =
                                                                      '${customerModels[index].email}';
                                                                  Form_tax
                                                                      .text = customerModels[index]
                                                                              .tax ==
                                                                          'null'
                                                                      ? "-"
                                                                      : '${customerModels[index].tax}';

                                                                  Value_AreaSer_ =
                                                                      int.parse(
                                                                              customerModels[index].typeser!) -
                                                                          1; // ser ประเภท
                                                                  _verticalGroupValue =
                                                                      '${customerModels[index].type}'; // ประเภท

                                                                  _Form_nameshop =
                                                                      '${customerModels[index].scname}';
                                                                  _Form_typeshop =
                                                                      '${customerModels[index].stype}';
                                                                  _Form_bussshop =
                                                                      '${customerModels[index].cname}';
                                                                  _Form_bussscontact =
                                                                      '${customerModels[index].attn}';
                                                                  _Form_address =
                                                                      '${customerModels[index].addr1}';
                                                                  _Form_tel =
                                                                      '${customerModels[index].tel}';
                                                                  _Form_email =
                                                                      '${customerModels[index].email}';
                                                                  _Form_tax = customerModels[index]
                                                                              .tax ==
                                                                          'null'
                                                                      ? "-"
                                                                      : '${customerModels[index].tax}';

                                                                  number_custno =
                                                                      customerModels[
                                                                              index]
                                                                          .custno
                                                                          .toString();
                                                                });

                                                                Navigator.pop(
                                                                    context);
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
                                                                      customerModels[index].custno ==
                                                                              null
                                                                          ? ''
                                                                          : '${customerModels[index].custno}',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style: const TextStyle(
                                                                          color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                          // fontWeight: FontWeight.bold,
                                                                          fontFamily: Font_.Fonts_T),
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
                                                                      '${customerModels[index].scname}',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style: const TextStyle(
                                                                          color: PeopleChaoScreen_Color.Colors_Text2_,

                                                                          // fontWeight: FontWeight.bold,
                                                                          fontFamily: Font_.Fonts_T),
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
                                                                      '${customerModels[index].cname}',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style: const TextStyle(
                                                                          color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                          // fontWeight: FontWeight.bold,
                                                                          fontFamily: Font_.Fonts_T),
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
                                                                      '${customerModels[index].type}',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style: const TextStyle(
                                                                          color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                          // fontWeight: FontWeight.bold,
                                                                          fontFamily: Font_.Fonts_T),
                                                                    ),
                                                                  ),
                                                                  const Expanded(
                                                                    flex: 1,
                                                                    child:
                                                                        AutoSizeText(
                                                                      minFontSize:
                                                                          10,
                                                                      maxFontSize:
                                                                          18,
                                                                      'Select',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style: TextStyle(
                                                                          color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                          // fontWeight: FontWeight.bold,
                                                                          fontFamily: Font_.Fonts_T),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          );
                                                        });
                                                  })),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )),
                  ),
                )
              : Container(
                  // height:
                  //     MediaQuery.of(context).size.height /
                  //         1.5,
                  width: MediaQuery.of(context).size.width / 1.2,
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
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15)),
                        ),
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Container(
                              // padding: EdgeInsets.all(10),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: _searchBar(),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade600,
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(0),
                                    bottomRight: Radius.circular(0)),
                              ),
                              child: Row(
                                children: const [
                                  Expanded(
                                    flex: 2,
                                    child: AutoSizeText(
                                      minFontSize: 10,
                                      maxFontSize: 18,
                                      'รหัสสมาชิก',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: FontWeight_.Fonts_T),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: AutoSizeText(
                                      minFontSize: 10,
                                      maxFontSize: 18,
                                      'ชื่อร้าน',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: FontWeight_.Fonts_T),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: AutoSizeText(
                                      minFontSize: 10,
                                      maxFontSize: 18,
                                      'ชื่อผู่เช่า/บริษัท',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: FontWeight_.Fonts_T),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: AutoSizeText(
                                      minFontSize: 10,
                                      maxFontSize: 18,
                                      'ประเภท',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: FontWeight_.Fonts_T),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: AutoSizeText(
                                      minFontSize: 10,
                                      maxFontSize: 18,
                                      'Select',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: FontWeight_.Fonts_T),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                                width: MediaQuery.of(context).size.width / 1.1,
                                height: MediaQuery.of(context).size.height / 2,
                                child: StreamBuilder(
                                    stream: Stream.periodic(
                                        const Duration(seconds: 0)),
                                    builder: (context, snapshot) {
                                      return ListView.builder(
                                          physics:
                                              const AlwaysScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: customerModels.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return Container(
                                              padding: const EdgeInsets.all(5),
                                              child: ListTile(
                                                onTap: () {
                                                  setState(() {
                                                    Form_nameshop.text =
                                                        '${customerModels[index].scname}';
                                                    Form_typeshop.text =
                                                        '${customerModels[index].stype}';
                                                    Form_bussshop.text =
                                                        '${customerModels[index].cname}';
                                                    Form_bussscontact.text =
                                                        '${customerModels[index].attn}';
                                                    Form_address.text =
                                                        '${customerModels[index].addr1}';
                                                    Form_tel.text =
                                                        '${customerModels[index].tel}';
                                                    Form_email.text =
                                                        '${customerModels[index].email}';
                                                    Form_tax
                                                        .text = customerModels[
                                                                    index]
                                                                .tax ==
                                                            'null'
                                                        ? "-"
                                                        : '${customerModels[index].tax}';

                                                    Value_AreaSer_ = int.parse(
                                                            customerModels[
                                                                    index]
                                                                .typeser!) -
                                                        1; // ser ประเภท
                                                    _verticalGroupValue =
                                                        '${customerModels[index].type}'; // ประเภท

                                                    _Form_nameshop =
                                                        '${customerModels[index].scname}';
                                                    _Form_typeshop =
                                                        '${customerModels[index].stype}';
                                                    _Form_bussshop =
                                                        '${customerModels[index].cname}';
                                                    _Form_bussscontact =
                                                        '${customerModels[index].attn}';
                                                    _Form_address =
                                                        '${customerModels[index].addr1}';
                                                    _Form_tel =
                                                        '${customerModels[index].tel}';
                                                    _Form_email =
                                                        '${customerModels[index].email}';
                                                    _Form_tax = customerModels[
                                                                    index]
                                                                .tax ==
                                                            'null'
                                                        ? "-"
                                                        : '${customerModels[index].tax}';

                                                    number_custno =
                                                        customerModels[index]
                                                            .custno
                                                            .toString();
                                                  });

                                                  Navigator.pop(context);
                                                },
                                                title: Row(
                                                  children: [
                                                    Expanded(
                                                      flex: 2,
                                                      child: AutoSizeText(
                                                        minFontSize: 10,
                                                        maxFontSize: 18,
                                                        customerModels[index]
                                                                    .custno ==
                                                                null
                                                            ? ''
                                                            : '${customerModels[index].custno}',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: const TextStyle(
                                                            color: PeopleChaoScreen_Color
                                                                .Colors_Text2_,
                                                            // fontWeight: FontWeight.bold,
                                                            fontFamily:
                                                                Font_.Fonts_T),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 3,
                                                      child: AutoSizeText(
                                                        minFontSize: 10,
                                                        maxFontSize: 18,
                                                        '${customerModels[index].scname}',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: const TextStyle(
                                                            color: PeopleChaoScreen_Color
                                                                .Colors_Text2_,
                                                            // fontWeight: FontWeight.bold,
                                                            fontFamily:
                                                                Font_.Fonts_T),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 3,
                                                      child: AutoSizeText(
                                                        minFontSize: 10,
                                                        maxFontSize: 18,
                                                        '${customerModels[index].cname}',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: const TextStyle(
                                                            color: PeopleChaoScreen_Color
                                                                .Colors_Text2_,
                                                            // fontWeight: FontWeight.bold,
                                                            fontFamily:
                                                                Font_.Fonts_T),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 3,
                                                      child: AutoSizeText(
                                                        minFontSize: 10,
                                                        maxFontSize: 18,
                                                        '${customerModels[index].type}',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: const TextStyle(
                                                            color: PeopleChaoScreen_Color
                                                                .Colors_Text2_,
                                                            // fontWeight: FontWeight.bold,
                                                            fontFamily:
                                                                Font_.Fonts_T),
                                                      ),
                                                    ),
                                                    const Expanded(
                                                      flex: 1,
                                                      child: AutoSizeText(
                                                        minFontSize: 10,
                                                        maxFontSize: 18,
                                                        'Select',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            color: PeopleChaoScreen_Color
                                                                .Colors_Text2_,
                                                            // fontWeight: FontWeight.bold,
                                                            fontFamily:
                                                                Font_.Fonts_T),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          });
                                    })),
                          ],
                        )),
                  ),
                ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
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
                            fontFamily: FontWeight_.Fonts_T),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }

//////////////------------------------------------------------>(Stepper 2)
  ///
  String imageStep2_base64 = '';
  String Value_DateTime_Step2 = '';
  String Value_rental_type_ = '';
  String Value_rental_type_2 = '';
  String Value_rental_type_3 = '';
  String Value_DateTime_end = '';
  String Value_D_start = '';
  String Value_D_end = '';

  String Value_rental_count_ = '';
  // List<String> rental_type_ = ['รายวัน', 'รายเดือน', 'รายปี'];

  Widget Body2() {
    var now = DateTime.now().year;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        // color: Colors.red,
        width: MediaQuery.of(context).size.width,
        // height: 450,
        child: Column(
          children: [
            Row(
              children: const [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: AutoSizeText(
                    minFontSize: 10,
                    maxFontSize: 15,
                    '2.ข้อมูลการเช่า',
                    style: TextStyle(
                        color: PeopleChaoScreen_Color.Colors_Text1_,
                        fontWeight: FontWeight.bold,
                        fontFamily: FontWeight_.Fonts_T),
                  ),
                ),
              ],
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 500,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 500,
                      child: Column(
                        children: [
                          Row(
                            children: const [
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: AutoSizeText(
                                  minFontSize: 10,
                                  maxFontSize: 15,
                                  'พื้นที่เช่า',
                                  style: TextStyle(
                                      color:
                                          PeopleChaoScreen_Color.Colors_Text2_,
                                      // fontWeight: FontWeight.bold,
                                      fontFamily: Font_.Fonts_T
                                      // fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(30, 8, 8, 8),
                            child: Row(
                              children: [
                                const Expanded(
                                  flex: 2,
                                  child: Text(
                                    'รวมพื้นที่เช่า(ตร.ม.)',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        color: PeopleChaoScreen_Color
                                            .Colors_Text2_,
                                        // fontWeight: FontWeight.bold,
                                        fontFamily: Font_.Fonts_T
                                        //fontWeight: FontWeight.bold,
                                        //fontSize: 10.0
                                        ),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
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
                                    child: Container(
                                      decoration: BoxDecoration(
                                        // color: Colors.green,
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(15),
                                          topRight: Radius.circular(15),
                                          bottomLeft: Radius.circular(15),
                                          bottomRight: Radius.circular(15),
                                        ),
                                        border: Border.all(
                                            color: Colors.grey, width: 1),
                                      ),
                                      padding: const EdgeInsets.all(15.0),
                                      child: AutoSizeText(
                                        minFontSize: 10,
                                        maxFontSize: 15,
                                        '${nFormat.format(_area_sum)}',
                                        style: const TextStyle(
                                            color: PeopleChaoScreen_Color
                                                .Colors_Text2_,
                                            // fontWeight: FontWeight.bold,
                                            fontFamily: Font_.Fonts_T),
                                      ),
                                    ),
                                  ),
                                ),
                                // const Expanded(
                                //   flex: 1,
                                //   child: Text(
                                //     '',
                                //     textAlign: TextAlign.center,
                                //     style: TextStyle(
                                //       color: Colors.white,
                                //       //fontWeight: FontWeight.bold,
                                //       //fontSize: 10.0
                                //     ),
                                //   ),
                                // ),
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
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: const [
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: AutoSizeText(
                                  minFontSize: 10,
                                  maxFontSize: 15,
                                  'ระยะเวลาการเช่า',
                                  style: TextStyle(
                                      color:
                                          PeopleChaoScreen_Color.Colors_Text2_,
                                      // fontWeight: FontWeight.bold,
                                      fontFamily: Font_.Fonts_T),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(30, 8, 8, 8),
                            child: Row(
                              children: [
                                const Expanded(
                                  flex: 1,
                                  child: Text(
                                    'ประเภทการเช่า',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        color: PeopleChaoScreen_Color
                                            .Colors_Text2_,
                                        // fontWeight: FontWeight.bold,
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
                                    child: DropdownButtonFormField2(
                                      decoration: InputDecoration(
                                        //Add isDense true and zero Padding.
                                        //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                                        isDense: true,
                                        contentPadding: EdgeInsets.zero,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        //Add more decoration as you want here
                                        //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                                      ),
                                      isExpanded: true,
                                      // disabledHint: Icon(Icons.time_to_leave, color: Colors.black),
                                      hint: Row(
                                        children: [
                                          Text(
                                            (Value_rental_type_.toString() ==
                                                    '')
                                                ? 'เลือก'
                                                : '${Value_rental_type_}',
                                            style: const TextStyle(
                                                fontSize: 14,
                                                color: PeopleChaoScreen_Color
                                                    .Colors_Text2_,
                                                // fontWeight: FontWeight.bold,
                                                fontFamily: Font_.Fonts_T),
                                          ),
                                        ],
                                      ),
                                      icon: const Icon(
                                        Icons.arrow_drop_down,
                                        color: Colors.black45,
                                      ),
                                      iconSize: 30,
                                      buttonHeight: 60,
                                      buttonPadding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      dropdownDecoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      items: rental_type_
                                          .map((item) =>
                                              DropdownMenuItem<String>(
                                                value:
                                                    '${item.ser}:${item.rtname}',
                                                child: Text(
                                                  item.rtname!,
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      color:
                                                          PeopleChaoScreen_Color
                                                              .Colors_Text2_,
                                                      // fontWeight: FontWeight.bold,
                                                      fontFamily:
                                                          Font_.Fonts_T),
                                                ),
                                              ))
                                          .toList(),
                                      onChanged: (value) async {
                                        //Do something when changing the item if you want.

                                        var zones = value!.indexOf(':');
                                        var rtnameSer =
                                            value.substring(0, zones);
                                        var rtnameName =
                                            value.substring(zones + 1);
                                        print(
                                            'mmmmm ${rtnameSer.toString()} $rtnameName');

                                        if (value == null) {
                                          setState(() {
                                            Value_rental_type_ = '';
                                            Value_rental_type_2 = '';
                                          });
                                        } else {
                                          setState(() {
                                            Value_D_start = '';
                                            Value_D_end = '';
                                            Value_DateTime_end = '';
                                            Value_DateTime_Step2 = '';
                                          });
                                          setState(() {
                                            Value_rental_type_ = rtnameName;
                                            if (rtnameName == 'รายวัน') {
                                              Value_rental_type_2 = 'วัน';
                                              Value_rental_type_3 = rtnameSer;
                                            } else if (rtnameName ==
                                                'รายสัปดาห์') {
                                              Value_rental_type_2 = 'สัปดาห์';
                                              Value_rental_type_3 = rtnameSer;
                                            } else if (rtnameName ==
                                                'รายเดือน') {
                                              Value_rental_type_2 = 'เดือน';
                                              Value_rental_type_3 = rtnameSer;
                                            } else if (rtnameName == 'รายปี') {
                                              Value_rental_type_2 = 'ปี';
                                              Value_rental_type_3 = rtnameSer;
                                            }
                                          });
                                        }
                                      },
                                      onSaved: (value) {
                                        // selectedValue = value.toString();
                                      },
                                    ),
                                  ),
                                ),
                                Value_rental_type_ == ''
                                    ? const SizedBox()
                                    : const Expanded(
                                        flex: 1,
                                        child: Text(
                                          'อายุสัญญา',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: PeopleChaoScreen_Color
                                                  .Colors_Text2_,
                                              // fontWeight: FontWeight.bold,
                                              fontFamily: Font_.Fonts_T),
                                        ),
                                      ),
                                Value_rental_type_ == ''
                                    ? const SizedBox()
                                    : Expanded(
                                        flex: 2,
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Container(
                                                decoration: const BoxDecoration(
                                                  // color: Colors.green,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft: Radius.circular(6),
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
                                                  keyboardType:
                                                      TextInputType.number,
                                                  // controller: Form1_text,
                                                  initialValue:
                                                      Value_rental_count_,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      Value_rental_count_ =
                                                          value;
                                                      Value_D_start = '';
                                                      Value_D_end = '';
                                                      Value_DateTime_end = '';
                                                      Value_DateTime_Step2 = '';
                                                    });
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
                                                      labelText:
                                                          'ระบุอายุสัญญา',
                                                      labelStyle:
                                                          const TextStyle(
                                                              color: PeopleChaoScreen_Color
                                                                  .Colors_Text2_,
                                                              // fontWeight: FontWeight.bold,
                                                              fontFamily: Font_
                                                                  .Fonts_T)),
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
                                            Value_rental_type_ == ''
                                                ? const SizedBox()
                                                : Expanded(
                                                    child: Text(
                                                      '$Value_rental_type_2',
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
                                                  ),
                                          ],
                                        ),
                                      ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(30, 8, 8, 8),
                            child: Row(
                              children: [
                                const Expanded(
                                  flex: 1,
                                  child: Text(
                                    'วันที่เริ่มสัญญา',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        color: PeopleChaoScreen_Color
                                            .Colors_Text2_,
                                        // fontWeight: FontWeight.bold,
                                        fontFamily: Font_.Fonts_T),
                                  ),
                                ),
                                Expanded(
                                    flex: 2,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        height: 50,
                                        decoration: BoxDecoration(
                                          // color: Colors.green,
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(15),
                                            topRight: Radius.circular(15),
                                            bottomLeft: Radius.circular(15),
                                            bottomRight: Radius.circular(15),
                                          ),
                                          border: Border.all(
                                              color: Colors.grey, width: 1),
                                        ),
                                        child: InkWell(
                                          onTap: () async {
                                            DateTime? newDate =
                                                await showDatePicker(
                                              // locale: const Locale('th', 'TH'),
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime(1000, 1, 01),
                                              lastDate: DateTime.now().add(
                                                  const Duration(days: 50)),
                                              builder: (context, child) {
                                                return Theme(
                                                  data: Theme.of(context)
                                                      .copyWith(
                                                    colorScheme:
                                                        const ColorScheme.light(
                                                      primary: AppBarColors
                                                          .ABar_Colors, // header background color
                                                      onPrimary: Colors
                                                          .white, // header text color
                                                      onSurface: Colors
                                                          .black, // body text color
                                                    ),
                                                    textButtonTheme:
                                                        TextButtonThemeData(
                                                      style:
                                                          TextButton.styleFrom(
                                                        primary: Colors
                                                            .black, // button text color
                                                      ),
                                                    ),
                                                  ),
                                                  child: child!,
                                                );
                                              },
                                            );

                                            if (newDate == null) {
                                              return;
                                            } else {
                                              print('$newDate');
                                              // var orderDate =
                                              //     DateFormat('dd-MM-yyyy')
                                              //         .format(newDate);
                                              if (Value_rental_count_ == '') {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                        const SnackBar(
                                                            content: Text(
                                                  'กรุณากรอกอายุสัญญา',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily:
                                                          Font_.Fonts_T),
                                                )));
                                              } else {
                                                // int countday = Value_rental_type_2 ==
                                                //         'วัน'
                                                //     ? int.parse(
                                                //         Value_rental_count_)
                                                //     : Value_rental_type_2 ==
                                                //             'สัปดาห์'
                                                //         ? int.parse(
                                                //                 Value_rental_count_) *
                                                //             7
                                                //         : Value_rental_type_2 ==
                                                //                 'เดือน'
                                                //             ? int.parse(
                                                //                     Value_rental_count_) *
                                                //                 30
                                                //             : int.parse(
                                                //                     Value_rental_count_) *
                                                //                 365;
                                                // var birthday = DateTime.parse(
                                                //         '$newDate 00:00:00.000')
                                                //     .add(Duration(
                                                //         days: countday));
                                                // var birthday = newDate.add(
                                                //     Duration(days: countday));

                                                int countday = int.parse(
                                                    Value_rental_count_);

                                                var birthday = Value_rental_type_2 ==
                                                        'วัน'
                                                    ? DateTime(
                                                        newDate.year,
                                                        newDate.month,
                                                        newDate.day +
                                                            (countday - 1))
                                                    : Value_rental_type_2 ==
                                                            'สัปดาห์'
                                                        ? DateTime(
                                                            newDate.year,
                                                            newDate.month,
                                                            newDate.day +
                                                                (countday * 6))
                                                        : Value_rental_type_2 ==
                                                                'เดือน'
                                                            ? DateTime(
                                                                newDate.year,
                                                                newDate.month +
                                                                    countday,
                                                                newDate.day - 1)
                                                            : DateTime(
                                                                newDate.year +
                                                                    countday,
                                                                newDate.month,
                                                                newDate.day -
                                                                    1);
                                                // var birthday = DateTime(
                                                //     newDate.year,
                                                //     newDate.month - 1,
                                                //     newDate.day);

                                                String start =
                                                    DateFormat('yyyy-MM-dd')
                                                        .format(newDate);
                                                String end =
                                                    DateFormat('yyyy-MM-dd')
                                                        .format(birthday);
                                                String end_StratTime =
                                                    DateFormat('dd-MM-yyy')
                                                        .format(newDate);

                                                String end_DateTime =
                                                    DateFormat('dd-MM-yyy')
                                                        .format(birthday);

                                                print(
                                                    '$start $end ...... $birthday');
                                                setState(() {
                                                  Value_D_start = start;
                                                  Value_D_end = end;

                                                  Value_DateTime_end =
                                                      end_DateTime;
                                                  Value_DateTime_Step2 =
                                                      end_StratTime;
                                                });
                                              }
                                            }
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(15.0),
                                            child: AutoSizeText(
                                              Value_DateTime_Step2 == ''
                                                  ? 'เลือกวันที่'
                                                  : '$Value_DateTime_Step2',
                                              minFontSize: 9,
                                              maxFontSize: 16,
                                              textAlign: TextAlign.start,
                                              style: const TextStyle(
                                                  color: PeopleChaoScreen_Color
                                                      .Colors_Text2_,
                                                  // fontWeight: FontWeight.bold,
                                                  fontFamily: Font_.Fonts_T),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ),
                                        // child: StreamBuilder(
                                        //     stream: Stream.periodic(
                                        //         const Duration(seconds: 0)),
                                        //     builder: (context, snapshot) {
                                        //       return DateTimePicker(
                                        //         locale: Locale('th', 'TH'),
                                        //         cursorColor: Colors.green,
                                        //         dateMask: 'dd-MM-yyyy',
                                        //         initialValue: '',
                                        //         firstDate: DateTime.now(),
                                        //         lastDate: DateTime.now()
                                        //             .add(Duration(days: 50)),
                                        //         // firstDate: DateTime(now),
                                        //         // lastDate: DateTime(now + 1),
                                        //         dateLabelText: 'วัน-เดือน-ปี',
                                        //         onChanged: (val) {
                                        //           if (Value_rental_count_ ==
                                        //               '') {
                                        //             ScaffoldMessenger.of(
                                        //                     context)
                                        //                 .showSnackBar(SnackBar(
                                        //                     content: Text(
                                        //                         'กรุณากรอกอายุสัญญา')));
                                        //           } else {
                                        //             int countday = Value_rental_type_2 ==
                                        //                     'วัน'
                                        //                 ? int.parse(
                                        //                     Value_rental_count_)
                                        //                 : Value_rental_type_2 ==
                                        //                         'เดือน'
                                        //                     ? int.parse(
                                        //                             Value_rental_count_) *
                                        //                         30
                                        //                     : int.parse(
                                        //                             Value_rental_count_) *
                                        //                         365;
                                        //             var birthday = DateTime.parse(
                                        //                     '$val 00:00:00.000')
                                        //                 .add(Duration(
                                        //                     days: countday));

                                        //             String start =
                                        //                 DateFormat('yyyy/MM/dd')
                                        //                     .format(
                                        //                         DateTime.parse(
                                        //                             val));
                                        //             String end =
                                        //                 DateFormat('yyyy/MM/dd')
                                        //                     .format(birthday);

                                        //             String end_DateTime =
                                        //                 DateFormat('dd-MM-yyy')
                                        //                     .format(birthday);

                                        //             print(
                                        //                 '$start $end ...... $birthday');
                                        //             setState(() {
                                        //               Value_D_start = start;
                                        //               Value_D_end = end;

                                        //               Value_DateTime_end =
                                        //                   end_DateTime;
                                        //               Value_DateTime_Step2 =
                                        //                   val;
                                        //             });
                                        //           }
                                        //         },
                                        //         style: TextStyle(
                                        //             color: Colors.black
                                        //             // fontWeight: FontWeight.bold,
                                        //             ),
                                        //         selectableDayPredicate: (date) {
                                        //           // Disable weekend days to select from the calendar
                                        //           if (date.weekday == 6 ||
                                        //               date.weekday == 7) {
                                        //             return false;
                                        //           }

                                        //           return true;
                                        //         },
                                        //       );
                                        // }
                                      ),
                                    )),
                                const Expanded(
                                  flex: 1,
                                  child: Text(
                                    'วันที่หมดสัญญา',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: PeopleChaoScreen_Color
                                            .Colors_Text2_,
                                        // fontWeight: FontWeight.bold,
                                        fontFamily: Font_.Fonts_T),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        // color: Colors.green,
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(15),
                                          topRight: Radius.circular(15),
                                          bottomLeft: Radius.circular(15),
                                          bottomRight: Radius.circular(15),
                                        ),
                                        border: Border.all(
                                            color: Colors.grey, width: 1),
                                      ),
                                      padding: const EdgeInsets.all(15.0),
                                      child: AutoSizeText(
                                        minFontSize: 10,
                                        maxFontSize: 15,
                                        '$Value_DateTime_end',
                                        style: TextStyle(
                                            color: Colors.grey.shade700,

                                            // fontWeight: FontWeight.bold,
                                            fontFamily: Font_.Fonts_T),
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
                  Expanded(
                    child: Container(
                      height: 500,
                      // color: Colors.blue,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: const [
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: AutoSizeText(
                                  minFontSize: 10,
                                  maxFontSize: 15,
                                  'รูปแผนผัง',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      color:
                                          PeopleChaoScreen_Color.Colors_Text1_,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: FontWeight_.Fonts_T),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            width: 420,
                            height: 300,
                            child: ListView.builder(
                                // physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: areaIMGModels.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: AutoSizeText(
                                          minFontSize: 10,
                                          maxFontSize: 15,
                                          '${areaIMGModels[index].lncode}:${areaIMGModels[index].ln}',
                                          textAlign: TextAlign.start,
                                          style: const TextStyle(
                                            color: PeopleChaoScreen_Color
                                                .Colors_Text1_,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: FontWeight_.Fonts_T,
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          print(
                                              '${MyConstant().domain}/${areaIMGModels[index].img!.trim()}');
                                          // chooseImageStep2();
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Stack(
                                            children: [
                                              Container(
                                                  width: 400,
                                                  height: 250,
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey[400],
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
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                          image: NetworkImage(
                                                              "${MyConstant().domain}/${areaIMGModels[index].img!.trim()}"),
                                                          fit: BoxFit.fitHeight,
                                                        ),
                                                      ),
                                                    ),
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                }),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    //----------------------------------->
                    setState(() {
                      activeStep = activeStep - 1;
                    });
                  },
                  child: Container(
                    width: 130,
                    height: 50,
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                    ),
                    child: const Center(
                      child: Text('Back',
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: FontWeight_.Fonts_T)),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    //----------------------------------->

                    if (Value_rental_count_ == '' ||
                        Value_DateTime_Step2 == '') {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text(
                        'กรุณากรอกข้อมูลให้ครบถ้วน',
                        style: TextStyle(
                            color: Colors.white, fontFamily: Font_.Fonts_T),
                      )));
                    } else {
                      SharedPreferences preferences =
                          await SharedPreferences.getInstance();
                      String? ren = preferences.getString('renTalSer');
                      String? ser_user = preferences.getString('ser');

                      String url =
                          '${MyConstant().domain}/GCquotx_select.php?isAdd=true&ren=$ren&ser_user=$ser_user';

                      try {
                        var response = await http.get(Uri.parse(url));

                        var result = json.decode(response.body);
                        print(result);
                        if (result.toString() != 'null') {
                          String url2 =
                              '${MyConstant().domain}/D_quotx.php?isAdd=true&ren=$ren&ser_user=$ser_user';

                          try {
                            var response2 = await http.get(Uri.parse(url2));

                            var result2 = json.decode(response2.body);
                            print(result2);
                            if (result2.toString() == 'true') {
                              setState(() {
                                activeStep = activeStep + 1;
                                quotxSelectModels.clear();
                              });
                              for (var i = 0; i < expAutoModels.length; i++) {
                                print(
                                    'auto>>>>>>>>>>>${expAutoModels[i].auto}');
                                if (expAutoModels[i].auto == '1') {
                                  var serex = expAutoModels[i].ser;
                                  var sdate = expAutoModels[i].unitser == '6'
                                      ? expAutoModels[i].sday
                                      : DateFormat('dd')
                                          .format(DateTime.parse(
                                              '$Value_D_start 00:00:00'))
                                          .toString();
                                  add_quot_auto(serex, sdate, i);
                                }
                              }
                            }
                          } catch (e) {}
                        } else {
                          for (var i = 0; i < expAutoModels.length; i++) {
                            print('auto>>>>>>>>>>>${expAutoModels[i].auto}');
                            if (expAutoModels[i].auto == '1') {
                              var serex = expAutoModels[i].ser;
                              var sdate = expAutoModels[i].unitser == '6'
                                  ? expAutoModels[i].sday
                                  : DateFormat('dd')
                                      .format(DateTime.parse(
                                          '$Value_D_start 00:00:00'))
                                      .toString();
                              add_quot_auto(serex, sdate, i);
                            }
                          }
                          setState(() {
                            activeStep = activeStep + 1;
                            quotxSelectModels.clear();
                          });
                        }
                      } catch (e) {}

                      read_GC_unitx();

                      // setState(() {
                      //   activeStep = activeStep + 1;
                      // });
                    }
                  },
                  child: Container(
                    width: 130,
                    height: 50,
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                    ),
                    child: const Center(
                      child: Text('Continue',
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: FontWeight_.Fonts_T)),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }

  Future<Null> read_GC_unitx() async {
    if (unitModels.isNotEmpty) {
      unitModels.clear();
      unitxModels.clear();
    }

    String url = '${MyConstant().domain}/GC_unit.php?isAdd=true';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print(result);
      if (result != null) {
        for (var map in result) {
          UnitModel unitModel = UnitModel.fromJson(map);
          UnitxModel unitxModel = UnitxModel.fromJson(map);

          setState(() {
            if (int.parse(Value_rental_type_3) == 1) {
              if (unitModel.ser == '4' || unitModel.ser == '5') {
                unitModels.add(unitModel);
              }
              // unitModels.add(unitModel);
              if (unitxModel.ser == '5' || unitxModel.ser == '7') {
                unitxModels.add(unitxModel);
              }
            } else if (int.parse(Value_rental_type_3) == 2) {
              if (unitModel.ser == '3' ||
                  unitModel.ser == '4' ||
                  unitModel.ser == '5') {
                unitModels.add(unitModel);
              }
              // unitModels.add(unitModel);
              if (unitxModel.ser == '5' || unitxModel.ser == '7') {
                unitxModels.add(unitxModel);
              }
            } else if (int.parse(Value_rental_type_3) == 3) {
              if (unitModel.ser == '2' ||
                  unitModel.ser == '3' ||
                  unitModel.ser == '4' ||
                  unitModel.ser == '5') {
                unitModels.add(unitModel);
              }
              // unitModels.add(unitModel);
              if (unitxModel.ser == '5' ||
                  unitxModel.ser == '6' ||
                  unitxModel.ser == '7') {
                unitxModels.add(unitxModel);
              }
            } else if (int.parse(Value_rental_type_3) == 4) {
              if (unitModel.ser == '1' ||
                  unitModel.ser == '2' ||
                  unitModel.ser == '3' ||
                  unitModel.ser == '4' ||
                  unitModel.ser == '5') {
                unitModels.add(unitModel);
              }
              // unitModels.add(unitModel);
              if (unitxModel.ser == '5' ||
                  unitxModel.ser == '6' ||
                  unitxModel.ser == '7') {
                unitxModels.add(unitxModel);
              }
            }
          });
        }
      } else {}
    } catch (e) {}
  }

//////////////------------------------------------------------>(Stepper 3)
  Widget Body3() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          // color: Colors.red,
          width: MediaQuery.of(context).size.width,
          // height: 450,
          child: Column(children: [
            Sub_Body3_Web(),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    //----------------------------------->
                    setState(() {
                      activeStep = activeStep - 1;
                    });
                  },
                  child: Container(
                    width: 130,
                    height: 50,
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                    ),
                    child: const Center(
                      child: Text('Back',
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: FontWeight_.Fonts_T)),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    // SharedPreferences preferences =
                    //     await SharedPreferences.getInstance();

                    // String? _route = preferences.getString('route');
                    // MaterialPageRoute materialPageRoute = MaterialPageRoute(
                    //     builder: (BuildContext context) =>
                    //         AdminScafScreen(route: _route));
                    // Navigator.pushAndRemoveUntil(
                    //     context, materialPageRoute, (route) => false);

                    add_quotAx();
                  },
                  child: Container(
                    width: 130,
                    height: 50,
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                    ),
                    child: const Center(
                      child: Text('เสร็จสิ้น',
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: FontWeight_.Fonts_T)),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            )
          ])),
    );
  }
//  onTap: () async {
//                               setState(() {
//                                 newValuePDF = [];
//                               });
//                               setState(() {
//                                 newValuePDFimg.clear();
//                                 newValuePDFimg = [];
//                               });

//                               for (int index = 0;
//                                   index < areaIMGModels.length;
//                                   index++) {
//                                 print('${areaIMGModels[index].img!.trim()}');
//                                 if (areaIMGModels[index].img!.trim() == '') {
//                                   newValuePDFimg.add(
//                                       'https://png.pngtree.com/png-vector/20190820/ourmid/pngtree-no-image-vector-illustration-isolated-png-image_1694547.jpg');
//                                 } else {
//                                   newValuePDFimg.add(
//                                       '${MyConstant().domain}/${areaIMGModels[index].img!.trim()}');
//                                 }
//                               }

//                               ///-------------------->
//                               List newValuePDFimg2 = [];
//                               for (int index = 0; index < 1; index++) {
//                                 if (renTalModels[0].imglogo!.trim() == '' ||
//                                     renTalModels[0].imglogo!.trim() == 'null' ||
//                                     renTalModels[0].imglogo!.trim() == 'Null') {
//                                   // newValuePDFimg.add(
//                                   //     'https://png.pngtree.com/png-vector/20190820/ourmid/pngtree-no-image-vector-illustration-isolated-png-image_1694547.jpg');
//                                 } else {
//                                   newValuePDFimg2.add(
//                                       '${MyConstant().domain}/files/$foder/logo/${renTalModels[0].imglogo!.trim()}');
//                                 }
//                               }

//                               ///-------------------->
//                               for (int index = 0;
//                                   index < quotxSelectModels.length;
//                                   index++) {
//                                 for (var i = 0;
//                                     i <
//                                         int.parse(
//                                             quotxSelectModels[index].term!);
//                                     i++) {
//                                   Map<String, dynamic> valueMap = {
//                                     'serial': i + 1,
//                                     'date':
//                                         '${DateFormat('dd').format(DateTime.parse('${quotxSelectModels[index].sdate!} 00:00:00'))}-${DateFormat('MM-yyyy').format(DateTime.parse('${quotxSelectModels[index].sdate!} 00:00:00').add(Duration(days: int.parse('${quotxSelectModels[index].day}') * i)))}',
//                                     'expname':
//                                         '${quotxSelectModels[index].expname!}',
//                                     'vtype':
//                                         '${quotxSelectModels[index].vtype!}',
//                                     'nvat':
//                                         '${quotxSelectModels[index].nvat!} %',
//                                     'vat': '${quotxSelectModels[index].vat!}',
//                                     'pvat':
//                                         '${nFormat.format(double.parse(quotxSelectModels[index].pvat!))}',
//                                     'nwht': '${quotxSelectModels[index].nwht!}',
//                                     'wht': '${quotxSelectModels[index].wht!}',
//                                     'total':
//                                         '${nFormat.format(double.parse(quotxSelectModels[index].total!))}',
//                                   };
//                                   newValuePDF.add(valueMap);
//                                 }
//                               }
//                               // for (int i = 0; i < newValue.length; i++) {
//                               //   print(
//                               //       '${newValue[i]['serial']},${newValue[i]['expname']}');
//                               // }
//                               Pdfgen_Quotation2.exportPDF_Quotation2(
//                                   context,
//                                   '${_selecteSerbool.map((e) => e).toString().substring(1, _selecteSerbool.map((e) => e).toString().length - 1)}',
//                                   '${nFormat.format(_area_sum)}',
//                                   '$Value_DateTime_Step2',
//                                   '$Value_DateTime_end',
//                                   '$Value_rental_count_',
//                                   '$Value_rental_type_',
//                                   '${Form_nameshop.text}',
//                                   '${Form_bussshop.text}',
//                                   '${_Form_address}',
//                                   '${Form_tel.text}',
//                                   '${Form_email.text}',
//                                   '${Form_tax.text}',
//                                   expTypeModels,
//                                   quotxSelectModels,
//                                   fname_user,
//                                   renTal_name,
//                                   newValuePDF,
//                                   newValuePDFimg,
//                                   newValuePDFimg2,
//                                   '${renTalModels[0].bill_addr}',
//                                   '${renTalModels[0].bill_email}',
//                                   '${renTalModels[0].bill_tel}',
//                                   '${renTalModels[0].bill_tax}',
//                                   '{cQuotModel.docno}');
//                             },
  Future<Null> add_quotAx() async {
    DateTime dateTime = DateTime.now();
    String orderDate = DateFormat('yyyy-MM-dd').format(dateTime);
    String orderTime = DateFormat('HH:mm:ss').format(dateTime);

    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? idUser = preferences.getString('ser');
    String? nameUser = preferences.getString('fname');
    String? ren = preferences.getString('renTalSer');
    String? zone_ser = preferences.getString('zoneSer');
    String? zone_name = preferences.getString('zonesName');

    // print(
    // '>>>>>$_Date>>>>>>>>>>>>>>>>>>>>> $Value_D_start ------ $Value_D_end>>>>>  $Value_DateTime_Step2 ------ $Value_DateTime_end');

    String _Mount =
        DateFormat('yyyy-MM').format(DateTime.parse('$Value_D_start 00:00:00'));

    String _Mounte =
        DateFormat('yyyy-MM').format(DateTime.parse('$Value_D_end 00:00:00'));

    // var dmy = '$_Mount-$_Date';
    // var dmye = '$_Mounte-$_Date';
    // print('>>>>>>>>>>>>>>>>>>>>>>>>>> $dmy ------ $dmye');

    var valut_type = Value_AreaSer_ + 1; // ser ประเภท
    var valut_type_name = _verticalGroupValue; // ประเภท
    var valut_nameshop = _Form_nameshop; //ชื่อร้าน
    var valut_typeshop = _Form_typeshop; //ประเภทร้าน
    var valut_bussshop = _Form_bussshop; //ชื่อผู้เช่า
    var valut_bussscontact = _Form_bussscontact; //ชื่อผู้ติดต่อ
    var valut_address = _Form_address; //ที่อยู่
    var valut_tel = _Form_tel; //เบอร์โทร
    var valut_email = _Form_email; //email
    var valut_tax = _Form_tax == 'null' ? '-' : _Form_tax; //เลข tax
    var valut_DateTime_Step2 = Value_DateTime_Step2; //เลือก ว-ด-ป
    var valut_rental_type = Value_rental_type_; //รายวัน เดือน ปี
    var valut_D_type = Value_rental_type_2; //วัน เดือน ปี
    var valut_D_type_ser = Value_rental_type_3; //ser วัน เดือน ปี
    var valut_D = Value_DateTime_end; //หมดสัญญา ว-ด-ป
    var valut_D_start = Value_D_start; //เริ่มสัญญา ป-ด-ว
    var valut_D_read = Value_D_read; //ทำสัญญา ป-ด-ว
    var valut_D_end = Value_D_end; //หมดสัญญา ป-ด-ว
    // var valut_D_end_dmy = dmye; //หมดสัญญา ป-ด-ว set
    var valut_D_count = Value_rental_count_; //จำนวน วัน เดือน ปี
    var ser_area = _selecteSer.map((e) => e).toString().substring(
        1, _selecteSer.map((e) => e).toString().length - 1); // serพื้นที่
    var name_area = _selecteSerbool.map((e) => e).toString().substring(
        1, _selecteSerbool.map((e) => e).toString().length - 1); //พื้นที่
    var ser_area_length = _selecteSer.length;
    var area_sum = _area_sum; //พื้นที่รวม
    var area_rent_sum = _area_rent_sum; //ราคาพื้นที่
    // var ser_expt = serex;

    String url = '${MyConstant().domain}/In_Quot.php?isAdd=true&ren=$ren';

    var response = await http.post(Uri.parse(url), body: {
      'ren': ren.toString(),
      'idUser': idUser.toString(),
      'nameUser': nameUser.toString(),
      'datexx': orderDate.toString(),
      'time': orderTime.toString(),
      'ser_area': ser_area.toString(),
      'name_area': name_area.toString(),
      'valut_type': valut_type.toString(),
      'valut_type_name': valut_type_name.toString(),
      'valut_nameshop': valut_nameshop.toString(),
      'valut_typeshop': valut_typeshop.toString(),
      'valut_bussshop': valut_bussshop.toString(),
      'valut_bussscontact': valut_type == 1
          ? valut_bussshop.toString()
          : valut_bussscontact.toString(),
      'valut_address': valut_address.toString(),
      'valut_tel': valut_tel.toString(),
      'valut_email': valut_email.toString(),
      'valut_tax': valut_tax == '' ? '' : valut_tax.toString(),
      'valut_rental_type': valut_rental_type.toString(),
      'valut_D_start': valut_D_start.toString(),
      'valut_D_end': valut_D_end.toString(),
      'valut_D_count': valut_D_count.toString(),
      'area_sum': area_sum.toString(),
      'area_rent_sum': area_rent_sum.toString(),
      'zone_ser': zone_ser.toString(),
      'zone_name': zone_name.toString(),
      'ser_area_length': ser_area_length.toString(),
      'valut_D_type_ser': valut_D_type_ser.toString(),
      'number_custno': number_custno.toString(),
      'valut_D_read': valut_D_read.toString(),
    }).then(
      (value) async {
        print('11111111......>>${value.body}');
        if (value.toString() != 'No') {
          // var result = json.decode(value.body);
          print('datasdvs == ${value.body}');

          // QuotxModel quotxSelectModel = QuotxModel.fromJson(result);

          var qser = value.body;
          var cser_;
          for (var i = 0; i < _selecteSer.length; i++) {
            var serAx = _selecteSer[i];

            String url =
                '${MyConstant().domain}/Inc_areax.php?isAdd=true&ren=$ren&serAx=$serAx&qser=$qser';
            try {
              var response = await http.get(Uri.parse(url));

              var result = json.decode(response.body);
              print('$i///////${result}');
              if (result != null) {
                setState(() async {
                  cser_ = await result[i]['cser'];
                });
              } else {}
            } catch (e) {}
          }
          print('cser_');
          print(cser_);
          SharedPreferences preferences = await SharedPreferences.getInstance();

//////////////-------------------------------------------------->
          // setState(() {
          //   newValuePDF = [];
          // });
          // setState(() {
          //   newValuePDFimg.clear();
          //   newValuePDFimg = [];
          // });

          // for (int index = 0; index < areaIMGModels.length; index++) {
          //   print('${areaIMGModels[index].img!.trim()}');
          //   if (areaIMGModels[index].img!.trim() == '') {
          //     newValuePDFimg.add(
          //         'https://png.pngtree.com/png-vector/20190820/ourmid/pngtree-no-image-vector-illustration-isolated-png-image_1694547.jpg');
          //   } else {
          //     newValuePDFimg.add(
          //         '${MyConstant().domain}/${areaIMGModels[index].img!.trim()}');
          //   }
          // }

          // ///-------------------->
          // List newValuePDFimg2 = [];
          // for (int index = 0; index < 1; index++) {
          //   if (renTalModels[0].imglogo!.trim() == '' ||
          //       renTalModels[0].imglogo!.trim() == 'null' ||
          //       renTalModels[0].imglogo!.trim() == 'Null') {
          //     // newValuePDFimg.add(
          //     //     'https://png.pngtree.com/png-vector/20190820/ourmid/pngtree-no-image-vector-illustration-isolated-png-image_1694547.jpg');
          //   } else {
          //     newValuePDFimg2.add(
          //         '${MyConstant().domain}/files/$foder/logo/${renTalModels[0].imglogo!.trim()}');
          //   }
          // }

          ///-------------------->
          for (int index = 0; index < quotxSelectModels.length; index++) {
            for (var i = 0;
                i < int.parse(quotxSelectModels[index].term!);
                i++) {
              Map<String, dynamic> valueMap = {
                'serial': i + 1,
                'date':
                    '${DateFormat('dd').format(DateTime.parse('${quotxSelectModels[index].sdate!} 00:00:00'))}-${DateFormat('MM-yyyy').format(DateTime.parse('${quotxSelectModels[index].sdate!} 00:00:00').add(Duration(days: int.parse('${quotxSelectModels[index].day}') * i)))}',
                'expname': '${quotxSelectModels[index].expname!}',
                'vtype': '${quotxSelectModels[index].vtype!}',
                'nvat': '${quotxSelectModels[index].nvat!} %',
                'vat': '${quotxSelectModels[index].vat!}',
                'pvat':
                    '${nFormat.format(double.parse(quotxSelectModels[index].pvat!))}',
                'nwht': '${quotxSelectModels[index].nwht!}',
                'wht': '${quotxSelectModels[index].wht!}',
                'total':
                    '${nFormat.format(double.parse(quotxSelectModels[index].total!))}',
              };
              newValuePDF.add(valueMap);
            }
          }
          Insert_log.Insert_logs('พื้นที่เช่า',
              'เสนอราคา>>เสนอราคา(${cser_},พื้นที่:${_selecteSerbool.map((e) => e).toString().substring(1, _selecteSerbool.map((e) => e).toString().length - 1)})');
          String? _route = preferences.getString('route');
          MaterialPageRoute materialPageRoute = MaterialPageRoute(
              builder: (BuildContext context) =>
                  AdminScafScreen(route: _route));
          Navigator.pushAndRemoveUntil(
              context, materialPageRoute, (route) => false);
          // Pdfgen_Quotation2.exportPDF_Quotation2(
          //     context,
          //     '${_selecteSerbool.map((e) => e).toString().substring(1, _selecteSerbool.map((e) => e).toString().length - 1)}',
          //     '${nFormat.format(_area_sum)}',
          //     '$Value_DateTime_Step2',
          //     '$Value_DateTime_end',
          //     '$Value_rental_count_',
          //     '$Value_rental_type_',
          //     '${Form_nameshop.text}',
          //     '${Form_bussshop.text}',
          //     '${_Form_address}',
          //     '${Form_tel.text}',
          //     '${Form_email.text}',
          //     '${Form_tax.text}',
          //     expTypeModels,
          //     quotxSelectModels,
          //     fname_user,
          //     renTal_name,
          //     newValuePDF,
          //     newValuePDFimg,
          //     newValuePDFimg2,
          //     '${renTalModels[0].bill_addr}',
          //     '${renTalModels[0].bill_email}',
          //     '${renTalModels[0].bill_tel}',
          //     '${renTalModels[0].bill_tax}',
          //     '${cser_}',
          //     _route);
        } else {
          print(value);
        }
      },
    );

    // var result = json.decode(response.body);
    // print(result.toString());
    // if (result != null) {
    //   print('datasdvs == $result');

    //   QuotxModel quotxSelectModel = QuotxModel.fromJson(result);

    //   var docno = quotxSelectModel.docno;
    //   var qser = quotxSelectModel.qser;

    //   for (var i = 0; i < _selecteSer.length; i++) {
    //     var serAx = _selecteSer[i];

    //     String url =
    //         '${MyConstant().domain}/Inc_areax.php?isAdd=true&ren=$ren&serAx=$serAx&docno=$docno&qser=$qser';
    //     try {
    //       var response = await http.get(Uri.parse(url));

    //       var result = json.decode(response.body);
    //       print(result);
    //       if (result != null) {
    //         SharedPreferences preferences =
    //             await SharedPreferences.getInstance();

    //         String? _route = preferences.getString('route');
    //         MaterialPageRoute materialPageRoute = MaterialPageRoute(
    //             builder: (BuildContext context) =>
    //                 AdminScafScreen(route: _route));
    //         Navigator.pushAndRemoveUntil(
    //             context, materialPageRoute, (route) => false);
    //       } else {}
    //     } catch (e) {}
    //   }
    // }
  }

  Future<Null> add_quot_auto(serex, _Date, int i) async {
    DateTime dateTime = DateTime.now();
    String orderDate = DateFormat('yyyy-MM-dd').format(dateTime);
    String orderTime = DateFormat('HH:mm:ss').format(dateTime);

    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? idUser = preferences.getString('ser');
    String? nameUser = preferences.getString('fname');
    String? ren = preferences.getString('renTalSer');
    //'ser'
    //'position'
    //'fname'
    //'lname'
    //'email'
    //'utype'
    //'verify'
    //'permission'
    print(
        '>>>>>$_Date>>>>>>>>>>>>>>>>>>>>> $Value_D_start ------ $Value_D_end>>>>>  $Value_DateTime_Step2 ------ $Value_DateTime_end');

    String _Mount =
        DateFormat('yyyy-MM').format(DateTime.parse('$Value_D_start 00:00:00'));

    String _Mounte =
        DateFormat('yyyy-MM').format(DateTime.parse('$Value_D_end 00:00:00'));

    var dmy = '$_Mount-$_Date';
    var dmye = '$_Mounte-$_Date';
    print('>>>>>>>>>>>>>>>>>>>>>>>>>> $dmy ------ $dmye');

    var valut_type = Value_AreaSer_ + 1; // ser ประเภท
    var valut_type_name = _verticalGroupValue; // ประเภท
    var valut_nameshop = _Form_nameshop; //ชื่อร้าน
    var valut_typeshop = _Form_typeshop; //ประเภทร้าน
    var valut_bussshop = _Form_bussshop; //ชื่อผู้เช่า
    var valut_bussscontact = _Form_bussscontact; //ชื่อผู้ติดต่อ
    var valut_address = _Form_address; //ที่อยู่
    var valut_tel = _Form_tel; //เบอร์โทร
    var valut_email = _Form_email; //email
    var valut_tax = _Form_tax == 'null' ? '-' : _Form_tax; //เลข tax
    var valut_DateTime_Step2 = Value_DateTime_Step2; //เลือก ว-ด-ป
    var valut_rental_type = Value_rental_type_; //รายวัน เดือน ปี
    // var valut_rental_type = expAutoModels[i].unitser == '0'
    //     ? Value_rental_type_
    //     : expAutoModels[i].unit; //รายวัน เดือน ปี
    var valut_D_type = Value_rental_type_2; //วัน เดือน ปี
    var valut_D = Value_DateTime_end; //หมดสัญญา ว-ด-ป
    var valut_D_start = Value_D_start; //เริ่มสัญญา ป-ด-ว
    var valut_D_start_dmy = dmy; //เริ่มสัญญา ป-ด-ว set
    var valut_D_end = Value_D_end; //หมดสัญญา ป-ด-ว
    var valut_D_end_dmy = dmye; //หมดสัญญา ป-ด-ว set
    var valut_D_count = Value_rental_count_; //จำนวน วัน เดือน ปี
    // var valut_D_count = expAutoModels[i].unitser == '0'
    //     ? Value_rental_count_
    //     : expAutoModels[i].unit == 'ครั้งเดียว'
    //         ? '1'
    //         : Value_rental_count_; //จำนวน วัน เดือน ปี
    var ser_area = _selecteSer.map((e) => e).toString().substring(
        1, _selecteSer.map((e) => e).toString().length - 1); // serพื้นที่
    var name_area = _selecteSerbool.map((e) => e).toString().substring(
        1, _selecteSerbool.map((e) => e).toString().length - 1); //พื้นที่
    var area_sum = _area_sum; //พื้นที่รวม

    var area_rent_sum = expAutoModels[i].cal_auto == '1'
        ? expAutoModels[i].unit == 'มิเตอร์'
            ? '0'
            : expAutoModels[i].pri_auto
        : expAutoModels[i].unit == 'มิเตอร์'
            ? '0'
            : _area_rent_sum; //ราคาพื้นที่
    var ser_expt = serex;

    String url =
        '${MyConstant().domain}/In_Qootx_select.php?isAdd=true&ren=$ren';
    await http.post(Uri.parse(url), body: {
      'idUser': idUser.toString(),
      'nameUser': nameUser.toString(),
      'datexx': orderDate.toString(),
      'time': orderTime.toString(),
      'ser_area': ser_area.toString(),
      'name_area': name_area.toString(),
      'valut_type': valut_type.toString(),
      'valut_type_name': valut_type_name.toString(),
      'valut_nameshop': valut_nameshop.toString(),
      'valut_typeshop': valut_typeshop.toString(),
      'valut_bussshop': valut_bussshop.toString(),
      'valut_bussscontact': valut_type == 1
          ? valut_bussshop.toString()
          : valut_bussscontact.toString(),
      'valut_address': valut_address.toString(),
      'valut_tel': valut_tel.toString(),
      'valut_email': valut_email.toString(),
      'valut_tax': valut_tax == '' ? '' : valut_tax.toString(),
      'valut_rental_type': valut_rental_type.toString(),
      'valut_D_start': valut_D_start.toString(),
      'valut_D_start_dmy': valut_D_start_dmy.toString(),
      'valut_D_end': valut_D_end.toString(),
      'valut_D_end_dmy': valut_D_end_dmy.toString(),
      'valut_D_count': valut_D_count.toString(),
      'area_sum': area_sum.toString(),
      'area_rent_sum': area_rent_sum.toString(),
      'ser_expt': serex.toString(),
      'value_cid': '',
    }).then(
      (value) async {
        print(value);
        if (value.toString() != 'null') {
          if (quotxSelectModels.isNotEmpty) {
            quotxSelectModels.clear();
          }
          print('value $value');
          var result = json.decode(value.body);
          print('datasdvs == $result');

          for (var map in result) {
            QuotxSelectModel quotxSelectModel = QuotxSelectModel.fromJson(map);
            setState(() {
              quotxSelectModels.add(quotxSelectModel);
            });
          }
        } else {
          print(value);
        }
      },
    );
  }

  Future<Null> add_quot(serex, _Date, int index) async {
    DateTime dateTime = DateTime.now();
    String orderDate = DateFormat('yyyy-MM-dd').format(dateTime);
    String orderTime = DateFormat('HH:mm:ss').format(dateTime);

    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? idUser = preferences.getString('ser');
    String? nameUser = preferences.getString('fname');
    String? ren = preferences.getString('renTalSer');
    //'ser'
    //'position'
    //'fname'
    //'lname'
    //'email'
    //'utype'
    //'verify'
    //'permission'
    print(
        '>>>>>$_Date>>>>>>>>>>>>>>>>>>>>> $Value_D_start ------ $Value_D_end>>>>>  $Value_DateTime_Step2 ------ $Value_DateTime_end');

    String _Mount =
        DateFormat('yyyy-MM').format(DateTime.parse('$Value_D_start 00:00:00'));
    String _day =
        DateFormat('dd').format(DateTime.parse('$Value_D_start 00:00:00'));

    String _Mounte =
        DateFormat('yyyy-MM').format(DateTime.parse('$Value_D_end 00:00:00'));

    var dmy =
        expModels[index].unit == 'มิเตอร์' ? '$_Mount-$_Date' : '$_Mount-$_day';
    var dmye = expModels[index].unit == 'มิเตอร์'
        ? '$_Mounte-$_Date'
        : '$_Mounte-$_day';
    print('>>>>>>>>>>>>>>>>>>>>>>>>>> $dmy ------ $dmye');

    var valut_type = Value_AreaSer_ + 1; // ser ประเภท
    var valut_type_name = _verticalGroupValue; // ประเภท
    var valut_nameshop = _Form_nameshop; //ชื่อร้าน
    var valut_typeshop = _Form_typeshop; //ประเภทร้าน
    var valut_bussshop = _Form_bussshop; //ชื่อผู้เช่า
    var valut_bussscontact = _Form_bussscontact; //ชื่อผู้ติดต่อ
    var valut_address = _Form_address; //ที่อยู่
    var valut_tel = _Form_tel; //เบอร์โทร
    var valut_email = _Form_email; //email
    var valut_tax = _Form_tax == 'null' ? '-' : _Form_tax; //เลข tax
    var valut_DateTime_Step2 = Value_DateTime_Step2; //เลือก ว-ด-ป
    // var valut_rental_type = Value_rental_type_; //รายวัน เดือน ปี
    // var valut_rental_type = expModels[index].unitser == '0'
    //     ? Value_rental_type_
    //     : expModels[index].unit; //รายวัน เดือน ปี
    var valut_rental_type = expModels[index].etype == 'R'
        ? Value_rental_type_
        : expModels[index].unitser == '0'
            ? Value_rental_type_
            : expModels[index].unit;
    var valut_D_type = Value_rental_type_2; //วัน เดือน ปี
    var valut_D = Value_DateTime_end; //หมดสัญญา ว-ด-ป
    var valut_D_start = Value_D_start; //เริ่มสัญญา ป-ด-ว
    var valut_D_start_dmy = dmy; //เริ่มสัญญา ป-ด-ว set
    var valut_D_end = Value_D_end; //หมดสัญญา ป-ด-ว
    var valut_D_end_dmy = dmye; //หมดสัญญา ป-ด-ว set
    // var valut_D_count = Value_rental_count_; //จำนวน วัน เดือน ปี
    // var valut_D_count = expModels[index].unitser == '0'
    //     ? Value_rental_count_
    //     : expModels[index].unit == 'ครั้งเดียว'
    //         ? '1'
    //         : Value_rental_count_; //จำนวน วัน เดือน ปี
    var valut_D_count = expModels[index].etype == 'R'
        ? Value_rental_count_
        : expModels[index].unitser == '0'
            ? Value_rental_count_
            : expModels[index].unit == 'ครั้งเดียว'
                ? '1'
                : Value_rental_count_;
    var ser_area = _selecteSer.map((e) => e).toString().substring(
        1, _selecteSer.map((e) => e).toString().length - 1); // serพื้นที่
    var name_area = _selecteSerbool.map((e) => e).toString().substring(
        1, _selecteSerbool.map((e) => e).toString().length - 1); //พื้นที่
    var area_sum = _area_sum; //พื้นที่รวม
    var area_rent_sum = expModels[index].cal_auto == '1'
        ? expModels[index].unit == 'มิเตอร์'
            ? '0'
            : expModels[index].pri_auto
        : expModels[index].unit == 'มิเตอร์'
            ? '0'
            : _area_rent_sum; //ราคาพื้นที่
    var ser_expt = serex;

    String url =
        '${MyConstant().domain}/In_Qootx_select.php?isAdd=true&ren=$ren';
    await http.post(Uri.parse(url), body: {
      'idUser': idUser.toString(),
      'nameUser': nameUser.toString(),
      'datexx': orderDate.toString(),
      'time': orderTime.toString(),
      'ser_area': ser_area.toString(),
      'name_area': name_area.toString(),
      'valut_type': valut_type.toString(),
      'valut_type_name': valut_type_name.toString(),
      'valut_nameshop': valut_nameshop.toString(),
      'valut_typeshop': valut_typeshop.toString(),
      'valut_bussshop': valut_bussshop.toString(),
      'valut_bussscontact': valut_type == 1
          ? valut_bussshop.toString()
          : valut_bussscontact.toString(),
      'valut_address': valut_address.toString(),
      'valut_tel': valut_tel.toString(),
      'valut_email': valut_email.toString(),
      'valut_tax': valut_tax == '' ? '' : valut_tax.toString(),
      'valut_rental_type': valut_rental_type.toString(),
      'valut_D_start': valut_D_start.toString(),
      'valut_D_start_dmy': valut_D_start_dmy.toString(),
      'valut_D_end': valut_D_end.toString(),
      'valut_D_end_dmy': valut_D_end_dmy.toString(),
      'valut_D_count': valut_D_count.toString(),
      'area_sum': area_sum.toString(),
      'area_rent_sum': area_rent_sum.toString(),
      'ser_expt': ser_expt.toString(),
      'value_cid': '',
    }).then(
      (value) async {
        print(value);
        if (value.toString() != 'null') {
          if (quotxSelectModels.isNotEmpty) {
            quotxSelectModels.clear();
          }
          print('value $value');
          var result = json.decode(value.body);
          print('datasdvs == $result');

          for (var map in result) {
            QuotxSelectModel quotxSelectModel = QuotxSelectModel.fromJson(map);
            setState(() {
              quotxSelectModels.add(quotxSelectModel);
            });
          }
          Navigator.pop(context);
        } else {
          print(value);
        }
      },
    );
  }

  Widget Sub_Body3_Web() {
    return Column(children: [
      Row(
        children: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: AutoSizeText(
              minFontSize: 10,
              maxFontSize: 15,
              '3.ค่าบริการ',
              style: TextStyle(
                  color: PeopleChaoScreen_Color.Colors_Text1_,
                  fontWeight: FontWeight.bold,
                  fontFamily: FontWeight_.Fonts_T),
            ),
          ),
        ],
      ),
      for (int Ser_Sub = 0; Ser_Sub < expTypeModels.length; Ser_Sub++)
        (expTypeModels[Ser_Sub].etype != 'F')
            ? Container(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: AutoSizeText(
                            minFontSize: 10,
                            maxFontSize: 15,
                            '3.${expTypeModels[Ser_Sub].ser} ${expTypeModels[Ser_Sub].bills}',
                            style: const TextStyle(
                                color: PeopleChaoScreen_Color.Colors_Text2_,
                                // fontWeight: FontWeight.bold,
                                fontFamily: Font_.Fonts_T),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10)),
                          ),
                          padding: const EdgeInsets.all(8.0),
                          child: IconButton(
                              onPressed: () {
                                read_GC_Exp(expTypeModels[Ser_Sub].ser);
                                showDialog<String>(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (BuildContext context) {
                                      return StreamBuilder(
                                          stream: Stream.periodic(
                                              const Duration(seconds: 0)),
                                          builder: (context, snapshot) {
                                            return AlertDialog(
                                              shape:
                                                  const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  20.0))),
                                              title: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Expanded(
                                                    flex: 6,
                                                    child: Text(
                                                      '${expTypeModels[Ser_Sub].bills}',
                                                      style: const TextStyle(
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
                                                  Expanded(
                                                      flex: 6,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          IconButton(
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                  context,
                                                                );
                                                              },
                                                              icon: const Icon(
                                                                  Icons.close,
                                                                  color: Colors
                                                                      .black)),
                                                        ],
                                                      )),
                                                ],
                                              ),
                                              content: SingleChildScrollView(
                                                child: ListBody(
                                                  children: <Widget>[
                                                    Container(
                                                      height: 50,
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      decoration: BoxDecoration(
                                                        color: Colors
                                                            .grey.shade300,
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
                                                        // border: Border.all(color: Colors.grey, width: 1),
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Expanded(
                                                            flex: 6,
                                                            child: Container(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child:
                                                                  const AutoSizeText(
                                                                maxLines: 2,
                                                                minFontSize: 8,
                                                                // maxFontSize: 15,
                                                                'รายการ',
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                style: TextStyle(
                                                                    color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                    // fontWeight: FontWeight.bold,
                                                                    fontFamily: Font_.Fonts_T),
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 1,
                                                            child: Container(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child:
                                                                  const AutoSizeText(
                                                                maxLines: 2,
                                                                minFontSize: 8,
                                                                maxFontSize: 15,
                                                                'ราคา/หน่วย',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: TextStyle(
                                                                    color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                    // fontWeight: FontWeight.bold,
                                                                    fontFamily: Font_.Fonts_T

                                                                    //fontSize: 10.0
                                                                    ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height /
                                                              1.8,
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      // height: 250,

                                                      decoration:
                                                          const BoxDecoration(
                                                        color:
                                                            AppbackgroundColor
                                                                .Sub_Abg_Colors,
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        0),
                                                                topRight:
                                                                    Radius
                                                                        .circular(
                                                                            0),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        0),
                                                                bottomRight:
                                                                    Radius
                                                                        .circular(
                                                                            0)),
                                                        // border: Border.all(color: Colors.grey, width: 1),
                                                      ),
                                                      child: ListView.builder(
                                                        // controller: expModels.length,
                                                        // itemExtent: 50,
                                                        physics:
                                                            const AlwaysScrollableScrollPhysics(), // const NeverScrollableScrollPhysics(),
                                                        shrinkWrap: true,
                                                        itemCount:
                                                            expModels.length,
                                                        itemBuilder:
                                                            (BuildContext
                                                                    context,
                                                                int index) {
                                                          return Container(
                                                            child: ListTile(
                                                                onTap: () {
                                                                  var serex =
                                                                      expModels[
                                                                              index]
                                                                          .ser;
                                                                  var sdate =
                                                                      expModels[
                                                                              index]
                                                                          .sday;

                                                                  DateTime
                                                                      dateTime =
                                                                      DateTime
                                                                          .now();
                                                                  // String _Date = DateFormat(
                                                                  //         'dd')
                                                                  //     .format(DateTime.parse(
                                                                  //         expModels[index]
                                                                  //             .sdate!));

                                                                  // Value_AreaSer_ +
                                                                  //     1; // ser ประเภท
                                                                  // _verticalGroupValue; // ประเภท
                                                                  // _Form_nameshop; //ชื่อร้าน
                                                                  // _Form_typeshop; //ประเภทร้าน
                                                                  // _Form_bussshop; //ชื่อผู้เช่า
                                                                  // _Form_bussscontact; //ชื่อผู้ติดต่อ
                                                                  // _Form_address; //ที่อยู่
                                                                  // _Form_tel; //เบอร์โทร
                                                                  // _Form_email; //email
                                                                  // _Form_tax; //เลข tax
                                                                  // Value_DateTime_Step2; //เลือก ว-ด-ป
                                                                  // Value_rental_type_; //รายวัน เดือน ปี
                                                                  // Value_rental_type_2; //วัน เดือน ปี
                                                                  // Value_DateTime_end; //หมดสัญญา ว-ด-ป
                                                                  // Value_D_start; //เริ่มสัญญา ป/ด/ว
                                                                  // Value_D_end; //หมดสัญญา ป/ด/ว
                                                                  // Value_rental_count_; //จำนวน วัน เดือน ปี
                                                                  // _selecteSer.map((e) => e).toString().substring(1,
                                                                  //     _selecteSer.map((e) => e).toString().length - 1); // serพื้นที่
                                                                  // _selecteSerbool.map((e) => e).toString().substring(1,
                                                                  //     _selecteSerbool.map((e) => e).toString().length - 1); //พื้นที่

                                                                  add_quot(
                                                                      serex,
                                                                      sdate,
                                                                      index);
                                                                },
                                                                title: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Expanded(
                                                                      flex: 6,
                                                                      child:
                                                                          Container(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            8.0),
                                                                        child:
                                                                            AutoSizeText(
                                                                          maxLines:
                                                                              2,
                                                                          minFontSize:
                                                                              8,
                                                                          // maxFontSize: 15,
                                                                          '${expModels[index].expname}',
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
                                                                    ),
                                                                    expModels[index].exptser ==
                                                                            '3'
                                                                        ? Expanded(
                                                                            flex:
                                                                                1,
                                                                            child:
                                                                                Padding(
                                                                              padding: const EdgeInsets.all(8.0),
                                                                              child: AutoSizeText(
                                                                                maxLines: 2,
                                                                                minFontSize: 8,
                                                                                maxFontSize: 15,
                                                                                '${expModels[index].pri} ฿',
                                                                                textAlign: TextAlign.end,
                                                                                style: const TextStyle(
                                                                                    color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                                    // fontWeight: FontWeight.bold,
                                                                                    fontFamily: Font_.Fonts_T

                                                                                    //fontSize: 10.0
                                                                                    ),
                                                                              ),
                                                                            ),
                                                                          )
                                                                        : SizedBox(),
                                                                  ],
                                                                )),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          });
                                    });
                                print('555');
                              },
                              icon: const Icon(Icons.add, color: Colors.green)),
                        ),
                      ],
                    ),
                    Container(
                      constraints: BoxConstraints(
                        // minHeight: 500, //minimum height
                        minWidth: 400, // minimum width

                        // maxHeight: MediaQuery.of(context).size.height,
                        //maximum height set to 100% of vertical height

                        maxWidth: (!Responsive.isDesktop(context))
                            ? 1200
                            : MediaQuery.of(context).size.width - 270,
                        //maximum width set to 100% of width
                      ),
                      decoration: const BoxDecoration(
                        color: AppbackgroundColor.Sub_Abg_Colors,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                        // border: Border.all(color: Colors.grey, width: 1),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                                    constraints: BoxConstraints(
                                      // minHeight: 500, //minimum height
                                      minWidth: 400, // minimum width

                                      // maxHeight: MediaQuery.of(context).size.height,
                                      //maximum height set to 100% of vertical height

                                      maxWidth: (!Responsive.isDesktop(context))
                                          ? 1200
                                          : MediaQuery.of(context).size.width -
                                              270,
                                      //maximum width set to 100% of width
                                    ),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              8, 8, 8, 0),
                                          child: Container(
                                              constraints: BoxConstraints(
                                                // minHeight: 500, //minimum height
                                                minWidth: 400, // minimum width

                                                // maxHeight: MediaQuery.of(context).size.height,
                                                //maximum height set to 100% of vertical height

                                                maxWidth:
                                                    (!Responsive.isDesktop(
                                                            context))
                                                        ? 1200
                                                        : MediaQuery.of(context)
                                                                .size
                                                                .width -
                                                            270,
                                                //maximum width set to 100% of width
                                              ),
                                              decoration: const BoxDecoration(
                                                color: AppbackgroundColor
                                                    .TiTile_Colors,
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(10),
                                                    topRight:
                                                        Radius.circular(10),
                                                    bottomLeft:
                                                        Radius.circular(0),
                                                    bottomRight:
                                                        Radius.circular(0)),
                                              ),
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  const Expanded(
                                                    flex: 2,
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.all(8.0),
                                                      child: AutoSizeText(
                                                        maxLines: 1,
                                                        minFontSize: 8,
                                                        maxFontSize: 15,
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
                                                      //Text(
                                                      // 'ประเภทค่าบริการ',
                                                      // textAlign: TextAlign.center,
                                                      // style: TextStyle(
                                                      //   color: Colors.black,
                                                      //   fontWeight: FontWeight.bold,
                                                      //   //fontSize: 10.0
                                                      // ),
                                                      // ),
                                                    ),
                                                  ),
                                                  const Expanded(
                                                    flex: 2,
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.all(8.0),
                                                      child: AutoSizeText(
                                                        maxLines: 1,
                                                        minFontSize: 8,
                                                        maxFontSize: 15,
                                                        'ความถี่',
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
                                                      // Text(
                                                      //   'ความถี่',
                                                      //   textAlign: TextAlign.center,
                                                      //   style: TextStyle(
                                                      //     color: Colors.black,
                                                      //     fontWeight: FontWeight.bold,
                                                      //     //fontSize: 10.0
                                                      //   ),
                                                      // ),
                                                    ),
                                                  ),
                                                  const Expanded(
                                                    flex: 1,
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.all(8.0),
                                                      child: AutoSizeText(
                                                        maxLines: 1,
                                                        minFontSize: 8,
                                                        maxFontSize: 15,
                                                        'จำนวนงวด',
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
                                                            ),
                                                      ),
                                                      // Text(
                                                      //   'จำนวนงวด',
                                                      //   textAlign: TextAlign.center,
                                                      //   style: TextStyle(
                                                      //     color: Colors.black,
                                                      //     fontWeight: FontWeight.bold,
                                                      //     //fontSize: 10.0
                                                      //   ),
                                                      // ),
                                                    ),
                                                  ),
                                                  // unit_ser == 6
                                                  //     ? Expanded(
                                                  //         flex: 1,
                                                  //         child: Padding(
                                                  //           padding: EdgeInsets.all(8.0),
                                                  //           child: AutoSizeText(
                                                  //             maxLines: 1,
                                                  //             minFontSize: 8,
                                                  //             maxFontSize: 15,
                                                  //             'หมายเลขเครื่อง',
                                                  //             textAlign: TextAlign.center,
                                                  //             style: TextStyle(
                                                  //               color: Colors.black,
                                                  //               fontWeight: FontWeight.bold,
                                                  //               //fontSize: 10.0
                                                  //             ),
                                                  //           ),
                                                  //           // Text(
                                                  //           //   'หมายเลขเครื่อง',
                                                  //           //   textAlign: TextAlign.center,
                                                  //           //   style: TextStyle(
                                                  //           //     color: Colors.black,
                                                  //           //     fontWeight: FontWeight.bold,
                                                  //           //     //fontSize: 10.0
                                                  //           //   ),
                                                  //           // ),
                                                  //         ),
                                                  //       )
                                                  //     : SizedBox(),
                                                  // unit_ser == 6
                                                  //     ? Expanded(
                                                  //         flex: 1,
                                                  //         child: Padding(
                                                  //           padding: EdgeInsets.all(8.0),
                                                  //           child: AutoSizeText(
                                                  //             maxLines: 1,
                                                  //             minFontSize: 8,
                                                  //             maxFontSize: 15,
                                                  //             'ราคา/หน่วย',
                                                  //             textAlign: TextAlign.center,
                                                  //             style: TextStyle(
                                                  //               color: Colors.black,
                                                  //               fontWeight: FontWeight.bold,
                                                  //               //fontSize: 10.0
                                                  //             ),
                                                  //           ),
                                                  //           // Text(
                                                  //           //   'ราคา/หน่วย',
                                                  //           //   textAlign: TextAlign.center,
                                                  //           //   style: TextStyle(
                                                  //           //     color: Colors.black,
                                                  //           //     fontWeight: FontWeight.bold,
                                                  //           //     //fontSize: 10.0
                                                  //           //   ),
                                                  //           // ),
                                                  //         ),
                                                  //       )
                                                  //     : SizedBox(),
                                                  const Expanded(
                                                    flex: 1,
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.all(8.0),
                                                      child: AutoSizeText(
                                                        maxLines: 1,
                                                        minFontSize: 8,
                                                        maxFontSize: 15,
                                                        'วันเริ่มต้น',
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
                                                            ),
                                                      ),
                                                      // Text(
                                                      //   'วันเริ่มต้น',
                                                      //   textAlign: TextAlign.center,
                                                      //   style: TextStyle(
                                                      //     color: Colors.black,
                                                      //     fontWeight: FontWeight.bold,
                                                      //     //fontSize: 10.0
                                                      //   ),
                                                      // ),
                                                    ),
                                                  ),
                                                  // Expanded(
                                                  //   flex: 1,
                                                  //   child: Padding(
                                                  //     padding: EdgeInsets.all(8.0),
                                                  //     child: Text(
                                                  //       'วันสิ้นสุด',
                                                  //       textAlign: TextAlign.center,
                                                  //       style: TextStyle(
                                                  //         color: Colors.black,
                                                  //         fontWeight: FontWeight.bold,
                                                  //         //fontSize: 10.0
                                                  //       ),
                                                  //     ),
                                                  //   ),
                                                  // ),
                                                  const Expanded(
                                                    flex: 1,
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.all(8.0),
                                                      child: AutoSizeText(
                                                        maxLines: 1,
                                                        minFontSize: 8,
                                                        maxFontSize: 15,
                                                        'ยอด(บาท)',
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
                                                            ),
                                                      ),
                                                      // Text(
                                                      //   'ยอด(บาท)',
                                                      //   textAlign: TextAlign.center,
                                                      //   style: TextStyle(
                                                      //     color: Colors.black,
                                                      //     fontWeight: FontWeight.bold,
                                                      //     //fontSize: 10.0
                                                      //   ),
                                                      // ),
                                                    ),
                                                  ),
                                                  const Expanded(
                                                    flex: 2,
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.all(8.0),
                                                      child: AutoSizeText(
                                                        maxLines: 1,
                                                        minFontSize: 8,
                                                        maxFontSize: 15,
                                                        'VAT',
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
                                                            ),
                                                      ),
                                                      // Text(
                                                      //   'VAT',
                                                      //   textAlign: TextAlign.center,
                                                      //   style: TextStyle(
                                                      //     color: Colors.black,
                                                      //     fontWeight: FontWeight.bold,
                                                      //     //fontSize: 10.0
                                                      //   ),
                                                      // ),
                                                    ),
                                                  ),
                                                  // Expanded(
                                                  //   flex: 1,
                                                  //   child: Padding(
                                                  //     padding:
                                                  //         EdgeInsets.all(8.0),
                                                  //     child: Text(
                                                  //       ' ',
                                                  //       textAlign:
                                                  //           TextAlign.center,
                                                  //       style: TextStyle(
                                                  //           color: PeopleChaoScreen_Color
                                                  //               .Colors_Text1_,
                                                  //           fontWeight:
                                                  //               FontWeight.bold,
                                                  //           fontFamily:
                                                  //               FontWeight_
                                                  //                   .Fonts_T
                                                  //           //fontSize: 10.0
                                                  //           ),
                                                  //     ),
                                                  //   ),
                                                  // ),
                                                  // if ((Value_AreaSer_ + 1) == 1)
                                                  //   const SizedBox()
                                                  // else
                                                  const Expanded(
                                                    flex: 2,
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.all(8.0),
                                                      child: AutoSizeText(
                                                        maxLines: 1,
                                                        minFontSize: 8,
                                                        maxFontSize: 15,
                                                        'WHT',
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
                                                            ),
                                                      ),
                                                      //  Text(
                                                      //   'WHT',
                                                      //   textAlign: TextAlign.center,
                                                      //   style: TextStyle(
                                                      //     color: Colors.black,
                                                      //     fontWeight: FontWeight.bold,
                                                      //     //fontSize: 10.0
                                                      //   ),
                                                      // ),
                                                    ),
                                                  ),
                                                  // if ((Value_AreaSer_ + 1) == 1)
                                                  //   const SizedBox()
                                                  // else
                                                  // const Expanded(
                                                  //   flex: 2,
                                                  //   child: Padding(
                                                  //     padding:
                                                  //         EdgeInsets.all(8.0),
                                                  //     child: AutoSizeText(
                                                  //       maxLines: 1,
                                                  //       minFontSize: 8,
                                                  //       maxFontSize: 15,
                                                  //       'WHT',
                                                  //       textAlign:
                                                  //           TextAlign.center,
                                                  //       style: TextStyle(
                                                  //           color: PeopleChaoScreen_Color
                                                  //               .Colors_Text1_,
                                                  //           fontWeight:
                                                  //               FontWeight.bold,
                                                  //           fontFamily:
                                                  //               FontWeight_
                                                  //                   .Fonts_T
                                                  //           //fontSize: 10.0
                                                  //           ),
                                                  //     ),
                                                  //     //  Text(
                                                  //     //   'WHT',
                                                  //     //   textAlign: TextAlign.center,
                                                  //     //   style: TextStyle(
                                                  //     //     color: Colors.black,
                                                  //     //     fontWeight: FontWeight.bold,
                                                  //     //     //fontSize: 10.0
                                                  //     //   ),
                                                  //     // ),
                                                  //   ),
                                                  // ),
                                                  const Expanded(
                                                    flex: 1,
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.all(8.0),
                                                      child: AutoSizeText(
                                                        maxLines: 1,
                                                        minFontSize: 8,
                                                        maxFontSize: 15,
                                                        'ยอดสุทธิ(บาท)',
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
                                                            ),
                                                      ),
                                                      //  Text(
                                                      //   'ยอดสุทธิ(บาท)',
                                                      //   textAlign: TextAlign.center,
                                                      //   style: TextStyle(
                                                      //     color: Colors.black,
                                                      //     fontWeight: FontWeight.bold,
                                                      //     //fontSize: 10.0
                                                      //   ),
                                                      // ),
                                                    ),
                                                  ),
                                                  const Expanded(
                                                    flex: 1,
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.all(8.0),
                                                      child: AutoSizeText(
                                                        maxLines: 1,
                                                        minFontSize: 8,
                                                        maxFontSize: 15,
                                                        'ลบ',
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
                                                            ),
                                                      ),
                                                      //  Text(
                                                      //   'ลบ',
                                                      //   textAlign: TextAlign.center,
                                                      //   style: TextStyle(
                                                      //     color: Colors.black,
                                                      //     fontWeight: FontWeight.bold,
                                                      //     //fontSize: 10.0
                                                      //   ),
                                                      // ),
                                                    ),
                                                  ),
                                                ],
                                              )),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              8, 0, 8, 0),
                                          child: Column(
                                            children: [
                                              Container(
                                                constraints: BoxConstraints(
                                                  minHeight:
                                                      250, //minimum height
                                                  minWidth:
                                                      400, // minimum width

                                                  maxHeight: 250,
                                                  //maximum height set to 100% of vertical height

                                                  maxWidth: (!Responsive
                                                          .isDesktop(context))
                                                      ? 1200
                                                      : MediaQuery.of(context)
                                                          .size
                                                          .width,
                                                  //maximum width set to 100% of width
                                                ),
                                                decoration: const BoxDecoration(
                                                  color: AppbackgroundColor
                                                      .Sub_Abg_Colors,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topLeft: Radius
                                                              .circular(0),
                                                          topRight:
                                                              Radius.circular(
                                                                  0),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  0),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  0)),
                                                  // border: Border.all(color: Colors.grey, width: 1),
                                                ),
                                                child: ListView.builder(
                                                  controller:
                                                      _scrollControllers[
                                                          Ser_Sub],
                                                  // itemExtent: 50,
                                                  physics:
                                                      const AlwaysScrollableScrollPhysics(), // const NeverScrollableScrollPhysics(),
                                                  shrinkWrap: true,
                                                  itemCount:
                                                      quotxSelectModels.length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    return Column(
                                                      children: [
                                                        Material(
                                                          color: Step3_tappedIndex_[
                                                                      Ser_Sub] ==
                                                                  index
                                                                      .toString()
                                                              ? tappedIndex_Color
                                                                  .tappedIndex_Colors
                                                              : AppbackgroundColor
                                                                  .Sub_Abg_Colors,
                                                          child: Container(
                                                            // color: Step3_tappedIndex_[Ser_Sub]
                                                            //             .toString() ==
                                                            //         index.toString()
                                                            //     ? tappedIndex_Color
                                                            //         .tappedIndex_Colors
                                                            //         .withOpacity(0.5)
                                                            //     : null,
                                                            child: expTypeModels[
                                                                            Ser_Sub]
                                                                        .ser ==
                                                                    quotxSelectModels[
                                                                            index]
                                                                        .exptser
                                                                ? ListTile(
                                                                    onTap: () {
                                                                      setState(
                                                                          () {
                                                                        Step3_tappedIndex_[Ser_Sub] =
                                                                            index.toString();
                                                                      });
                                                                    },
                                                                    title: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Expanded(
                                                                          flex:
                                                                              2,
                                                                          child:
                                                                              Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            children: [
                                                                              Container(
                                                                                padding: const EdgeInsets.all(8.0),
                                                                                child: AutoSizeText(
                                                                                  maxLines: 2,
                                                                                  minFontSize: 8,
                                                                                  // maxFontSize: 15,
                                                                                  '${quotxSelectModels[index].expname}',
                                                                                  textAlign: TextAlign.start,
                                                                                  style: const TextStyle(
                                                                                      color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                                      // fontWeight: FontWeight.bold,
                                                                                      fontFamily: Font_.Fonts_T

                                                                                      //fontSize: 10.0
                                                                                      ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        Expanded(
                                                                          flex:
                                                                              2,
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8),
                                                                            child: quotxSelectModels[index].dtype == 'KU'
                                                                                ? DropdownButtonFormField2(
                                                                                    decoration: InputDecoration(
                                                                                      isDense: true,
                                                                                      contentPadding: EdgeInsets.zero,
                                                                                      border: OutlineInputBorder(
                                                                                        borderRadius: BorderRadius.circular(10),
                                                                                      ),
                                                                                    ),
                                                                                    isExpanded: true,
                                                                                    hint: Text(
                                                                                      quotxSelectModels[index].unit == null ? 'เลือก' : '${quotxSelectModels[index].unit}',
                                                                                      maxLines: 1,
                                                                                      style: const TextStyle(
                                                                                          fontSize: 14,
                                                                                          color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                                          // fontWeight: FontWeight.bold,
                                                                                          fontFamily: Font_.Fonts_T),
                                                                                    ),
                                                                                    icon: const Icon(
                                                                                      Icons.arrow_drop_down,
                                                                                      color: TextHome_Color.TextHome_Colors,
                                                                                    ),
                                                                                    style: TextStyle(color: Colors.green.shade900, fontFamily: Font_.Fonts_T),
                                                                                    iconSize: 20,
                                                                                    buttonHeight: 50,
                                                                                    // buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                                                                                    dropdownDecoration: BoxDecoration(
                                                                                      borderRadius: BorderRadius.circular(10),
                                                                                    ),
                                                                                    items: unitxModels.map((item) {
                                                                                      // if
                                                                                      return DropdownMenuItem<String>(
                                                                                        value: '${item.ser}:${item.unit}',
                                                                                        child: Text(
                                                                                          item.unit!,
                                                                                          style: const TextStyle(
                                                                                              fontSize: 14,
                                                                                              color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                                              // fontWeight: FontWeight.bold,
                                                                                              fontFamily: Font_.Fonts_T),
                                                                                        ),
                                                                                      );
                                                                                    }).toList(),

                                                                                    onChanged: (value) async {
                                                                                      var zones = value!.indexOf(':');
                                                                                      var unitSer = value.substring(0, zones);
                                                                                      var unitName = value.substring(zones + 1);
                                                                                      print('mmmmm ${unitSer.toString()} $unitName');
                                                                                      var valut_D_start = Value_D_start; //เริ่มสัญญา ป-ด-ว
                                                                                      var valut_D_end = Value_D_end; //หมดสัญญา ป-ด-ว
                                                                                      var valut_D_type = Value_rental_type_2; //วัน เดือน ปี
                                                                                      var valut_D_count = Value_rental_count_; //จำนวน วัน เดือน ปี

                                                                                      setState(() {
                                                                                        unit_ser = int.parse(unitSer);
                                                                                      });

                                                                                      print('MMMMMMMMM $Value_rental_type_3 MMMMM..... $valut_D_start  $valut_D_type  $valut_D_count  ');
                                                                                      SharedPreferences preferences = await SharedPreferences.getInstance();
                                                                                      String? ren = preferences.getString('renTalSer');
                                                                                      String? ser_user = preferences.getString('ser');
                                                                                      var qser = quotxSelectModels[index].ser;

                                                                                      String url = '${MyConstant().domain}/UDUquotx_select.php?isAdd=true&ren=$ren&qser=$qser&unitSer=$unitSer&unitName=$unitName&valut_D_start=$valut_D_start&valut_D_type=$valut_D_type&valut_D_count=$valut_D_count&Value_rental_type_3=$Value_rental_type_3&ser_user=$ser_user';
                                                                                      try {
                                                                                        var response = await http.get(Uri.parse(url));

                                                                                        var result = json.decode(response.body);
                                                                                        print(result);
                                                                                        if (result.toString() != 'null') {
                                                                                          if (quotxSelectModels != 0) {
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
                                                                                    },
                                                                                  )
                                                                                : DropdownButtonFormField2(
                                                                                    decoration: InputDecoration(
                                                                                      isDense: true,
                                                                                      contentPadding: EdgeInsets.zero,
                                                                                      border: OutlineInputBorder(
                                                                                        borderRadius: BorderRadius.circular(10),
                                                                                      ),
                                                                                    ),
                                                                                    isExpanded: true,
                                                                                    hint: Text(
                                                                                      quotxSelectModels[index].unit == null ? 'เลือก' : '${quotxSelectModels[index].unit}',
                                                                                      maxLines: 1,
                                                                                      style: const TextStyle(
                                                                                          fontSize: 14,
                                                                                          color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                                          // fontWeight: FontWeight.bold,
                                                                                          fontFamily: Font_.Fonts_T),
                                                                                    ),
                                                                                    icon: const Icon(
                                                                                      Icons.arrow_drop_down,
                                                                                      color: TextHome_Color.TextHome_Colors,
                                                                                    ),
                                                                                    style: TextStyle(
                                                                                      color: Colors.green.shade900,
                                                                                    ),
                                                                                    iconSize: 20,
                                                                                    buttonHeight: 50,
                                                                                    // buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                                                                                    dropdownDecoration: BoxDecoration(
                                                                                      borderRadius: BorderRadius.circular(10),
                                                                                    ),
                                                                                    items: unitModels.map((item) {
                                                                                      // if (int.parse(Value_rental_type_3) ==
                                                                                      //     1)
                                                                                      return DropdownMenuItem<String>(
                                                                                        value: '${item.ser}:${item.unit}',
                                                                                        child: Text(
                                                                                          item.unit!,
                                                                                          style: const TextStyle(
                                                                                              fontSize: 14,
                                                                                              color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                                              // fontWeight: FontWeight.bold,
                                                                                              fontFamily: Font_.Fonts_T),
                                                                                        ),
                                                                                      );
                                                                                      // } else {}
                                                                                      // return dob;
                                                                                    }).toList(),

                                                                                    onChanged: (value) async {
                                                                                      var zones = value!.indexOf(':');
                                                                                      var unitSer = value.substring(0, zones);
                                                                                      var unitName = value.substring(zones + 1);
                                                                                      print('mmmmm ${unitSer.toString()} $unitName');
                                                                                      var valut_D_start = Value_D_start; //เริ่มสัญญา ป-ด-ว
                                                                                      var valut_D_end = Value_D_end; //หมดสัญญา ป-ด-ว
                                                                                      var valut_D_type = Value_rental_type_2; //วัน เดือน ปี
                                                                                      var valut_D_count = Value_rental_count_; //จำนวน วัน เดือน ปี

                                                                                      print('MMMMMMMMM $Value_rental_type_3 MMMMM..... $valut_D_start  $valut_D_type  $valut_D_count  ');
                                                                                      SharedPreferences preferences = await SharedPreferences.getInstance();
                                                                                      String? ren = preferences.getString('renTalSer');
                                                                                      String? ser_user = preferences.getString('ser');
                                                                                      var qser = quotxSelectModels[index].ser;

                                                                                      String url = '${MyConstant().domain}/UDUquotx_select.php?isAdd=true&ren=$ren&qser=$qser&unitSer=$unitSer&unitName=$unitName&valut_D_start=$valut_D_start&valut_D_type=$valut_D_type&valut_D_count=$valut_D_count&Value_rental_type_3=$Value_rental_type_3&ser_user=$ser_user';
                                                                                      try {
                                                                                        var response = await http.get(Uri.parse(url));

                                                                                        var result = json.decode(response.body);
                                                                                        print(result);
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
                                                                                    },
                                                                                  ),
                                                                          ),
                                                                        ),
                                                                        Expanded(
                                                                          flex:
                                                                              1,
                                                                          child:
                                                                              GestureDetector(
                                                                            onTap:
                                                                                () {
                                                                              var valut_D_count = Value_rental_count_; //จำนวน วัน เดือน ปี
                                                                              print(valut_D_count);
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
                                                                                                  padding: EdgeInsets.all(8.0),
                                                                                                  child: Column(
                                                                                                    children: [
                                                                                                      Container(
                                                                                                        padding: EdgeInsets.all(8.0),
                                                                                                        child: AutoSizeText(
                                                                                                          maxLines: 2,
                                                                                                          minFontSize: 8,
                                                                                                          // maxFontSize: 15,
                                                                                                          'จำนวน ${quotxSelectModels[index].fine} งวด',
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
                                                                                                        textAlign: TextAlign.right,
                                                                                                        initialValue: quotxSelectModels[index].term,
                                                                                                        onFieldSubmitted: (value) async {
                                                                                                          var valut_D = int.parse(value);
                                                                                                          var valut_D_count = int.parse(quotxSelectModels[index].fine.toString());
                                                                                                          // var valut_D_count = int.parse(Value_rental_count_); //จำนวน วัน เดือน ปี

                                                                                                          if (valut_D <= valut_D_count && valut_D > 0) {
                                                                                                            Navigator.of(context).pop();
                                                                                                            print('$valut_D T $valut_D_count');
                                                                                                            SharedPreferences preferences = await SharedPreferences.getInstance();
                                                                                                            String? ren = preferences.getString('renTalSer');
                                                                                                            String? ser_user = preferences.getString('ser');
                                                                                                            var qser = quotxSelectModels[index].ser;
                                                                                                            String url = '${MyConstant().domain}/UDTERMquotx_select.php?isAdd=true&ren=$ren&qser=$qser&value=$value&ser_user=$ser_user';

                                                                                                            try {
                                                                                                              var response = await http.get(Uri.parse(url));

                                                                                                              var result = json.decode(response.body);
                                                                                                              print(result);
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
                                                                                                          } else {
                                                                                                            ScaffoldMessenger.of(context).showSnackBar(
                                                                                                              SnackBar(content: Text('จำนวนงวดไม่ถูกต้องกรุณาลองใหม่!', style: TextStyle(color: Colors.white, fontFamily: Font_.Fonts_T))),
                                                                                                            );
                                                                                                            print('$valut_D E $valut_D_count');
                                                                                                          }
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
                                                                                                                fontFamily: Font_.Fonts_T)),
                                                                                                        inputFormatters: <TextInputFormatter>[
                                                                                                          // for below version 2 use this
                                                                                                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                                                                                          // for version 2 and greater youcan also use this
                                                                                                          FilteringTextInputFormatter.digitsOnly
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
                                                                                  });
                                                                            },
                                                                            child:
                                                                                Padding(
                                                                              padding: EdgeInsets.all(8.0),
                                                                              child: AutoSizeText(
                                                                                maxLines: 2,
                                                                                minFontSize: 8,
                                                                                // maxFontSize: 15,
                                                                                '${quotxSelectModels[index].term}', //  var valut_D_count = Value_rental_count_; //จำนวน วัน เดือน ปี
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
                                                                          flex:
                                                                              1,
                                                                          child:
                                                                              Container(
                                                                            height:
                                                                                45,
                                                                            // decoration:
                                                                            //     BoxDecoration(
                                                                            //   // color: Colors.green,
                                                                            //   borderRadius:
                                                                            //       const BorderRadius.only(
                                                                            //     topLeft: Radius.circular(15),
                                                                            //     topRight: Radius.circular(15),
                                                                            //     bottomLeft: Radius.circular(15),
                                                                            //     bottomRight: Radius.circular(15),
                                                                            //   ),
                                                                            //   border:
                                                                            //       Border.all(color: Colors.grey, width: 1),
                                                                            // ),
                                                                            child: quotxSelectModels[index].term == '1'
                                                                                ? InkWell(
                                                                                    onTap: () async {
                                                                                      DateTime? newDate = await showDatePicker(
                                                                                        // locale: const Locale('th', 'TH'),
                                                                                        context: context,
                                                                                        initialDate: DateTime.now(),
                                                                                        firstDate: DateTime(1000, 1, 01),
                                                                                        lastDate: DateTime.now().add(const Duration(days: 50)),
                                                                                        builder: (context, child) {
                                                                                          return Theme(
                                                                                            data: Theme.of(context).copyWith(
                                                                                              colorScheme: const ColorScheme.light(
                                                                                                primary: AppBarColors.ABar_Colors, // header background color
                                                                                                onPrimary: Colors.white, // header text color
                                                                                                onSurface: Colors.black, // body text color
                                                                                              ),
                                                                                              textButtonTheme: TextButtonThemeData(
                                                                                                style: TextButton.styleFrom(
                                                                                                  primary: Colors.black, // button text color
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                            child: child!,
                                                                                          );
                                                                                        },
                                                                                      );

                                                                                      if (newDate == null) {
                                                                                        return;
                                                                                      } else {
                                                                                        print('$newDate');
                                                                                        String start = DateFormat('yyyy-MM-dd').format(newDate);
                                                                                        String? sdatex = DateFormat('yyyy-MM').format(DateTime.parse('${quotxSelectModels[index].sdate} 00:00:00'));

                                                                                        String? ldatex = DateFormat('yyyy-MM').format(DateTime.parse('${quotxSelectModels[index].ldate} 00:00:00'));

                                                                                        String value = DateFormat('dd').format(DateTime.parse('$start 00:00:00')).toString();

                                                                                        String StDay = '$start';
                                                                                        String EtDay = '$ldatex-$value';

                                                                                        print('$StDay $EtDay ...... ');

                                                                                        SharedPreferences preferences = await SharedPreferences.getInstance();
                                                                                        String? ren = preferences.getString('renTalSer');
                                                                                        String? ser_user = preferences.getString('ser');
                                                                                        var qser = quotxSelectModels[index].ser;
                                                                                        String url = '${MyConstant().domain}/UDDquotx_select.php?isAdd=true&ren=$ren&qser=$qser&start=$StDay&end=$EtDay&ser_user=$ser_user';

                                                                                        try {
                                                                                          var response = await http.get(Uri.parse(url));

                                                                                          var result = json.decode(response.body);
                                                                                          print(result);
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
                                                                                    },
                                                                                    child: Container(
                                                                                      alignment: Alignment.center,
                                                                                      padding: EdgeInsets.all(5.0),
                                                                                      decoration: BoxDecoration(
                                                                                        // color: Colors.green,
                                                                                        borderRadius: const BorderRadius.only(
                                                                                          topLeft: Radius.circular(15),
                                                                                          topRight: Radius.circular(15),
                                                                                          bottomLeft: Radius.circular(15),
                                                                                          bottomRight: Radius.circular(15),
                                                                                        ),
                                                                                        border: Border.all(color: Colors.grey, width: 1),
                                                                                      ),
                                                                                      child: AutoSizeText(
                                                                                        DateFormat('dd-MM-yyyy').format(DateTime.parse('${quotxSelectModels[index].sdate!} 00:00:00')).toString(),
                                                                                        minFontSize: 9,
                                                                                        maxFontSize: 16,
                                                                                        textAlign: TextAlign.start,
                                                                                        style: const TextStyle(
                                                                                          color: PeopleChaoScreen_Color.Colors_Text2_,

                                                                                          fontFamily: Font_.Fonts_T,
                                                                                          //fontWeight: FontWeight.bold,
                                                                                          //fontSize: 10.0
                                                                                        ),
                                                                                        maxLines: 1,
                                                                                        overflow: TextOverflow.ellipsis,
                                                                                      ),
                                                                                    ),
                                                                                  )
                                                                                : DropdownButtonFormField2(
                                                                                    decoration: InputDecoration(
                                                                                      //Add isDense true and zero Padding.
                                                                                      //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                                                                                      isDense: true,
                                                                                      contentPadding: EdgeInsets.zero,
                                                                                      border: OutlineInputBorder(
                                                                                        borderRadius: BorderRadius.circular(15),
                                                                                      ),
                                                                                      //Add more decoration as you want here
                                                                                      //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                                                                                    ),
                                                                                    isExpanded: true,
                                                                                    // disabledHint: Icon(Icons.time_to_leave, color: Colors.black),
                                                                                    hint: Row(
                                                                                      children: [
                                                                                        Text(
                                                                                          DateFormat('dd').format(DateTime.parse('${quotxSelectModels[index].sdate!} 00:00:00')).toString(),
                                                                                          style: const TextStyle(
                                                                                              fontSize: 14,
                                                                                              color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                                              // fontWeight: FontWeight.bold,
                                                                                              fontFamily: Font_.Fonts_T),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                    icon: Visibility(visible: false, child: Icon(Icons.arrow_downward)),
                                                                                    // icon: const Icon(
                                                                                    //   Icons.arrow_drop_down,
                                                                                    //   color: Colors.black45,
                                                                                    // ),
                                                                                    iconSize: 30,
                                                                                    buttonHeight: 60,
                                                                                    buttonPadding: const EdgeInsets.only(left: 10, right: 10),
                                                                                    dropdownDecoration: BoxDecoration(
                                                                                      borderRadius: BorderRadius.circular(15),
                                                                                    ),
                                                                                    items: dateselect
                                                                                        .map((item) => DropdownMenuItem<String>(
                                                                                              value: item,
                                                                                              child: Text(
                                                                                                item,
                                                                                                style: const TextStyle(
                                                                                                    fontSize: 14,
                                                                                                    color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                                                    // fontWeight: FontWeight.bold,
                                                                                                    fontFamily: Font_.Fonts_T),
                                                                                              ),
                                                                                            ))
                                                                                        .toList(),
                                                                                    onChanged: (value) async {
                                                                                      String? sdatex = DateFormat('yyyy-MM').format(DateTime.parse('${quotxSelectModels[index].sdate} 00:00:00'));

                                                                                      String? ldatex = DateFormat('yyyy-MM').format(DateTime.parse('${quotxSelectModels[index].ldate} 00:00:00'));

                                                                                      // String start = DateFormat('dd').format(newDate);

                                                                                      String StDay = '$sdatex-$value';
                                                                                      String EtDay = '$ldatex-$value';

                                                                                      print('$StDay $EtDay ...... ');

                                                                                      SharedPreferences preferences = await SharedPreferences.getInstance();
                                                                                      String? ren = preferences.getString('renTalSer');
                                                                                      String? ser_user = preferences.getString('ser');
                                                                                      var qser = quotxSelectModels[index].ser;
                                                                                      String url = '${MyConstant().domain}/UDDquotx_select.php?isAdd=true&ren=$ren&qser=$qser&start=$StDay&end=$EtDay&ser_user=$ser_user';

                                                                                      try {
                                                                                        var response = await http.get(Uri.parse(url));

                                                                                        var result = json.decode(response.body);
                                                                                        print(result);
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
                                                                                    },
                                                                                    onSaved: (value) {
                                                                                      // selectedValue = value.toString();
                                                                                    },
                                                                                  ),
                                                                            // InkWell(
                                                                            //   onTap:
                                                                            //       () async {
                                                                            //     DateTime? newDate = await showDatePicker(
                                                                            //       locale: const Locale('th', 'TH'),
                                                                            //       context: context,
                                                                            //       initialDate: DateTime.now(),
                                                                            //       firstDate: DateTime(2023),
                                                                            //       lastDate: DateTime(2023, 31),
                                                                            //       builder: (context, child) {
                                                                            //         return Theme(
                                                                            //           data: Theme.of(context).copyWith(
                                                                            //             colorScheme: const ColorScheme.light(
                                                                            //               primary: AppBarColors.ABar_Colors, // header background color
                                                                            //               onPrimary: Colors.white, // header text color
                                                                            //               onSurface: Colors.black, // body text color
                                                                            //             ),
                                                                            //             textButtonTheme: TextButtonThemeData(
                                                                            //               style: TextButton.styleFrom(
                                                                            //                 primary: Colors.black, // button text color
                                                                            //               ),
                                                                            //             ),
                                                                            //           ),
                                                                            //           child: child!,
                                                                            //         );
                                                                            //       },
                                                                            //     );

                                                                            //     if (newDate == null) {
                                                                            //       return;
                                                                            //     } else {
                                                                            //       // var term = int.parse(
                                                                            //       //     quotxSelectModels[index]
                                                                            //       //         .term!);
                                                                            //       // var countday =
                                                                            //       //     int.parse(
                                                                            //       //         quotxSelectModels[index].day!);

                                                                            //       // var birthday =
                                                                            //       //     newDate.add(Duration(
                                                                            //       //         days:
                                                                            //       //             countday));
                                                                            //       // String start = DateFormat(
                                                                            //       //         'yyyy-MM-dd')
                                                                            //       //     .format(
                                                                            //       //         newDate);
                                                                            //       // String end = DateFormat(
                                                                            //       //         'yyyy-MM-dd')
                                                                            //       //     .format(
                                                                            //       //         birthday);
                                                                            //       String? sdatex = DateFormat('yyyy-MM').format(DateTime.parse('${quotxSelectModels[index].sdate} 00:00:00'));

                                                                            //       String? ldatex = DateFormat('yyyy-MM').format(DateTime.parse('${quotxSelectModels[index].ldate} 00:00:00'));

                                                                            //       String start = DateFormat('dd').format(newDate);

                                                                            //       String StDay = '$sdatex-$start';
                                                                            //       String EtDay = '$ldatex-$start';

                                                                            //       print('$StDay $EtDay ...... ');

                                                                            //       SharedPreferences preferences = await SharedPreferences.getInstance();
                                                                            //       String? ren = preferences.getString('renTalSer');
                                                                            //       String? ser_user = preferences.getString('ser');
                                                                            //       var qser = quotxSelectModels[index].ser;
                                                                            //       String url = '${MyConstant().domain}/UDDquotx_select.php?isAdd=true&ren=$ren&qser=$qser&start=$StDay&end=$EtDay&ser_user=$ser_user';

                                                                            //       try {
                                                                            //         var response = await http.get(Uri.parse(url));

                                                                            //         var result = json.decode(response.body);
                                                                            //         print(result);
                                                                            //         if (result.toString() != 'null') {
                                                                            //           if (quotxSelectModels.isNotEmpty) {
                                                                            //             setState(() {
                                                                            //               quotxSelectModels.clear();
                                                                            //             });
                                                                            //           }
                                                                            //           for (var map in result) {
                                                                            //             QuotxSelectModel quotxSelectModel = QuotxSelectModel.fromJson(map);
                                                                            //             setState(() {
                                                                            //               quotxSelectModels.add(quotxSelectModel);
                                                                            //             });
                                                                            //           }
                                                                            //         } else {
                                                                            //           setState(() {
                                                                            //             quotxSelectModels.clear();
                                                                            //           });
                                                                            //         }
                                                                            //       } catch (e) {}
                                                                            //     }
                                                                            //   },
                                                                            //   child:
                                                                            //       Container(
                                                                            //     padding: const EdgeInsets.all(8),
                                                                            //     child: AutoSizeText(
                                                                            //       '${DateFormat('dd').format(DateTime.parse('${quotxSelectModels[index].sdate!} 00:00:00'))}',
                                                                            //       minFontSize: 9,
                                                                            //       maxFontSize: 16,
                                                                            //       textAlign: TextAlign.center,
                                                                            //       style: const TextStyle(
                                                                            //           color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                            //           // fontWeight: FontWeight.bold,
                                                                            //           fontFamily: Font_.Fonts_T
                                                                            //           // fontWeight: FontWeight.bold,
                                                                            //           ),
                                                                            //       maxLines: 1,
                                                                            //       overflow: TextOverflow.ellipsis,
                                                                            //     ),
                                                                            //   ),
                                                                            // ),
                                                                          ),
                                                                          // AutoSizeText(
                                                                          //   maxLines: 2,
                                                                          //   minFontSize: 8,
                                                                          //   // maxFontSize: 15,
                                                                          //   '${quotxSelectModels[index].sdate}',
                                                                          //   textAlign:
                                                                          //       TextAlign
                                                                          //           .center,
                                                                          //   style:
                                                                          //       const TextStyle(
                                                                          //     color: TextHome_Color
                                                                          //         .TextHome_Colors,

                                                                          //     //fontSize: 10.0
                                                                          //   ),
                                                                          // ),
                                                                        ),
                                                                        // Expanded(
                                                                        //   flex: 1,
                                                                        //   child: AutoSizeText(
                                                                        //     maxLines: 2,
                                                                        //     minFontSize: 8,
                                                                        //     // maxFontSize: 15,
                                                                        //     '${quotxSelectModels[index].ldate}',
                                                                        //     textAlign:
                                                                        //         TextAlign
                                                                        //             .center,
                                                                        //     style:
                                                                        //         const TextStyle(
                                                                        //       color: TextHome_Color
                                                                        //           .TextHome_Colors,

                                                                        //       //fontSize: 10.0
                                                                        //     ),
                                                                        //   ),
                                                                        // ),
                                                                        int.parse(quotxSelectModels[index].sunit!) ==
                                                                                6
                                                                            ? const Expanded(
                                                                                flex: 1,
                                                                                child: AutoSizeText(
                                                                                  maxLines: 2,
                                                                                  minFontSize: 8,
                                                                                  maxFontSize: 15,
                                                                                  '0.00',
                                                                                  textAlign: TextAlign.right,
                                                                                  style: TextStyle(
                                                                                    color: TextHome_Color.TextHome_Colors,

                                                                                    //fontSize: 10.0
                                                                                  ),
                                                                                ),
                                                                              )
                                                                            : Expanded(
                                                                                flex: 1,
                                                                                child: Container(
                                                                                  height: 45,
                                                                                  child: InkWell(
                                                                                    onTap: () {
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
                                                                                                                  '${quotxSelectModels[index].expname}',
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
                                                                                                                textAlign: TextAlign.right,
                                                                                                                initialValue: quotxSelectModels[index].amt, // nFormat.format(double.parse(quotxSelectModels[index].amt!)),
                                                                                                                // onChanged: (value) async {
                                                                                                                //   SharedPreferences preferences = await SharedPreferences.getInstance();
                                                                                                                //   String? ren = preferences.getString('renTalSer');
                                                                                                                //   String? ser_user = preferences.getString('ser');
                                                                                                                //   var qser = quotxSelectModels[index].ser;
                                                                                                                //   String url = '${MyConstant().domain}/UDBquotx_select.php?isAdd=true&ren=$ren&qser=$qser&qty=$value&ser_user=$ser_user';

                                                                                                                //   try {
                                                                                                                //     var response = await http.get(Uri.parse(url));

                                                                                                                //     var result = json.decode(response.body);
                                                                                                                //     print(result);
                                                                                                                //     if (result.toString() != 'null') {
                                                                                                                //       if (quotxSelectModels.isNotEmpty) {
                                                                                                                //         setState(() {
                                                                                                                //           quotxSelectModels.clear();
                                                                                                                //         });
                                                                                                                //       }
                                                                                                                //       for (var map in result) {
                                                                                                                //         QuotxSelectModel quotxSelectModel = QuotxSelectModel.fromJson(map);
                                                                                                                //         setState(() {
                                                                                                                //           quotxSelectModels.add(quotxSelectModel);
                                                                                                                //         });
                                                                                                                //       }
                                                                                                                //     } else {
                                                                                                                //       setState(() {
                                                                                                                //         quotxSelectModels.clear();
                                                                                                                //       });
                                                                                                                //     }
                                                                                                                //   } catch (e) {}
                                                                                                                // },
                                                                                                                onFieldSubmitted: (value) async {
                                                                                                                  SharedPreferences preferences = await SharedPreferences.getInstance();
                                                                                                                  String? ren = preferences.getString('renTalSer');
                                                                                                                  String? ser_user = preferences.getString('ser');
                                                                                                                  var qser = quotxSelectModels[index].ser;
                                                                                                                  String url = '${MyConstant().domain}/UDBquotx_select.php?isAdd=true&ren=$ren&qser=$qser&qty=$value&ser_user=$ser_user';

                                                                                                                  try {
                                                                                                                    var response = await http.get(Uri.parse(url));

                                                                                                                    var result = json.decode(response.body);
                                                                                                                    print(result);
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
                                                                                                                      Navigator.of(context).pop();
                                                                                                                    } else {
                                                                                                                      setState(() {
                                                                                                                        quotxSelectModels.clear();
                                                                                                                      });
                                                                                                                    }
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
                                                                                                                        fontFamily: Font_.Fonts_T)),
                                                                                                                // inputFormatters: <
                                                                                                                //     TextInputFormatter>[
                                                                                                                //   // for below version 2 use this
                                                                                                                //   FilteringTextInputFormatter
                                                                                                                //       .allow(RegExp(
                                                                                                                //           r'[0-9]')),
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
                                                                                          });
                                                                                    },
                                                                                    child: Container(
                                                                                        height: 45,
                                                                                        decoration: BoxDecoration(
                                                                                          borderRadius: BorderRadius.only(
                                                                                            topRight: Radius.circular(15),
                                                                                            topLeft: Radius.circular(15),
                                                                                            bottomRight: Radius.circular(15),
                                                                                            bottomLeft: Radius.circular(15),
                                                                                          ),
                                                                                          border: Border.all(
                                                                                            width: 1,
                                                                                            color: Colors.grey,
                                                                                          ),
                                                                                        ),
                                                                                        padding: const EdgeInsets.all(3.0),
                                                                                        child: Text(
                                                                                          '${quotxSelectModels[index].amt}',
                                                                                          textAlign: TextAlign.end,
                                                                                          style: TextStyle(
                                                                                            color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                                            fontFamily: Font_.Fonts_T,
                                                                                          ),
                                                                                        )),
                                                                                  ),
                                                                                  // TextFormField(
                                                                                  //   textAlign: TextAlign.right,
                                                                                  //   initialValue: nFormat.format(double.parse(quotxSelectModels[index].amt!)),
                                                                                  //   //onChanged
                                                                                  //   onChanged: (value) async {
                                                                                  //     SharedPreferences preferences = await SharedPreferences.getInstance();
                                                                                  //     String? ren = preferences.getString('renTalSer');
                                                                                  //     String? ser_user = preferences.getString('ser');
                                                                                  //     var qser = quotxSelectModels[index].ser;
                                                                                  //     String url = '${MyConstant().domain}/UDBquotx_select.php?isAdd=true&ren=$ren&qser=$qser&qty=$value&ser_user=$ser_user';

                                                                                  //     try {
                                                                                  //       var response = await http.get(Uri.parse(url));

                                                                                  //       var result = json.decode(response.body);
                                                                                  //       print(result);
                                                                                  //       if (result.toString() != 'null') {
                                                                                  //         if (quotxSelectModels.isNotEmpty) {
                                                                                  //           setState(() {
                                                                                  //             quotxSelectModels.clear();
                                                                                  //           });
                                                                                  //         }
                                                                                  //         for (var map in result) {
                                                                                  //           QuotxSelectModel quotxSelectModel = QuotxSelectModel.fromJson(map);
                                                                                  //           setState(() {
                                                                                  //             quotxSelectModels.add(quotxSelectModel);
                                                                                  //           });
                                                                                  //         }
                                                                                  //       } else {
                                                                                  //         setState(() {
                                                                                  //           quotxSelectModels.clear();
                                                                                  //         });
                                                                                  //       }
                                                                                  //     } catch (e) {}
                                                                                  //   },
                                                                                  //   // maxLength: 13,
                                                                                  //   cursorColor: Colors.green,
                                                                                  //   decoration: InputDecoration(
                                                                                  //       fillColor: Colors.white.withOpacity(0.05),
                                                                                  //       filled: true,
                                                                                  //       // prefixIcon:
                                                                                  //       //     const Icon(Icons.key, color: Colors.black),
                                                                                  //       // suffixIcon: Icon(Icons.clear, color: Colors.black),
                                                                                  //       focusedBorder: const OutlineInputBorder(
                                                                                  //         borderRadius: BorderRadius.only(
                                                                                  //           topRight: Radius.circular(15),
                                                                                  //           topLeft: Radius.circular(15),
                                                                                  //           bottomRight: Radius.circular(15),
                                                                                  //           bottomLeft: Radius.circular(15),
                                                                                  //         ),
                                                                                  //         borderSide: BorderSide(
                                                                                  //           width: 1,
                                                                                  //           color: Colors.grey,
                                                                                  //         ),
                                                                                  //       ),
                                                                                  //       enabledBorder: const OutlineInputBorder(
                                                                                  //         borderRadius: BorderRadius.only(
                                                                                  //           topRight: Radius.circular(15),
                                                                                  //           topLeft: Radius.circular(15),
                                                                                  //           bottomRight: Radius.circular(15),
                                                                                  //           bottomLeft: Radius.circular(15),
                                                                                  //         ),
                                                                                  //         borderSide: BorderSide(
                                                                                  //           width: 1,
                                                                                  //           color: Colors.grey,
                                                                                  //         ),
                                                                                  //       ),
                                                                                  //       // labelText: 'PASSWOED',
                                                                                  //       labelStyle: const TextStyle(
                                                                                  //           color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                                  //           // fontWeight: FontWeight.bold,
                                                                                  //           fontFamily: Font_.Fonts_T)),
                                                                                  //   // inputFormatters: <
                                                                                  //   //     TextInputFormatter>[
                                                                                  //   //   // for below version 2 use this
                                                                                  //   //   FilteringTextInputFormatter
                                                                                  //   //       .allow(RegExp(
                                                                                  //   //           r'[0-9]')),
                                                                                  //   //   // for version 2 and greater youcan also use this
                                                                                  //   //   FilteringTextInputFormatter
                                                                                  //   //       .digitsOnly
                                                                                  //   // ],
                                                                                  // ),
                                                                                ),
                                                                                //     AutoSizeText(
                                                                                //   maxLines:
                                                                                //       2,
                                                                                //   minFontSize:
                                                                                //       8,
                                                                                //   // maxFontSize: 15,
                                                                                //   '${quotxSelectModels[index].amt}',
                                                                                //   textAlign:
                                                                                //       TextAlign.center,
                                                                                //   style:
                                                                                //       const TextStyle(
                                                                                //     color:
                                                                                //         TextHome_Color.TextHome_Colors,

                                                                                //     //fontSize: 10.0
                                                                                //   ),
                                                                                // ),
                                                                              ),
                                                                        Expanded(
                                                                          flex:
                                                                              1,
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8),
                                                                            child:
                                                                                DropdownButtonFormField2(
                                                                              decoration: InputDecoration(
                                                                                isDense: true,
                                                                                contentPadding: EdgeInsets.zero,
                                                                                border: OutlineInputBorder(
                                                                                  borderRadius: BorderRadius.circular(10),
                                                                                ),
                                                                              ),
                                                                              isExpanded: true,
                                                                              hint: Text(
                                                                                quotxSelectModels[index].vtype == null || quotxSelectModels[index].vtype == 'null' ? 'เลือก' : '${quotxSelectModels[index].vtype}',
                                                                                maxLines: 1,
                                                                                style: const TextStyle(
                                                                                    fontSize: 14,
                                                                                    color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                                    // fontWeight: FontWeight.bold,
                                                                                    fontFamily: Font_.Fonts_T),
                                                                              ),
                                                                              icon: const Icon(
                                                                                Icons.arrow_drop_down,
                                                                                color: TextHome_Color.TextHome_Colors,
                                                                              ),
                                                                              style: TextStyle(color: Colors.green.shade900, fontFamily: Font_.Fonts_T),
                                                                              iconSize: 20,
                                                                              buttonHeight: 50,
                                                                              // buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                                                                              dropdownDecoration: BoxDecoration(
                                                                                borderRadius: BorderRadius.circular(10),
                                                                              ),
                                                                              items: vatModels
                                                                                  .map((item) => DropdownMenuItem<String>(
                                                                                        value: '${item.ser}:${item.vat}',
                                                                                        child: Text(
                                                                                          item.vat!,
                                                                                          style: const TextStyle(
                                                                                              fontSize: 14,
                                                                                              color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                                              // fontWeight: FontWeight.bold,
                                                                                              fontFamily: Font_.Fonts_T),
                                                                                        ),
                                                                                      ))
                                                                                  .toList(),

                                                                              onChanged: (value) async {
                                                                                var zones = value!.indexOf(':');
                                                                                var vatSer = value.substring(0, zones);
                                                                                var vatName = value.substring(zones + 1);
                                                                                print('mmmmm ${vatSer.toString()} $vatName');

                                                                                SharedPreferences preferences = await SharedPreferences.getInstance();
                                                                                String? ren = preferences.getString('renTalSer');
                                                                                String? ser_user = preferences.getString('ser');
                                                                                var qser = quotxSelectModels[index].ser;

                                                                                var amt = quotxSelectModels[index].amt;

                                                                                print('object>>> $amt');

                                                                                String url = '${MyConstant().domain}/UDVquotx_select.php?isAdd=true&ren=$ren&qser=$qser&vatSer=$vatSer&vatName=$vatName&amt=$amt&ser_user=$ser_user';
                                                                                try {
                                                                                  var response = await http.get(Uri.parse(url));

                                                                                  var result = json.decode(response.body);
                                                                                  print(result);
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
                                                                              },
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Expanded(
                                                                          flex:
                                                                              1,
                                                                          child:
                                                                              AutoSizeText(
                                                                            maxLines:
                                                                                2,
                                                                            minFontSize:
                                                                                8,
                                                                            // maxFontSize: 15,
                                                                            '${quotxSelectModels[index].vat}',
                                                                            textAlign:
                                                                                TextAlign.right,
                                                                            style: const TextStyle(
                                                                                color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                                // fontWeight: FontWeight.bold,
                                                                                fontFamily: Font_.Fonts_T),
                                                                          ),
                                                                        ),
                                                                        // if ((Value_AreaSer_ +
                                                                        //         1) ==
                                                                        //     1)
                                                                        //   const SizedBox()
                                                                        // else
                                                                        Expanded(
                                                                          flex:
                                                                              1,
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8),
                                                                            child:
                                                                                DropdownButtonFormField2(
                                                                              decoration: InputDecoration(
                                                                                isDense: true,
                                                                                contentPadding: EdgeInsets.zero,
                                                                                border: OutlineInputBorder(
                                                                                  borderRadius: BorderRadius.circular(10),
                                                                                ),
                                                                              ),
                                                                              isExpanded: true,
                                                                              hint: Text(
                                                                                quotxSelectModels[index].nwht == null || quotxSelectModels[index].nwht == 'null' ? 'เลือก' : '${quotxSelectModels[index].nwht} %',
                                                                                maxLines: 1,
                                                                                style: const TextStyle(
                                                                                    fontSize: 14,
                                                                                    color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                                    // fontWeight: FontWeight.bold,
                                                                                    fontFamily: Font_.Fonts_T),
                                                                              ),
                                                                              icon: const Icon(
                                                                                Icons.arrow_drop_down,
                                                                                color: Colors.black,
                                                                              ),
                                                                              style: TextStyle(color: Colors.green.shade900, fontFamily: Font_.Fonts_T),
                                                                              iconSize: 20,
                                                                              buttonHeight: 50,
                                                                              // buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                                                                              dropdownDecoration: BoxDecoration(
                                                                                borderRadius: BorderRadius.circular(10),
                                                                              ),
                                                                              items: whtModels
                                                                                  .map((item) => DropdownMenuItem<String>(
                                                                                        value: '${item.ser}:${item.wht}',
                                                                                        child: Text(
                                                                                          item.wht!,
                                                                                          style: const TextStyle(
                                                                                              fontSize: 14,
                                                                                              color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                                              // fontWeight: FontWeight.bold,
                                                                                              fontFamily: Font_.Fonts_T),
                                                                                        ),
                                                                                      ))
                                                                                  .toList(),

                                                                              onChanged: (value) async {
                                                                                var zones = value!.indexOf(':');
                                                                                var whtSer = value.substring(0, zones);
                                                                                var whtName = value.substring(zones + 1);
                                                                                print('mmmmm ${whtSer.toString()} $whtName');

                                                                                SharedPreferences preferences = await SharedPreferences.getInstance();
                                                                                String? ren = preferences.getString('renTalSer');
                                                                                String? ser_user = preferences.getString('ser');
                                                                                var qser = quotxSelectModels[index].ser;

                                                                                var amt = quotxSelectModels[index].amt;

                                                                                print('object>>> $amt');

                                                                                String url = '${MyConstant().domain}/UDWquotx_select.php?isAdd=true&ren=$ren&qser=$qser&whtSer=$whtSer&whtName=$whtName&amt=$amt&ser_user=$ser_user';
                                                                                try {
                                                                                  var response = await http.get(Uri.parse(url));

                                                                                  var result = json.decode(response.body);
                                                                                  print(result);
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
                                                                              },
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        // if ((Value_AreaSer_ +
                                                                        //         1) ==
                                                                        //     1)
                                                                        //   const SizedBox()
                                                                        // else
                                                                        Expanded(
                                                                          flex:
                                                                              1,
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
                                                                            child:
                                                                                AutoSizeText(
                                                                              maxLines: 2,
                                                                              minFontSize: 8,
                                                                              // maxFontSize: 15,
                                                                              '${quotxSelectModels[index].wht}',
                                                                              textAlign: TextAlign.right,
                                                                              style: const TextStyle(
                                                                                  color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                                  // fontWeight: FontWeight.bold,
                                                                                  fontFamily: Font_.Fonts_T

                                                                                  //fontSize: 10.0
                                                                                  ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Expanded(
                                                                          flex:
                                                                              1,
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
                                                                            child:
                                                                                AutoSizeText(
                                                                              maxLines: 2,
                                                                              minFontSize: 8,
                                                                              // maxFontSize: 15,
                                                                              '${nFormat.format(double.parse(quotxSelectModels[index].total!))}',
                                                                              textAlign: TextAlign.right,
                                                                              style: const TextStyle(
                                                                                  color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                                  // fontWeight: FontWeight.bold,
                                                                                  fontFamily: Font_.Fonts_T

                                                                                  //fontSize: 10.0
                                                                                  ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Expanded(
                                                                          flex:
                                                                              1,
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
                                                                            child:
                                                                                InkWell(
                                                                              onTap: () async {
                                                                                var qser = quotxSelectModels[index].ser;
                                                                                SharedPreferences preferences = await SharedPreferences.getInstance();
                                                                                String? ren = preferences.getString('renTalSer');
                                                                                String? ser_user = preferences.getString('ser');
                                                                                String url = '${MyConstant().domain}/Dquotx_select.php?isAdd=true&ren=$ren&qser=$qser&ser_user=$ser_user';

                                                                                try {
                                                                                  var response = await http.get(Uri.parse(url));

                                                                                  var result = json.decode(response.body);
                                                                                  print(result);
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
                                                                              },
                                                                              child: Container(
                                                                                  // decoration:
                                                                                  //     const BoxDecoration(
                                                                                  //   color: Colors
                                                                                  //       .red,
                                                                                  //   borderRadius: BorderRadius.only(
                                                                                  //       topLeft:
                                                                                  //           Radius.circular(
                                                                                  //               10),
                                                                                  //       topRight:
                                                                                  //           Radius.circular(
                                                                                  //               10),
                                                                                  //       bottomLeft:
                                                                                  //           Radius.circular(
                                                                                  //               10),
                                                                                  //       bottomRight:
                                                                                  //           Radius.circular(
                                                                                  //               10)),
                                                                                  // ),
                                                                                  padding: const EdgeInsets.all(8.0),
                                                                                  child: const Icon(
                                                                                    Icons.delete,
                                                                                    color: Colors.red,
                                                                                  )),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ))
                                                                : null,
                                                          ),
                                                        ),
                                                        int.parse(quotxSelectModels[
                                                                        index]
                                                                    .sunit!) !=
                                                                6
                                                            ? const SizedBox()
                                                            : Container(
                                                                // color: Step3_tappedIndex_[Ser_Sub]
                                                                //             .toString() ==
                                                                //         index.toString()
                                                                //     ? tappedIndex_Color
                                                                //         .tappedIndex_Colors
                                                                //         .withOpacity(0.5)
                                                                //     : null,
                                                                child: expTypeModels[Ser_Sub]
                                                                            .ser ==
                                                                        quotxSelectModels[index]
                                                                            .exptser
                                                                    ? ListTile(
                                                                        onTap:
                                                                            () {
                                                                          setState(
                                                                              () {
                                                                            Step3_tappedIndex_[Ser_Sub] =
                                                                                index.toString();
                                                                          });
                                                                        },
                                                                        title:
                                                                            Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          children: [
                                                                            Expanded(
                                                                              flex: 5,
                                                                              child: Container(
                                                                                height: 45,
                                                                              ),
                                                                            ),
                                                                            Expanded(
                                                                              flex: 2,
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.all(8.0),
                                                                                child: InkWell(
                                                                                  onTap: () {
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
                                                                                                                'เลขเครื่อง ${quotxSelectModels[index].meter}',
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
                                                                                                              initialValue: quotxSelectModels[index].meter,
                                                                                                              onFieldSubmitted: (value) async {
                                                                                                                SharedPreferences preferences = await SharedPreferences.getInstance();
                                                                                                                String? ren = preferences.getString('renTalSer');
                                                                                                                String? ser_user = preferences.getString('ser');
                                                                                                                var qser = quotxSelectModels[index].ser;
                                                                                                                String url = '${MyConstant().domain}/UMTquotx_select.php?isAdd=true&ren=$ren&qser=$qser&qty=$value&ser_user=$ser_user';

                                                                                                                try {
                                                                                                                  var response = await http.get(Uri.parse(url));

                                                                                                                  var result = json.decode(response.body);
                                                                                                                  print(result);
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
                                                                                                                  labelText: 'เลขเครื่อง',
                                                                                                                  labelStyle: const TextStyle(
                                                                                                                      color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                                                                      // fontWeight: FontWeight.bold,
                                                                                                                      fontFamily: Font_.Fonts_T)),
                                                                                                              inputFormatters: <TextInputFormatter>[
                                                                                                                // for below version 2 use this
                                                                                                                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                                                                                                // for version 2 and greater youcan also use this
                                                                                                                FilteringTextInputFormatter.digitsOnly
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
                                                                                        });
                                                                                  },
                                                                                  child: Column(
                                                                                    children: [
                                                                                      Text(
                                                                                        'เลขเครื่อง ',
                                                                                        textAlign: TextAlign.start,
                                                                                        style: TextStyle(
                                                                                          color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                                          fontFamily: Font_.Fonts_T,
                                                                                          fontSize: 15,
                                                                                        ),
                                                                                      ),
                                                                                      Row(
                                                                                        children: [
                                                                                          Expanded(
                                                                                            child: Container(
                                                                                              height: 40,
                                                                                              decoration: BoxDecoration(
                                                                                                borderRadius: BorderRadius.only(
                                                                                                  topRight: Radius.circular(15),
                                                                                                  topLeft: Radius.circular(15),
                                                                                                  bottomRight: Radius.circular(15),
                                                                                                  bottomLeft: Radius.circular(15),
                                                                                                ),
                                                                                                border: Border.all(
                                                                                                  width: 1,
                                                                                                  color: Colors.grey,
                                                                                                ),
                                                                                              ),
                                                                                              padding: const EdgeInsets.all(5.0),
                                                                                              child: Text(
                                                                                                '${quotxSelectModels[index].meter}',
                                                                                                textAlign: TextAlign.end,
                                                                                                style: TextStyle(
                                                                                                  color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                                                  fontFamily: Font_.Fonts_T,
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
                                                                            ),
                                                                            Expanded(
                                                                              flex: 2,
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.all(8.0),
                                                                                child: InkWell(
                                                                                  onTap: () {
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
                                                                                                                'เลขมิเตอร์เริ่มต้น ${quotxSelectModels[index].fineLate}',
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
                                                                                                              textAlign: TextAlign.right,
                                                                                                              initialValue: quotxSelectModels[index].fineLate,
                                                                                                              onFieldSubmitted: (value) async {
                                                                                                                SharedPreferences preferences = await SharedPreferences.getInstance();
                                                                                                                String? ren = preferences.getString('renTalSer');
                                                                                                                String? ser_user = preferences.getString('ser');
                                                                                                                var qser = quotxSelectModels[index].ser;
                                                                                                                String url = '${MyConstant().domain}/UMTTquotx_select.php?isAdd=true&ren=$ren&qser=$qser&qty=$value&ser_user=$ser_user';

                                                                                                                try {
                                                                                                                  var response = await http.get(Uri.parse(url));

                                                                                                                  var result = json.decode(response.body);
                                                                                                                  print(result);
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
                                                                                                                  labelText: 'เลขมิเตอร์เริ่มต้น',
                                                                                                                  labelStyle: const TextStyle(
                                                                                                                      color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                                                                      // fontWeight: FontWeight.bold,
                                                                                                                      fontFamily: Font_.Fonts_T)),
                                                                                                              inputFormatters: <TextInputFormatter>[
                                                                                                                // for below version 2 use this
                                                                                                                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                                                                                                // for version 2 and greater youcan also use this
                                                                                                                FilteringTextInputFormatter.digitsOnly
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
                                                                                        });
                                                                                  },
                                                                                  child: Column(
                                                                                    children: [
                                                                                      Text(
                                                                                        'เลขมิเตอร์เริ่มต้น ',
                                                                                        textAlign: TextAlign.start,
                                                                                        style: TextStyle(
                                                                                          color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                                          fontFamily: Font_.Fonts_T,
                                                                                          fontSize: 15,
                                                                                        ),
                                                                                      ),
                                                                                      Row(
                                                                                        children: [
                                                                                          Expanded(
                                                                                            child: Container(
                                                                                              height: 40,
                                                                                              decoration: BoxDecoration(
                                                                                                borderRadius: BorderRadius.only(
                                                                                                  topRight: Radius.circular(15),
                                                                                                  topLeft: Radius.circular(15),
                                                                                                  bottomRight: Radius.circular(15),
                                                                                                  bottomLeft: Radius.circular(15),
                                                                                                ),
                                                                                                border: Border.all(
                                                                                                  width: 1,
                                                                                                  color: Colors.grey,
                                                                                                ),
                                                                                              ),
                                                                                              padding: const EdgeInsets.all(5.0),
                                                                                              child: Text(
                                                                                                '${quotxSelectModels[index].fineLate}',
                                                                                                textAlign: TextAlign.end,
                                                                                                style: TextStyle(
                                                                                                  color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                                                  fontFamily: Font_.Fonts_T,
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
                                                                            ),
                                                                            Expanded(
                                                                              flex: 1,
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.all(8.0),
                                                                                child: InkWell(
                                                                                  onTap: () {
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
                                                                                                                'ราคา/หน่วย ${quotxSelectModels[index].qty}',
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
                                                                                                              textAlign: TextAlign.right,
                                                                                                              initialValue: quotxSelectModels[index].qty,
                                                                                                              onFieldSubmitted: (value) async {
                                                                                                                SharedPreferences preferences = await SharedPreferences.getInstance();
                                                                                                                String? ren = preferences.getString('renTalSer');
                                                                                                                String? ser_user = preferences.getString('ser');
                                                                                                                var qser = quotxSelectModels[index].ser;
                                                                                                                String url = '${MyConstant().domain}/UQTquotx_select.php?isAdd=true&ren=$ren&qser=$qser&qtyx=$value&ser_user=$ser_user';

                                                                                                                try {
                                                                                                                  var response = await http.get(Uri.parse(url));

                                                                                                                  var result = json.decode(response.body);
                                                                                                                  print(result);
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
                                                                                                                  labelText: 'ราคา/หน่วย',
                                                                                                                  labelStyle: const TextStyle(
                                                                                                                      color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                                                                      // fontWeight: FontWeight.bold,
                                                                                                                      fontFamily: Font_.Fonts_T)),
                                                                                                              inputFormatters: <TextInputFormatter>[
                                                                                                                // for below version 2 use this
                                                                                                                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                                                                                                // for version 2 and greater youcan also use this
                                                                                                                FilteringTextInputFormatter.digitsOnly
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
                                                                                        });
                                                                                  },
                                                                                  child: Column(
                                                                                    children: [
                                                                                      Text(
                                                                                        'ราคา/หน่วย ',
                                                                                        textAlign: TextAlign.start,
                                                                                        style: TextStyle(
                                                                                          color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                                          fontFamily: Font_.Fonts_T,
                                                                                          fontSize: 15,
                                                                                        ),
                                                                                      ),
                                                                                      Row(
                                                                                        children: [
                                                                                          Expanded(
                                                                                            child: Container(
                                                                                              height: 40,
                                                                                              decoration: BoxDecoration(
                                                                                                borderRadius: BorderRadius.only(
                                                                                                  topRight: Radius.circular(15),
                                                                                                  topLeft: Radius.circular(15),
                                                                                                  bottomRight: Radius.circular(15),
                                                                                                  bottomLeft: Radius.circular(15),
                                                                                                ),
                                                                                                border: Border.all(
                                                                                                  width: 1,
                                                                                                  color: Colors.grey,
                                                                                                ),
                                                                                              ),
                                                                                              padding: const EdgeInsets.all(5.0),
                                                                                              child: Text(
                                                                                                '${quotxSelectModels[index].qty}',
                                                                                                textAlign: TextAlign.end,
                                                                                                style: TextStyle(
                                                                                                  color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                                                  fontFamily: Font_.Fonts_T,
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
                                                                            ),
                                                                            // Expanded(
                                                                            //   flex: 2,
                                                                            //   child: Padding(
                                                                            //     padding: const EdgeInsets.all(8.0),
                                                                            //     child: Container(
                                                                            //       height: 45,
                                                                            //       child: TextFormField(
                                                                            //         textAlign: TextAlign.right,
                                                                            //         initialValue: quotxSelectModels[index].meter,
                                                                            //         onChanged: (value) async {
                                                                            //           SharedPreferences preferences = await SharedPreferences.getInstance();
                                                                            //           String? ren = preferences.getString('renTalSer');
                                                                            //           String? ser_user = preferences.getString('ser');
                                                                            //           var qser = quotxSelectModels[index].ser;
                                                                            //           String url = '${MyConstant().domain}/UMTquotx_select.php?isAdd=true&ren=$ren&qser=$qser&qty=$value&ser_user=$ser_user';

                                                                            //           try {
                                                                            //             var response = await http.get(Uri.parse(url));

                                                                            //             var result = json.decode(response.body);
                                                                            //             print(result);
                                                                            //             if (result.toString() != 'null') {
                                                                            //               if (quotxSelectModels.isNotEmpty) {
                                                                            //                 setState(() {
                                                                            //                   quotxSelectModels.clear();
                                                                            //                 });
                                                                            //               }
                                                                            //               for (var map in result) {
                                                                            //                 QuotxSelectModel quotxSelectModel = QuotxSelectModel.fromJson(map);
                                                                            //                 setState(() {
                                                                            //                   quotxSelectModels.add(quotxSelectModel);
                                                                            //                 });
                                                                            //               }
                                                                            //             } else {
                                                                            //               setState(() {
                                                                            //                 quotxSelectModels.clear();
                                                                            //               });
                                                                            //             }
                                                                            //           } catch (e) {}
                                                                            //         },
                                                                            //         // maxLength: 13,
                                                                            //         cursorColor: Colors.green,
                                                                            //         decoration: InputDecoration(
                                                                            //             fillColor: Colors.white.withOpacity(0.05),
                                                                            //             filled: true,
                                                                            //             // prefixIcon:
                                                                            //             //     const Icon(Icons.key, color: Colors.black),
                                                                            //             // suffixIcon: Icon(Icons.clear, color: Colors.black),
                                                                            //             focusedBorder: const OutlineInputBorder(
                                                                            //               borderRadius: BorderRadius.only(
                                                                            //                 topRight: Radius.circular(15),
                                                                            //                 topLeft: Radius.circular(15),
                                                                            //                 bottomRight: Radius.circular(15),
                                                                            //                 bottomLeft: Radius.circular(15),
                                                                            //               ),
                                                                            //               borderSide: BorderSide(
                                                                            //                 width: 1,
                                                                            //                 color: Colors.grey,
                                                                            //               ),
                                                                            //             ),
                                                                            //             enabledBorder: const OutlineInputBorder(
                                                                            //               borderRadius: BorderRadius.only(
                                                                            //                 topRight: Radius.circular(15),
                                                                            //                 topLeft: Radius.circular(15),
                                                                            //                 bottomRight: Radius.circular(15),
                                                                            //                 bottomLeft: Radius.circular(15),
                                                                            //               ),
                                                                            //               borderSide: BorderSide(
                                                                            //                 width: 1,
                                                                            //                 color: Colors.grey,
                                                                            //               ),
                                                                            //             ),
                                                                            //             labelText: 'เลขเครื่อง',
                                                                            //             labelStyle: const TextStyle(
                                                                            //                 color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                            //                 // fontWeight: FontWeight.bold,
                                                                            //                 fontFamily: Font_.Fonts_T)),
                                                                            //       ),
                                                                            //     ),
                                                                            //   ),
                                                                            // ),
                                                                            // Expanded(
                                                                            //   flex: 2,
                                                                            //   child: Padding(
                                                                            //     padding: const EdgeInsets.all(8.0),
                                                                            //     child: Container(
                                                                            //       height: 45,
                                                                            //       child: TextFormField(
                                                                            //         textAlign: TextAlign.right,
                                                                            //         initialValue: quotxSelectModels[index].fineLate,
                                                                            //         onChanged: (value) async {
                                                                            //           SharedPreferences preferences = await SharedPreferences.getInstance();
                                                                            //           String? ren = preferences.getString('renTalSer');
                                                                            //           String? ser_user = preferences.getString('ser');
                                                                            //           var qser = quotxSelectModels[index].ser;
                                                                            //           String url = '${MyConstant().domain}/UMTTquotx_select.php?isAdd=true&ren=$ren&qser=$qser&qty=$value&ser_user=$ser_user';

                                                                            //           try {
                                                                            //             var response = await http.get(Uri.parse(url));

                                                                            //             var result = json.decode(response.body);
                                                                            //             print(result);
                                                                            //             if (result.toString() != 'null') {
                                                                            //               if (quotxSelectModels.isNotEmpty) {
                                                                            //                 setState(() {
                                                                            //                   quotxSelectModels.clear();
                                                                            //                 });
                                                                            //               }
                                                                            //               for (var map in result) {
                                                                            //                 QuotxSelectModel quotxSelectModel = QuotxSelectModel.fromJson(map);
                                                                            //                 setState(() {
                                                                            //                   quotxSelectModels.add(quotxSelectModel);
                                                                            //                 });
                                                                            //               }
                                                                            //             } else {
                                                                            //               setState(() {
                                                                            //                 quotxSelectModels.clear();
                                                                            //               });
                                                                            //             }
                                                                            //           } catch (e) {}
                                                                            //         },
                                                                            //         // maxLength: 13,
                                                                            //         cursorColor: Colors.green,
                                                                            //         decoration: InputDecoration(
                                                                            //             fillColor: Colors.white.withOpacity(0.05),
                                                                            //             filled: true,
                                                                            //             // prefixIcon:
                                                                            //             //     const Icon(Icons.key, color: Colors.black),
                                                                            //             // suffixIcon: Icon(Icons.clear, color: Colors.black),
                                                                            //             focusedBorder: const OutlineInputBorder(
                                                                            //               borderRadius: BorderRadius.only(
                                                                            //                 topRight: Radius.circular(15),
                                                                            //                 topLeft: Radius.circular(15),
                                                                            //                 bottomRight: Radius.circular(15),
                                                                            //                 bottomLeft: Radius.circular(15),
                                                                            //               ),
                                                                            //               borderSide: BorderSide(
                                                                            //                 width: 1,
                                                                            //                 color: Colors.grey,
                                                                            //               ),
                                                                            //             ),
                                                                            //             enabledBorder: const OutlineInputBorder(
                                                                            //               borderRadius: BorderRadius.only(
                                                                            //                 topRight: Radius.circular(15),
                                                                            //                 topLeft: Radius.circular(15),
                                                                            //                 bottomRight: Radius.circular(15),
                                                                            //                 bottomLeft: Radius.circular(15),
                                                                            //               ),
                                                                            //               borderSide: BorderSide(
                                                                            //                 width: 1,
                                                                            //                 color: Colors.grey,
                                                                            //               ),
                                                                            //             ),
                                                                            //             labelText: 'เลขมิเตอร์เริ่มต้น',
                                                                            //             labelStyle: const TextStyle(
                                                                            //                 color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                            //                 // fontWeight: FontWeight.bold,
                                                                            //                 fontFamily: Font_.Fonts_T)),
                                                                            //       ),
                                                                            //     ),
                                                                            //   ),
                                                                            // ),
                                                                            // Expanded(
                                                                            //   flex: 1,
                                                                            //   child: Padding(
                                                                            //     padding: const EdgeInsets.all(8.0),
                                                                            //     child: Container(
                                                                            //       height: 45,
                                                                            //       child: TextFormField(
                                                                            //         textAlign: TextAlign.right,
                                                                            //         initialValue: quotxSelectModels[index].qty,
                                                                            //         onChanged: (value) async {
                                                                            //           SharedPreferences preferences = await SharedPreferences.getInstance();
                                                                            //           String? ren = preferences.getString('renTalSer');
                                                                            //           String? ser_user = preferences.getString('ser');
                                                                            //           var qser = quotxSelectModels[index].ser;
                                                                            //           String url = '${MyConstant().domain}/UQTquotx_select.php?isAdd=true&ren=$ren&qser=$qser&qtyx=$value&ser_user=$ser_user';

                                                                            //           try {
                                                                            //             var response = await http.get(Uri.parse(url));

                                                                            //             var result = json.decode(response.body);
                                                                            //             print(result);
                                                                            //             if (result.toString() != 'null') {
                                                                            //               if (quotxSelectModels.isNotEmpty) {
                                                                            //                 setState(() {
                                                                            //                   quotxSelectModels.clear();
                                                                            //                 });
                                                                            //               }
                                                                            //               for (var map in result) {
                                                                            //                 QuotxSelectModel quotxSelectModel = QuotxSelectModel.fromJson(map);
                                                                            //                 setState(() {
                                                                            //                   quotxSelectModels.add(quotxSelectModel);
                                                                            //                 });
                                                                            //               }
                                                                            //             } else {
                                                                            //               setState(() {
                                                                            //                 quotxSelectModels.clear();
                                                                            //               });
                                                                            //             }
                                                                            //           } catch (e) {}
                                                                            //         },
                                                                            //         // maxLength: 13,
                                                                            //         cursorColor: Colors.green,
                                                                            //         decoration: InputDecoration(
                                                                            //             fillColor: Colors.white.withOpacity(0.05),
                                                                            //             filled: true,
                                                                            //             // prefixIcon:
                                                                            //             //     const Icon(Icons.key, color: Colors.black),
                                                                            //             // suffixIcon: Icon(Icons.clear, color: Colors.black),
                                                                            //             focusedBorder: const OutlineInputBorder(
                                                                            //               borderRadius: BorderRadius.only(
                                                                            //                 topRight: Radius.circular(15),
                                                                            //                 topLeft: Radius.circular(15),
                                                                            //                 bottomRight: Radius.circular(15),
                                                                            //                 bottomLeft: Radius.circular(15),
                                                                            //               ),
                                                                            //               borderSide: BorderSide(
                                                                            //                 width: 1,
                                                                            //                 color: Colors.grey,
                                                                            //               ),
                                                                            //             ),
                                                                            //             enabledBorder: const OutlineInputBorder(
                                                                            //               borderRadius: BorderRadius.only(
                                                                            //                 topRight: Radius.circular(15),
                                                                            //                 topLeft: Radius.circular(15),
                                                                            //                 bottomRight: Radius.circular(15),
                                                                            //                 bottomLeft: Radius.circular(15),
                                                                            //               ),
                                                                            //               borderSide: BorderSide(
                                                                            //                 width: 1,
                                                                            //                 color: Colors.grey,
                                                                            //               ),
                                                                            //             ),
                                                                            //             labelText: 'ราคา/หน่วย',
                                                                            //             labelStyle: const TextStyle(
                                                                            //                 color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                            //                 // fontWeight: FontWeight.bold,
                                                                            //                 fontFamily: Font_.Fonts_T)),
                                                                            //       ),
                                                                            //     ),
                                                                            //   ),
                                                                            // ),
                                                                            // Expanded(
                                                                            //   flex: 1,
                                                                            //   child: Container(
                                                                            //     height: 45,
                                                                            //   ),
                                                                            // ),
                                                                            // const Expanded(
                                                                            //   flex: 1,
                                                                            //   child: AutoSizeText(
                                                                            //     maxLines: 2,
                                                                            //     minFontSize: 8,
                                                                            //     // maxFontSize: 15,
                                                                            //     '',
                                                                            //     textAlign: TextAlign.center,
                                                                            //     style: TextStyle(
                                                                            //       color: TextHome_Color.TextHome_Colors,

                                                                            //       //fontSize: 10.0
                                                                            //     ),
                                                                            //   ),
                                                                            // ),
                                                                            // Expanded(
                                                                            //   flex: 1,
                                                                            //   child: Container(
                                                                            //     height: 45,
                                                                            //   ),
                                                                            // ),
                                                                            // const Expanded(
                                                                            //   flex: 1,
                                                                            //   child: Padding(
                                                                            //     padding: EdgeInsets.all(8),
                                                                            //   ),
                                                                            // ),
                                                                            const Expanded(
                                                                              flex: 1,
                                                                              child: AutoSizeText(
                                                                                maxLines: 2,
                                                                                minFontSize: 8,
                                                                                // maxFontSize: 15,
                                                                                '',
                                                                                textAlign: TextAlign.center,
                                                                                style: TextStyle(
                                                                                    color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                                    // fontWeight: FontWeight.bold,
                                                                                    fontFamily: Font_.Fonts_T),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ))
                                                                    : null,
                                                              ),
                                                      ],
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
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                            child: Column(
                              children: [
                                Container(
                                    width:
                                        MediaQuery.of(context).size.width - 2,
                                    decoration: const BoxDecoration(
                                      color: AppbackgroundColor.Sub_Abg_Colors,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(0),
                                          topRight: Radius.circular(0),
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10)),
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
                                                    const EdgeInsets.all(8.0),
                                                child: InkWell(
                                                  onTap: () {
                                                    _scrollControllers[Ser_Sub]
                                                        .animateTo(
                                                      0,
                                                      duration: const Duration(
                                                          seconds: 1),
                                                      curve: Curves.easeOut,
                                                    );
                                                  },
                                                  child: Container(
                                                      decoration: BoxDecoration(
                                                        // color: AppbackgroundColor
                                                        //     .TiTile_Colors,
                                                        borderRadius: const BorderRadius
                                                            .only(
                                                            topLeft: Radius
                                                                .circular(6),
                                                            topRight:
                                                                Radius.circular(
                                                                    6),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    6),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    8)),
                                                        border: Border.all(
                                                            color: Colors.grey,
                                                            width: 1),
                                                      ),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              3.0),
                                                      child: const Text(
                                                        'Top',
                                                        style: TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 10.0,
                                                            fontFamily:
                                                                FontWeight_
                                                                    .Fonts_T),
                                                      )),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  if (_scrollControllers[
                                                          Ser_Sub]
                                                      .hasClients) {
                                                    final position =
                                                        _scrollControllers[
                                                                Ser_Sub]
                                                            .position
                                                            .maxScrollExtent;

                                                    _scrollControllers[Ser_Sub]
                                                        .animateTo(
                                                      position,
                                                      duration: const Duration(
                                                          seconds: 1),
                                                      curve: Curves.easeOut,
                                                    );
                                                  }
                                                },
                                                child: Container(
                                                    decoration: BoxDecoration(
                                                      // color: AppbackgroundColor
                                                      //     .TiTile_Colors,
                                                      borderRadius:
                                                          const BorderRadius
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
                                                          color: Colors.grey,
                                                          width: 1),
                                                    ),
                                                    padding:
                                                        const EdgeInsets.all(
                                                            3.0),
                                                    child: const Text(
                                                      'Down',
                                                      style: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 10.0,
                                                          fontFamily:
                                                              FontWeight_
                                                                  .Fonts_T),
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
                                                onTap: () {
                                                  _scrollControllers[Ser_Sub]
                                                      .animateTo(
                                                          _scrollControllers[
                                                                      Ser_Sub]
                                                                  .offset -
                                                              220,
                                                          curve: Curves.linear,
                                                          duration:
                                                              const Duration(
                                                                  milliseconds:
                                                                      500));
                                                },
                                                child: const Padding(
                                                    padding:
                                                        EdgeInsets.all(8.0),
                                                    child: Align(
                                                      alignment:
                                                          Alignment.centerLeft,
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
                                                            topLeft:
                                                                Radius.circular(
                                                                    6),
                                                            topRight:
                                                                Radius.circular(
                                                                    6),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    6),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    6)),
                                                    border: Border.all(
                                                        color: Colors.grey,
                                                        width: 1),
                                                  ),
                                                  padding:
                                                      const EdgeInsets.all(3.0),
                                                  child: const Text(
                                                    'Scroll',
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 10.0,
                                                        fontFamily: FontWeight_
                                                            .Fonts_T),
                                                  )),
                                              InkWell(
                                                onTap: () {
                                                  _scrollControllers[Ser_Sub]
                                                      .animateTo(
                                                          _scrollControllers[
                                                                      Ser_Sub]
                                                                  .offset +
                                                              220,
                                                          curve: Curves.linear,
                                                          duration:
                                                              const Duration(
                                                                  milliseconds:
                                                                      500));
                                                },
                                                child: const Padding(
                                                    padding:
                                                        EdgeInsets.all(8.0),
                                                    child: Align(
                                                      alignment:
                                                          Alignment.centerRight,
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
                          Padding(
                            padding: const EdgeInsets.only(right: 10, left: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                const AutoSizeText(
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
                        ],
                      ),
                    ),
                  ],
                ),
              )
            : Container(
                child: Column(children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AutoSizeText(
                        minFontSize: 10,
                        maxFontSize: 15,
                        '3.${expTypeModels[Ser_Sub].ser} ${expTypeModels[Ser_Sub].bills}',
                        style: const TextStyle(
                            color: PeopleChaoScreen_Color.Colors_Text2_,
                            // fontWeight: FontWeight.bold,
                            fontFamily: Font_.Fonts_T),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                      ),
                      padding: const EdgeInsets.all(8.0),
                      child: IconButton(
                          onPressed: () {
                            // read_GC_Exp(expTypeModels[Ser_Sub].ser);
                            // showDialog<String>(
                            //     barrierDismissible: false,
                            //     context: context,
                            //     builder: (BuildContext context) {
                            //       return StreamBuilder(
                            //           stream: Stream.periodic(
                            //               const Duration(seconds: 0)),
                            //           builder: (context, snapshot) {
                            //             return AlertDialog(
                            //                 shape:
                            //                     const RoundedRectangleBorder(
                            //                         borderRadius:
                            //                             BorderRadius.all(
                            //                                 Radius.circular(
                            //                                     20.0))),
                            //                 title: Row(
                            //                   mainAxisAlignment:
                            //                       MainAxisAlignment
                            //                           .spaceAround,
                            //                   children: [
                            //                     Expanded(
                            //                       flex: 6,
                            //                       child: Text(
                            //                         '${expTypeModels[Ser_Sub].bills}',
                            //                         style: TextStyle(
                            //                           color: Colors.black,
                            //                           fontWeight:
                            //                               FontWeight.bold,
                            //                         ),
                            //                       ),
                            //                     ),
                            //                     Expanded(
                            //                         flex: 6,
                            //                         child: Row(
                            //                           mainAxisAlignment:
                            //                               MainAxisAlignment
                            //                                   .end,
                            //                           children: [
                            //                             IconButton(
                            //                                 onPressed:
                            //                                     () {
                            //                                   Navigator
                            //                                       .pop(
                            //                                     context,
                            //                                   );
                            //                                 },
                            //                                 icon: Icon(
                            //                                     Icons
                            //                                         .close,
                            //                                     color: Colors
                            //                                         .black)),
                            //                           ],
                            //                         )),
                            //                   ],
                            //                 ),
                            //                 content: Container(
                            //                   height:
                            //                       MediaQuery.of(context)
                            //                               .size
                            //                               .height /
                            //                           1.5,
                            //                   width:
                            //                       MediaQuery.of(context)
                            //                               .size
                            //                               .width /
                            //                           1.2,
                            //                   child: Column(
                            //                     children: [
                            //                       Container(
                            //                         color: Colors
                            //                             .grey.shade300,
                            //                         child: Row(
                            //                           mainAxisAlignment:
                            //                               MainAxisAlignment
                            //                                   .spaceBetween,
                            //                           children: [
                            //                             Expanded(
                            //                               flex: 6,
                            //                               child:
                            //                                   Container(
                            //                                 padding:
                            //                                     const EdgeInsets
                            //                                             .all(
                            //                                         8.0),
                            //                                 child:
                            //                                     AutoSizeText(
                            //                                   maxLines: 2,
                            //                                   minFontSize:
                            //                                       8,
                            //                                   // maxFontSize: 15,
                            //                                   'รายการ',
                            //                                   textAlign:
                            //                                       TextAlign
                            //                                           .start,
                            //                                   style:
                            //                                       const TextStyle(
                            //                                     color: TextHome_Color
                            //                                         .TextHome_Colors,

                            //                                     //fontSize: 10.0
                            //                                   ),
                            //                                 ),
                            //                               ),
                            //                             ),
                            //                             Expanded(
                            //                               flex: 1,
                            //                               child:
                            //                                   Container(
                            //                                 padding:
                            //                                     EdgeInsets
                            //                                         .all(
                            //                                             8.0),
                            //                                 child:
                            //                                     AutoSizeText(
                            //                                   maxLines: 2,
                            //                                   minFontSize:
                            //                                       8,
                            //                                   // maxFontSize: 15,
                            //                                   'หน่วย',
                            //                                   textAlign:
                            //                                       TextAlign
                            //                                           .center,
                            //                                   style:
                            //                                       const TextStyle(
                            //                                     color: TextHome_Color
                            //                                         .TextHome_Colors,

                            //                                     //fontSize: 10.0
                            //                                   ),
                            //                                 ),
                            //                               ),
                            //                             ),
                            //                           ],
                            //                         ),
                            //                       ),
                            //                       Padding(
                            //                         padding:
                            //                             const EdgeInsets
                            //                                     .fromLTRB(
                            //                                 8, 0, 8, 8),
                            //                         child: Column(
                            //                           children: [
                            //                             Container(
                            //                               height: MediaQuery.of(
                            //                                           context)
                            //                                       .size
                            //                                       .height /
                            //                                   1.8,
                            //                               width: MediaQuery.of(
                            //                                       context)
                            //                                   .size
                            //                                   .width,
                            //                               // height: 250,

                            //                               decoration:
                            //                                   const BoxDecoration(
                            //                                 color: AppbackgroundColor
                            //                                     .Sub_Abg_Colors,
                            //                                 borderRadius: BorderRadius.only(
                            //                                     topLeft: Radius
                            //                                         .circular(
                            //                                             0),
                            //                                     topRight:
                            //                                         Radius.circular(
                            //                                             0),
                            //                                     bottomLeft:
                            //                                         Radius.circular(
                            //                                             0),
                            //                                     bottomRight:
                            //                                         Radius.circular(
                            //                                             0)),
                            //                                 // border: Border.all(color: Colors.grey, width: 1),
                            //                               ),
                            //                               child: ListView
                            //                                   .builder(
                            //                                 // controller: expModels.length,
                            //                                 // itemExtent: 50,
                            //                                 physics:
                            //                                     const NeverScrollableScrollPhysics(),
                            //                                 shrinkWrap:
                            //                                     true,
                            //                                 itemCount:
                            //                                     expModels
                            //                                         .length,
                            //                                 itemBuilder:
                            //                                     (BuildContext
                            //                                             context,
                            //                                         int index) {
                            //                                   return Container(
                            //                                     child: ListTile(
                            //                                         onTap: () {
                            //                                           var serex =
                            //                                               expModels[index].ser;
                            //                                           String
                            //                                               _Date =
                            //                                               DateFormat('dd').format(DateTime.parse('${expModels[index].sdate!} 00:00:00'));
                            //                                           // Value_AreaSer_ +
                            //                                           //     1; // ser ประเภท
                            //                                           // _verticalGroupValue; // ประเภท
                            //                                           // _Form_nameshop; //ชื่อร้าน
                            //                                           // _Form_typeshop; //ประเภทร้าน
                            //                                           // _Form_bussshop; //ชื่อผู้เช่า
                            //                                           // _Form_bussscontact; //ชื่อผู้ติดต่อ
                            //                                           // _Form_address; //ที่อยู่
                            //                                           // _Form_tel; //เบอร์โทร
                            //                                           // _Form_email; //email
                            //                                           // _Form_tax; //เลข tax
                            //                                           // Value_DateTime_Step2; //เลือก ว-ด-ป
                            //                                           // Value_rental_type_; //รายวัน เดือน ปี
                            //                                           // Value_rental_type_2; //วัน เดือน ปี
                            //                                           // Value_DateTime_end; //หมดสัญญา ว-ด-ป
                            //                                           // Value_D_start; //เริ่มสัญญา ป/ด/ว
                            //                                           // Value_D_end; //หมดสัญญา ป/ด/ว
                            //                                           // Value_rental_count_; //จำนวน วัน เดือน ปี
                            //                                           // _selecteSer.map((e) => e).toString().substring(1,
                            //                                           //     _selecteSer.map((e) => e).toString().length - 1); // serพื้นที่
                            //                                           // _selecteSerbool.map((e) => e).toString().substring(1,
                            //                                           //     _selecteSerbool.map((e) => e).toString().length - 1); //พื้นที่

                            //                                           add_quot(serex,
                            //                                               _Date);
                            //                                         },
                            //                                         title: Row(
                            //                                           mainAxisAlignment:
                            //                                               MainAxisAlignment.spaceBetween,
                            //                                           children: [
                            //                                             Expanded(
                            //                                               flex: 6,
                            //                                               child: Container(
                            //                                                 padding: const EdgeInsets.all(8.0),
                            //                                                 child: AutoSizeText(
                            //                                                   maxLines: 2,
                            //                                                   minFontSize: 8,
                            //                                                   // maxFontSize: 15,
                            //                                                   '${expModels[index].expname}',
                            //                                                   textAlign: TextAlign.start,
                            //                                                   style: const TextStyle(
                            //                                                     color: TextHome_Color.TextHome_Colors,

                            //                                                     //fontSize: 10.0
                            //                                                   ),
                            //                                                 ),
                            //                                               ),
                            //                                             ),
                            //                                             Expanded(
                            //                                               flex: 1,
                            //                                               child: Padding(
                            //                                                 padding: EdgeInsets.all(8.0),
                            //                                                 child: AutoSizeText(
                            //                                                   maxLines: 2,
                            //                                                   minFontSize: 8,
                            //                                                   // maxFontSize: 15,
                            //                                                   '${expModels[index].unit}',
                            //                                                   textAlign: TextAlign.center,
                            //                                                   style: const TextStyle(
                            //                                                     color: TextHome_Color.TextHome_Colors,

                            //                                                     //fontSize: 10.0
                            //                                                   ),
                            //                                                 ),
                            //                                               ),
                            //                                             ),
                            //                                           ],
                            //                                         )),
                            //                                   );
                            //                                 },
                            //                               ),
                            //                             ),
                            //                           ],
                            //                         ),
                            //                       ),
                            //                     ],
                            //                   ),
                            //                 ));
                            //           });
                            //     });
                            // print('555');
                          },
                          icon: const Icon(Icons.add, color: Colors.green)),
                    ),
                  ],
                ),
                Container(
                  constraints: BoxConstraints(
                    // minHeight: 500, //minimum height
                    minWidth: 400, // minimum width

                    // maxHeight: MediaQuery.of(context).size.height,
                    //maximum height set to 100% of vertical height

                    maxWidth: (!Responsive.isDesktop(context))
                        ? 1200
                        : MediaQuery.of(context).size.width - 270,
                    //maximum width set to 100% of width
                  ),
                  decoration: const BoxDecoration(
                    color: AppbackgroundColor.Sub_Abg_Colors,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                    // border: Border.all(color: Colors.grey, width: 1),
                  ),
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
                          child: Row(children: [
                            Container(
                              constraints: BoxConstraints(
                                // minHeight: 500, //minimum height
                                minWidth: 400, // minimum width

                                // maxHeight: MediaQuery.of(context).size.height,
                                //maximum height set to 100% of vertical height

                                maxWidth: (!Responsive.isDesktop(context))
                                    ? 1200
                                    : MediaQuery.of(context).size.width - 270,
                                //maximum width set to 100% of width
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(8, 8, 8, 0),
                                    child: Container(
                                        constraints: BoxConstraints(
                                          // minHeight: 500, //minimum height
                                          minWidth: 400, // minimum width

                                          // maxHeight: MediaQuery.of(context).size.height,
                                          //maximum height set to 100% of vertical height

                                          maxWidth:
                                              (!Responsive.isDesktop(context))
                                                  ? 1200
                                                  : MediaQuery.of(context)
                                                          .size
                                                          .width -
                                                      270,
                                          //maximum width set to 100% of width
                                        ),
                                        decoration: const BoxDecoration(
                                          color:
                                              AppbackgroundColor.TiTile_Colors,
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10),
                                              bottomLeft: Radius.circular(0),
                                              bottomRight: Radius.circular(0)),
                                        ),
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: const [
                                            Expanded(
                                              flex: 1,
                                              child: Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text(
                                                  'ค่าบริการที่ต้องการปรับ',
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
                                                      ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text(
                                                  'ความถี่',
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
                                                      ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text(
                                                  'จำนวนวันช้ากว่ากำหนด',
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
                                                      ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text(
                                                  'วิธีคิดค่าปรับ',
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
                                                      ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text(
                                                  'ยอดปรับ',
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
                                                      ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text(
                                                  'ลบ',
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
                                                      ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(8, 0, 8, 8),
                                    child: Column(
                                      children: [
                                        Container(
                                          // height: 250,
                                          // width: MediaQuery.of(context)
                                          //     .size
                                          //     .width,
                                          constraints: BoxConstraints(
                                            minHeight: 250, //minimum height
                                            minWidth: 400, // minimum width

                                            maxHeight: 250,
                                            //maximum height set to 100% of vertical height

                                            maxWidth:
                                                (!Responsive.isDesktop(context))
                                                    ? 1200
                                                    : MediaQuery.of(context)
                                                            .size
                                                            .width -
                                                        270,
                                            //maximum width set to 100% of width
                                          ),
                                          decoration: const BoxDecoration(
                                            color: AppbackgroundColor
                                                .Sub_Abg_Colors,
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(0),
                                                topRight: Radius.circular(0),
                                                bottomLeft: Radius.circular(0),
                                                bottomRight:
                                                    Radius.circular(0)),
                                            // border: Border.all(color: Colors.grey, width: 1),
                                          ),
                                          child: ListView.builder(
                                            controller:
                                                _scrollControllers[Ser_Sub],
                                            // itemExtent: 50,
                                            physics:
                                                const AlwaysScrollableScrollPhysics(), // const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: quotxSelectModels.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return Material(
                                                color: Step3_tappedIndex_[
                                                            Ser_Sub] ==
                                                        index.toString()
                                                    ? tappedIndex_Color
                                                        .tappedIndex_Colors
                                                    : AppbackgroundColor
                                                        .Sub_Abg_Colors,
                                                child: Container(
                                                  // color: Step3_tappedIndex_[
                                                  //                 Ser_Sub]
                                                  //             .toString() ==
                                                  //         index.toString()
                                                  //     ? tappedIndex_Color
                                                  //         .tappedIndex_Colors
                                                  //         .withOpacity(0.5)
                                                  //     : null,
                                                  child:
                                                      expTypeModels[Ser_Sub]
                                                                  .ser ==
                                                              quotxSelectModels[
                                                                      index]
                                                                  .exptser
                                                          ? ListTile(
                                                              onTap: () {
                                                                setState(() {
                                                                  Step3_tappedIndex_[
                                                                          Ser_Sub] =
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
                                                                              .center,
                                                                      children: [
                                                                        Container(
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                Colors.grey.shade300,
                                                                            borderRadius: const BorderRadius.only(
                                                                                topLeft: Radius.circular(10),
                                                                                topRight: Radius.circular(10),
                                                                                bottomLeft: Radius.circular(10),
                                                                                bottomRight: Radius.circular(10)),
                                                                            // border: Border.all(color: Colors.grey, width: 1),
                                                                          ),
                                                                          padding: const EdgeInsets
                                                                              .all(
                                                                              8.0),
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
                                                                                // fontWeight: FontWeight.bold,
                                                                                fontFamily: Font_.Fonts_T),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                          .all(
                                                                          8.0),
                                                                      child:
                                                                          AutoSizeText(
                                                                        maxLines:
                                                                            2,
                                                                        minFontSize:
                                                                            8,
                                                                        // maxFontSize: 15,
                                                                        '${quotxSelectModels[index].unit}',
                                                                        textAlign:
                                                                            TextAlign.right,
                                                                        style: const TextStyle(
                                                                            color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                            // fontWeight: FontWeight.bold,
                                                                            fontFamily: Font_.Fonts_T),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                          .all(
                                                                          8.0),
                                                                      child:
                                                                          AutoSizeText(
                                                                        maxLines:
                                                                            2,
                                                                        minFontSize:
                                                                            8,
                                                                        // maxFontSize: 15,
                                                                        '${quotxSelectModels[index].day}',
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        style: const TextStyle(
                                                                            color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                            // fontWeight: FontWeight.bold,
                                                                            fontFamily: Font_.Fonts_T),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  const Expanded(
                                                                    flex: 1,
                                                                    child:
                                                                        AutoSizeText(
                                                                      maxLines:
                                                                          2,
                                                                      minFontSize:
                                                                          8,
                                                                      // maxFontSize: 15,
                                                                      'บาท',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .right,
                                                                      style: const TextStyle(
                                                                          color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                          // fontWeight: FontWeight.bold,
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
                                                                      '${quotxSelectModels[index].amt}',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .right,
                                                                      style: const TextStyle(
                                                                          color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                          // fontWeight: FontWeight.bold,
                                                                          fontFamily: Font_.Fonts_T),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child: Row(
                                                                      children: [
                                                                        Expanded(
                                                                          flex:
                                                                              1,
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
                                                                            child:
                                                                                InkWell(
                                                                              onTap: () {
                                                                                _scrollControllers[Ser_Sub].animateTo(_scrollControllers[Ser_Sub].offset - 220, curve: Curves.linear, duration: const Duration(milliseconds: 500));
                                                                              },
                                                                              child: Container(
                                                                                  decoration: const BoxDecoration(
                                                                                    color: Colors.green,
                                                                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                                                                                  ),
                                                                                  padding: const EdgeInsets.all(8.0),
                                                                                  child: const Icon(
                                                                                    Icons.edit,
                                                                                    color: Colors.white,
                                                                                  )),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Expanded(
                                                                          flex:
                                                                              1,
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
                                                                            child:
                                                                                InkWell(
                                                                              onTap: () {
                                                                                _scrollControllers[Ser_Sub].animateTo(_scrollControllers[Ser_Sub].offset - 220, curve: Curves.linear, duration: const Duration(milliseconds: 500));
                                                                              },
                                                                              child: Container(
                                                                                  decoration: const BoxDecoration(
                                                                                    color: Colors.red,
                                                                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                                                                                  ),
                                                                                  padding: const EdgeInsets.all(8.0),
                                                                                  child: const Icon(
                                                                                    Icons.delete,
                                                                                    color: Colors.white,
                                                                                  )),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ))
                                                          : null,
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
                          ]),
                        ),
                      ),
                      Container(
                          width: MediaQuery.of(context).size.width,
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
                                          _scrollControllers[Ser_Sub].animateTo(
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
                                        if (_scrollControllers[Ser_Sub]
                                            .hasClients) {
                                          final position =
                                              _scrollControllers[Ser_Sub]
                                                  .position
                                                  .maxScrollExtent;

                                          _scrollControllers[Ser_Sub].animateTo(
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
                                      onTap: () {
                                        _scrollControllers[Ser_Sub].animateTo(
                                            _scrollControllers[Ser_Sub].offset -
                                                220,
                                            curve: Curves.linear,
                                            duration: const Duration(
                                                milliseconds: 500));
                                      },
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
                                      onTap: () {
                                        _scrollControllers[Ser_Sub].animateTo(
                                            _scrollControllers[Ser_Sub].offset +
                                                220,
                                            curve: Curves.linear,
                                            duration: const Duration(
                                                milliseconds: 500));
                                      },
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
              ])),
      const SizedBox(
        height: 20,
      ),
      Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(6),
              topRight: Radius.circular(6),
              bottomLeft: Radius.circular(6),
              bottomRight: Radius.circular(6)),
          border: Border.all(color: Colors.grey, width: 1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: AutoSizeText(
                minFontSize: 10,
                maxFontSize: 15,
                'ตารางสรุปค่าบริการ',
                style: TextStyle(
                    color: PeopleChaoScreen_Color.Colors_Text1_,
                    fontWeight: FontWeight.bold,
                    fontFamily: FontWeight_.Fonts_T),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () async {
                  await showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                            title: const Text(
                              'ตารางสรุปรายละเอียดค่าบริการ',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: PeopleChaoScreen_Color.Colors_Text2_,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: Font_.Fonts_T

                                  //fontSize: 10.0
                                  ),
                            ),
                            content: SingleChildScrollView(
                              child: ListBody(
                                children: <Widget>[
                                  Container(
                                      // height:
                                      //     MediaQuery.of(context).size.height,
                                      width: MediaQuery.of(context).size.width,
                                      decoration: const BoxDecoration(
                                        // color: Color(0xfff3f3ee),
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10)),
                                      ),
                                      child: Column(children: [
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
                                                  child: Column(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .fromLTRB(
                                                                8, 8, 8, 0),
                                                        child: Container(
                                                            width: (!Responsive
                                                                    .isDesktop(
                                                                        context))
                                                                ? 1200
                                                                : MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width -
                                                                    200,
                                                            decoration:
                                                                const BoxDecoration(
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
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          0)),
                                                            ),
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: const [
                                                                Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              8.0),
                                                                  child: Text(
                                                                    'ประเภทค่าบริการ',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .start,
                                                                    style: TextStyle(
                                                                        color: PeopleChaoScreen_Color
                                                                            .Colors_Text1_,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        fontFamily:
                                                                            FontWeight_.Fonts_T),
                                                                  ),
                                                                ),
                                                              ],
                                                            )),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .fromLTRB(
                                                                8, 0, 8, 0),
                                                        child: Container(
                                                            width: (!Responsive
                                                                    .isDesktop(
                                                                        context))
                                                                ? 1200
                                                                : MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width -
                                                                    200,
                                                            decoration:
                                                                const BoxDecoration(
                                                              color: AppbackgroundColor
                                                                  .TiTile_Colors,
                                                              borderRadius: BorderRadius.only(
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
                                                                          0)),
                                                            ),
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: const [
                                                                Expanded(
                                                                  flex: 1,
                                                                  child:
                                                                      AutoSizeText(
                                                                    maxLines: 1,
                                                                    minFontSize:
                                                                        8,
                                                                    maxFontSize:
                                                                        20,
                                                                    'งวด',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: TextStyle(
                                                                        color: PeopleChaoScreen_Color
                                                                            .Colors_Text2_,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        fontFamily:
                                                                            FontWeight_.Fonts_T),
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
                                                                    'วันที่ชำระ',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: TextStyle(
                                                                        color: PeopleChaoScreen_Color
                                                                            .Colors_Text2_,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        fontFamily:
                                                                            Font_.Fonts_T),
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
                                                                    'ประเภทค่าบริการ',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: TextStyle(
                                                                        color: PeopleChaoScreen_Color
                                                                            .Colors_Text2_,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        fontFamily:
                                                                            Font_.Fonts_T),
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
                                                                    'VAT',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: TextStyle(
                                                                        color: PeopleChaoScreen_Color
                                                                            .Colors_Text2_,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        fontFamily:
                                                                            Font_.Fonts_T),
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
                                                                    'VAT(%)',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: TextStyle(
                                                                        color: PeopleChaoScreen_Color
                                                                            .Colors_Text2_,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        fontFamily:
                                                                            Font_.Fonts_T),
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
                                                                    'VAT(฿)',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: TextStyle(
                                                                        color: PeopleChaoScreen_Color
                                                                            .Colors_Text2_,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        fontFamily:
                                                                            Font_.Fonts_T),
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
                                                                    '',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: TextStyle(
                                                                        color: PeopleChaoScreen_Color
                                                                            .Colors_Text2_,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        fontFamily:
                                                                            Font_.Fonts_T),
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
                                                                    'WHT (%)',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: TextStyle(
                                                                        color: PeopleChaoScreen_Color
                                                                            .Colors_Text2_,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        fontFamily:
                                                                            Font_.Fonts_T),
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
                                                                    'WHT (฿)',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: TextStyle(
                                                                        color: PeopleChaoScreen_Color
                                                                            .Colors_Text2_,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        fontFamily:
                                                                            Font_.Fonts_T),
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
                                                                    'ยอดสุทธิ์',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: TextStyle(
                                                                        color: PeopleChaoScreen_Color
                                                                            .Colors_Text2_,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        fontFamily:
                                                                            Font_.Fonts_T),
                                                                  ),
                                                                ),
                                                              ],
                                                            )),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .fromLTRB(
                                                                8, 0, 8, 8),
                                                        child: Column(
                                                          children: [
                                                            Container(
                                                              height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height /
                                                                  2,
                                                              width: (!Responsive
                                                                      .isDesktop(
                                                                          context))
                                                                  ? 1200
                                                                  : MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width -
                                                                      200,
                                                              decoration:
                                                                  const BoxDecoration(
                                                                color: AppbackgroundColor
                                                                    .Sub_Abg_Colors,
                                                                borderRadius: BorderRadius.only(
                                                                    topLeft: Radius
                                                                        .circular(
                                                                            0),
                                                                    topRight: Radius
                                                                        .circular(
                                                                            0),
                                                                    bottomLeft:
                                                                        Radius.circular(
                                                                            0),
                                                                    bottomRight:
                                                                        Radius.circular(
                                                                            0)),
                                                                // border: Border.all(color: Colors.grey, width: 1),
                                                              ),
                                                              child: ListView
                                                                  .builder(
                                                                // itemExtent: 50,
                                                                physics:
                                                                    const AlwaysScrollableScrollPhysics(), // const NeverScrollableScrollPhysics(),
                                                                shrinkWrap:
                                                                    true,
                                                                itemCount:
                                                                    quotxSelectModels
                                                                        .length,
                                                                itemBuilder:
                                                                    (BuildContext
                                                                            context,
                                                                        int index) {
                                                                  return Container(
                                                                    child: ListTile(
                                                                        onTap: () {
                                                                          setState(
                                                                              () {
                                                                            Strp3_tappedIndex6 =
                                                                                index.toString();
                                                                          });
                                                                        },
                                                                        title: Column(
                                                                          children: [
                                                                            for (var i = 0;
                                                                                i < int.parse(quotxSelectModels[index].term!);
                                                                                i++)
                                                                              Row(
                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                children: [
                                                                                  Expanded(
                                                                                    flex: 1,
                                                                                    child: AutoSizeText(
                                                                                      maxLines: 1,
                                                                                      minFontSize: 8,
                                                                                      maxFontSize: 20,
                                                                                      '${(i + 1)}',
                                                                                      textAlign: TextAlign.center,
                                                                                      style: const TextStyle(
                                                                                          color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                                          // fontWeight: FontWeight.bold,
                                                                                          fontFamily: Font_.Fonts_T),
                                                                                    ),
                                                                                  ),
                                                                                  Expanded(
                                                                                    flex: 1,
                                                                                    child: AutoSizeText(
                                                                                      maxLines: 1,
                                                                                      minFontSize: 8,
                                                                                      maxFontSize: 20,
                                                                                      '${DateFormat('dd-MM-yyyy').format(DateTime.parse('${quotxSelectModels[index].sdate!} 00:00:00').add(Duration(days: (int.parse(quotxSelectModels[index].day!) * i))))}',
                                                                                      textAlign: TextAlign.center,
                                                                                      style: const TextStyle(
                                                                                          color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                                          // fontWeight: FontWeight.bold,
                                                                                          fontFamily: Font_.Fonts_T),
                                                                                    ),
                                                                                  ),
                                                                                  Expanded(
                                                                                    flex: 1,
                                                                                    child: AutoSizeText(
                                                                                      maxLines: 1,
                                                                                      minFontSize: 8,
                                                                                      maxFontSize: 20,
                                                                                      '${quotxSelectModels[index].expname!}',
                                                                                      textAlign: TextAlign.center,
                                                                                      style: const TextStyle(
                                                                                          color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                                          // fontWeight: FontWeight.bold,
                                                                                          fontFamily: Font_.Fonts_T),
                                                                                    ),
                                                                                  ),
                                                                                  Expanded(
                                                                                    flex: 1,
                                                                                    child: AutoSizeText(
                                                                                      maxLines: 1,
                                                                                      minFontSize: 8,
                                                                                      maxFontSize: 20,
                                                                                      '${quotxSelectModels[index].vtype!}',
                                                                                      textAlign: TextAlign.right,
                                                                                      style: const TextStyle(
                                                                                          color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                                          // fontWeight: FontWeight.bold,
                                                                                          fontFamily: Font_.Fonts_T),
                                                                                    ),
                                                                                  ),
                                                                                  Expanded(
                                                                                    flex: 1,
                                                                                    child: AutoSizeText(
                                                                                      maxLines: 1,
                                                                                      minFontSize: 8,
                                                                                      maxFontSize: 20,
                                                                                      '${quotxSelectModels[index].nvat!} %',
                                                                                      textAlign: TextAlign.right,
                                                                                      style: const TextStyle(
                                                                                          color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                                          // fontWeight: FontWeight.bold,
                                                                                          fontFamily: Font_.Fonts_T),
                                                                                    ),
                                                                                  ),
                                                                                  Expanded(
                                                                                    flex: 1,
                                                                                    child: AutoSizeText(
                                                                                      maxLines: 1,
                                                                                      minFontSize: 8,
                                                                                      maxFontSize: 20,
                                                                                      '${quotxSelectModels[index].vat!}',
                                                                                      textAlign: TextAlign.right,
                                                                                      style: const TextStyle(
                                                                                          color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                                          // fontWeight: FontWeight.bold,
                                                                                          fontFamily: Font_.Fonts_T),
                                                                                    ),
                                                                                  ),
                                                                                  Expanded(
                                                                                    flex: 1,
                                                                                    child: AutoSizeText(
                                                                                      maxLines: 1,
                                                                                      minFontSize: 8,
                                                                                      maxFontSize: 20, '${nFormat.format(double.parse(quotxSelectModels[index].pvat!))}',
                                                                                      // '${quotxSelectModels[index].pvat!}',
                                                                                      textAlign: TextAlign.right,
                                                                                      style: const TextStyle(
                                                                                          color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                                          // fontWeight: FontWeight.bold,
                                                                                          fontFamily: Font_.Fonts_T),
                                                                                    ),
                                                                                  ),
                                                                                  Expanded(
                                                                                    flex: 1,
                                                                                    child: AutoSizeText(
                                                                                      maxLines: 1,
                                                                                      minFontSize: 8,
                                                                                      maxFontSize: 20,
                                                                                      '${quotxSelectModels[index].nwht!}',
                                                                                      textAlign: TextAlign.right,
                                                                                      style: const TextStyle(
                                                                                          color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                                          // fontWeight: FontWeight.bold,
                                                                                          fontFamily: Font_.Fonts_T),
                                                                                    ),
                                                                                  ),
                                                                                  Expanded(
                                                                                    flex: 1,
                                                                                    child: AutoSizeText(
                                                                                      maxLines: 1,
                                                                                      minFontSize: 8,
                                                                                      maxFontSize: 20,
                                                                                      '${quotxSelectModels[index].wht!}',
                                                                                      textAlign: TextAlign.right,
                                                                                      style: const TextStyle(
                                                                                          color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                                          // fontWeight: FontWeight.bold,
                                                                                          fontFamily: Font_.Fonts_T),
                                                                                    ),
                                                                                  ),
                                                                                  Expanded(
                                                                                    flex: 1,
                                                                                    child: AutoSizeText(
                                                                                      maxLines: 1,
                                                                                      minFontSize: 8,
                                                                                      maxFontSize: 20,
                                                                                      '${nFormat.format(double.parse(quotxSelectModels[index].total!))}',
                                                                                      textAlign: TextAlign.right,
                                                                                      style: const TextStyle(
                                                                                          color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                                          // fontWeight: FontWeight.bold,
                                                                                          fontFamily: Font_.Fonts_T),
                                                                                    ),
                                                                                  ),
                                                                                ],
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
                                              ],
                                            ),
                                          ),
                                        ),
                                      ]))
                                ],
                              ),
                            ),
                            actions: <Widget>[
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width: 130,
                                    height: 40,
                                    decoration: const BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20),
                                          bottomLeft: Radius.circular(20),
                                          bottomRight: Radius.circular(20)),
                                    ),
                                    padding: const EdgeInsets.all(8.0),
                                    child: const Center(
                                      child: Text('ยกเลิก',
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: false,
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: FontWeight_.Fonts_T)),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))));
                      });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(6),
                        topRight: Radius.circular(6),
                        bottomLeft: Radius.circular(6),
                        bottomRight: Radius.circular(6)),
                    border: Border.all(color: Colors.grey, width: 1),
                  ),
                  padding: const EdgeInsets.all(8.0),
                  child: const AutoSizeText(
                    minFontSize: 10,
                    maxFontSize: 15,
                    'ดูรายละเอียด',
                    style: TextStyle(
                        color: PeopleChaoScreen_Color.Colors_Text1_,
                        fontWeight: FontWeight.bold,
                        fontFamily: FontWeight_.Fonts_T),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      Container(
        constraints: BoxConstraints(
          // minHeight: 500, //minimum height
          minWidth: 400, // minimum width

          // maxHeight: MediaQuery.of(context).size.height,
          //maximum height set to 100% of vertical height

          maxWidth: (!Responsive.isDesktop(context))
              ? 1200
              : MediaQuery.of(context).size.width - 270,
          //maximum width set to 100% of width
        ),
        decoration: const BoxDecoration(
          color: AppbackgroundColor.Sub_Abg_Colors,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
          // border: Border.all(color: Colors.grey, width: 1),
        ),
        child: Column(
          children: [
            ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(dragDevices: {
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
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                            child: Container(
                                constraints: BoxConstraints(
                                  // minHeight: 500, //minimum height
                                  minWidth: 400, // minimum width

                                  // maxHeight: MediaQuery.of(context).size.height,
                                  //maximum height set to 100% of vertical height

                                  maxWidth: (!Responsive.isDesktop(context))
                                      ? 1200
                                      : MediaQuery.of(context).size.width - 290,
                                  //maximum width set to 100% of width
                                ),
                                decoration: const BoxDecoration(
                                  color: AppbackgroundColor.TiTile_Colors,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(0),
                                      bottomRight: Radius.circular(0)),
                                ),
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Expanded(
                                      flex: 1,
                                      child: Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          'งวด',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
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
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
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
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
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
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
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
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            //fontSize: 10.0
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                            child: Column(
                              children: [
                                Container(
                                  constraints: BoxConstraints(
                                    minHeight: 250, //minimum height
                                    minWidth: 400, // minimum width

                                    maxHeight: 250,
                                    //maximum height set to 100% of vertical height

                                    maxWidth: (!Responsive.isDesktop(context))
                                        ? 1200
                                        : MediaQuery.of(context).size.width -
                                            290,
                                    //maximum width set to 100% of width
                                  ),
                                  decoration: const BoxDecoration(
                                    color: AppbackgroundColor.Sub_Abg_Colors,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(0),
                                        topRight: Radius.circular(0),
                                        bottomLeft: Radius.circular(0),
                                        bottomRight: Radius.circular(0)),
                                    // border: Border.all(color: Colors.grey, width: 1),
                                  ),
                                  child: ListView.builder(
                                    controller: _scrollController6,
                                    // itemExtent: 50,
                                    physics:
                                        const AlwaysScrollableScrollPhysics(), //NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: quotxSelectModels.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Material(
                                        color: Strp3_tappedIndex6 ==
                                                index.toString()
                                            ? tappedIndex_Color
                                                .tappedIndex_Colors
                                            : AppbackgroundColor.Sub_Abg_Colors,
                                        child: Container(
                                          // color: Strp3_tappedIndex6 ==
                                          //         index.toString()
                                          //     ? tappedIndex_Color
                                          //         .tappedIndex_Colors
                                          //         .withOpacity(0.5)
                                          //     : null,
                                          child: ListTile(
                                              onTap: () {
                                                setState(() {
                                                  Strp3_tappedIndex6 =
                                                      index.toString();
                                                });
                                              },
                                              title: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Expanded(
                                                    flex: 1,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
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
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: AutoSizeText(
                                                            maxLines: 2,
                                                            minFontSize: 8,
                                                            // maxFontSize: 15,
                                                            '${quotxSelectModels[index].unit} / ${quotxSelectModels[index].term} (งวด)',
                                                            textAlign:
                                                                TextAlign.start,
                                                            style:
                                                                const TextStyle(
                                                              color: TextHome_Color
                                                                  .TextHome_Colors,

                                                              //fontSize: 10.0
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: AutoSizeText(
                                                        maxLines: 2,
                                                        minFontSize: 8,
                                                        // maxFontSize: 15,
                                                        '${DateFormat('dd-MM-yyyy').format(DateTime.parse('${quotxSelectModels[index].sdate!} 00:00:00'))} - ${DateFormat('dd-MM-yyyy').format(DateTime.parse('${quotxSelectModels[index].ldate!} 00:00:00'))}',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: const TextStyle(
                                                          color: TextHome_Color
                                                              .TextHome_Colors,

                                                          //fontSize: 10.0
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: AutoSizeText(
                                                        maxLines: 2,
                                                        minFontSize: 8,
                                                        // maxFontSize: 15,
                                                        '${quotxSelectModels[index].expname} ${quotxSelectModels[index].meter}',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: const TextStyle(
                                                          color: TextHome_Color
                                                              .TextHome_Colors,

                                                          //fontSize: 10.0
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: AutoSizeText(
                                                      maxLines: 2,
                                                      minFontSize: 8,
                                                      // maxFontSize: 15,
                                                      quotxSelectModels[index]
                                                                  .qty ==
                                                              '0.00'
                                                          ? '${nFormat.format(double.parse(quotxSelectModels[index].total!))} / งวด'
                                                          : '${nFormat.format(double.parse(quotxSelectModels[index].qty!))} / หน่วย',
                                                      // '${nFormat.format(double.parse(quotxSelectModels[index].total!))}',
                                                      textAlign:
                                                          TextAlign.right,
                                                      style: const TextStyle(
                                                        color: TextHome_Color
                                                            .TextHome_Colors,

                                                        //fontSize: 10.0
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: AutoSizeText(
                                                      maxLines: 2,
                                                      minFontSize: 8,
                                                      // maxFontSize: 15,
                                                      '${nFormat.format(int.parse(quotxSelectModels[index].term!) * double.parse(quotxSelectModels[index].total!))}',
                                                      textAlign:
                                                          TextAlign.right,
                                                      style: const TextStyle(
                                                        color: TextHome_Color
                                                            .TextHome_Colors,

                                                        //fontSize: 10.0
                                                      ),
                                                    ),
                                                  ),
                                                ],
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
                  ],
                ),
              ),
            ),
            Container(
                width: MediaQuery.of(context).size.width,
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
                                _scrollController6.animateTo(
                                  0,
                                  duration: const Duration(seconds: 1),
                                  curve: Curves.easeOut,
                                );
                              },
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
                                        fontFamily: FontWeight_.Fonts_T),
                                  )),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              if (_scrollController6.hasClients) {
                                final position =
                                    _scrollController6.position.maxScrollExtent;
                                _scrollController6.animateTo(
                                  position,
                                  duration: const Duration(seconds: 1),
                                  curve: Curves.easeOut,
                                );
                              }
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                  // color: AppbackgroundColor
                                  //     .TiTile_Colors,
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(6),
                                      topRight: Radius.circular(6),
                                      bottomLeft: Radius.circular(6),
                                      bottomRight: Radius.circular(6)),
                                  border:
                                      Border.all(color: Colors.grey, width: 1),
                                ),
                                padding: const EdgeInsets.all(3.0),
                                child: const Text(
                                  'Down',
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 10.0,
                                      fontFamily: FontWeight_.Fonts_T),
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
                            onTap: _moveUp6,
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
                                border:
                                    Border.all(color: Colors.grey, width: 1),
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
                            onTap: _moveDown6,
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
    ]);
  }
  //////////////------------------------------------------------------>

  Widget header() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              headerText(),
              style: const TextStyle(
                color: PeopleChaoScreen_Color.Colors_Text2_,
                // fontWeight: FontWeight.bold,
                fontFamily: Font_.Fonts_T,
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

//////////////------------------------------------------------------>
  String headerText() {
    switch (activeStep) {
      case 0:
        return 'ผู้เช่า';

      case 1:
        return 'การเช่า';

      case 2:
        return 'ค่าบริการ';

      default:
        return '';
    }
  }

//////////////------------------------------------------------------>
}

class PreviewDataChaoArea extends StatelessWidget {
  final pw.Document doc;

  const PreviewDataChaoArea({Key? key, required this.doc}) : super(key: key);

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
              SharedPreferences preferences =
                  await SharedPreferences.getInstance();

              String? _route = preferences.getString('route');
              MaterialPageRoute materialPageRoute = MaterialPageRoute(
                  builder: (BuildContext context) =>
                      AdminScafScreen(route: _route));
              Navigator.pushAndRemoveUntil(
                  context, materialPageRoute, (route) => false);
            },
            icon: const Icon(
              Icons.arrow_back_outlined,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          title: const Text(
            "ข้อมูลพื้นที่",
            style: TextStyle(color: Colors.white, fontFamily: Font_.Fonts_T),
          ),
        ),
        body: PdfPreview(
          build: (format) => doc.save(),
          allowSharing: true,
          allowPrinting: true,
          maxPageWidth: MediaQuery.of(context).size.width * 0.6,
          // scrollViewDecoration:,
          initialPageFormat: PdfPageFormat.a4,
          pdfFileName: "ข้อมูลพื้นที่.pdf",
        ),
      ),
    );
  }
}

class PreviewScreen extends StatelessWidget {
  final pw.Document doc;
  final CQuotModel cQuotModel;

  const PreviewScreen({Key? key, required this.doc, required this.cQuotModel})
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
              SharedPreferences preferences =
                  await SharedPreferences.getInstance();

              String? _route = preferences.getString('route');
              MaterialPageRoute materialPageRoute = MaterialPageRoute(
                  builder: (BuildContext context) =>
                      AdminScafScreen(route: _route));
              Navigator.pushAndRemoveUntil(
                  context, materialPageRoute, (route) => false);
            },
            icon: const Icon(
              Icons.arrow_back_outlined,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          title: Text(
            "ใบเสนอราคาเลขที่ ${cQuotModel.docno}",
            style:
                const TextStyle(color: Colors.white, fontFamily: Font_.Fonts_T),
          ),
        ),
        body: PdfPreview(
          build: (format) => doc.save(),
          allowSharing: true,
          allowPrinting: true,
          maxPageWidth: MediaQuery.of(context).size.width * 0.6,
          // scrollViewDecoration:,
          initialPageFormat: PdfPageFormat.a4,
          pdfFileName: "${cQuotModel.docno}.pdf",
        ),
      ),
    );
  }
}

class PreviewPdfgen_quotationChoarea extends StatelessWidget {
  final pw.Document doc;
  final renTal_name;
  final route_;
  final docno_;
  const PreviewPdfgen_quotationChoarea(
      {Key? key, required this.doc, this.renTal_name, this.route_, this.docno_})
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
            onPressed: () {
              MaterialPageRoute materialPageRoute = MaterialPageRoute(
                  builder: (BuildContext context) =>
                      AdminScafScreen(route: route_));
              Navigator.pushAndRemoveUntil(
                  context, materialPageRoute, (route) => false);
              // Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_outlined,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          title: Text(
            "ใบเสนอราคาเลขที่ ${docno_}",
            style: const TextStyle(
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
          pdfFileName:
              "$renTal_name(ณ วันที่${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}).pdf",
        ),
      ),
    );
  }
}
