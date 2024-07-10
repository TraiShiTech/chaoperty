import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_multi_formatter/formatters/masked_input_formatter.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
// import 'package:ftpconnect/ftpconnect.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:otp_timer_button/otp_timer_button.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';

import '../AdminScaffold/AdminScaffold.dart';
import '../Beam/Beam_apiPassw.dart';
import '../Beam/Beam_api_disabled.dart';
import '../Beam/webviewPay_beamcheckout.dart';
import '../Constant/Myconstant.dart';
import '../INSERT_Log/Insert_log.dart';
import '../Man_PDF/Man_Pay_Receipt_PDF.dart';
import '../Model/GetCFinnancetrans_Model.dart';
import '../Model/GetInvoiceRe_Model.dart';
import '../Model/GetPayMent_Model.dart';
import '../Model/GetRenTal_Model.dart';
import '../Model/GetTrans_Model.dart';
import '../PeopleChao/webviewPay.dart';

import '../Responsive/responsive.dart';
import '../Style/colors.dart';

class AccountInvoicePay extends StatefulWidget {
  const AccountInvoicePay({super.key});

  @override
  State<AccountInvoicePay> createState() => _AccountInvoicePayState();
}

class _AccountInvoicePayState extends State<AccountInvoicePay> {
  var nFormat = NumberFormat("#,##0.00", "en_US");
  final Form_time = TextEditingController();
  var Refpay_1, Refpay_2, Refpay_3;
  var extension_;
  var file_;
  final sum_dispx = TextEditingController();
  final sum_disamtx = TextEditingController();
  DateTime datex = DateTime.now();
  String? MONTH_Now, YEAR_Now;
  List<String> YE_Th = [];
  DateTime newDatetime = DateTime.now();
  List<TransModel> _TransModels = [];
  List<RenTalModel> renTalModels = [];
  List<InvoiceReModel> InvoiceModels = [];
  List<PayMentModel> _PayMentModels = [];
  List<InvoiceReModel> _InvoiceModels = <InvoiceReModel>[];
  List<InvoiceReModel> limitedList_InvoiceModels_ = [];
  DateTime? _selected;
  String? view_P1, view_P2;
  String? renTal_user, renTal_name, zone_ser, zone_name;

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
      zone_Subser,
      zone_Subname,
      newValuePDFimg_QR,
      cidSelect;
  double sum_pvat = 0.00,
      sum_vat = 0.00,
      sum_wht = 0.00,
      sum_amt = 0.00,
      sum_dis = 0.00,
      sum_disamt = 0.00,
      sum_disp = 0,
      sum_Pakan = 0,
      sum_Pakan_KF = 0,
      dis_Pakan = 0,
      dis_matjum = 0,
      dis_sum_Pakan = 0.00,
      dis_sum_Matjum = 0.00,
      sum_Matjum_KF = 0,
      sum_tran_dis = 0,
      sum_matjum = 0.00,
      sum_tran_fine = 0,
      fine_total = 0,
      fine_total2 = 0,
      sum_fine = 0;
  String? paymentSer1,
      paymentName1,
      paymentSer2,
      paymentName2,
      cFinn,
      tappedIndex_ = '',
      Value_newDateY = '',
      Value_newDateD = '',
      Value_newDateY1 = '',
      selectedValue,
      bname1,
      Value_newDateD1 = '',
      Pay_Ke;
  String? payment_ptSer1, payment_ptSer2;
  String? name_slip, name_slip_ser;
  String? base64_Slip, fileName_Slip;
  String? tem_page_ser, doctax;
  int limit = 50; // The maximum number of items you want
  int offset = 0; // The starting index of items you want
  int endIndex = 0;
  ScrollController _scrollController2 = ScrollController();
  ////////------------------------------------>
  List Default_ = [
    'บิลธรรมดา',
  ];
  List Default2_ = [
    'บิลธรรมดา',
    'ใบกำกับภาษี',
  ];
  ////////------------------------------------>
  int Default_Receipt_type = 0;
  int TitleType_Default_Receipt = 0;
  List Default_Receipt_ = [
    'ออกใบเสร็จ',
    'ไม่ออกใบเสร็จ',
  ];

  List TitleType_Default_Receipt_ = [
    'ไม่ระบุ',
    'ต้นฉบับ',
    'สำเนา',
  ];
  ////////------------------------------------>
  @override
  void initState() {
    super.initState();
    read_GC_rental();
    checkPreferance();
    red_Trans_select2();
    red_payMent();
    Value_newDateY1 = DateFormat('yyyy-MM-dd').format(newDatetime);
    Value_newDateD1 = DateFormat('dd-MM-yyyy').format(newDatetime);
    Value_newDateY = DateFormat('yyyy-MM-dd').format(newDatetime);
    Value_newDateD = DateFormat('dd-MM-yyyy').format(newDatetime);
  }

  Future<Null> red_payMent() async {
    // if (_PayMentModels.length != 0) {
    //   setState(() {
    //     _PayMentModels.clear();
    //   });
    // }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');

    String url = '${MyConstant().domain}/GC_payMent.php?isAdd=true&ren=$ren';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);

      Map<String, dynamic> map = Map();
      map['ser'] = '0';
      map['datex'] = '';
      map['timex'] = '';
      map['ptser'] = '';
      map['ptname'] = 'เลือก';
      map['bser'] = '';
      map['bank'] = '';
      map['bno'] = '';
      map['bname'] = '';
      map['bsaka'] = '';
      map['btser'] = '';
      map['btype'] = '';
      map['st'] = '1';
      map['rser'] = '';
      map['accode'] = '';
      map['co'] = '';
      map['data_update'] = '';
      map['auto'] = '0';
      map['fine'] = '0';
      map['fine_a'] = '0';
      map['fine_c'] = '0';

      PayMentModel _PayMentModel = PayMentModel.fromJson(map);

      setState(() {
        _PayMentModels.add(_PayMentModel);
      });
      if (result.toString() != 'null') {
        for (var map in result) {
          PayMentModel _PayMentModel = PayMentModel.fromJson(map);
          var autox = _PayMentModel.auto;
          var serx = _PayMentModel.ser;
          var ptnamex = _PayMentModel.ptname;
          var fine = _PayMentModel.fine;
          var fine_amt = fine == '1'
              ? _PayMentModel.fine_c == '0.00'
                  ? double.parse(_PayMentModel.fine_a!)
                  : (((sum_amt - sum_disamt - dis_sum_Pakan - dis_sum_Matjum) *
                          double.parse(_PayMentModel.fine_c!)) /
                      100)
              : 0.00;
          setState(() {
            _PayMentModels.add(_PayMentModel);
            if (_PayMentModel.ptser == '7') {
              Pay_Ke = _PayMentModel.key_b;
            }

            if (autox == '1') {
              payment_ptSer1 = _PayMentModel.ptser.toString();
              paymentSer1 = serx.toString();
              paymentName1 = ptnamex.toString();
              selectedValue = _PayMentModel.bno.toString();
              bname1 = _PayMentModel.bname.toString();
              fine_total = fine_amt;
            }
          });
        }

        if (paymentName1 == null) {
          paymentSer1 = 1.toString();
          paymentName1 = 'เงินสด'.toString();
        }
      }
    } catch (e) {}
  }

  Future<Null> checkPreferance() async {
    int currentYear = DateTime.now().year;
    for (int i = currentYear; i >= currentYear - 10; i--) {
      YE_Th.add(i.toString());
    }

    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      MONTH_Now = DateFormat('MM').format(DateTime.parse('${datex}'));
      YEAR_Now = DateFormat('yyyy').format(DateTime.parse('${datex}'));
      renTal_user = preferences.getString('renTalSer');
      renTal_name = preferences.getString('renTalName');
      // fname_ = preferences.getString('fname');
      // if (preferences.getString('renTalSer') == '65') {
      //   viewTab = 0;
      // }
    });
    red_InvoiceMon_bill();
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

            tem_page_ser = renTalModel.tem_page!.trim();
            Default_Receipt_type =
                (renTalModel.printbill_default.toString() == 'N') ? 1 : 0;
            TitleType_Default_Receipt = int.parse(renTalModel.receipt_title!);
            renTalModels.add(renTalModel);
            if (bill_defaultx == 'P') {
              bills_name_ = 'บิลธรรมดา';
            } else {
              bills_name_ = 'ใบกำกับภาษี';
            }
          });
        }
      } else {}
    } catch (e) {
      print('Error-Dis(read_GC_rental) : ${e}');
    }
    var TextForm_time_hr =
        (datex.hour.toString().length < 2) ? '0${datex.hour}' : '${datex.hour}';
    var TextForm_time_min = (datex.minute.toString().length < 2)
        ? '0${datex.minute}'
        : '${datex.minute}';
    var TextForm_time_sec = (datex.second.toString().length < 2)
        ? '0${datex.second}'
        : '${datex.second}';
    setState(() {
      Form_time.text =
          '${TextForm_time_hr}:${TextForm_time_min}:${TextForm_time_sec}';
    });
  }

  Future<Null> red_InvoiceMon_bill() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var ren = preferences.getString('renTalSer');
    var zone = preferences.getString('zonePSer');
    var zone_Sub = preferences.getString('zoneSubSer');

    print('zone>>>ser $zone');

    if (limitedList_InvoiceModels_.length != 0) {
      setState(() {
        limitedList_InvoiceModels_.clear();
      });
    }
    String Serdata =
        (zone.toString() == '0' || zone == null) ? 'All' : 'Allzone';
    String url = (Serdata.toString() == 'All')
        ? '${MyConstant().domain}/GC_bill_invoiceMon_Pay.php?isAdd=true&ren=$ren&Serdata=$Serdata&serzone=$zone&_monts=$MONTH_Now&yex=$YEAR_Now'
        : '${MyConstant().domain}/GC_bill_invoiceMon_Pay.php?isAdd=true&ren=$ren&Serdata=$Serdata&serzone=$zone&_monts=$MONTH_Now&yex=$YEAR_Now';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print('result $ciddoc');
      if (result.toString() != 'null') {
        for (var map in result) {
          InvoiceReModel transMeterModel = InvoiceReModel.fromJson(map);
          setState(() {
            limitedList_InvoiceModels_.add(transMeterModel);
          });
        }
      }

      Future.delayed(const Duration(milliseconds: 200), () async {
        setState(() {
          _InvoiceModels = limitedList_InvoiceModels_;
        });
      });
      read_Invoice_limit();
    } catch (e) {}
  }

  Future<Null> read_Invoice_limit() async {
    setState(() {
      endIndex = offset + limit;
      InvoiceModels = limitedList_InvoiceModels_.sublist(
          offset, // Start index
          (endIndex <= limitedList_InvoiceModels_.length)
              ? endIndex
              : limitedList_InvoiceModels_.length // End index
          );
    });
  }

  _searchBar() {
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
          // fontSize: 20.0,
          color: TextHome_Color.TextHome_Colors,
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
        // text = text.toLowerCase();
        setState(() {
          // ignore: non_constant_identifier_names
          InvoiceModels = _InvoiceModels.where((InvoiceModelx) {
            var notTitle = InvoiceModelx.cid.toString();
            var notdocno = InvoiceModelx.docno.toString();
            var notdate = InvoiceModelx.date.toString();
            var notdatex = DateFormat.yMMMd('th_TH')
                .format(DateTime.parse('${InvoiceModelx.date} 00:00:00'))
                .toString();
            var notln = InvoiceModelx.ln.toString();
            var notsname = InvoiceModelx.scname.toString();
            var notcname = InvoiceModelx.cname.toString();
            // var notTitle = InvoiceModelx.cid.toString().toLowerCase();
            // var notdocno = InvoiceModelx.docno.toString().toLowerCase();
            // var notdate = InvoiceModelx.date.toString().toLowerCase();
            // var notdatex = DateFormat.yMMMd('th_TH')
            //     .format(DateTime.parse('${InvoiceModelx.date} 00:00:00'))
            //     .toString()
            //     .toLowerCase();
            // var notln = InvoiceModelx.ln.toString().toLowerCase();
            // var notsname = InvoiceModelx.scname.toString().toLowerCase();
            // var notcname = InvoiceModelx.cname.toString().toLowerCase();

            return notTitle.contains(text) ||
                notsname.contains(text) ||
                notcname.contains(text) ||
                notdatex.contains(text) ||
                notdocno.contains(text) ||
                notln.contains(text);
          }).toList();
        });
        if (text.isEmpty) {
          read_Invoice_limit();
        } else {}
      },
    );
  }

  Future<Null> in_Trans_select(index) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    var user = preferences.getString('ser');
    var ciddoc = InvoiceModels[index].cid;
    var qutser = '1';

    // var tser = InvoiceModels[index].ser;
    // var tdocno = InvoiceModels[index].docno;
    // var total_bill = ((double.parse(InvoiceModels[index].total_dis!) +
    //     double.parse(InvoiceModels[index].total_vat!)));
    // var total_dis = ((double.parse(InvoiceModels[index].total_bill!) -
    //     double.parse(InvoiceModels[index].total_dis!)));
    // var total_vat = InvoiceModels[index].total_vat;
    // var total_wht = InvoiceModels[index].total_wht;
    // var total_amt = InvoiceModels[index].total_bill;
    var tser = InvoiceModels[index].ser;
    var tdocno = InvoiceModels[index].docno;
    var total_bill = double.parse(InvoiceModels[index].total_dis!);
    var total_dis = double.parse(InvoiceModels[index].amt_dis!);
    var total_vat = InvoiceModels[index].total_vat;
    var total_wht = InvoiceModels[index].total_wht;
    var total_amt = InvoiceModels[index].total_bill;
    print('object $tdocno');
    String url =
        '${MyConstant().domain}/In_tran_select_Inv.php?isAdd=true&ren=$ren&ciddoc=$ciddoc&qutser=$qutser&tser=$tser&tdocno=$tdocno&user=$user&total_bill=$total_bill&total_dis=$total_dis&total_vat=$total_vat&total_wht=$total_wht&total_amt=$total_amt';
    print('url $url');

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print('rr>>>>>> $result');
      if (result.toString() == 'true') {
        setState(() {
          red_Trans_select2();
        });
        print('rrrrrrrrrrrrrr');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              backgroundColor: Colors.red,
              content: Text('ไม่สามารถเลือกรายการซ้ำได้',
                  style: TextStyle(
                      color: Colors.white, fontFamily: Font_.Fonts_T))),
        );
      }
    } catch (e) {
      print('rrrrrrrrrrrrrr $e');
    }
  }

  Future<Null> red_Trans_select2() async {
    if (_TransModels.isNotEmpty) {
      setState(() {
        _TransModels.clear();
        sum_pvat = 0;
        sum_vat = 0;
        sum_wht = 0;
        sum_amt = 0;
        sum_tran_dis = 0;
        sum_matjum = 0;
        sum_fine = 0;
      });
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    var user = preferences.getString('ser');
    var ciddoc = '';
    var qutser = '';

    String url =
        '${MyConstant().domain}/GC_tran_select_inv.php?isAdd=true&ren=$ren&user=$user&ciddoc=$ciddoc'; //GC_tran_select_fin
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);
      if (result.toString() != 'null') {
        setState(() {
          _TransModels.clear();
          sum_pvat = 0;
          sum_vat = 0;
          sum_wht = 0;
          sum_amt = 0;
          sum_tran_dis = 0;
          sum_fine = 0;
        });
        for (var map in result) {
          TransModel _TransModel = TransModel.fromJson(map);

          var sum_pvatx = double.parse(_TransModel.pvat!);
          var sum_vatx = double.parse(_TransModel.vat!);
          var sum_whtx = double.parse(_TransModel.wht!);
          var sum_amtx = double.parse(_TransModel.total!);
          var sum_disx = double.parse(_TransModel.dis!);
          var sum_finex = double.parse(_TransModel.fine!);
          setState(() {
            sum_pvat = sum_pvat + sum_pvatx;
            sum_vat = sum_vat + sum_vatx;
            sum_wht = sum_wht + sum_whtx;
            sum_amt = sum_amt + sum_amtx;
            sum_tran_dis = sum_tran_dis + sum_disx;
            sum_fine = sum_fine + sum_finex;
            _TransModels.add(_TransModel);
          });
        }
      } else {
        setState(() {
          dis_matjum = 0;
          dis_sum_Matjum = 0.00;
        });
      }
    } catch (e) {}
    print('_TransModels.length >>>>> ${_TransModels.length}');
    // setState(() {
    //   red_Trans_select2_fin();
    //   read_GC_matjum();

    //   Form_payment1.text =
    //       (sum_amt - sum_disamt - dis_sum_Pakan - sum_tran_dis - dis_sum_Matjum)
    //           .toStringAsFixed(2)
    //           .toString();
    // });
  }

  Widget Next_page() {
    return Row(
      children: [
        const Expanded(child: Text('')),
        StreamBuilder(
            stream: Stream.periodic(const Duration(milliseconds: 300)),
            builder: (context, snapshot) {
              return Container(
                decoration: const BoxDecoration(
                  color: AppbackgroundColor.Sub_Abg_Colors,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                ),
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  children: [
                    InkWell(
                        onTap: (offset == 0)
                            ? null
                            : () async {
                                if (offset == 0) {
                                } else {
                                  setState(() {
                                    offset = offset - limit;

                                    read_Invoice_limit();
                                    tappedIndex_ = '';
                                  });
                                  _scrollController2.animateTo(
                                    0,
                                    duration: const Duration(seconds: 1),
                                    curve: Curves.easeOut,
                                  );
                                }
                              },
                        child: Icon(
                          Icons.arrow_left,
                          color:
                              (offset == 0) ? Colors.grey[200] : Colors.black,
                          size: 25,
                        )),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
                      child: Text(
                        /// '*//$endIndex /${limitedList_teNantModels.length} ///${(endIndex / limit)}/${(limitedList_teNantModels.length / limit).ceil()}',
                        '${(endIndex / limit)}/${(limitedList_InvoiceModels_.length / limit).ceil()}',
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontFamily: FontWeight_.Fonts_T,
                          //fontSize: 10.0
                        ),
                      ),
                    ),
                    InkWell(
                        onTap: (endIndex >= limitedList_InvoiceModels_.length)
                            ? null
                            : () async {
                                setState(() {
                                  offset = offset + limit;
                                  tappedIndex_ = '';
                                  read_Invoice_limit();
                                });
                                _scrollController2.animateTo(
                                  0,
                                  duration: const Duration(seconds: 1),
                                  curve: Curves.easeOut,
                                );
                              },
                        child: Icon(
                          Icons.arrow_right,
                          color: (endIndex >= limitedList_InvoiceModels_.length)
                              ? Colors.grey[200]
                              : Colors.black,
                          size: 25,
                        )),
                  ],
                ),
              );
            }),
      ],
    );
  }

/////////----------------------------------------------------------->

  Future<void> uploadFile_Slip() async {
    // InsertFile_SQL(fileName, MixPath_);
    // Open the file picker and get the selected file
    // final input = html.FileUploadInputElement();
    // // input..accept = 'application/pdf';
    // input.accept = 'image/jpeg,image/png,image/jpg';
    // input.click();
    // // deletedFile_('IDcard_LE000001_25-02-2023.pdf');
    // await input.onChange.first;

    // final file = input.files!.first;
    // final reader = html.FileReader();
    // reader.readAsArrayBuffer(file);
    // await reader.onLoadEnd.first;
    // String fileName_ = file.name;
    // String extension = fileName_.split('.').last;
    // print('File name: $fileName_');
    // print('Extension: $extension');
    // setState(() {
    //   base64_Slip = base64Encode(reader.result as Uint8List);
    // });
    // print(base64_Slip);
    // setState(() {
    //   extension_ = extension;
    //   file_ = file;
    // });

    // ignore: deprecated_member_use
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
      // print(base64_Slip);
    }
    // OKuploadFile_Slip(extension, file);
  }

  Future<void> OKuploadFile_Slip() async {
    if (base64_Slip != null) {
      String Path_foder = 'slip';
      String dateTimeNow = DateTime.now().toString();
      String date = DateFormat('ddMMyyyy')
          .format(DateTime.parse('${dateTimeNow}'))
          .toString();
      final dateTimeNow2 = DateTime.now().toUtc().add(const Duration(hours: 7));
      final formatter2 = DateFormat('HHmmss');
      final formattedTime2 = formatter2.format(dateTimeNow2);
      String Time_ = formattedTime2.toString();
      // var fileName_Slip_ = 'slip_INVALL_${date}_$Time_';
      setState(() {
        fileName_Slip = 'slip_INVALL_${date}_$Time_.$extension_';
      });

      try {
        // 2. Read the image as bytes
        // final imageBytes = await pickedFile.readAsBytes();

        // 3. Encode the image as a base64 string
        // final base64Image = base64Encode(imageBytes);

        // 4. Make an HTTP POST request to your server
        final url =
            '${MyConstant().domain}/File_uploadSlip_NewEdit.php?name=$fileName_Slip&Foder=$foder&extension=$extension_';

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
          print('Image uploaded successfully');
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

  ////////////--------------------------------------------->
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: (Responsive.isDesktop(context))
                    ? MediaQuery.of(context).size.width * 0.85
                    : 1200,
                child: Column(
                  children: [
                    Container(
                      // color: Colors.white,
                      height: MediaQuery.of(context).size.height * 0.95,

                      child: Row(
                        children: [
                          // if (view_P1 == null)
                          Expanded(
                              child: Container(
                            decoration: const BoxDecoration(
                              color: AppbackgroundColor.Sub_Abg_Colors,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10)),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: AppbackgroundColor.TiTile_Colors,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(0),
                                        bottomRight: Radius.circular(0)),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: TextButton(
                                            onPressed: () async {
                                              // _onshowMonth(context: context, locale: 'th');
                                            },
                                            child: const Text(
                                              'รายการวางบิล',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                color: AccountScreen_Color
                                                    .Colors_Text1_,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: FontWeight_.Fonts_T,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 4,
                                          child: Container(
                                            height: 40,
                                            decoration: const BoxDecoration(
                                              color: Colors.white70,
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(10),
                                                  topRight: Radius.circular(10),
                                                  bottomLeft:
                                                      Radius.circular(10),
                                                  bottomRight:
                                                      Radius.circular(10)),
                                            ),
                                            child: _searchBar(),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: SizedBox(
                                            child: Next_page(),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  color: AppbackgroundColor.TiTile_Colors,
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            'เลขที่สัญญา',
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              color: AccountScreen_Color
                                                  .Colors_Text1_,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: FontWeight_.Fonts_T,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            'เลขที่วางบิล',
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              color: AccountScreen_Color
                                                  .Colors_Text1_,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: FontWeight_.Fonts_T,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            'กำหนดชำระ',
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              color: AccountScreen_Color
                                                  .Colors_Text1_,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: FontWeight_.Fonts_T,
                                            ),
                                          ),
                                        ),
                                        // Expanded(
                                        //   flex: 1,
                                        //   child: Text(
                                        //     'WHT',
                                        //     textAlign: TextAlign.end,
                                        //   ),
                                        // ),
                                        // Expanded(
                                        //   flex: 1,
                                        //   child: Text(
                                        //     'VAT',
                                        //     textAlign: TextAlign.end,
                                        //   ),
                                        // ),
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            'ส่วนลด',
                                            textAlign: TextAlign.end,
                                            style: TextStyle(
                                              color: AccountScreen_Color
                                                  .Colors_Text1_,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: FontWeight_.Fonts_T,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            'ยอดรวม',
                                            textAlign: TextAlign.end,
                                            style: TextStyle(
                                              color: AccountScreen_Color
                                                  .Colors_Text1_,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: FontWeight_.Fonts_T,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: ListView.builder(
                                      // padding: const EdgeInsets.all(8),
                                      itemCount: InvoiceModels.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Material(
                                          color: (_TransModels.any((A) =>
                                                  A.docno ==
                                                  InvoiceModels[index].docno))
                                              ? tappedIndex_Color
                                                  .tappedIndex_Colors
                                              : null,
                                          child: Container(
                                              child: ListTile(
                                                  onTap: () async {
                                                    setState(() {
                                                      Refpay_1 = null;
                                                      Refpay_2 = null;
                                                      Refpay_3 = null;
                                                    });
                                                    if (_TransModels.length !=
                                                        10) {
                                                      in_Trans_select(index);
                                                      setState(() {
                                                        cidSelect =
                                                            InvoiceModels[index]
                                                                .cid;
                                                      });
                                                    } else {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        const SnackBar(
                                                            backgroundColor:
                                                                Colors.red,
                                                            content: Text(
                                                                'ไม่สามารถทำมากกว่า 10 รายการได้ ',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontFamily:
                                                                        Font_
                                                                            .Fonts_T))),
                                                      );
                                                    }

                                                    // print(
                                                    //     '${InvoiceModels[index].ser} ${InvoiceModels[index].cid} ${InvoiceModels[index].docno}');
                                                  },
                                                  title: Container(
                                                      decoration:
                                                          const BoxDecoration(
                                                        // color: Colors.green[100]!
                                                        //     .withOpacity(0.5),
                                                        border: Border(
                                                          bottom: BorderSide(
                                                            color:
                                                                Colors.black12,
                                                            width: 1,
                                                          ),
                                                        ),
                                                      ),
                                                      child: Column(
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Expanded(
                                                                flex: 2,
                                                                child: Text(
                                                                  '${InvoiceModels[index].ln}',
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      fontFamily:
                                                                          Font_
                                                                              .Fonts_T,
                                                                      color: Colors
                                                                          .grey),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                flex: 2,
                                                                child: Text(
                                                                  '${InvoiceModels[index].scname}',
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      fontFamily:
                                                                          Font_
                                                                              .Fonts_T,
                                                                      color: Colors
                                                                          .grey),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                flex: 2,
                                                                child: Text(
                                                                  '${InvoiceModels[index].cname}',
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      fontFamily:
                                                                          Font_
                                                                              .Fonts_T,
                                                                      color: Colors
                                                                          .grey),
                                                                ),
                                                              ),
                                                              // Expanded(
                                                              //   flex: 1,
                                                              //   child: Text(
                                                              //     '${nFormat.format(double.parse(InvoiceModels[index].total_wht!))}',
                                                              //     textAlign: TextAlign.end,
                                                              //   ),
                                                              // ),
                                                              // Expanded(
                                                              //   flex: 1,
                                                              //   child: Text(
                                                              //     '${nFormat.format(double.parse(InvoiceModels[index].total_vat!))}',
                                                              //     textAlign: TextAlign.end,
                                                              //   ),
                                                              // ),
                                                              const Expanded(
                                                                flex: 2,
                                                                child: Text(
                                                                  '',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      color: Colors
                                                                          .grey),
                                                                ),
                                                              ),
                                                              const Expanded(
                                                                flex: 2,
                                                                child: Text(
                                                                  '',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .end,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              Expanded(
                                                                flex: 2,
                                                                child:
                                                                    AutoSizeText(
                                                                  minFontSize:
                                                                      8,
                                                                  maxFontSize:
                                                                      14,
                                                                  maxLines: 1,
                                                                  '${index + 1}: ${InvoiceModels[index].cid}',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .start,
                                                                  style:
                                                                      const TextStyle(
                                                                    color: AccountScreen_Color
                                                                        .Colors_Text2_,
                                                                    // fontWeight:
                                                                    //     FontWeight
                                                                    //         .bold,
                                                                    fontFamily:
                                                                        Font_
                                                                            .Fonts_T,
                                                                    //fontSize: 10.0
                                                                  ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                flex: 2,
                                                                child:
                                                                    AutoSizeText(
                                                                  minFontSize:
                                                                      8,
                                                                  maxFontSize:
                                                                      14,
                                                                  maxLines: 1,
                                                                  '${InvoiceModels[index].docno}',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .start,
                                                                  style:
                                                                      const TextStyle(
                                                                    color: AccountScreen_Color
                                                                        .Colors_Text2_,
                                                                    // fontWeight:
                                                                    //     FontWeight
                                                                    //         .bold,
                                                                    fontFamily:
                                                                        Font_
                                                                            .Fonts_T,
                                                                    //fontSize: 10.0
                                                                  ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                flex: 2,
                                                                child:
                                                                    AutoSizeText(
                                                                  minFontSize:
                                                                      8,
                                                                  maxFontSize:
                                                                      14,
                                                                  maxLines: 1,
                                                                  DateFormat.yMMMd(
                                                                          'th_TH')
                                                                      .format(DateTime
                                                                          .parse(
                                                                              '${InvoiceModels[index].date} 00:00:00'))
                                                                      .toString(),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .start,
                                                                  style:
                                                                      const TextStyle(
                                                                    color: AccountScreen_Color
                                                                        .Colors_Text2_,
                                                                    // fontWeight:
                                                                    //     FontWeight
                                                                    //         .bold,
                                                                    fontFamily:
                                                                        Font_
                                                                            .Fonts_T,
                                                                    //fontSize: 10.0
                                                                  ),
                                                                ),
                                                              ),
                                                              // Expanded(
                                                              //   flex: 1,
                                                              //   child: Text(
                                                              //     '${nFormat.format(double.parse(InvoiceModels[index].total_wht!))}',
                                                              //     textAlign: TextAlign.end,
                                                              //   ),
                                                              // ),
                                                              // Expanded(
                                                              //   flex: 1,
                                                              //   child: Text(
                                                              //     '${nFormat.format(double.parse(InvoiceModels[index].total_vat!))}',
                                                              //     textAlign: TextAlign.end,
                                                              //   ),
                                                              // ),
                                                              Expanded(
                                                                flex: 2,
                                                                child:
                                                                    AutoSizeText(
                                                                  minFontSize:
                                                                      8,
                                                                  maxFontSize:
                                                                      14,
                                                                  maxLines: 1,
                                                                  '${nFormat.format(((double.parse(InvoiceModels[index].amt_dis!))))}',
                                                                  // '${nFormat.format(((double.parse(InvoiceModels[index].total_bill!) - double.parse(InvoiceModels[index].total_dis!))))}',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .end,
                                                                  style:
                                                                      const TextStyle(
                                                                    color: AccountScreen_Color
                                                                        .Colors_Text2_,
                                                                    // fontWeight:
                                                                    //     FontWeight
                                                                    //         .bold,
                                                                    fontFamily:
                                                                        Font_
                                                                            .Fonts_T,
                                                                    //fontSize: 10.0
                                                                  ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                flex: 2,
                                                                child:
                                                                    AutoSizeText(
                                                                  minFontSize:
                                                                      8,
                                                                  maxFontSize:
                                                                      14,
                                                                  maxLines: 1,
                                                                  '${nFormat.format((double.parse(InvoiceModels[index].total_dis!)))}',
                                                                  // '${nFormat.format((double.parse(InvoiceModels[index].total_dis!) + double.parse(InvoiceModels[index].total_vat!)))}',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .end,
                                                                  style:
                                                                      const TextStyle(
                                                                    color: AccountScreen_Color
                                                                        .Colors_Text2_,
                                                                    // fontWeight:
                                                                    //     FontWeight
                                                                    //         .bold,
                                                                    fontFamily:
                                                                        Font_
                                                                            .Fonts_T,
                                                                    //fontSize: 10.0
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      )))),
                                        );
                                      }),
                                ),
                                Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[400],
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(0),
                                      topRight: Radius.circular(0),
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                    ),
                                    // border: Border.all(color: Colors.grey, width: 1),
                                  ),
                                )
                              ],
                            ),
                          )),
                          const SizedBox(
                            width: 10,
                          ),
                          // if (view_P2 == null)
                          Expanded(
                            child: Container(
                              decoration: const BoxDecoration(
                                color: AppbackgroundColor.Sub_Abg_Colors,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10)),
                              ),
                              // height: MediaQuery.of(context).size.width * 0.4,
                              child: Column(
                                children: [
                                  SizedBox(
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.deepPurple[300],
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
                                                                  0),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  0)),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      10.0),
                                                  child: TextButton(
                                                    onPressed: () async {
                                                      // if (_TransModels.length != 0) {
                                                      //   in_Trans_invoice_all();
                                                      // } else {
                                                      //   ScaffoldMessenger.of(context)
                                                      //       .showSnackBar(
                                                      //     const SnackBar(
                                                      //         content: Text(
                                                      //             'กรุณาเลือก เดือน ปี ที่ต้องการวางบิล',
                                                      //             style: TextStyle(
                                                      //                 color: Colors.white,
                                                      //                 fontFamily:
                                                      //                     Font_.Fonts_T))),
                                                      //   );
                                                      // }
                                                    },
                                                    child: const Text(
                                                      "รายละเอียด",
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily:
                                                            FontWeight_.Fonts_T,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        Container(
                                          color: AppbackgroundColor.TiTile_Box,
                                          padding: const EdgeInsets.all(4.0),
                                          child: Row(
                                            children: [
                                              const Expanded(
                                                flex: 2,
                                                child: Text(
                                                  'เลขที่สัญญา',
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    color: AccountScreen_Color
                                                        .Colors_Text1_,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T,
                                                  ),
                                                ),
                                              ),
                                              const Expanded(
                                                flex: 3,
                                                child: Text(
                                                  'เลขที่วางบิล',
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    color: AccountScreen_Color
                                                        .Colors_Text1_,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T,
                                                  ),
                                                ),
                                              ),
                                              const Expanded(
                                                flex: 1,
                                                child: Text(
                                                  'WHT',
                                                  textAlign: TextAlign.end,
                                                  style: TextStyle(
                                                    color: AccountScreen_Color
                                                        .Colors_Text1_,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T,
                                                  ),
                                                ),
                                              ),
                                              const Expanded(
                                                flex: 1,
                                                child: Text(
                                                  'VAT',
                                                  textAlign: TextAlign.end,
                                                  style: TextStyle(
                                                    color: AccountScreen_Color
                                                        .Colors_Text1_,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T,
                                                  ),
                                                ),
                                              ),
                                              const Expanded(
                                                flex: 2,
                                                child: Text(
                                                  'ยอด',
                                                  textAlign: TextAlign.end,
                                                  style: TextStyle(
                                                    color: AccountScreen_Color
                                                        .Colors_Text1_,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T,
                                                  ),
                                                ),
                                              ),
                                              const Expanded(
                                                flex: 2,
                                                child: Text(
                                                  'ส่วนลด',
                                                  textAlign: TextAlign.end,
                                                  style: TextStyle(
                                                    color: AccountScreen_Color
                                                        .Colors_Text1_,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T,
                                                  ),
                                                ),
                                              ),
                                              const Expanded(
                                                flex: 2,
                                                child: Text(
                                                  'ยอดรวม',
                                                  textAlign: TextAlign.end,
                                                  style: TextStyle(
                                                    color: AccountScreen_Color
                                                        .Colors_Text1_,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: IconButton(
                                                    onPressed: () async {
                                                      for (var index = 0;
                                                          index <
                                                              _TransModels
                                                                  .length;
                                                          index++) {
                                                        de_Trans_item_inv(
                                                            index);
                                                      }
                                                      setState(() {
                                                        Refpay_1 = null;
                                                        Refpay_2 = null;
                                                        Refpay_3 = null;
                                                      });
                                                    },
                                                    icon: const Icon(
                                                      Icons.close,
                                                      color: Colors.red,
                                                    )),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: ListView.builder(
                                      // padding: const EdgeInsets.all(8),
                                      itemCount: _TransModels.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Material(
                                          color:
                                              tappedIndex_ == index.toString()
                                                  ? tappedIndex_Color
                                                      .tappedIndex_Colors
                                                  : AppbackgroundColor
                                                      .Sub_Abg_Colors,
                                          child: Container(
                                            child: ListTile(
                                              // onTap: () async {},
                                              title: Container(
                                                decoration: const BoxDecoration(
                                                  // color: Colors.green[100]!
                                                  //     .withOpacity(0.5),
                                                  border: Border(
                                                    bottom: BorderSide(
                                                      color: Colors.black12,
                                                      width: 1,
                                                    ),
                                                  ),
                                                ),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          flex: 2,
                                                          child: AutoSizeText(
                                                            minFontSize: 8,
                                                            maxFontSize: 14,
                                                            maxLines: 1,
                                                            '${index + 1}.${_TransModels[index].refno}',
                                                            textAlign:
                                                                TextAlign.start,
                                                            style:
                                                                const TextStyle(
                                                              color: AccountScreen_Color
                                                                  .Colors_Text2_,
                                                              // fontWeight:
                                                              //     FontWeight
                                                              //         .bold,
                                                              fontFamily:
                                                                  Font_.Fonts_T,
                                                              //fontSize: 10.0
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 3,
                                                          child: AutoSizeText(
                                                            minFontSize: 8,
                                                            maxFontSize: 14,
                                                            maxLines: 1,
                                                            '${_TransModels[index].docno}',
                                                            textAlign:
                                                                TextAlign.start,
                                                            style:
                                                                const TextStyle(
                                                              color: AccountScreen_Color
                                                                  .Colors_Text2_,
                                                              // fontWeight:
                                                              //     FontWeight
                                                              //         .bold,
                                                              fontFamily:
                                                                  Font_.Fonts_T,
                                                              //fontSize: 10.0
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 1,
                                                          child: AutoSizeText(
                                                            minFontSize: 8,
                                                            maxFontSize: 14,
                                                            maxLines: 1,
                                                            '${nFormat.format(double.parse(_TransModels[index].wht.toString()))}',
                                                            textAlign:
                                                                TextAlign.end,
                                                            style:
                                                                const TextStyle(
                                                              color: AccountScreen_Color
                                                                  .Colors_Text2_,
                                                              // fontWeight:
                                                              //     FontWeight
                                                              //         .bold,
                                                              fontFamily:
                                                                  Font_.Fonts_T,
                                                              //fontSize: 10.0
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 1,
                                                          child: AutoSizeText(
                                                            minFontSize: 8,
                                                            maxFontSize: 14,
                                                            maxLines: 1,
                                                            '${nFormat.format(double.parse(_TransModels[index].vat.toString()))}',
                                                            textAlign:
                                                                TextAlign.end,
                                                            style:
                                                                const TextStyle(
                                                              color: AccountScreen_Color
                                                                  .Colors_Text2_,
                                                              // fontWeight:
                                                              //     FontWeight
                                                              //         .bold,
                                                              fontFamily:
                                                                  Font_.Fonts_T,
                                                              //fontSize: 10.0
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 2,
                                                          child: AutoSizeText(
                                                            minFontSize: 8,
                                                            maxFontSize: 14,
                                                            maxLines: 1,
                                                            '${nFormat.format(double.parse(_TransModels[index].amt.toString()))}',
                                                            textAlign:
                                                                TextAlign.end,
                                                            style:
                                                                const TextStyle(
                                                              color: AccountScreen_Color
                                                                  .Colors_Text2_,
                                                              // fontWeight:
                                                              //     FontWeight
                                                              //         .bold,
                                                              fontFamily:
                                                                  Font_.Fonts_T,
                                                              //fontSize: 10.0
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 2,
                                                          child: AutoSizeText(
                                                            minFontSize: 8,
                                                            maxFontSize: 14,
                                                            maxLines: 1,
                                                            '${nFormat.format(double.parse(_TransModels[index].dis.toString()))}',
                                                            textAlign:
                                                                TextAlign.end,
                                                            style:
                                                                const TextStyle(
                                                              color: AccountScreen_Color
                                                                  .Colors_Text2_,
                                                              // fontWeight:
                                                              //     FontWeight
                                                              //         .bold,
                                                              fontFamily:
                                                                  Font_.Fonts_T,
                                                              //fontSize: 10.0
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 2,
                                                          child: AutoSizeText(
                                                            minFontSize: 8,
                                                            maxFontSize: 14,
                                                            maxLines: 1,
                                                            '${nFormat.format(double.parse(_TransModels[index].total.toString()))}',
                                                            textAlign:
                                                                TextAlign.end,
                                                            style:
                                                                const TextStyle(
                                                              color: AccountScreen_Color
                                                                  .Colors_Text2_,
                                                              // fontWeight:
                                                              //     FontWeight
                                                              //         .bold,
                                                              fontFamily:
                                                                  Font_.Fonts_T,
                                                              //fontSize: 10.0
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 1,
                                                          child: Align(
                                                            alignment: Alignment
                                                                .centerRight,
                                                            child: IconButton(
                                                                onPressed:
                                                                    () async {
                                                                  de_Trans_item_inv(
                                                                      index);
                                                                  setState(() {
                                                                    Refpay_1 =
                                                                        null;
                                                                    Refpay_2 =
                                                                        null;
                                                                    Refpay_3 =
                                                                        null;
                                                                  });
                                                                },
                                                                icon: Icon(
                                                                  Icons
                                                                      .remove_circle_outline,
                                                                  color: Colors
                                                                      .red[300],
                                                                )),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    if (_TransModels[index]
                                                            .fine !=
                                                        '0.00')
                                                      Row(
                                                        children: [
                                                          const Expanded(
                                                            flex: 2,
                                                            child: Text(
                                                              '',
                                                              textAlign:
                                                                  TextAlign.end,
                                                            ),
                                                          ),
                                                          const Expanded(
                                                            flex: 3,
                                                            child: Text(
                                                              '',
                                                              textAlign:
                                                                  TextAlign.end,
                                                            ),
                                                          ),
                                                          const Expanded(
                                                            flex: 1,
                                                            child: Text(
                                                              '',
                                                              textAlign:
                                                                  TextAlign.end,
                                                            ),
                                                          ),
                                                          const Expanded(
                                                            flex: 1,
                                                            child: Text(
                                                              '',
                                                              textAlign:
                                                                  TextAlign.end,
                                                            ),
                                                          ),
                                                          const Expanded(
                                                            flex: 2,
                                                            child: Text(
                                                              '',
                                                              textAlign:
                                                                  TextAlign.end,
                                                            ),
                                                          ),
                                                          const Expanded(
                                                            flex: 2,
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .end,
                                                              children: [
                                                                Icon(
                                                                  Icons
                                                                      .subdirectory_arrow_right,
                                                                  color: Colors
                                                                      .red,
                                                                ),
                                                                Text(
                                                                  'ค่าปรับ',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .end,
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .red,
                                                                    fontSize:
                                                                        12,
                                                                    // fontWeight:
                                                                    //     FontWeight
                                                                    //         .bold,
                                                                    fontFamily:
                                                                        Font_
                                                                            .Fonts_T,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 2,
                                                            child: Text(
                                                              '${nFormat.format(double.parse(_TransModels[index].fine.toString()))}',
                                                              textAlign:
                                                                  TextAlign.end,
                                                              style:
                                                                  const TextStyle(
                                                                color:
                                                                    Colors.red,
                                                                fontSize: 12,
                                                                // fontWeight:
                                                                //     FontWeight
                                                                //         .bold,
                                                                fontFamily: Font_
                                                                    .Fonts_T,
                                                              ),
                                                            ),
                                                          ),
                                                          const Expanded(
                                                            flex: 1,
                                                            child: Text(
                                                              '',
                                                              textAlign:
                                                                  TextAlign.end,
                                                            ),
                                                          ),
                                                        ],
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
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Divider(),
                                  fine_total == 0.00
                                      ? const SizedBox()
                                      : Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Row(
                                            children: [
                                              const Expanded(
                                                flex: 1,
                                                child: AutoSizeText(
                                                  minFontSize: 10,
                                                  maxFontSize: 15,
                                                  'ค่าธรรมเนียม ( บิล/บาท )',
                                                  style: TextStyle(
                                                      color: Colors.red,
                                                      //fontWeight: FontWeight.bold,
                                                      fontFamily:
                                                          Font_.Fonts_T),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: AutoSizeText(
                                                  minFontSize: 10,
                                                  maxFontSize: 15,
                                                  textAlign: TextAlign.end,
                                                  '${_TransModels.length} ( ${nFormat.format((fine_total))} ) / ${nFormat.format((fine_total * _TransModels.length))}',
                                                  style: const TextStyle(
                                                      color: Colors.red,
                                                      //fontWeight: FontWeight.bold,
                                                      fontFamily:
                                                          Font_.Fonts_T),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                  Container(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                            'ทั้งหมด ${_TransModels.length}',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        const Expanded(
                                          flex: 1,
                                          child: Text('รายการ'),
                                        ),
                                        const Expanded(
                                          flex: 2,
                                          child: Text(''),
                                        ),
                                        const Expanded(
                                          flex: 1,
                                          child: Text(
                                            'ยอดรวม',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                            '${nFormat.format(sum_amt + sum_fine + (fine_total * _TransModels.length))}',
                                            textAlign: TextAlign.end,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Divider(),
                                  const SizedBox(
                                    height: 5,
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
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              flex: 2,
                                              child: Row(
                                                children: [
                                                  const AutoSizeText(
                                                    minFontSize: 10,
                                                    maxFontSize: 15,
                                                    'ส่วนลด',
                                                    style: TextStyle(
                                                        color:
                                                            PeopleChaoScreen_Color
                                                                .Colors_Text2_,
                                                        //fontWeight: FontWeight.bold,
                                                        fontFamily: FontWeight_
                                                            .Fonts_T),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  SizedBox(
                                                    width: 100,
                                                    height: 30,
                                                    child: TextFormField(
                                                      keyboardType:
                                                          TextInputType.number,
                                                      controller: sum_dispx,
                                                      onChanged: (value) async {
                                                        var valuenum =
                                                            value == ''
                                                                ? 0
                                                                : double.parse(
                                                                    value);
                                                        var sum = ((sum_amt *
                                                                valuenum) /
                                                            100);

                                                        setState(() {
                                                          // discount_ =
                                                          // '${valuenum.toString()}';
                                                          sum_dis = sum;
                                                          sum_disamt = sum;
                                                          sum_disamtx.text =
                                                              sum.toString();
                                                          // Form_payment1
                                                          //     .text = (sum_amt -
                                                          //         sum_disamt -
                                                          //         dis_sum_Pakan -
                                                          //         sum_tran_dis -
                                                          //         dis_sum_Matjum)
                                                          //     .toStringAsFixed(
                                                          //         2)
                                                          //     .toString();
                                                        });

                                                        print(
                                                            'sum_dis $sum_dis   /////// ${valuenum.toString()}');
                                                      },
                                                      cursorColor: Colors.black,
                                                      decoration:
                                                          InputDecoration(
                                                              fillColor: Colors
                                                                  .white
                                                                  .withOpacity(
                                                                      0.3),
                                                              filled: true,
                                                              // prefixIcon:
                                                              //     const Icon(Icons.person, color: Colors.black),
                                                              // suffixIcon: Icon(Icons.clear, color: Colors.black),
                                                              focusedBorder:
                                                                  const OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .only(
                                                                  topRight: Radius
                                                                      .circular(
                                                                          5),
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          5),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          5),
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          5),
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
                                                                          5),
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          5),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          5),
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          5),
                                                                ),
                                                                borderSide:
                                                                    BorderSide(
                                                                  width: 1,
                                                                  color: Colors
                                                                      .grey,
                                                                ),
                                                              ),
                                                              // labelText: 'ระบุชื่อร้านค้า',
                                                              labelStyle:
                                                                  const TextStyle(
                                                                      color: Colors
                                                                          .black54,
                                                                      fontSize:
                                                                          8,

                                                                      //fontWeight: FontWeight.bold,
                                                                      fontFamily:
                                                                          Font_
                                                                              .Fonts_T)),
                                                      inputFormatters: <TextInputFormatter>[
                                                        FilteringTextInputFormatter
                                                            .allow(RegExp(
                                                                r'[0-9 .]')),
                                                        // FilteringTextInputFormatter.digitsOnly
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  const AutoSizeText(
                                                    minFontSize: 10,
                                                    maxFontSize: 15,
                                                    '%',
                                                    style: TextStyle(
                                                        color:
                                                            PeopleChaoScreen_Color
                                                                .Colors_Text2_,
                                                        //fontWeight: FontWeight.bold,
                                                        fontFamily:
                                                            Font_.Fonts_T),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: SizedBox(
                                                width: 20,
                                                height: 30,
                                                child: TextFormField(
                                                  keyboardType:
                                                      TextInputType.number,
                                                  showCursor: true,
                                                  //add this line
                                                  readOnly: false,

                                                  // initialValue: sum_disamt.text,
                                                  textAlign: TextAlign.end,
                                                  controller: sum_disamtx,
                                                  onChanged: (value) async {
                                                    print(
                                                        '>>>>>$value<<<<<<${sum_disamtx.text}<<<< ${value.isEmpty}<<<');

                                                    var valuenum = value == ''
                                                        ? 0.00
                                                        : double.parse(value);

                                                    setState(() {
                                                      sum_dis = valuenum;
                                                      sum_disamt = valuenum;

                                                      sum_dispx.clear();
                                                      // Form_payment1
                                                      //     .text = ((sum_amt +
                                                      //             sum_fine +
                                                      //             sum_vat +
                                                      //             sum_wht) -
                                                      //         sum_disamt)
                                                      //     .toStringAsFixed(
                                                      //         2)
                                                      //     .toString();
                                                    });

                                                    print('sum_dis $sum_dis');
                                                  },
                                                  cursorColor: Colors.black,
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
                                                                  5),
                                                          topLeft:
                                                              Radius.circular(
                                                                  5),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  5),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  5),
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
                                                                  5),
                                                          topLeft:
                                                              Radius.circular(
                                                                  5),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  5),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  5),
                                                        ),
                                                        borderSide: BorderSide(
                                                          // width: 1,
                                                          color: Colors.grey,
                                                        ),
                                                      ),
                                                      // labelText: 'ระบุชื่อร้านค้า',
                                                      labelStyle:
                                                          const TextStyle(
                                                              color: Colors
                                                                  .black54,
                                                              fontSize: 8,

                                                              //fontWeight: FontWeight.bold,
                                                              fontFamily: Font_
                                                                  .Fonts_T)),
                                                  inputFormatters: <TextInputFormatter>[
                                                    FilteringTextInputFormatter
                                                        .allow(
                                                            RegExp(r'[0-9 .]')),
                                                    // FilteringTextInputFormatter.digitsOnly
                                                  ],
                                                ),
                                              ),
                                              // AutoSizeText(
                                              //   minFontSize: 10,
                                              //   maxFontSize: 15,
                                              //   textAlign: TextAlign.end,
                                              //   '${nFormat.format(0.00)}',
                                              //   style: TextStyle(
                                              //       color: PeopleChaoScreen_Color
                                              //           .Colors_Text2_,
                                              //       //fontWeight: FontWeight.bold,
                                              //       fontFamily: Font_.Fonts_T),
                                              // ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                height: 50,
                                                color: AppbackgroundColor
                                                    .Sub_Abg_Colors,
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: const Text(
                                                  'ยอดชำระรวม',
                                                  textAlign: TextAlign.start,
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
                                              flex: 4,
                                              child: Container(
                                                height: 50,
                                                color: AppbackgroundColor
                                                    .Sub_Abg_Colors,
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.red[50]!
                                                        .withOpacity(0.5),
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(8),
                                                      topRight:
                                                          Radius.circular(8),
                                                      bottomLeft:
                                                          Radius.circular(8),
                                                      bottomRight:
                                                          Radius.circular(8),
                                                    ),
                                                    // border: Border.all(
                                                    //     color: Colors.grey, width: 1),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      // '${nFormat.format(sum_amt - sum_disamt)}',
                                                      '${nFormat.format(sum_amt + sum_fine + (fine_total * _TransModels.length) - double.parse(sum_disamtx.text.toString() == '' ? '0' : sum_disamtx.text.toString()))}',
                                                      textAlign: TextAlign.end,
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
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                height: 40,
                                                color: AppbackgroundColor
                                                    .Sub_Abg_Colors,
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: const Text(
                                                  'ใบเสร็จ',
                                                  textAlign: TextAlign.start,
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
                                              flex: 2,
                                              child: Container(
                                                height: 40,
                                                color: AppbackgroundColor
                                                    .Sub_Abg_Colors,
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: DropdownButtonFormField2(
                                                  alignment: Alignment.center,
                                                  focusColor: Colors.white,
                                                  autofocus: false,
                                                  decoration: InputDecoration(
                                                    enabled: true,
                                                    hoverColor: Colors.brown,
                                                    prefixIconColor:
                                                        Colors.blue,
                                                    fillColor: Colors.white
                                                        .withOpacity(0.05),
                                                    filled: false,
                                                    isDense: true,
                                                    contentPadding:
                                                        EdgeInsets.zero,
                                                    border: OutlineInputBorder(
                                                      borderSide:
                                                          const BorderSide(
                                                              color:
                                                                  Colors.red),
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
                                                  hint: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            2.0),
                                                    child: Text(
                                                      '${Default_Receipt_[Default_Receipt_type]}',
                                                      style: const TextStyle(
                                                          fontSize: 14,
                                                          color:
                                                              PeopleChaoScreen_Color
                                                                  .Colors_Text2_,
                                                          // fontWeight: FontWeight.bold,
                                                          fontFamily:
                                                              Font_.Fonts_T),
                                                    ),
                                                  ),

                                                  isExpanded: false,
                                                  // value: Default_Receipt_type == 0 ?''
                                                  // :'',
                                                  icon: const Icon(
                                                    Icons.arrow_drop_down,
                                                    color: Colors.black,
                                                  ),
                                                  style: const TextStyle(
                                                    color: Colors.grey,
                                                  ),
                                                  iconSize: 20,
                                                  buttonHeight: 40,
                                                  buttonWidth: 250,
                                                  // buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                                                  dropdownDecoration:
                                                      BoxDecoration(
                                                    // color: Colors
                                                    //     .amber,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    border: Border.all(
                                                        color: Colors.white,
                                                        width: 1),
                                                  ),
                                                  items:
                                                      Default_Receipt_.map(
                                                          (item) =>
                                                              DropdownMenuItem<
                                                                  String>(
                                                                value:
                                                                    '${item}',
                                                                child: Text(
                                                                  '${item}',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: const TextStyle(
                                                                      fontSize: 14,
                                                                      color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                      // fontWeight: FontWeight.bold,
                                                                      fontFamily: Font_.Fonts_T),
                                                                ),
                                                              )).toList(),

                                                  onChanged: (value) async {
                                                    int selectedIndex =
                                                        Default_Receipt_
                                                            .indexWhere(
                                                                (item) =>
                                                                    item ==
                                                                    value);

                                                    setState(() {
                                                      Default_Receipt_type =
                                                          selectedIndex;
                                                      TitleType_Default_Receipt =
                                                          0;
                                                    });

                                                    print(
                                                        '${selectedIndex}////$value  ////----> $Default_Receipt_type');
                                                  },
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                height: 40,
                                                color: AppbackgroundColor
                                                    .Sub_Abg_Colors,
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: const Text(
                                                  'รูปแบบบิล',
                                                  textAlign: TextAlign.start,
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
                                              flex: 2,
                                              child: Container(
                                                height: 40,
                                                color: AppbackgroundColor
                                                    .Sub_Abg_Colors,
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: DropdownButtonFormField2(
                                                  decoration: InputDecoration(
                                                    isDense: true,
                                                    contentPadding:
                                                        EdgeInsets.zero,
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                  ),
                                                  isExpanded: true,

                                                  hint: Text(
                                                    bills_name_.toString(),
                                                    maxLines: 1,
                                                    style: const TextStyle(
                                                        fontSize: 14,
                                                        color:
                                                            PeopleChaoScreen_Color
                                                                .Colors_Text2_,
                                                        //fontWeight: FontWeight.bold,
                                                        fontFamily:
                                                            Font_.Fonts_T),
                                                  ),
                                                  icon: const Icon(
                                                    Icons.arrow_drop_down,
                                                    color:
                                                        PeopleChaoScreen_Color
                                                            .Colors_Text2_,
                                                  ),
                                                  style: const TextStyle(
                                                      color: Colors.green,
                                                      fontFamily:
                                                          Font_.Fonts_T),
                                                  iconSize: 30,
                                                  buttonHeight: 40,
                                                  // buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                                                  dropdownDecoration:
                                                      BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  items: bill_tser == '1'
                                                      ? Default_.map(
                                                          (item) =>
                                                              DropdownMenuItem<
                                                                  String>(
                                                                value: item,
                                                                child: Text(
                                                                  item,
                                                                  style: const TextStyle(
                                                                      fontSize: 14,
                                                                      color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                      //fontWeight: FontWeight.bold,
                                                                      fontFamily: Font_.Fonts_T),
                                                                ),
                                                              )).toList()
                                                      : Default2_.map(
                                                          (item) =>
                                                              DropdownMenuItem<
                                                                  String>(
                                                                value: item,
                                                                child: Text(
                                                                  item,
                                                                  style: const TextStyle(
                                                                      fontSize: 14,
                                                                      color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                      //fontWeight: FontWeight.bold,
                                                                      fontFamily: Font_.Fonts_T),
                                                                ),
                                                              )).toList(),

                                                  onChanged: (value) async {
                                                    var bill_set =
                                                        value == 'บิลธรรมดา'
                                                            ? 'P'
                                                            : 'F';
                                                    setState(() {
                                                      bills_name_ = bill_set;
                                                    });
                                                    print(bills_name_);
                                                  },
                                                  // onSaved: (value) {
                                                  //   // selectedValue = value.toString();
                                                  // },
                                                ),
                                              ),
                                            ),
                                            if (Default_Receipt_[
                                                        Default_Receipt_type]
                                                    .toString() ==
                                                'ออกใบเสร็จ')
                                              Expanded(
                                                flex: 1,
                                                child: Container(
                                                  height: 40,
                                                  color: AppbackgroundColor
                                                      .Sub_Abg_Colors,
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: const Text(
                                                    'หัวบิล',
                                                    textAlign: TextAlign.start,
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
                                            if (Default_Receipt_[
                                                        Default_Receipt_type]
                                                    .toString() ==
                                                'ออกใบเสร็จ')
                                              Expanded(
                                                flex: 2,
                                                child: Container(
                                                  height: 40,
                                                  color: AppbackgroundColor
                                                      .Sub_Abg_Colors,
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child:
                                                      DropdownButtonFormField2(
                                                    alignment: Alignment.center,
                                                    focusColor: Colors.white,
                                                    autofocus: false,
                                                    decoration: InputDecoration(
                                                      enabled: true,
                                                      hoverColor: Colors.brown,
                                                      prefixIconColor:
                                                          Colors.blue,
                                                      fillColor: Colors.white
                                                          .withOpacity(0.05),
                                                      filled: false,
                                                      isDense: true,
                                                      contentPadding:
                                                          EdgeInsets.zero,
                                                      border:
                                                          OutlineInputBorder(
                                                        borderSide:
                                                            const BorderSide(
                                                                color:
                                                                    Colors.red),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      focusedBorder:
                                                          const OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                          topRight:
                                                              Radius.circular(
                                                                  10),
                                                          topLeft:
                                                              Radius.circular(
                                                                  10),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  10),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  10),
                                                        ),
                                                        borderSide: BorderSide(
                                                          width: 1,
                                                          color: Color.fromARGB(
                                                              255,
                                                              231,
                                                              227,
                                                              227),
                                                        ),
                                                      ),
                                                    ),
                                                    hint: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              2.0),
                                                      child: Text(
                                                        '${TitleType_Default_Receipt_[TitleType_Default_Receipt]}',
                                                        style: const TextStyle(
                                                            fontSize: 14,
                                                            color: PeopleChaoScreen_Color
                                                                .Colors_Text2_,
                                                            // fontWeight: FontWeight.bold,
                                                            fontFamily:
                                                                Font_.Fonts_T),
                                                      ),
                                                    ),

                                                    isExpanded: false,
                                                    // value: Default_Receipt_type == 0 ?''
                                                    // :'',
                                                    icon: const Icon(
                                                      Icons.arrow_drop_down,
                                                      color: Colors.black,
                                                    ),
                                                    style: const TextStyle(
                                                      color: Colors.grey,
                                                    ),
                                                    iconSize: 20,
                                                    buttonHeight: 40,
                                                    buttonWidth: 250,
                                                    // buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                                                    dropdownDecoration:
                                                        BoxDecoration(
                                                      // color: Colors
                                                      //     .amber,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      border: Border.all(
                                                          color: Colors.white,
                                                          width: 1),
                                                    ),
                                                    items:
                                                        TitleType_Default_Receipt_
                                                            .map((item) =>
                                                                DropdownMenuItem<
                                                                    String>(
                                                                  value:
                                                                      '${item}',
                                                                  child: Text(
                                                                    '${item}',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: const TextStyle(
                                                                        fontSize: 14,
                                                                        color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                        // fontWeight: FontWeight.bold,
                                                                        fontFamily: Font_.Fonts_T),
                                                                  ),
                                                                )).toList(),

                                                    onChanged: (value) async {
                                                      int selectedIndex =
                                                          TitleType_Default_Receipt_
                                                              .indexWhere(
                                                                  (item) =>
                                                                      item ==
                                                                      value);

                                                      setState(() {
                                                        TitleType_Default_Receipt =
                                                            selectedIndex;
                                                      });

                                                      print(
                                                          '${selectedIndex}////$value  ////----> $TitleType_Default_Receipt');
                                                    },
                                                  ),
                                                ),
                                              ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              (Responsive.isDesktop(context))
                                                  ? 'รูปแบบการชำระ'
                                                  : 'การชำระ',
                                              textAlign: TextAlign.start,
                                              style: const TextStyle(
                                                  color: PeopleChaoScreen_Color
                                                      .Colors_Text1_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T
                                                  //fontSize: 10.0
                                                  ),
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Expanded(
                                              flex: 4,
                                              child: Column(
                                                children: [
                                                  Container(
                                                    decoration:
                                                        const BoxDecoration(
                                                      color: AppbackgroundColor
                                                          .Sub_Abg_Colors,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(0),
                                                        topRight:
                                                            Radius.circular(6),
                                                        bottomLeft:
                                                            Radius.circular(0),
                                                        bottomRight:
                                                            Radius.circular(6),
                                                      ),
                                                      // border: Border.all(color: Colors.grey, width: 1),
                                                    ),
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child:
                                                        DropdownButtonFormField2(
                                                      decoration:
                                                          InputDecoration(
                                                        //Add isDense true and zero Padding.
                                                        //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                                                        isDense: true,
                                                        contentPadding:
                                                            EdgeInsets.zero,
                                                        border:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                        ),
                                                        //Add more decoration as you want here
                                                        //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                                                      ),
                                                      isExpanded: true,
                                                      // disabledHint: Icon(Icons.time_to_leave, color: Colors.black),
                                                      hint: Row(
                                                        children: [
                                                          Text(
                                                            (paymentName1 ==
                                                                    null)
                                                                ? 'เลือก'
                                                                : '$paymentName1',
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    color: PeopleChaoScreen_Color
                                                                        .Colors_Text2_,
                                                                    // fontWeight: FontWeight.bold,
                                                                    fontFamily:
                                                                        Font_
                                                                            .Fonts_T),
                                                          ),
                                                        ],
                                                      ),
                                                      icon: const Icon(
                                                        Icons.arrow_drop_down,
                                                        color: Colors.black45,
                                                      ),
                                                      iconSize: 25,
                                                      buttonHeight: 42,
                                                      buttonPadding:
                                                          const EdgeInsets.only(
                                                              left: 10,
                                                              right: 10),
                                                      dropdownDecoration:
                                                          BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                      ),
                                                      items: _PayMentModels.map(
                                                          (item) =>
                                                              DropdownMenuItem<
                                                                  String>(
                                                                onTap: () {
                                                                  bname1 = item
                                                                      .bname;
                                                                  var fine_amt = item
                                                                              .fine ==
                                                                          '1'
                                                                      ? item.fine_c ==
                                                                              '0.00'
                                                                          ? double.parse(double.parse(item.fine_a!)
                                                                              .toStringAsFixed(
                                                                                  2)
                                                                              .toString())
                                                                          : double.parse((((sum_amt - sum_disamt - dis_sum_Pakan - dis_sum_Matjum) * double.parse(item.fine_c!) - double.parse(sum_disamtx.text.toString() == '' ? '0' : sum_disamtx.text.toString())) / 100)
                                                                              .toStringAsFixed(2)
                                                                              .toString())
                                                                      : fine_total;

                                                                  setState(() {
                                                                    payment_ptSer1 = item
                                                                        .ptser
                                                                        .toString();
                                                                    fine_total = item.fine ==
                                                                            '1'
                                                                        ? fine_amt
                                                                        : 0.00;
                                                                    // sum_amt = item.fine == '1'
                                                                    //     ? sum_amt + fine_amt
                                                                    //     : sum_amt - fine_amt;
                                                                    newValuePDFimg_QR = (item.img ==
                                                                                null ||
                                                                            item.img.toString() ==
                                                                                '')
                                                                        ? '${MyConstant().domain}/Awaitdownload/imagenot.png'
                                                                        : '${MyConstant().domain}/files/$foder/payment/${item.img}';
                                                                    selectedValue =
                                                                        item.bno!;
                                                                  });
                                                                  print(
                                                                      '**/*/*   --- ${selectedValue}');
                                                                },
                                                                value:
                                                                    '${item.ser}:${item.ptname}',
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
                                                                        Expanded(
                                                                          child:
                                                                              Text(
                                                                            '${item.ptname!}',
                                                                            textAlign:
                                                                                TextAlign.start,
                                                                            overflow:
                                                                                TextOverflow.ellipsis,
                                                                            style: const TextStyle(
                                                                                fontSize: 12,
                                                                                color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                                // fontWeight: FontWeight.bold,
                                                                                fontFamily: Font_.Fonts_T),
                                                                          ),
                                                                        ),
                                                                        Expanded(
                                                                          child:
                                                                              Text(
                                                                            '${item.bno!}',
                                                                            textAlign:
                                                                                TextAlign.end,
                                                                            overflow:
                                                                                TextOverflow.ellipsis,
                                                                            style: const TextStyle(
                                                                                fontSize: 12,
                                                                                color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                                // fontWeight: FontWeight.bold,
                                                                                fontFamily: Font_.Fonts_T),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    Row(
                                                                      children: [
                                                                        Expanded(
                                                                          child:
                                                                              Text(
                                                                            (item.ptser.toString() == '2')
                                                                                ? '( แบบแนบรูป QR เอง )'
                                                                                : (item.ptser.toString() == '5')
                                                                                    ? '( ระบบ Gen PromptPay QR ให้ )'
                                                                                    : (item.ptser.toString() == '6')
                                                                                        ? '( ระบบ Gen Standard QR [ref.1 , ref.2] ให้ )'
                                                                                        : '',
                                                                            textAlign:
                                                                                TextAlign.start,
                                                                            overflow:
                                                                                TextOverflow.ellipsis,
                                                                            style: const TextStyle(
                                                                                fontSize: 9,
                                                                                color: Colors.grey,
                                                                                // fontWeight: FontWeight.bold,
                                                                                fontFamily: Font_.Fonts_T),
                                                                          ),
                                                                        ),
                                                                        Expanded(
                                                                          child:
                                                                              Text(
                                                                            item.fine.toString() == '0'
                                                                                ? ''
                                                                                : item.fine_c.toString() == '0.00'
                                                                                    ? 'ค่าธรรมเนียม ${item.fine_a} บาท'
                                                                                    : 'ค่าธรรมเนียม ${item.fine_c} %',
                                                                            textAlign:
                                                                                TextAlign.end,
                                                                            overflow:
                                                                                TextOverflow.ellipsis,
                                                                            style: const TextStyle(
                                                                                fontSize: 9,
                                                                                color: Colors.red,
                                                                                // fontWeight: FontWeight.bold,
                                                                                fontFamily: Font_.Fonts_T),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              )).toList(),
                                                      onChanged: (value) async {
                                                        print(value);
                                                        // Do something when changing the item if you want.

                                                        var zones =
                                                            value!.indexOf(':');
                                                        var rtnameSer =
                                                            value.substring(
                                                                0, zones);
                                                        var rtnameName =
                                                            value.substring(
                                                                zones + 1);
                                                        // print(
                                                        //     'mmmmm ${rtnameSer.toString()} $rtnameName');
                                                        setState(() {
                                                          // pamentpage = 0;
                                                          paymentName2 = null;

                                                          paymentSer1 =
                                                              rtnameSer
                                                                  .toString();
                                                          // Form_payment2.clear();

                                                          if (rtnameSer
                                                                  .toString() ==
                                                              '0') {
                                                            paymentName1 = null;
                                                          } else {
                                                            paymentName1 =
                                                                rtnameName
                                                                    .toString();
                                                          }
                                                          if (rtnameSer
                                                                  .toString() ==
                                                              '0') {
                                                            // Form_payment1.clear();
                                                          } else {
                                                            // Form_payment1.text = (sum_amt -
                                                            //         sum_disamt -
                                                            //         dis_sum_Pakan -
                                                            //         sum_tran_dis -
                                                            //         dis_sum_Matjum)
                                                            //     .toStringAsFixed(2)
                                                            //     .toString();
                                                          }
                                                        });
                                                        print(
                                                            'mmmmm ${rtnameSer.toString()} $rtnameName');

                                                        setState(() {
                                                          Refpay_1 = null;
                                                          Refpay_2 = null;
                                                          Refpay_3 = null;
                                                        });
                                                      },
                                                      // onSaved: (value) {

                                                      // },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            // Expanded(
                                            //   flex: 2,
                                            //   child: Column(
                                            //     children: [
                                            //       Container(
                                            //         color: Colors.green,
                                            //         child: Padding(
                                            //           padding: const EdgeInsets.all(8.0),
                                            //           child: TextButton(
                                            //             onPressed: () async {},
                                            //             child: const Text(
                                            //               "QR",
                                            //               style: TextStyle(
                                            //                 color: Colors.black,
                                            //                 fontFamily: Font_.Fonts_T,
                                            //                 fontWeight: FontWeight.bold,
                                            //               ),
                                            //             ),
                                            //           ),
                                            //         ),
                                            //       ),
                                            //       Container(
                                            //         color: Colors.green,
                                            //         child: Padding(
                                            //           padding: const EdgeInsets.all(8.0),
                                            //           child: TextButton(
                                            //             onPressed: () async {
                                            //               in_Trans_invoice_refno()
                                            //                   .then((value) {
                                            //                 setState(() {
                                            //                   for (int index = 0;
                                            //                       index <
                                            //                           _TransModels.length;
                                            //                       index++) {
                                            //                     de_Trans_item_inv(index);
                                            //                   }
                                            //                   red_Trans_select2();
                                            //                   red_InvoiceMon_bill();
                                            //                 });
                                            //               });
                                            //             },
                                            //             child: const Text(
                                            //               "ยืนยันการชำระ",
                                            //               style: TextStyle(
                                            //                 color: Colors.black,
                                            //                 fontFamily: Font_.Fonts_T,
                                            //                 fontWeight: FontWeight.bold,
                                            //               ),
                                            //             ),
                                            //           ),
                                            //         ),
                                            //       ),
                                            //     ],
                                            //   ),
                                            // )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              flex: 4,
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: Container(
                                                      height: 35,
                                                      color: AppbackgroundColor
                                                          .Sub_Abg_Colors,
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: const Center(
                                                        child: Text(
                                                          'วันที่ทำรายการ',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              color: PeopleChaoScreen_Color
                                                                  .Colors_Text1_,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontFamily:
                                                                  FontWeight_
                                                                      .Fonts_T
                                                              //fontSize: 10.0
                                                              ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Container(
                                                        height: 35,
                                                        color:
                                                            AppbackgroundColor
                                                                .Sub_Abg_Colors,
                                                        padding:
                                                            const EdgeInsets
                                                                .all(4.0),
                                                        child: Container(
                                                          height: 35,
                                                          decoration:
                                                              BoxDecoration(
                                                            // color: Colors.green,
                                                            borderRadius:
                                                                const BorderRadius
                                                                    .only(
                                                              topLeft: Radius
                                                                  .circular(15),
                                                              topRight: Radius
                                                                  .circular(15),
                                                              bottomLeft: Radius
                                                                  .circular(15),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          15),
                                                            ),
                                                            border: Border.all(
                                                                color:
                                                                    Colors.grey,
                                                                width: 1),
                                                          ),
                                                          child: InkWell(
                                                            onTap: () async {
                                                              DateTime?
                                                                  newDate =
                                                                  await showDatePicker(
                                                                locale:
                                                                    const Locale(
                                                                        'th',
                                                                        'TH'),
                                                                context:
                                                                    context,
                                                                initialDate:
                                                                    DateTime
                                                                        .now(),
                                                                firstDate: DateTime
                                                                        .now()
                                                                    .add(const Duration(
                                                                        days:
                                                                            -50)),
                                                                lastDate: DateTime
                                                                        .now()
                                                                    .add(const Duration(
                                                                        days:
                                                                            365)),
                                                                builder:
                                                                    (context,
                                                                        child) {
                                                                  return Theme(
                                                                    data: Theme.of(
                                                                            context)
                                                                        .copyWith(
                                                                      colorScheme:
                                                                          const ColorScheme
                                                                              .light(
                                                                        primary:
                                                                            AppBarColors.ABar_Colors, // header background color
                                                                        onPrimary:
                                                                            Colors.white, // header text color
                                                                        onSurface:
                                                                            Colors.black, // body text color
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
                                                                    child:
                                                                        child!,
                                                                  );
                                                                },
                                                              );

                                                              if (newDate ==
                                                                  null) {
                                                                return;
                                                              } else {
                                                                String start =
                                                                    DateFormat(
                                                                            'yyyy-MM-dd')
                                                                        .format(
                                                                            newDate);
                                                                String end = DateFormat(
                                                                        'dd-MM-yyyy')
                                                                    .format(
                                                                        newDate);

                                                                print(
                                                                    '$start $end');
                                                                setState(() {
                                                                  Value_newDateY1 =
                                                                      start;
                                                                  Value_newDateD1 =
                                                                      end;
                                                                });
                                                              }
                                                              setState(() {
                                                                Refpay_1 = null;
                                                                Refpay_2 = null;
                                                                Refpay_3 = null;
                                                              });
                                                            },
                                                            child: AutoSizeText(
                                                              Value_newDateD1 ==
                                                                      ''
                                                                  ? 'เลือกวันที่'
                                                                  : '$Value_newDateD1',
                                                              minFontSize: 8,
                                                              maxFontSize: 16,
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
                                                                              .Fonts_T),
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          ),
                                                        )),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            (payment_ptSer1.toString() == '7' ||
                                                    paymentName1
                                                            .toString()
                                                            .trim() ==
                                                        'Beam Checkout')
                                                ? SizedBox()
                                                : Expanded(
                                                    flex: 4,
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                          child: Container(
                                                            height: 35,
                                                            color: AppbackgroundColor
                                                                .Sub_Abg_Colors,
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: const Center(
                                                              child: Text(
                                                                'วันที่ชำระ',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: TextStyle(
                                                                    color: PeopleChaoScreen_Color
                                                                        .Colors_Text1_,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontFamily:
                                                                        FontWeight_
                                                                            .Fonts_T
                                                                    //fontSize: 10.0
                                                                    ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Container(
                                                              height: 35,
                                                              color: AppbackgroundColor
                                                                  .Sub_Abg_Colors,
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(4.0),
                                                              child: Container(
                                                                height: 50,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  // color: Colors.green,
                                                                  borderRadius:
                                                                      const BorderRadius
                                                                          .only(
                                                                    topLeft: Radius
                                                                        .circular(
                                                                            15),
                                                                    topRight: Radius
                                                                        .circular(
                                                                            15),
                                                                    bottomLeft:
                                                                        Radius.circular(
                                                                            15),
                                                                    bottomRight:
                                                                        Radius.circular(
                                                                            15),
                                                                  ),
                                                                  border: Border.all(
                                                                      color: Colors
                                                                          .grey,
                                                                      width: 1),
                                                                ),
                                                                child: InkWell(
                                                                  onTap:
                                                                      () async {
                                                                    DateTime?
                                                                        newDate =
                                                                        await showDatePicker(
                                                                      locale: const Locale(
                                                                          'th',
                                                                          'TH'),
                                                                      context:
                                                                          context,
                                                                      initialDate:
                                                                          DateTime
                                                                              .now(),
                                                                      firstDate: DateTime
                                                                              .now()
                                                                          .add(const Duration(
                                                                              days: -50)),
                                                                      lastDate: DateTime
                                                                              .now()
                                                                          .add(const Duration(
                                                                              days: 365)),
                                                                      builder:
                                                                          (context,
                                                                              child) {
                                                                        return Theme(
                                                                          data:
                                                                              Theme.of(context).copyWith(
                                                                            colorScheme:
                                                                                const ColorScheme.light(
                                                                              primary: AppBarColors.ABar_Colors, // header background color
                                                                              onPrimary: Colors.white, // header text color
                                                                              onSurface: Colors.black, // body text color
                                                                            ),
                                                                            textButtonTheme:
                                                                                TextButtonThemeData(
                                                                              style: TextButton.styleFrom(
                                                                                primary: Colors.black, // button text color
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          child:
                                                                              child!,
                                                                        );
                                                                      },
                                                                    );

                                                                    if (newDate ==
                                                                        null) {
                                                                      return;
                                                                    } else {
                                                                      String
                                                                          start =
                                                                          DateFormat('yyyy-MM-dd')
                                                                              .format(newDate);
                                                                      String
                                                                          end =
                                                                          DateFormat('dd-MM-yyyy')
                                                                              .format(newDate);

                                                                      print(
                                                                          '$start $end');
                                                                      setState(
                                                                          () {
                                                                        Value_newDateY =
                                                                            start;
                                                                        Value_newDateD =
                                                                            end;
                                                                      });
                                                                    }
                                                                    setState(
                                                                        () {
                                                                      Refpay_1 =
                                                                          null;
                                                                      Refpay_2 =
                                                                          null;
                                                                      Refpay_3 =
                                                                          null;
                                                                    });
                                                                  },
                                                                  child:
                                                                      AutoSizeText(
                                                                    Value_newDateD ==
                                                                            ''
                                                                        ? 'เลือกวันที่'
                                                                        : '$Value_newDateD',
                                                                    minFontSize:
                                                                        8,
                                                                    maxFontSize:
                                                                        14,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: const TextStyle(
                                                                        color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                        // fontWeight: FontWeight.bold,
                                                                        fontFamily: Font_.Fonts_T),
                                                                    maxLines: 1,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                  ),
                                                                ),
                                                              )),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                          ],
                                        ),

                                        if (paymentName1.toString().trim() == 'เงินโอน' ||
                                            paymentName2.toString().trim() ==
                                                'เงินโอน' ||
                                            paymentName1.toString().trim() ==
                                                'Online Payment' ||
                                            paymentName2.toString().trim() ==
                                                'Online Payment' ||
                                            paymentName1.toString().trim() ==
                                                'Online Standard QR' ||
                                            paymentName2.toString().trim() ==
                                                'Online Standard QR')
                                          Column(
                                            children: [
                                              Container(
                                                // height: 70,
                                                decoration: BoxDecoration(
                                                  color: AppbackgroundColor
                                                      .Sub_Abg_Colors,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft: Radius.circular(0),
                                                    topRight:
                                                        Radius.circular(0),
                                                    bottomLeft:
                                                        Radius.circular(6),
                                                    bottomRight:
                                                        Radius.circular(6),
                                                  ),
                                                  // border: Border.all(
                                                  //     color: Colors.grey, width: 1),
                                                ),
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: (Refpay_1 == null &&
                                                        Refpay_2 == null)
                                                    ? null
                                                    : Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Divider(),
                                                          Row(
                                                            children: [
                                                              Expanded(
                                                                flex: 1,
                                                                child: Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  child: Text(
                                                                    'อ้างอิง 1 : $Refpay_1',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        color: Colors
                                                                            .grey,
                                                                        fontFamily:
                                                                            Font_.Fonts_T),
                                                                  ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                flex: 1,
                                                                child: Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  child: Text(
                                                                    'อ้างอิง 2 : ${Refpay_2}',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        color: Colors
                                                                            .grey,
                                                                        fontFamily:
                                                                            Font_.Fonts_T),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Divider(),
                                                        ],
                                                      ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    flex: 1,
                                                    child: Container(
                                                      height: 40,
                                                      color: AppbackgroundColor
                                                          .Sub_Abg_Colors,
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: const Center(
                                                        child: Text(
                                                          ' เวลา/หลักฐาน',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              color: PeopleChaoScreen_Color
                                                                  .Colors_Text1_,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontFamily:
                                                                  FontWeight_
                                                                      .Fonts_T
                                                              //fontSize: 10.0
                                                              ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 4,
                                                    child: Container(
                                                      width: 100,
                                                      height: 40,
                                                      color: AppbackgroundColor
                                                          .Sub_Abg_Colors,
                                                      child: Center(
                                                        child: Row(
                                                          children: [
                                                            Expanded(
                                                              child: Container(
                                                                height: 40,
                                                                decoration:
                                                                    const BoxDecoration(
                                                                  color: AppbackgroundColor
                                                                      .Sub_Abg_Colors,
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
                                                                        4.0),
                                                                child:
                                                                    TextFormField(
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .number,
                                                                  controller:
                                                                      Form_time,

                                                                  onChanged:
                                                                      (value) {},
                                                                  onFieldSubmitted:
                                                                      (value) {},
                                                                  // maxLength: 13,
                                                                  cursorColor:
                                                                      Colors
                                                                          .green,
                                                                  decoration: InputDecoration(
                                                                      labelText: '00:00:00',
                                                                      fillColor: Colors.white.withOpacity(0.3),
                                                                      filled: true,
                                                                      // prefixIcon:
                                                                      //     const Icon(Icons.person, color: Colors.black),
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
                                                                      // labelText: 'ระบุอายุสัญญา',
                                                                      labelStyle: const TextStyle(
                                                                          color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                          // fontWeight: FontWeight.bold,
                                                                          fontFamily: Font_.Fonts_T)),
                                                                  inputFormatters: [
                                                                    MaskedInputFormatter(
                                                                        '##:##:##'),
                                                                    // FilteringTextInputFormatter.allow(
                                                                    //     RegExp(r'[0-9]')),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 100,
                                                    child: InkWell(
                                                      onTap: () {
                                                        (base64_Slip == null)
                                                            ? uploadFile_Slip()
                                                            : showDialog<void>(
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
                                                                      'มีไฟล์ slip อยู่แล้ว',
                                                                      style: TextStyle(
                                                                          color: PeopleChaoScreen_Color
                                                                              .Colors_Text1_,
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontFamily:
                                                                              FontWeight_.Fonts_T),
                                                                    )),
                                                                    content:
                                                                        SingleChildScrollView(
                                                                      child:
                                                                          ListBody(
                                                                        children: const <Widget>[
                                                                          Text(
                                                                            'มีไฟล์ slip อยู่แล้ว หากต้องการอัพโหลดกรุณาลบไฟล์ที่มีอยู่แล้วก่อน',
                                                                            style:
                                                                                TextStyle(color: PeopleChaoScreen_Color.Colors_Text2_, fontFamily: Font_.Fonts_T),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    actions: <Widget>[
                                                                      Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
                                                                            child:
                                                                                InkWell(
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
                                                                                    'ลบไฟล์',
                                                                                    style: TextStyle(color: PeopleChaoScreen_Color.Colors_Text3_, fontWeight: FontWeight.bold, fontFamily: Font_.Fonts_T),
                                                                                  ))),
                                                                              onTap: () async {
                                                                                setState(() {
                                                                                  base64_Slip = null;
                                                                                });
                                                                                Navigator.of(context).pop();
                                                                              },
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
                                                                            child:
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
                                                                              onTap: () {
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
                                                      child: Container(
                                                        decoration:
                                                            const BoxDecoration(
                                                          color: Colors.green,
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
                                                                    10),
                                                          ),
                                                          // border: Border.all(
                                                          //     color: Colors.grey, width: 1),
                                                        ),
                                                        padding:
                                                            const EdgeInsets
                                                                .all(4.0),
                                                        child: const Text(
                                                          'เพิ่มไฟล์',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              color: PeopleChaoScreen_Color
                                                                  .Colors_Text1_,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontFamily:
                                                                  FontWeight_
                                                                      .Fonts_T
                                                              //fontSize: 10.0
                                                              ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ), //Online Payment
                                        if (paymentName1.toString().trim() == 'เงินโอน' ||
                                            paymentName2.toString().trim() ==
                                                'เงินโอน' ||
                                            paymentName1.toString().trim() ==
                                                'Online Payment' ||
                                            paymentName2.toString().trim() ==
                                                'Online Payment' ||
                                            paymentName1.toString().trim() ==
                                                'Online Standard QR' ||
                                            paymentName2.toString().trim() ==
                                                'Online Standard QR')
                                          Container(
                                            decoration: const BoxDecoration(
                                              color: AppbackgroundColor
                                                  .Sub_Abg_Colors,
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(0),
                                                topRight: Radius.circular(0),
                                                bottomLeft: Radius.circular(0),
                                                bottomRight: Radius.circular(0),
                                              ),
                                              // border: Border.all(color: Colors.grey, width: 1),
                                            ),
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(2.0),
                                                          child: Text(
                                                            (base64_Slip !=
                                                                    null)
                                                                ? 'สถานะหลักฐาน : เลือกไฟล์แล้ว '
                                                                : 'สถานะหลักฐาน : ยังไม่ได้เลือกไฟล์',
                                                            textAlign:
                                                                TextAlign.start,
                                                            style: TextStyle(
                                                                color: (base64_Slip !=
                                                                        null)
                                                                    ? Colors.green[
                                                                        600]
                                                                    : Colors.red[
                                                                        600],
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily:
                                                                    FontWeight_
                                                                        .Fonts_T
                                                                //fontSize: 10.0
                                                                ),
                                                          ),
                                                        ),
                                                        // Padding(
                                                        //   padding: const EdgeInsets.all(2.0),
                                                        //   child: Text(
                                                        //     (base64_Slip != null) ? '$base64_Slip' : '',
                                                        //     textAlign: TextAlign.start,
                                                        //     style: TextStyle(
                                                        //         color: Colors.blue[600],
                                                        //         fontWeight: FontWeight.bold,
                                                        //         fontFamily: FontWeight_.Fonts_T,
                                                        //         fontSize: 10.0),
                                                        //   ),
                                                        // ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: InkWell(
                                                    onTap: () async {
                                                      // String Url =
                                                      //     await '${MyConstant().domain}/files/kad_taii/slip/$name_slip';
                                                      // print(Url);
                                                      showDialog(
                                                        context: context,
                                                        builder: (context) => AlertDialog(
                                                            // title: Center(
                                                            //   child: Text(
                                                            //     '${widget.Get_Value_cid}',
                                                            //     maxLines: 1,
                                                            //     textAlign:
                                                            //         TextAlign.start,
                                                            //     style: const TextStyle(
                                                            //         color: Colors
                                                            //             .black,
                                                            //         fontWeight:
                                                            //             FontWeight
                                                            //                 .bold,
                                                            //         fontFamily:
                                                            //             FontWeight_
                                                            //                 .Fonts_T,
                                                            //         fontSize: 12.0),
                                                            //   ),
                                                            // ),
                                                            content: Stack(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              children: <Widget>[
                                                                Image.memory(
                                                                  base64Decode(
                                                                      base64_Slip
                                                                          .toString()),
                                                                  // height: 200,
                                                                  // fit: BoxFit.cover,
                                                                ),
                                                              ],
                                                            ),
                                                            actions: <Widget>[
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  // Padding(
                                                                  //   padding:
                                                                  //       const EdgeInsets.all(8.0),
                                                                  //   child: Container(
                                                                  //     width: 100,
                                                                  //     decoration: const BoxDecoration(
                                                                  //       color: Colors.green,
                                                                  //       borderRadius:
                                                                  //           BorderRadius.only(
                                                                  //               topLeft: Radius
                                                                  //                   .circular(10),
                                                                  //               topRight:
                                                                  //                   Radius.circular(
                                                                  //                       10),
                                                                  //               bottomLeft:
                                                                  //                   Radius.circular(
                                                                  //                       10),
                                                                  //               bottomRight:
                                                                  //                   Radius.circular(
                                                                  //                       10)),
                                                                  //     ),
                                                                  //     padding:
                                                                  //         const EdgeInsets.all(8.0),
                                                                  //     child: TextButton(
                                                                  //       onPressed: () async {
                                                                  //         // downloadImage2();
                                                                  //         // downloadImage(Url);
                                                                  //         // Navigator.pop(
                                                                  //         //     context, 'OK');
                                                                  //       },
                                                                  //       child: const Text(
                                                                  //         'ดาวน์โหลด',
                                                                  //         style: TextStyle(
                                                                  //             color: Colors.white,
                                                                  //             fontWeight:
                                                                  //                 FontWeight.bold,
                                                                  //             fontFamily: FontWeight_
                                                                  //                 .Fonts_T),
                                                                  //       ),
                                                                  //     ),
                                                                  //   ),
                                                                  // ),
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            8.0),
                                                                    child:
                                                                        Container(
                                                                      width:
                                                                          100,
                                                                      decoration:
                                                                          const BoxDecoration(
                                                                        color: Colors
                                                                            .black,
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
                                                                          TextButton(
                                                                        onPressed: () => Navigator.pop(
                                                                            context,
                                                                            'OK'),
                                                                        child:
                                                                            const Text(
                                                                          'ปิด',
                                                                          style: TextStyle(
                                                                              color: Colors.white,
                                                                              fontWeight: FontWeight.bold,
                                                                              fontFamily: FontWeight_.Fonts_T),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ]),
                                                      );
                                                    },
                                                    child: Container(
                                                      decoration:
                                                          const BoxDecoration(
                                                        color: Colors.blueGrey,
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
                                                                  10),
                                                        ),
                                                        // border: Border.all(
                                                        //     color: Colors.grey, width: 1),
                                                      ),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              4.0),
                                                      child: const Text(
                                                        'เรียกดูไฟล์',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontFamily:
                                                                FontWeight_
                                                                    .Fonts_T
                                                            //fontSize: 10.0
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
                                  (payment_ptSer1.toString() == '7' ||
                                          paymentName1.toString().trim() ==
                                              'Beam Checkout')
                                      ? Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color:
                                                  Colors.white.withOpacity(0.3),
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topLeft: Radius.circular(15),
                                                topRight: Radius.circular(15),
                                                bottomLeft: Radius.circular(15),
                                                bottomRight:
                                                    Radius.circular(15),
                                              ),
                                              border: Border.all(
                                                  color: Colors.grey, width: 1),
                                            ),
                                            padding: const EdgeInsets.all(2.0),
                                            child: InkWell(
                                              onTap: (_TransModels.length == 0)
                                                  ? null
                                                  : () async {
                                                      double totalQr_ = 0.00;
                                                      setState(() {
                                                        totalQr_ = sum_amt +
                                                            sum_fine +
                                                            (fine_total *
                                                                _TransModels
                                                                    .length) -
                                                            double.parse(sum_disamtx
                                                                        .text
                                                                        .toString() ==
                                                                    ''
                                                                ? '0'
                                                                : sum_disamtx
                                                                    .text
                                                                    .toString());
                                                      });
                                                      if (totalQr_ != 0.00) {
                                                        in_Trans_invoice_refno()
                                                            .then((value) {
                                                          setState(() {
                                                            for (int index = 0;
                                                                index <
                                                                    _TransModels
                                                                        .length;
                                                                index++) {
                                                              de_Trans_item_inv(
                                                                  index);
                                                            }
                                                            red_Trans_select2();
                                                            red_InvoiceMon_bill();
                                                          });
                                                        });
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
                                                                            Radius.circular(20.0))),
                                                                // title: const Text('AlertDialog Title'),
                                                                content:
                                                                    SingleChildScrollView(
                                                                  child:
                                                                      ListBody(
                                                                    children: <Widget>[
                                                                      Center(
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(4.0),
                                                                          child:
                                                                              Text(
                                                                            'รายการชำระทั้งหมด ${_TransModels.length} รายการ',
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style: TextStyle(
                                                                                color: PeopleChaoScreen_Color.Colors_Text1_,
                                                                                fontWeight: FontWeight.w600,
                                                                                fontFamily: Font_.Fonts_T,
                                                                                fontSize: 14.0),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Center(
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(4.0),
                                                                          child:
                                                                              Text(
                                                                            '# จำนวนเงินชำระทั้งหมด เท่ากับ ${totalQr_} บาท ',
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style: TextStyle(
                                                                                color: Colors.red,
                                                                                fontWeight: FontWeight.bold,
                                                                                fontFamily: FontWeight_.Fonts_T,
                                                                                fontSize: 14.0),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Center(
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(4.0),
                                                                          child:
                                                                              Text(
                                                                            '( กรุณาตรวจสอบความถูกต้อง )',
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style: TextStyle(
                                                                                color: PeopleChaoScreen_Color.Colors_Text1_,
                                                                                // fontWeight: FontWeight.bold,
                                                                                fontSize: 14.0),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      if (_TransModels
                                                                              .length !=
                                                                          0)
                                                                        Center(
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(4.0),
                                                                            child:
                                                                                Text(
                                                                              '# ยืนยันการทำรายการชำระต่อ ใช่หรือไม่.. ? ',
                                                                              textAlign: TextAlign.center,
                                                                              style: TextStyle(
                                                                                  color: Colors.red,
                                                                                  // fontWeight: FontWeight.bold,
                                                                                  fontFamily: Font_.Fonts_T,
                                                                                  fontSize: 14.0),
                                                                            ),
                                                                          ),
                                                                        ),
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
                                                                        color: Colors
                                                                            .grey,
                                                                        height:
                                                                            4.0,
                                                                      ),
                                                                      const SizedBox(
                                                                        height:
                                                                            5.0,
                                                                      ),
                                                                      Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          if (_TransModels.length !=
                                                                              0)
                                                                            Container(
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.all(8.0),
                                                                                child: InkWell(
                                                                                  child: Container(
                                                                                      width: 100,
                                                                                      decoration: const BoxDecoration(
                                                                                        color: Colors.green,
                                                                                        borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                                                                                        // border: Border.all(color: Colors.white, width: 1),
                                                                                      ),
                                                                                      padding: const EdgeInsets.all(8.0),
                                                                                      child: const Center(
                                                                                          child: Text(
                                                                                        'ยืนยัน',
                                                                                        textAlign: TextAlign.center,
                                                                                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontFamily: FontWeight_.Fonts_T
                                                                                            //fontSize: 10.0
                                                                                            ),
                                                                                      ))),
                                                                                  onTap: () async {
                                                                                    Navigator.of(context).pop();
                                                                                    in_Trans_invoice_refno().then((value) {
                                                                                      setState(() {
                                                                                        for (int index = 0; index < _TransModels.length; index++) {
                                                                                          de_Trans_item_inv(index);
                                                                                        }
                                                                                        red_Trans_select2();
                                                                                        red_InvoiceMon_bill();
                                                                                      });
                                                                                    });
                                                                                  },
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          Container(
                                                                            child:
                                                                                Padding(
                                                                              padding: const EdgeInsets.all(8.0),
                                                                              child: InkWell(
                                                                                child: Container(
                                                                                    width: 100,
                                                                                    decoration: const BoxDecoration(
                                                                                      color: Colors.red,
                                                                                      borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                                                                                      // border: Border.all(color: Colors.white, width: 1),
                                                                                    ),
                                                                                    padding: const EdgeInsets.all(8.0),
                                                                                    child: const Center(
                                                                                        child: Text(
                                                                                      'ยกเลิก',
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
                                                                  ),
                                                                ],
                                                              );
                                                            });
                                                      }
                                                    },
                                              child: Container(
                                                width: 800,
                                                height: 40,
                                                decoration: BoxDecoration(
                                                  color: Colors.indigo[400],
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topLeft: const Radius
                                                              .circular(10),
                                                          topRight: Radius
                                                              .circular(10),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  10),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  10)),
                                                  // border: Border.all(color: Colors.white, width: 1),
                                                ),
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .fromLTRB(8, 0, 8, 0),
                                                      child: CircleAvatar(
                                                        radius: 16.0,
                                                        backgroundImage: AssetImage(
                                                            'images/LogoBank/BEAM.png'),
                                                        backgroundColor:
                                                            Colors.transparent,
                                                      ),
                                                    ),
                                                    // Icon(
                                                    //   Icons.qr_code,
                                                    //   color: Colors.white,
                                                    // ),
                                                    Center(
                                                        child: Text(
                                                      'Beam Checkout',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily:
                                                              FontWeight_
                                                                  .Fonts_T),
                                                    )),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ))
                                      : Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color:
                                                  Colors.white.withOpacity(0.3),
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topLeft: Radius.circular(15),
                                                topRight: Radius.circular(15),
                                                bottomLeft: Radius.circular(15),
                                                bottomRight:
                                                    Radius.circular(15),
                                              ),
                                              border: Border.all(
                                                  color: Colors.grey, width: 1),
                                            ),
                                            padding: const EdgeInsets.all(2.0),
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  if (_TransModels.length != 0)
                                                    (paymentName1
                                                                    .toString()
                                                                    .trim() ==
                                                                'Online Payment' ||
                                                            paymentName1
                                                                    .toString()
                                                                    .trim() ==
                                                                'เงินโอน')
                                                        ? Container(
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
                                                                        6),
                                                                bottomRight:
                                                                    Radius
                                                                        .circular(
                                                                            6),
                                                              ),
                                                              // border: Border.all(color: Colors.grey, width: 1),
                                                            ),
                                                            // padding: const EdgeInsets.all(4.0),
                                                            child: Stack(
                                                              children: [
                                                                InkWell(
                                                                  child: Container(
                                                                      // width: 200,
                                                                      height: 50,
                                                                      decoration: BoxDecoration(
                                                                        color: Colors
                                                                            .blue[900],
                                                                        borderRadius: const BorderRadius.only(
                                                                            topLeft:
                                                                                Radius.circular(8),
                                                                            topRight: Radius.circular(8),
                                                                            bottomLeft: Radius.circular(8),
                                                                            bottomRight: Radius.circular(8)),
                                                                        // border: Border.all(color: Colors.white, width: 1),
                                                                      ),
                                                                      padding: const EdgeInsets.all(8.0),
                                                                      child: (paymentName1.toString().trim() == 'เงินโอน' || paymentName2.toString().trim() == 'เงินโอน')
                                                                          ? const Center(
                                                                              child: Text(
                                                                              'QR ที่แนบไว้',
                                                                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontFamily: FontWeight_.Fonts_T),
                                                                            ))
                                                                          : Row(
                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                              children: [
                                                                                Container(
                                                                                    height: 40,
                                                                                    width: 100,
                                                                                    child: Image.asset(
                                                                                      'images/prompay.png',
                                                                                      height: 40,
                                                                                      width: 100,
                                                                                      fit: BoxFit.cover,
                                                                                    )),
                                                                                const Center(
                                                                                    child: Text(
                                                                                  'Generator QR Code PromtPay',
                                                                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontFamily: FontWeight_.Fonts_T),
                                                                                )),
                                                                              ],
                                                                            )),
                                                                  onTap: () {
                                                                    double
                                                                        totalQr_ =
                                                                        0.00;
                                                                    setState(
                                                                        () {
                                                                      totalQr_ = sum_amt +
                                                                          sum_fine +
                                                                          (fine_total *
                                                                              _TransModels
                                                                                  .length) -
                                                                          double.parse(sum_disamtx.text.toString() == ''
                                                                              ? '0'
                                                                              : sum_disamtx.text.toString());
                                                                    });

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
                                                                          insetPadding:
                                                                              const EdgeInsets.all(5),
                                                                          shape:
                                                                              const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
                                                                          // title: Row(
                                                                          //   mainAxisAlignment:
                                                                          //       MainAxisAlignment.end,
                                                                          //   children: [
                                                                          //     Icon(
                                                                          //       Icons.cancel,
                                                                          //       color: Colors.red,
                                                                          //       size: 30,
                                                                          //     )
                                                                          //   ],
                                                                          // ),
                                                                          content: StreamBuilder(
                                                                              stream: Stream.periodic(const Duration(seconds: 0)),
                                                                              builder: (context, snapshot) {
                                                                                return SingleChildScrollView(
                                                                                  child: ListBody(
                                                                                    children: <Widget>[
                                                                                      SizedBox(
                                                                                        height: 20,
                                                                                        child: Row(
                                                                                          mainAxisAlignment: MainAxisAlignment.end,
                                                                                          children: [
                                                                                            InkWell(
                                                                                              onTap: () {
                                                                                                Navigator.pop(context, 'OK');
                                                                                              },
                                                                                              child: const Icon(
                                                                                                Icons.cancel,
                                                                                                color: Colors.red,
                                                                                                size: 22,
                                                                                              ),
                                                                                            )
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                      (paymentName1.toString().trim() == 'เงินโอน' || paymentName2.toString().trim() == 'เงินโอน')
                                                                                          ? Padding(
                                                                                              padding: const EdgeInsets.all(8.0),
                                                                                              child: Container(
                                                                                                child: Column(
                                                                                                  children: [
                                                                                                    const Text(
                                                                                                      'รูปแบบ : โอนตามเลขบัญชี หรือรูปที่แนบไว้',
                                                                                                      style: TextStyle(
                                                                                                        fontSize: 16,
                                                                                                        fontWeight: FontWeight.bold,
                                                                                                      ),
                                                                                                    ),
                                                                                                    Padding(
                                                                                                      padding: const EdgeInsets.all(8.0),
                                                                                                      child: Container(
                                                                                                          color: Colors.grey,
                                                                                                          width: 200,
                                                                                                          height: 200,
                                                                                                          child: (newValuePDFimg_QR == null || newValuePDFimg_QR.toString() == '')
                                                                                                              ? const Icon(
                                                                                                                  Icons.image_not_supported,
                                                                                                                  color: Colors.white,
                                                                                                                  // size: 22,
                                                                                                                )
                                                                                                              : Image.network('$newValuePDFimg_QR')),
                                                                                                    ),
                                                                                                    Text(
                                                                                                      'บัญชี : $selectedValue',
                                                                                                      style: const TextStyle(
                                                                                                        fontSize: 13,
                                                                                                        fontWeight: FontWeight.bold,
                                                                                                      ),
                                                                                                    ),
                                                                                                    Text(
                                                                                                      'จำนวนเงิน : ${nFormat.format(totalQr_)} บาท',
                                                                                                      style: const TextStyle(
                                                                                                        fontSize: 13,
                                                                                                        fontWeight: FontWeight.bold,
                                                                                                      ),
                                                                                                    ),
                                                                                                  ],
                                                                                                ),
                                                                                              ),
                                                                                            )
                                                                                          : Container(
                                                                                              // height: 600,
                                                                                              width: 320,
                                                                                              child: WebViewX2Page(id_ser: (paymentName1.toString().trim() == 'Online Payment') ? '$selectedValue' : 'ไม่พบเลขบัญชี', amt_ser: (paymentName1.toString().trim() == 'Online Payment') ? '${totalQr_}' : '0.00', name_ser: (paymentName1.toString().trim() == 'Online Payment') ? '$bname1' : 'ไม่พบชื่อบัญชี'),
                                                                                            ),
                                                                                    ],
                                                                                  ),
                                                                                );
                                                                              }),
                                                                        );
                                                                      },
                                                                    );
                                                                  },
                                                                ),
                                                              ],
                                                            ),
                                                          )
                                                        : const SizedBox(),
                                                  if (paymentName1
                                                              .toString()
                                                              .trim() ==
                                                          'Online Standard QR' ||
                                                      paymentName2
                                                              .toString()
                                                              .trim() ==
                                                          'Online Standard QR')
                                                    Container(
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
                                                                  6),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  6),
                                                        ),
                                                        // border: Border.all(color: Colors.grey, width: 1),
                                                      ),
                                                      child: (Refpay_1 !=
                                                                  null &&
                                                              Refpay_2 != null)
                                                          ? InkWell(
                                                              child: Container(
                                                                  width: 280,
                                                                  height: 50,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Colors
                                                                            .deepPurple[
                                                                        400],
                                                                    borderRadius: BorderRadius.only(
                                                                        topLeft:
                                                                            const Radius.circular(
                                                                                10),
                                                                        topRight:
                                                                            Radius.circular(
                                                                                10),
                                                                        bottomLeft:
                                                                            Radius.circular(
                                                                                10),
                                                                        bottomRight:
                                                                            Radius.circular(10)),
                                                                    // border: Border.all(color: Colors.white, width: 1),
                                                                  ),
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Icon(
                                                                        Icons
                                                                            .qr_code,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                      Center(
                                                                          child:
                                                                              Text(
                                                                        'Generator  QR ( อีกใหม่อีกครั้ง )',
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                14,
                                                                            color:
                                                                                Colors.white,
                                                                            fontWeight: FontWeight.bold,
                                                                            fontFamily: FontWeight_.Fonts_T),
                                                                      )),
                                                                    ],
                                                                  )),
                                                              onTap: () async {
                                                                showDialog<
                                                                    String>(
                                                                  context:
                                                                      context,
                                                                  builder: (BuildContext
                                                                          context) =>
                                                                      AlertDialog(
                                                                    shape: const RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.all(Radius.circular(20.0))),
                                                                    title: const Center(
                                                                        child: Text(
                                                                      'ยืนยัน Generator QR อีกใหม่อีกครั้ง ?',
                                                                      style: TextStyle(
                                                                          color: AdminScafScreen_Color
                                                                              .Colors_Text1_,
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontFamily:
                                                                              FontWeight_.Fonts_T),
                                                                    )),
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
                                                                          Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
                                                                            child:
                                                                                Row(
                                                                              mainAxisAlignment: MainAxisAlignment.center,
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
                                                                                        Navigator.pop(context, 'OK');
                                                                                        Gen_QRStandard_ref();
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
                                                              })
                                                          : InkWell(
                                                              child: Container(
                                                                  width: 280,
                                                                  height: 50,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Colors
                                                                            .deepPurple[
                                                                        400],
                                                                    borderRadius: BorderRadius.only(
                                                                        topLeft:
                                                                            const Radius.circular(
                                                                                10),
                                                                        topRight:
                                                                            Radius.circular(
                                                                                10),
                                                                        bottomLeft:
                                                                            Radius.circular(
                                                                                10),
                                                                        bottomRight:
                                                                            Radius.circular(10)),
                                                                    // border: Border.all(color: Colors.white, width: 1),
                                                                  ),
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Icon(
                                                                        Icons
                                                                            .qr_code,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                      Center(
                                                                          child:
                                                                              Text(
                                                                        'Generator Online Standard QR ',
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.white,
                                                                            fontWeight: FontWeight.bold,
                                                                            fontFamily: FontWeight_.Fonts_T),
                                                                      )),
                                                                    ],
                                                                  )),
                                                              onTap: () async {
                                                                Gen_QRStandard_ref();
                                                              }),
                                                    ),
                                                  Expanded(child: SizedBox()),

                                                  ((paymentName1
                                                                      .toString()
                                                                      .trim() ==
                                                                  'Online Standard QR' ||
                                                              paymentName2
                                                                      .toString()
                                                                      .trim() ==
                                                                  'Online Standard QR') &&
                                                          (Refpay_1 == null ||
                                                              Refpay_2 == null))
                                                      ? Container(
                                                          width: 280,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: AppbackgroundColor
                                                                    .Sub_Abg_Colors
                                                                .withOpacity(
                                                                    0.5),
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
                                                                          6),
                                                            ),
                                                            // border: Border.all(color: Colors.grey, width: 1),
                                                          ),
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Text(
                                                            'กรุณา Gen Online Standard QR  !!',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .red[600],
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily:
                                                                    FontWeight_
                                                                        .Fonts_T
                                                                //fontSize: 10.0
                                                                ),
                                                          ),
                                                        )
                                                      : Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(2.0),
                                                          child: Container(
                                                            width: 280,
                                                            child:
                                                                OtpTimerButton(
                                                              height: 50,
                                                              text: Text(
                                                                (_TransModels
                                                                            .length ==
                                                                        0)
                                                                    ? 'กรุณาเลือกรายการชำระ'
                                                                    : 'ยืนยันรับชำระ ',
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
                                                              duration: 3,
                                                              radius: 8,
                                                              backgroundColor: (_TransModels
                                                                          .length ==
                                                                      0)
                                                                  ? Colors
                                                                      .grey[300]
                                                                  : Colors.orange[
                                                                      400],
                                                              textColor:
                                                                  Colors.black,
                                                              buttonType: ButtonType
                                                                  .elevated_button,
                                                              loadingIndicator:
                                                                  const CircularProgressIndicator(
                                                                strokeWidth: 2,
                                                                color:
                                                                    Colors.red,
                                                              ),
                                                              loadingIndicatorColor:
                                                                  Colors.red,
                                                              onPressed:
                                                                  (_TransModels
                                                                              .length ==
                                                                          0)
                                                                      ? null
                                                                      : () async {
                                                                          double
                                                                              totalQr_ =
                                                                              0.00;
                                                                          setState(
                                                                              () {
                                                                            totalQr_ = sum_amt +
                                                                                sum_fine +
                                                                                (fine_total * _TransModels.length) -
                                                                                double.parse(sum_disamtx.text.toString() == '' ? '0' : sum_disamtx.text.toString());
                                                                          });
                                                                          if (totalQr_ !=
                                                                              0.00) {
                                                                            in_Trans_invoice_refno().then((value) {
                                                                              setState(() {
                                                                                for (int index = 0; index < _TransModels.length; index++) {
                                                                                  de_Trans_item_inv(index);
                                                                                }
                                                                                red_Trans_select2();
                                                                                red_InvoiceMon_bill();
                                                                              });
                                                                            });
                                                                          } else {
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
                                                                                            child: Padding(
                                                                                              padding: const EdgeInsets.all(4.0),
                                                                                              child: Text(
                                                                                                'รายการชำระทั้งหมด ${_TransModels.length} รายการ',
                                                                                                textAlign: TextAlign.center,
                                                                                                style: TextStyle(color: PeopleChaoScreen_Color.Colors_Text1_, fontWeight: FontWeight.w600, fontFamily: Font_.Fonts_T, fontSize: 14.0),
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                          Center(
                                                                                            child: Padding(
                                                                                              padding: const EdgeInsets.all(4.0),
                                                                                              child: Text(
                                                                                                '# จำนวนเงินชำระทั้งหมด เท่ากับ ${totalQr_} บาท ',
                                                                                                textAlign: TextAlign.center,
                                                                                                style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontFamily: FontWeight_.Fonts_T, fontSize: 14.0),
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                          Center(
                                                                                            child: Padding(
                                                                                              padding: const EdgeInsets.all(4.0),
                                                                                              child: Text(
                                                                                                '( กรุณาตรวจสอบความถูกต้อง )',
                                                                                                textAlign: TextAlign.center,
                                                                                                style: TextStyle(
                                                                                                    color: PeopleChaoScreen_Color.Colors_Text1_,
                                                                                                    // fontWeight: FontWeight.bold,
                                                                                                    fontSize: 14.0),
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                          if (_TransModels.length != 0)
                                                                                            Center(
                                                                                              child: Padding(
                                                                                                padding: const EdgeInsets.all(4.0),
                                                                                                child: Text(
                                                                                                  '# ยืนยันการทำรายการชำระต่อ ใช่หรือไม่.. ? ',
                                                                                                  textAlign: TextAlign.center,
                                                                                                  style: TextStyle(
                                                                                                      color: Colors.red,
                                                                                                      // fontWeight: FontWeight.bold,
                                                                                                      fontFamily: Font_.Fonts_T,
                                                                                                      fontSize: 14.0),
                                                                                                ),
                                                                                              ),
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
                                                                                            color: Colors.grey,
                                                                                            height: 4.0,
                                                                                          ),
                                                                                          const SizedBox(
                                                                                            height: 5.0,
                                                                                          ),
                                                                                          Row(
                                                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                                                            children: [
                                                                                              if (_TransModels.length != 0)
                                                                                                Container(
                                                                                                  child: Padding(
                                                                                                    padding: const EdgeInsets.all(8.0),
                                                                                                    child: InkWell(
                                                                                                      child: Container(
                                                                                                          width: 100,
                                                                                                          decoration: const BoxDecoration(
                                                                                                            color: Colors.green,
                                                                                                            borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                                                                                                            // border: Border.all(color: Colors.white, width: 1),
                                                                                                          ),
                                                                                                          padding: const EdgeInsets.all(8.0),
                                                                                                          child: const Center(
                                                                                                              child: Text(
                                                                                                            'ยืนยัน',
                                                                                                            textAlign: TextAlign.center,
                                                                                                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontFamily: FontWeight_.Fonts_T
                                                                                                                //fontSize: 10.0
                                                                                                                ),
                                                                                                          ))),
                                                                                                      onTap: () async {
                                                                                                        Navigator.of(context).pop();
                                                                                                        in_Trans_invoice_refno().then((value) {
                                                                                                          setState(() {
                                                                                                            for (int index = 0; index < _TransModels.length; index++) {
                                                                                                              de_Trans_item_inv(index);
                                                                                                            }
                                                                                                            red_Trans_select2();
                                                                                                            red_InvoiceMon_bill();
                                                                                                          });
                                                                                                        });
                                                                                                      },
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                              Container(
                                                                                                child: Padding(
                                                                                                  padding: const EdgeInsets.all(8.0),
                                                                                                  child: InkWell(
                                                                                                    child: Container(
                                                                                                        width: 100,
                                                                                                        decoration: const BoxDecoration(
                                                                                                          color: Colors.red,
                                                                                                          borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                                                                                                          // border: Border.all(color: Colors.white, width: 1),
                                                                                                        ),
                                                                                                        padding: const EdgeInsets.all(8.0),
                                                                                                        child: const Center(
                                                                                                            child: Text(
                                                                                                          'ยกเลิก',
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
                                                                                      ),
                                                                                    ],
                                                                                  );
                                                                                });
                                                                          }
                                                                        },
                                                            ),
                                                          ),
                                                        ),

                                                  // Expanded(
                                                  //   flex: 1,
                                                  //   child: Column(
                                                  //     children: [
                                                  //       Container(
                                                  //         color: Colors.green,
                                                  //         child: Padding(
                                                  //           padding: const EdgeInsets.all(8.0),
                                                  //           child: TextButton(
                                                  //             onPressed: () async {},
                                                  //             child: const Text(
                                                  //               "QR",
                                                  //               style: TextStyle(
                                                  //                 color: Colors.black,
                                                  //                 fontFamily: Font_.Fonts_T,
                                                  //                 fontWeight: FontWeight.bold,
                                                  //               ),
                                                  //             ),
                                                  //           ),
                                                  //         ),
                                                  //       ),
                                                  //       Container(
                                                  //         color: Colors.green,
                                                  //         child: Padding(
                                                  //           padding: const EdgeInsets.all(8.0),
                                                  //           child: TextButton(
                                                  //             onPressed: () async {
                                                  //               in_Trans_invoice_refno()
                                                  //                   .then((value) {
                                                  //                 setState(() {
                                                  //                   for (int index = 0;
                                                  //                       index <
                                                  //                           _TransModels.length;
                                                  //                       index++) {
                                                  //                     de_Trans_item_inv(index);
                                                  //                   }
                                                  //                   red_Trans_select2();
                                                  //                   red_InvoiceMon_bill();
                                                  //                 });
                                                  //               });
                                                  //             },
                                                  //             child: const Text(
                                                  //               "ยืนยันการชำระ",
                                                  //               style: TextStyle(
                                                  //                 color: Colors.black,
                                                  //                 fontFamily: Font_.Fonts_T,
                                                  //                 fontWeight: FontWeight.bold,
                                                  //               ),
                                                  //             ),
                                                  //           ),
                                                  //         ),
                                                  //       ),
                                                  //     ],
                                                  //   ),
                                                  // )
                                                ]),
                                          ),
                                        ),
                                  const SizedBox(
                                    height: 20,
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
              )),
        ],
      ),
    );
  }

  // List<String> rowdetail = [];

  // _importFromExcel() async {
  //   var file = "${MyConstant().domain}/IMG/report.xlsx";
  //   var bytes = File(file).readAsBytesSync();
  //   var excel = Excel.decodeBytes(bytes);

  //   for (var table in excel.tables.keys) {
  //     for (var row in excel.tables[table]!.rows) {
  //       print(row.toString());
  //       // rowdetail.add(row.toString());
  //     }
  //   }

  //   // print(rowdetail.map((e) => e.toString()));
  // }

  Future<Null> de_Trans_item_inv(index) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    var user = preferences.getString('ser');

    var tser = _TransModels[index].ser;

    print('tser >>.> $tser');

    String url =
        '${MyConstant().domain}/De_tran_ser_inv.php?isAdd=true&ren=$ren&tser=$tser&user=$user';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);
      if (result.toString() == 'true') {
        setState(() {
          red_Trans_select2();
        });
        print('rrrrrrrrrrrrrr');
      }
    } catch (e) {}
  }

  Future<Null> in_Trans_invoice_refno() async {
    try {
      await OKuploadFile_Slip();
    } catch (e) {}
    // for (int index = 0; index < _TransModels.length; index++) {
    String? fileName_Slip_ =
        (fileName_Slip == null) ? '' : fileName_Slip.toString().trim();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    var user = preferences.getString('ser');
    var ciddoc = cidSelect; //_TransModels[index].refno;
    var qutser = '1';

    var sumdis = double.parse(sum_disamtx.text.toString() == ''
        ? '0'
        : sum_disamtx.text
            .toString()); // double.parse(_TransModels[index].dis.toString()).toString();
    var sumdisp = double.parse(
        sum_dispx.text.toString() == '' ? '0' : sum_dispx.text.toString());
    var dateY = Value_newDateY;
    var dateY1 = Value_newDateY1;
    var time = DateFormat('HH:mm:ss').format(newDatetime).toString();
    //pamentpage == 0
    var dis_akan = '0.00';
    var dis_Matjum = '0.00';
    var payment1 = (sum_amt +
        sum_fine +
        (fine_total * _TransModels.length) -
        double.parse(sum_disamtx.text.toString() == ''
            ? '0'
            : sum_disamtx.text
                .toString())); // (double.parse(_TransModels[index].total.toString()) + double.parse(_TransModels[index].fine.toString())).toString();
    var payment2 = 0.toString();
    var pSer1 = paymentSer1;
    var pSer2 = paymentSer2;
    var ref = ''; //_TransModels[index].docno;
    var sum_whta =
        sum_wht; // double.parse(_TransModels[index].wht.toString()).toString();
    // var bill = 'P';
    var bill = bills_name_ == 'บิลธรรมดา' ? 'P' : 'F';
    var comment = '';
    // var sum_fine =
    //     double.parse(_TransModels[index].fine.toString()).toString();
    var fine_total_amt = fine_total;
    // print('in_Trans_invoice_refno()///$fileName_Slip_');
    // print('in_Trans_invoice_refno >>> $payment1  $payment2  $bill ');
//In_tran_financet1 //In_tran_finanref1
    var Refpay1 = (Refpay_1 == null) ? '' : Refpay_1;
    var Refpay2 = (Refpay_2 == null) ? '' : Refpay_2;
    var Refpay3 = (Refpay_3 == null) ? '' : Refpay_3;
    String url =
        '${MyConstant().domain}/In_tran_INV_all.php?isAdd=true&ren=$ren&ciddoc=$ciddoc&qutser=$qutser&user=$user&sumdis=$sumdis&sumdisp=$sumdisp&dateY=$dateY&dateY1=$dateY1&time=$time&payment1=$payment1&payment2=$payment2&pSer1=$pSer1&pSer2=$pSer2&ref=$ref&sum_whta=$sum_whta&bill=$bill&fileNameSlip=$fileName_Slip_&comment=$comment&dis_Pakan=$dis_akan&dis_Matjum=$dis_Matjum&sum_fine=$sum_fine&fine_total_amt=$fine_total_amt&refpay=$Refpay1';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print(result);
      if (result.toString() != 'No') {
        print('result.toString() != No');
        for (var map in result) {
          CFinnancetransModel cFinnancetransModel =
              CFinnancetransModel.fromJson(map);
          setState(() {
            cFinn = cFinnancetransModel.docno;

            doctax = cFinnancetransModel.doctax;
            sum_disamtx.clear();
            sum_dispx.clear();
          });
          print('zzzzasaaa123454>>>>  $cFinn');
          print(
              'in_Trans_invoice_refno bno123454>>>>  ${cFinnancetransModel.bno}//// ${cFinnancetransModel.doctax}');
        }

        // Insert_log.Insert_logs('บัญชี', 'ชำระบิล:$cFinn ');
        // (Default_Receipt_type == 1)
        //     ? Show_Dialog()
        //     : Receipt_his_statusbill(cFinn);
        if (paymentName1.toString().trim() == 'Beam Checkout' ||
            paymentName2.toString().trim() == 'Beam Checkout' ||
            payment_ptSer1.toString().trim() == '7' ||
            payment_ptSer2.toString().trim() == '7') {
          String url_beam =
              '${MyConstant().domain}/Pay_Beam_Step1.php?isAdd=true&ren=$ren&ciddoc=$cFinn';

          try {
            var response_s = await http.get(Uri.parse(url_beam));

            var result_s = json.decode(response_s.body);
            print(result_s);
            if (result_s.toString() == 'true') {
              Future.delayed(Duration(milliseconds: 200), () async {
                print('Pay_Beam_Step1//---------> true <** in_Trans_invoice');
                read_GC_beamcheckout(cFinn, payment1, ciddoc);
              });
            }
          } catch (e) {}
        } else {}
        print('rrrrrrrrrrrrrr');
      }
    } catch (e) {}
    // }
  }

  //////////////------------------------------------------------------------->
  Future<Null> Show_Dialog() async {
    Dialog_Update();
  }

  Dialog_Update() async {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
          backgroundColor: Colors.green,
          content: Text('ทำรายการเสร็จสิ้น ...!!',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: FontWeight_.Fonts_T))),
    );
  }

  //////////////-------------------------------------------------------------> ( รายการ ประวัติบิล )
  Future<Null> Receipt_his_statusbill(cFinn) async {
    /////////-------------->
    String? TitleType_Default_Receipt_Name;
    List newValuePDFimg = [];
    /////////-------------->
    for (int index = 0; index < 1; index++) {
      if (renTalModels[0].imglogo!.trim() == '') {
        // newValuePDFimg.add(
        //     'https://png.pngtree.com/png-vector/20190820/ourmid/pngtree-no-image-vector-illustration-isolated-png-image_1694547.jpg');
      } else {
        newValuePDFimg.add(
            '${MyConstant().domain}/files/$foder/logo/${renTalModels[0].imglogo!.trim()}');
      }
    }
/////////-------------->
    if (TitleType_Default_Receipt == 0) {
    } else {
      setState(() {
        TitleType_Default_Receipt_Name =
            '${TitleType_Default_Receipt_[TitleType_Default_Receipt]}';
      });
    }
    ManPay_Receipt_PDF.ManPayReceipt_PDF(
        cFinn,
        context,
        foder,
        renTal_name,
        // sname,
        // cname,
        // addr,
        // tax,
        bill_addr,
        bill_email,
        bill_tel,
        bill_tax,
        bill_name,
        newValuePDFimg,
        TitleType_Default_Receipt_Name,
        tem_page_ser,
        bills_name_);
  }

  Future<Null> Gen_QRStandard_ref() async {
    var day = DateTime.now().toUtc().millisecondsSinceEpoch;
    var refpay = 'WP$day';
    var refpay2 =
        '${DateFormat('ddMM').format(DateFormat('dd-MM-yyyy').parse(Value_newDateD.toString()))}${int.parse('${DateFormat('yyyy').format(DateFormat('dd-MM-yyyy').parse(Value_newDateD.toString()))}') + 543}';
    var Bno = (paymentName1.toString().trim() == 'Online Standard QR')
        ? selectedValue
        : '';
    var text1 = (paymentName1.toString().trim() == 'Online Standard QR')
        ? ((sum_amt + sum_fine) +
                    (fine_total * _TransModels.length) -
                    double.parse(sum_disamtx.text.toString() == ''
                        ? '0'
                        : sum_disamtx.text.toString()) ==
                0.00)
            ? 0.00
            : (sum_amt + sum_fine) +
                (fine_total * _TransModels.length) -
                double.parse(sum_disamtx.text.toString() == ''
                    ? '0'
                    : sum_disamtx.text.toString())
        : 0.00;
    // var text2 = (paymentName2.toString().trim() == 'Online Standard QR')
    //     ? (Form_payment2.text == null || Form_payment2.text == '')
    //         ? 0.00
    //         : Form_payment2.text
    //     : 0.00;

    String total_QR = '${nFormat.format(double.parse('${text1}'))}';
    String newTotal_QR = total_QR.replaceAll(RegExp(r'[^0-9]'), '');
    setState(() {
      Refpay_1 = refpay;
      Refpay_2 = refpay2;
    });
    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
            insetPadding: EdgeInsets.all(5),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            // title: Row(
            //   mainAxisAlignment:
            //       MainAxisAlignment.end,
            //   children: [
            //     Icon(
            //       Icons.cancel,
            //       color: Colors.red,
            //       size: 30,
            //     )
            //   ],
            // ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  SizedBox(
                    height: 20,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context, 'OK');
                          },
                          child: Icon(
                            Icons.cancel,
                            color: Colors.red,
                            size: 22,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 1),
                  Divider(),
                  SizedBox(height: 1),
                  StreamBuilder(
                      stream: Stream.periodic(const Duration(seconds: 0)),
                      builder: (context, snapshot) {
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Text(
                                  'Online Standard QR',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: FontWeight_.Fonts_T),
                                ),
                              ),
                            ),
                            Divider(),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'บช. : $Bno',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                    fontFamily: Font_.Fonts_T),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'ref1 : $Refpay_1',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                    fontFamily: Font_.Fonts_T),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'ref2 : ${Refpay_2}',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                    fontFamily: Font_.Fonts_T),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'จำนวนเงิน : ${total_QR} บาท',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                    fontFamily: Font_.Fonts_T),
                              ),
                            ),
                          ],
                        );
                      }),
                  SizedBox(height: 1),
                  Divider(),
                  SizedBox(height: 1),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        'SCAN ME',
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontFamily: FontWeight_.Fonts_T),
                      ),
                    ),
                  ),
                  Center(
                    child: TimerCountdown(
                      format: CountDownTimerFormat.minutesSeconds,
                      minutesDescription: 'นาที',
                      secondsDescription: 'วินาที',
                      timeTextStyle: TextStyle(
                          color: Colors.orange,
                          // fontWeight:
                          //     FontWeight.bold,
                          fontFamily: Font_.Fonts_T),
                      endTime: DateTime.now().add(
                        Duration(
                          minutes: 15,
                          seconds: 1,
                        ),
                      ),
                      onEnd: () {
                        Navigator.pop(context, 'OK');
                      },
                    ),
                  ),
                  StreamBuilder(
                      stream: Stream.periodic(const Duration(seconds: 0)),
                      builder: (context, snapshot) {
                        return Column(
                          children: [
                            Container(
                              width: 150,
                              height: 150,
                              child: SfBarcodeGenerator(
                                value: (Value_newDateD == '')
                                    ? ''
                                    : '|$Bno\r$Refpay_1\r$Refpay_2\r${newTotal_QR}',
                                //  '|$selectedValue_bank_bno\r${cFinn.replaceAll('-', '')}\r${DateFormat('ddMM').format(DateTime.parse(End_Bill_Paydate))}$YearQRthai\r${newTotal_QR}',

                                symbology: QRCode(),
                                showValue: false,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Text(
                                  (Value_newDateD == null ||
                                          Value_newDateD.toString() == '')
                                      ? 'วันที่ ${Value_newDateD} '
                                      : 'วันที่ ${DateFormat('dd/MM').format(DateFormat('dd-MM-yyyy').parse(Value_newDateD.toString()))}/${int.parse('${DateFormat('yyyy').format(DateFormat('dd-MM-yyyy').parse(Value_newDateD.toString()))}') + 543}',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontFamily: FontWeight_.Fonts_T),
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        '(หากปิดหรือรีเฟรช QR Code จะถูกสร้างใหม่)',
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.red,
                            fontFamily: Font_.Fonts_T),
                      ),
                    ),
                  ),
                ],
              ),
            ));
      },
    );
  }
///////////--------------------------------------------------------------->

  ///////--------------------------------------------------------->(Beamchec-Stap-2)
  Future<Null> read_GC_beamcheckout(cFinn, PriAll, cid_s) async {
    /////////--------------->
    String decodedPassword = retrieveDecodedPassword(Pay_Ke.toString());
    String basicAuth = generateBasicAuth(decodedPassword);
    /////////--------->
    DateTime datexnow = DateTime.now();
    final moonLanding = DateTime.utc(datexnow.year, datexnow.month,
        datexnow.day, datexnow.hour, datexnow.minute + 10, 00);
    final isoDate2 = moonLanding.toIso8601String();

    /////////-------------->
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': '$basicAuth'
    };
    var request = https_Request();
    /////////------------->
    request.body = json.encode({
      "channel": "qrThb",
      "expiry": "$isoDate2",

      ///"2024-04-06T15:00:00Z",
      "order": {
        "currencyCode": "THB",
        "description": "$cid_s / $cFinn",
        // "[${renTal_user}]:$renTal_name, คุณ :$name_book จองพื้นที่ ${Area_selecte} ,วันที่จอง : ${datex_book}",
        "merchantReference": "เลขที่สัญญา :$cid_s,(W)",
        "merchantReferenceId": "$cFinn",
        "netAmount": double.parse(PriAll.toString()),
        "orderItems": [
          // for (int index = 0; index < selected_Area.length; index++)
          {
            "product": {
              "description": "รับชำระ : ${cFinn}",
              "imageUrl":
                  "https://www.shutterstock.com/image-vector/map-icon-red-marker-pin-260nw-1962656155.jpg",
              "name": "${cid_s}",
              "price": double.parse(PriAll.toString()),
              "sku": "string"
            },
            "quantity": 1
          },
        ],
        "totalAmount": double.parse(PriAll.toString()),
        "totalDiscount": 0
      },
      "redirectUrl": "",
      "requiredFieldsFormId": "",
      "supportedPaymentMethods": ["qrThb"]
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());
      String jsonString = await response.stream.bytesToString();
      Map<String, dynamic> data = jsonDecode(jsonString);
      String purchaseId = data['purchaseId'];
      String paymentLink = data['paymentLink'];

      // print('Purchase ID: $purchaseId');
      // print('Payment Link: $paymentLink'); ////UP_PurchaseID_Beamcheck
      if (purchaseId == null ||
          paymentLink == null ||
          purchaseId.toString() == '' ||
          paymentLink.toString() == '' ||
          cFinn == null ||
          cFinn.toString() == '') {
      } else {
        Beamcheckout_Dialog(cFinn, purchaseId, paymentLink);
      }
    } else {
      // print(response.reasonPhrase);
    }
  }

///////----------------------------------------------------------->(Beamchec-Stap-3)
  Future<Null> Beamcheckout_Dialog(cFinn, purchaseId, paymentLink) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    var user = preferences.getString('ser');

    var cFinnc_s = cFinn;
    var purchaseId_s = purchaseId;
    var paymentLink_s = paymentLink;
    String url =
        await '${MyConstant().domain}/UP_PurchaseID_Beamcheck.php?isAdd=true&serren=${ren}&iddocno=$cFinnc_s&beamid=$purchaseId_s&url_s=$paymentLink_s';
    if (purchaseId != null && cFinn != null) {
      Future.delayed(Duration(microseconds: 2), () {
        // read_Recheck_beamcheckout('$purchaseId');
        startUpdates(cFinn, '$purchaseId');
      });

      try {
        var response = await http.get(Uri.parse(url));

        var result = await json.decode(response.body);

        if (result.toString() == 'true') {
          await showDialog<void>(
            context: context,
            barrierDismissible: false, // user must tap button!
            builder: (BuildContext context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                backgroundColor: AppbackgroundColor.Sub_Abg_Colors,
                titlePadding: const EdgeInsets.all(0.0),
                contentPadding: const EdgeInsets.all(10.0),
                actionsPadding: const EdgeInsets.all(6.0),
                title: StreamBuilder(
                    stream: Stream.periodic(const Duration(seconds: 0)),
                    builder: (context, snapshot) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          if (cahek != 1)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () async {
                                  Dia_log(200);
                                  // Navigator.pop(context);
                                  // Dialog_cancellock(purchaseId_s);

                                  Beam_purchase_disabled(
                                          purchaseId, Pay_Ke, ren, cFinnc_s,'')
                                      .then((value) => {
                                            _timer.cancel(),
                                            Navigator.pop(context),
                                            Future.delayed(
                                                Duration(milliseconds: 600),
                                                () async {
                                              Dialog_cancellock();
                                            }),
                                          });
                                },
                                child: Icon(
                                  Icons.cancel,
                                  color: Colors.red,
                                  size: 30,
                                ),
                              ),
                            )
                        ],
                      );
                    }),
                content: StreamBuilder(
                    stream: Stream.periodic(const Duration(seconds: 0)),
                    builder: (context, snapshot) {
                      return SingleChildScrollView(
                        child: ListBody(
                          children: <Widget>[
                            Container(
                              // height: 600,
                              width: MediaQuery.of(context).size.width,
                              child:
                                  WebViewX2Pagebeamcheck(id_ser: paymentLink_s),
                            ),
                          ],
                        ),
                      );
                    }),
              );
            },
          );
        } else {}
      } catch (e) {
        print(e);
      }
    }
  }

///////-------------------------------------------------------->(Beamchec-Stap-4)
  int cahek = 0;
  late Timer _timer;

  void startUpdates(cFinn, purchaseId) {
    _timer = Timer.periodic(Duration(seconds: 2), (timer) async {
      if (cahek == 1) {
        _timer.cancel(); // Stop the timer if cahek is 1
        return;
      }

      await read_Recheck_beamcheckout(cFinn, purchaseId);
      // print('read_Recheck_beamcheckout ');
    });
  }

  Future<Null> read_Recheck_beamcheckout(cFinn, purchaseId) async {
    /////////------------------------------------------------>
    String decodedPassword = retrieveDecodedPassword(Pay_Ke.toString());
    String basicAuth = generateBasicAuth(decodedPassword);
    /////////------------------------------------------------>
    var headers = {'Authorization': '$basicAuth'};
    var request = https_Request_check(purchaseId);
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    /////////------------------------------------------------>
    if (response.statusCode == 200) {
      String jsonString = await response.stream.bytesToString();
      Map<String, dynamic> jsonData = json.decode(jsonString);
      var DateTimePay = jsonData['timePaid'].toString().trim();
      var urlIdpaycomplete = jsonData['paymentLink'].toString().trim();

      print('State: ${jsonData['state']}');
      if (jsonData['state'].toString().trim() == 'complete') {
        setState(() {
          cahek = 1;
        });
        Future.delayed(Duration(milliseconds: 200), () async {
          SharedPreferences preferences = await SharedPreferences.getInstance();
          //////-------------------------------->
          Insert_log.Insert_logs('บัญชี', 'ชำระบิล:$cFinn ');
          (Default_Receipt_type == 1)
              ? Show_Dialog()
              : Receipt_his_statusbill(cFinn);
          print('rrrrrrrrrrrrrr');
        });

        //////-------------------------------->
      } else {}
      // print(await response.stream.bytesToString());
    } else {
      // print(response.reasonPhrase);
    }
  }

/////////////---------------------------------------------------->
  Dialog_cancellock() async {
    PanaraInfoDialog.showAnimatedGrow(
      context,
      title: "Oops",
      message: "ยกเลิกการรับชำระ เสร็จสิ้น ...!!",
      buttonText: "รับทราบ",
      onTapDismiss: () async {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        Navigator.pop(context);
        String? _route = preferences.getString('route');
        MaterialPageRoute materialPageRoute = MaterialPageRoute(
            builder: (BuildContext context) => AdminScafScreen(route: _route));
        Navigator.pushAndRemoveUntil(
            context, materialPageRoute, (route) => false);
      },
      panaraDialogType: PanaraDialogType.warning,
      barrierDismissible: false, // optional parameter (default is true)
    );
  }

  Dia_log(milli_seconds) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) {
          Timer(Duration(milliseconds: milli_seconds), () {
            Navigator.of(context).pop();
          });
          return Dialog(
            child: SizedBox(
                height: 40,
                width: 40,
                child: Center(
                    child: SizedBox(
                        height: 25,
                        width: 25,
                        child: CircularProgressIndicator()))
                // FittedBox(
                //   fit: BoxFit.cover,
                //   child: Image.asset(
                //     "images/gif-LOGOchao.gif",
                //     fit: BoxFit.cover,
                //     height: 20,
                //     width: 80,
                //   ),
                // ),
                ),
          );
        });
  }

///////////--------------------------------------------------------------->
}
