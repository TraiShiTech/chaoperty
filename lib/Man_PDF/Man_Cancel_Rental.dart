import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../Constant/Myconstant.dart';
import '../Model/GetC_Quot_Select_Model.dart';
import '../Model/GetFinnancetrans_Model.dart';
import '../Model/GetTeNant_Model.dart';
import '../Model/GetTrans_Kon_Model.dart';
import '../Model/GetUser_Model.dart';
import '../Model/Read_DataONBill_PDF_Model.dart';
import '../Model/trans_re_bill_history_model.dart';
import '../PDF/PDF_Receipt/pdf_AC_his_statusbill.dart';
import '../PDF/pdf_Cancel_Rental.dart';

import '../PDF/pdf_Cancel_Rental_Lao.dart';
import '../PDF_TP2/PDF_Receipt_TP2/pdf_AC_his_statusbill_TP2.dart';
import '../PDF_TP3/PDF_Receipt_TP3/pdf_AC_his_statusbill_TP3.dart';
import '../PDF_TP4/PDF_Receipt_TP4/pdf_AC_his_statusbill_TP4.dart';
import '../PDF_TP5/PDF_Receipt_TP5/pdf_AC_his_statusbill_TP5.dart';
import '../PDF_TP6/PDF_Receipt_TP6/pdf_AC_his_statusbill_TP6.dart';
import '../PDF_TP7/PDF_Receipt_TP7/pdf_AC_his_statusbill_TP7.dart';
import '../PDF_TP8/PDF_Receipt_TP8/pdf_AC_his_statusbill_TP8.dart';
import '../PDF_TP8_Ortorkor/PDF_Receipt_TP8_Ortorkor/pdf_AC_his_statusbill_TP8.dart';

class Man_CancelRental_PDF {
  static void ManCancelRental_PDF(
    TitleType_Default_Receipt_Name,
    qutser,
    ciddoc, ////----->เลขที่รับชำระ
    context, ////----->context
    foder, ////----->foder
    renTal_name,
    // sname, ////----->ชื่อร้าน
    // cname, ////----->ชื่อผู้ติดต่อ
    // addr, ////----->ที่อยู่
    // tax, ////----->เลขประจำตัวผู้เสียภาษี
    bill_addr,
    bill_email,
    bill_tel,
    bill_tax,
    bill_name,
    newValuePDFimg,
    // TitleType_Default_Receipt_Name, //->หัวบิล [ต้นฉับับ  สำเนา ไม่ระบุ]

    tem_page_ser,

    ///----->ser เทมเพลต
  ) async {
    ///////////----------------------------------------------->
    List<TeNantModel> teNantModels = [];
    List<QuotxSelectModel> quotxSelectModels = [];
    List<TransKonModel> transKonModels = [];
    ///////////----------------------------------------------->
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    var rtser = preferences.getString('renTalSer');
    var rt_Language = preferences.getString('renTal_Language');
    var user = preferences.getString('ser');
    var fonts_pdf = (rt_Language.toString().trim() == 'LA')
        ? await 'fonts/NotoSansLao.ttf'
        : await 'fonts/THSarabunNew.ttf';
    var nFormat = (rt_Language.toString().trim() == 'LA')
        ? NumberFormat("#,##0", "en_US")
        : NumberFormat("#,##0.00", "en_US");
    ///////////----------------------------------------------->
    String? TeNant_nameshop,
        TeNant_typeshop,
        TeNant_bussshop,
        TeNant_bussscontact,
        TeNant_address,
        TeNant_tel,
        TeNant_email,
        TeNant_rental_count,
        TeNant_area,
        TeNant_ln,
        TeNant_sdate,
        TeNant_ldate,
        TeNant_period,
        TeNant_rtname,
        TeNant_docno,
        TeNant_zn,
        TeNant_aser,
        TeNant_qty,
        TeNant_cdate,
        TeNant_tax,
        TeNant_ctype,
        TeNant_custno,
        TeNant_verticalGroupValue;
    String? TeNant_ciddoc, TeNant_qutser;
///////////----------------------------------------------->
    String url =
        '${MyConstant().domain}/GC_tenantlookAS.php?isAdd=true&ren=$ren&ciddoc=$ciddoc&qutser=$qutser';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);
      if (result != null) {
        for (var map in result) {
          TeNantModel teNantModel = TeNantModel.fromJson(map);
          teNantModels.add(teNantModel);
          TeNant_custno = teNantModel.custno_1.toString();
          TeNant_ctype = teNantModel.ctype.toString();
          TeNant_nameshop = teNantModel.sname.toString();
          TeNant_typeshop = teNantModel.stype.toString();
          TeNant_bussshop = teNantModel.cname.toString();
          TeNant_bussscontact = teNantModel.attn.toString();
          TeNant_address = teNantModel.addr.toString();
          TeNant_tel = teNantModel.tel.toString();
          TeNant_email = teNantModel.email.toString();
          TeNant_tax =
              teNantModel.tax == null ? "-" : teNantModel.tax.toString();
          TeNant_area = teNantModel.area.toString();
          TeNant_ln = teNantModel.area_c.toString();

          TeNant_sdate = DateFormat('dd-MM-yyyy')
              .format(DateTime.parse('${teNantModel.sdate} 00:00:00'))
              .toString();
          TeNant_ldate = DateFormat('dd-MM-yyyy')
              .format(DateTime.parse('${teNantModel.ldate} 00:00:00'))
              .toString();
          TeNant_period = teNantModel.period.toString();
          TeNant_rtname = teNantModel.rtname.toString();
          TeNant_docno = teNantModel.docno.toString();
          TeNant_zn = teNantModel.zn.toString();
          TeNant_aser = teNantModel.aser.toString();
          TeNant_qty = teNantModel.qty.toString();
          TeNant_cdate = teNantModel.cdate.toString();
          TeNant_verticalGroupValue = teNantModel.ctype.toString();
        }
      }
    } catch (e) {}

///////////----------------------------------------------->
    String url2 =
        '${MyConstant().domain}/GC_quot_conx.php?isAdd=true&ren=$ren&ciddoc=$ciddoc&qutser=$qutser';
    try {
      var response = await http.get(Uri.parse(url2));

      var result = json.decode(response.body);
      // print(result);
      if (result.toString() != 'null') {
        if (quotxSelectModels.isNotEmpty) {
          quotxSelectModels.clear();
        }
        for (var map in result) {
          QuotxSelectModel quotxSelectModel = QuotxSelectModel.fromJson(map);
          quotxSelectModels.add(quotxSelectModel);
        }
      } else {
        quotxSelectModels.clear();
      }
    } catch (e) {}

///////////-----------------------------------------------> GC_tenantCancel_PDF
    String url3 =
        '${MyConstant().domain}/GC_tran_Kon_pakan.php?isAdd=true&ren=$ren&user=$user&ciddoc=$ciddoc';
    try {
      var response = await http.get(Uri.parse(url3));

      var result = json.decode(response.body);
      // print(result);
      if (result.toString() != 'null') {
        for (var map in result) {
          TransKonModel transKonModel = TransKonModel.fromJson(map);
          var sum_amtx = double.parse(transKonModel.total!);
          // sum_Kon = sum_Kon + sum_amtx;
          // bot = 1;
          transKonModels.add(transKonModel);
        }
      }
    } catch (e) {}
///////////----------------------------------------------->
    var Formbecause_cancel;
    var cc_date;
    String url4 =
        '${MyConstant().domain}/GC_tenantCancel_PDF.php?isAdd=true&ren=$ren&user=$user&ciddoc=$ciddoc';
    try {
      var response = await http.get(Uri.parse(url4));

      var result = json.decode(response.body);
      // print(result);
      if (result.toString() != 'null') {
        for (var map in result) {
          TeNantModel teNantModelsCancel = TeNantModel.fromJson(map);
          Formbecause_cancel = teNantModelsCancel.cc_remark.toString();
          cc_date = teNantModelsCancel.cc_date.toString();
        }
      }
    } catch (e) {}
///////////----------------------------------------------->
    Future.delayed(Duration(milliseconds: 500), () async {
      print('ciddoc');
      print(qutser);
      print(ciddoc);
      print(ciddoc);
      print('**ciddoc');
      (rt_Language.toString().trim() == 'LA')
          ? PdfgeCancel_Rental_Lao.exportPDF_Cancel_Rental_Lao(
              context,
              foder,
              renTal_name,
              bill_addr,
              bill_email,
              bill_tel,
              bill_tax,
              bill_name,
              TeNant_nameshop,
              TeNant_typeshop,
              TeNant_bussshop,
              TeNant_bussscontact,
              TeNant_address,
              TeNant_tel,
              TeNant_email,
              TeNant_rental_count,
              TeNant_area,
              TeNant_ln,
              TeNant_sdate,
              TeNant_ldate,
              TeNant_period,
              TeNant_rtname,
              TeNant_docno,
              TeNant_zn,
              TeNant_aser,
              TeNant_qty,
              TeNant_cdate,
              TeNant_tax,
              TeNant_ctype,
              TeNant_custno,
              ciddoc,
              qutser,
              TeNant_verticalGroupValue,
              newValuePDFimg,
              Formbecause_cancel,
              quotxSelectModels,
              transKonModels,
              TitleType_Default_Receipt_Name,
              cc_date,
              fonts_pdf)
          : PdfgeCancel_Rental.exportPDF_Cancel_Rental(
              context,
              foder,
              renTal_name,
              bill_addr,
              bill_email,
              bill_tel,
              bill_tax,
              bill_name,
              TeNant_nameshop,
              TeNant_typeshop,
              TeNant_bussshop,
              TeNant_bussscontact,
              TeNant_address,
              TeNant_tel,
              TeNant_email,
              TeNant_rental_count,
              TeNant_area,
              TeNant_ln,
              TeNant_sdate,
              TeNant_ldate,
              TeNant_period,
              TeNant_rtname,
              TeNant_docno,
              TeNant_zn,
              TeNant_aser,
              TeNant_qty,
              TeNant_cdate,
              TeNant_tax,
              TeNant_ctype,
              TeNant_custno,
              ciddoc,
              qutser,
              TeNant_verticalGroupValue,
              newValuePDFimg,
              Formbecause_cancel,
              quotxSelectModels,
              transKonModels,
              TitleType_Default_Receipt_Name,
              cc_date,
              fonts_pdf);
    });
  }
}
