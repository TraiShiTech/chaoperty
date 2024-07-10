import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../Constant/Myconstant.dart';
import '../Model/GetContract_Model.dart';
import '../Model/GetFinnancetrans_Model.dart';
import '../Model/trans_re_bill_model.dart';

import '../PDF_Market/pdf_hisbill_Market.dart';

class ManPay_ReceiptMarket_PDF {
  // --------------------------------> PDF หลังรับชำระ และ ประวัติบิล
  static void ManPayReceiptMarket_PDF(
    context,
    Ser,
    foder,
    cFinn,
    bill_addr,
    bill_email,
    bill_tel,
    bill_tax,
    bill_name,
  ) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var rt_Language = preferences.getString('renTal_Language');
    String domain_Market =
        'https://dzentric.com/chaoperty_market/Chaoperty_market_API';

    //GC_select_bill
    //
    var TextForm_name,
        TextForm_tel,
        serUser,
        zoneser,
        zoneName,
        selected_Area,
        selected_AreaSer;

    var paymentName1,
        fileNameSlip_,
        TextForm_time,
        bank1,
        bname1,
        bno1,
        datex,
        datexPay,
        url;
    var Areaqty, pos, pay_ptset;
    var fonts_pdf = (rt_Language.toString().trim() == 'LA')
        ? await 'fonts/NotoSansLao.ttf'
        : await 'fonts/THSarabunNew.ttf';
    var nFormat = (rt_Language.toString().trim() == 'LA');
    double Total = 0.00;
    List datexbook = [];
    List<TransReBillModel> _TransReBillModels = [];
    ///////////------------------------------------>
    String url_1 =
        '${domain_Market}/GC_select_bill.php?isAdd=true&ren=$Ser&ciddoc=$cFinn';

    try {
      var response = await http.get(Uri.parse(url_1));
      var result = json.decode(response.body);

      if (result.toString() != 'null') {
        // print('url_1>>>> $result');
        for (var map in result) {
          TransReBillModel TransReBillModels = TransReBillModel.fromJson(map);
          _TransReBillModels.add(TransReBillModels);
        }
      } else {
        // print('url_1>>>> null');
      }
    } catch (e) {}

    //////////////////////-------------------------------------------->
    String url_2 =
        '${domain_Market}/GC_bill_pay_amtMarket.php?isAdd=true&ren=$Ser&ciddoc=$cFinn';
    try {
      var response = await http.get(Uri.parse(url_2));
      var result = json.decode(response.body);

      if (result.toString() != 'null') {
        // print('url_2>>>> $result');
        for (var map in result) {
          FinnancetransModel finnancetransModel =
              FinnancetransModel.fromJson(map);
          Total = (finnancetransModel.total == null)
              ? 0.00
              : double.parse(finnancetransModel.total.toString());
          paymentName1 = finnancetransModel.ptname.toString();
          fileNameSlip_ = (finnancetransModel.ptser.toString() != '7')
              ? finnancetransModel.slip.toString()
              : (finnancetransModel.ref1 != null ||
                      finnancetransModel.ref1.toString() != '')
                  ? finnancetransModel.ref1.toString()
                  : finnancetransModel.slip.toString();
          TextForm_time = finnancetransModel.ptime.toString();
          bname1 = finnancetransModel.bname.toString();
          datexbook.add(finnancetransModel.date_book.toString());
          datex = finnancetransModel.daterec.toString();
          datexPay = finnancetransModel.dateacc.toString();
          pos = finnancetransModel.pos.toString();
          pay_ptset = finnancetransModel.ptser.toString();
          url = (finnancetransModel.ptser.toString() != '7')
              ? '${MyConstant().domain}/files/$foder/slip/${finnancetransModel.slip}'
              : finnancetransModel.slip.toString();
          bno1 = finnancetransModel.bno.toString();
          bank1 = finnancetransModel.bank.toString();
        }
      }
    } catch (e) {}
    //////////////////////-------------------------------------------->
    String url_3 =
        '${domain_Market}/GC_cont_nameBook.php?isAdd=true&ren=$Ser&ciddoc=$cFinn';
    try {
      var response = await http.get(Uri.parse(url_3));
      var result = json.decode(response.body);

      if (result.toString() != 'null') {
        // print('url_3>>>> $result');
        for (var map in result) {
          ContractModel ContractModels = ContractModel.fromJson(map);
          TextForm_name = ContractModels.sname.toString();
          TextForm_tel = ContractModels.tel.toString();
          TextForm_tel = ContractModels.tel.toString();
          serUser = ContractModels.user.toString();
          zoneser = ContractModels.zser.toString();
          zoneName = ContractModels.zn.toString();
          selected_Area = ContractModels.ln.toString();
          Areaqty = ContractModels.qty.toString();
        }
      } else {
        // print('url_3>>>> null');
      }
    } catch (e) {}
    ///////////------------------------------------>
    Pdfgen_hisbill_Market.exportPDF_hisbill_market(
        context,
        Ser,
        TextForm_name,
        TextForm_tel,
        TextForm_time,
        paymentName1,
        fileNameSlip_,
        serUser,
        cFinn,
        zoneser,
        selected_Area,
        datex,
        datexPay,
        datexbook,
        bname1,
        bill_addr,
        bill_email,
        bill_tel,
        bill_tax,
        bill_name,
        zoneName,
        _TransReBillModels,
        Total,
        Areaqty,
        pos,
        url,
        pay_ptset,
        bno1,
        bank1);
  }
}
