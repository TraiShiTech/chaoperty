import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../Constant/Myconstant.dart';
import '../Model/GetC_Quot_Select_Model.dart';
import '../Model/GetFinnancetrans_Model.dart';
import '../Model/GetInvoice_Model.dart';
import '../Model/GetInvoice_history_Model.dart';
import '../Model/GetTeNant_Model.dart';
import '../Model/GetTrans_Kon_Model.dart';
import '../Model/GetTrans_hisdisinv_Model.dart';
import '../Model/GetUser_Model.dart';
import '../Model/Read_DataONBill_PDF_Model.dart';
import '../Model/trans_re_bill_history_model.dart';
import '../PDF/PDF_Receipt/pdf_AC_his_statusbill.dart';
import '../PDF/pdf_Cancel_Rental.dart';

import '../PDF_TP3/PDF_Billing_TP3/pdf_Reduce_debt_TP3.dart';
import '../PDF_TP4/PDF_Billing_TP4/pdf_Reduce_debt_TP4.dart';
import '../PDF_TP7/PDF_Billing_TP7/pdf_Reduce_debt_TP7.dart';
import '../PDF_TP8/PDF_Billing_TP8/pdf_Reduce_debt_TP8.dart';
import '../PDF_TP2/PDF_Receipt_TP2/pdf_AC_his_statusbill_TP2.dart';
import '../PDF_TP3/PDF_Receipt_TP3/pdf_AC_his_statusbill_TP3.dart';
import '../PDF_TP4/PDF_Receipt_TP4/pdf_AC_his_statusbill_TP4.dart';
import '../PDF_TP5/PDF_Receipt_TP5/pdf_AC_his_statusbill_TP5.dart';
import '../PDF_TP6/PDF_Receipt_TP6/pdf_AC_his_statusbill_TP6.dart';
import '../PDF_TP7/PDF_Receipt_TP7/pdf_AC_his_statusbill_TP7.dart';
import '../PDF_TP8/PDF_Receipt_TP8/pdf_AC_his_statusbill_TP8.dart';
import '../PDF_TP8_Ortorkor/PDF_Receipt_TP8_Ortorkor/pdf_AC_his_statusbill_TP8.dart';

class Man_Reducedebt_PDF {
  static void man_Reducedebt_PDF(
      TitleType_Default_Receipt_Name,
      foder,
      qutser,
      tem_page_ser,
      context,
      Get_Value_cid,
      namenew,
      bill_addr,
      bill_email,
      bill_tel,
      bill_tax,
      bill_name,
      newValuePDFimg,
      inv_num,
      docno_inv) async {
    var nFormat = NumberFormat("#,##0.00", "en_US");
    // List<InvoiceHistoryModel> _InvoiceHistoryModels = [];
    List<TransHisDisInvModel> _TransHisDisInvModels = [];
    String? numinvoice;
    String? Form_nameshop;
    String? Form_typeshop;
    String? Form_bussshop;
    String? Form_bussscontact;
    String? Form_address;
    String? Form_tel;
    String? Form_email;
    String? Form_tax;
    String? rental_count_text;
    String? Form_area;
    String? Form_ln;
    String? Form_sdate;
    String? Form_ldate;
    String? Form_period;
    String? Form_rtname;
    String? Form_docno;
    String? Form_zn;
    String? Form_aser;
    String? Form_qty;
    String? Form_custno;
    String? payment_Ptser1,
        payment_Ptname1,
        payment_Bno1,
        bank1,
        img1,
        btype1,
        ptname1,
        ptser1;
    String? payment_Ptser2,
        payment_Ptname2,
        payment_Bno2,
        bank2,
        img2,
        btype2,
        ptname2,
        ptser2;
    String? Datex_invoice;
    double sum_pvat = 0.00,
        sum_vat = 0.00,
        sum_wht = 0.00,
        sum_amt = 0.00,
        sum_dis = 0.00,
        sum_disamt = 0.00,
        sum_tran_dis = 0.00,
        sum_disp = 0.00;
    String? Cust_no, Ln_s, Zone_s, cid_;
    String? ser_user;
//--------------------->
    if (_TransHisDisInvModels.length != 0) {
      _TransHisDisInvModels.clear();
      sum_pvat = 0;
      sum_vat = 0;
      sum_wht = 0;
      sum_amt = 0;
      sum_disamt = 0;
      sum_disp = 0;
    }
    double amt_inv = 0.00,
        vat_inv = 0.00,
        wht_inv = 0.00,
        nwht_inv = 0.00,
        nvat_inv = 0.00;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var fname;
    var rtser = preferences.getString('renTalSer');
    var ren = preferences.getString('renTalSer');
    var renTal_name = preferences.getString('renTalName');

    var ciddoc = Get_Value_cid;

    String url_1 =
        '${MyConstant().domain}/GC_bill_invoice_hisdis.php?isAdd=true&ren=$ren&ciddoc=$ciddoc&qutser=$qutser';
    try {
      var response = await http.get(Uri.parse(url_1));

      var result = json.decode(response.body);
      // print(result);
      if (result.toString() != 'null') {
        for (var map in result) {
          InvoiceModel _InvoiceModel = InvoiceModel.fromJson(map);
          if (_InvoiceModel.docno.toString() == docno_inv.toString()) {
            Datex_invoice = _InvoiceModel.daterec;
            vat_inv = (_InvoiceModel.vatall == null)
                ? 0.00
                : double.parse(_InvoiceModel.vatall.toString());

            wht_inv = (_InvoiceModel.whtall == null)
                ? 0.00
                : double.parse(_InvoiceModel.whtall.toString());

            nwht_inv = (_InvoiceModel.nwht == null)
                ? 0.00
                : double.parse(_InvoiceModel.nwht.toString());
            amt_inv = (double.parse(_InvoiceModel.amtall!) +
                double.parse(_InvoiceModel.vatall!) -
                double.parse(_InvoiceModel.whtall!));
            nvat_inv = (_InvoiceModel.nvat == null)
                ? 0.00
                : double.parse(_InvoiceModel.nvat!);
          }
        }
      }
    } catch (e) {}

/////////////////////------------------------->

    String url_usersell =
        '${MyConstant().domain}/GC_User_PDF.php?isAdd=true&serUser=$ser_user';
    try {
      var response = await http.get(Uri.parse(url_usersell));
      var result = json.decode(response.body);

      if (result.toString() != 'null') {
        //  print('GC_Data_OnBill_PDF>>>> $result');
        for (var map in result) {
          UserModel userModel = UserModel.fromJson(map);

          fname = '[${userModel.ser}] ${userModel.fname} ${userModel.lname}';
        }
      }
    } catch (e) {}

////////////------------------------------------------------------>

    String url_2 =
        '${MyConstant().domain}/GC_tenantlookAS.php?isAdd=true&ren=$ren&ciddoc=$ciddoc&qutser=$qutser';
    try {
      var response = await http.get(Uri.parse(url_2));

      var result = json.decode(response.body);
      //print(result);
      if (result != null) {
        for (var map in result) {
          TeNantModel teNantModel = TeNantModel.fromJson(map);
          // teNantModels.add(teNantModel);
          Form_nameshop = teNantModel.sname.toString();
          Form_typeshop = teNantModel.stype.toString();
          Form_bussshop = teNantModel.cname.toString();
          Form_bussscontact = teNantModel.attn.toString();
          Form_address = teNantModel.addr.toString();
          Form_tel = teNantModel.tel.toString();
          Form_email = teNantModel.email.toString();
          Form_tax = teNantModel.tax == null ? "-" : teNantModel.tax.toString();
          Form_area = teNantModel.area.toString();
          Form_ln = teNantModel.area_c.toString();
          Form_sdate = DateFormat('dd-MM-yyyy')
              .format(DateTime.parse('${teNantModel.sdate} 00:00:00'))
              .toString();
          Form_ldate = DateFormat('dd-MM-yyyy')
              .format(DateTime.parse('${teNantModel.ldate} 00:00:00'))
              .toString();
          Form_period = teNantModel.period.toString();
          Form_rtname = teNantModel.rtname.toString();
          Form_docno = teNantModel.docno.toString();
          Form_zn = teNantModel.zn.toString();
          Form_aser = teNantModel.aser.toString();
          Form_qty = teNantModel.qty.toString();
          Form_custno = teNantModel.custno_1.toString();
        }
      }
    } catch (e) {}

///////////////////----------------------------------------->
    String url_3 =
        '${MyConstant().domain}/GC_bill_invoice_hislist.php?isAdd=true&ren=$ren&ciddoc=$docno_inv&qutser=$qutser';
    try {
      var response = await http.get(Uri.parse(url_3));

      var result = json.decode(response.body);
      print(result);
      if (result.toString() != 'null') {
        for (var map in result) {
          TransHisDisInvModel _TransHisDisInvModel =
              TransHisDisInvModel.fromJson(map);

          var sum_pvatx = double.parse(_TransHisDisInvModel.pvat!);
          var sum_vatx = double.parse(_TransHisDisInvModel.vat!);
          var sum_whtx = double.parse(_TransHisDisInvModel.wht!);
          var sum_amtx = double.parse(_TransHisDisInvModel.total!);
          var sum_disx = double.parse(_TransHisDisInvModel.dis!);
          sum_pvat = sum_pvat + sum_pvatx;
          sum_vat = sum_vat + sum_vatx;
          sum_wht = sum_wht + sum_whtx;
          sum_amt = sum_amt + sum_amtx;

          sum_tran_dis = sum_tran_dis + sum_disx;
          _TransHisDisInvModels.add(_TransHisDisInvModel);
        }
      }
    } catch (e) {}

///////////////////----------------------------------------->
    String url_4 =
        '${MyConstant().domain}/GC_bill_invoice_history.php?isAdd=true&ren=$ren&docnoin=$inv_num';
    try {
      var response = await http.get(Uri.parse(url_4));

      var result = json.decode(response.body);
      //  print(result);
      if (result.toString() != 'null') {
        for (var map in result) {
          InvoiceHistoryModel _InvoiceHistoryModel =
              InvoiceHistoryModel.fromJson(map);

          var sum_amtx = double.parse(_InvoiceHistoryModel.total_t!);
          var sum_disamtx = double.parse(_InvoiceHistoryModel.disendbill!);

          sum_amt = sum_amt + sum_amtx;
          sum_disamt = sum_disamtx;
        }
      }
    } catch (e) {}
    double sum_total = (sum_amt - sum_disamt);
//////-------------------------------------->
    final tableData003 = [
      for (int index = 0; index < _TransHisDisInvModels.length; index++)
        [
          '${index + 1}',

          ///---0
          '${_TransHisDisInvModels[index].docno}',

          ///---1
          '${_TransHisDisInvModels[index].name}',

          ///---2

          '${nFormat.format((_TransHisDisInvModels[index].amt == null) ? 0.00 : double.parse(_TransHisDisInvModels[index].amt!))}',

          ///---3
          '${nFormat.format((_TransHisDisInvModels[index].vat == null) ? 0.00 : double.parse(_TransHisDisInvModels[index].vat!))}',

          ///---4
          '${nFormat.format((_TransHisDisInvModels[index].wht == null) ? 0.00 : double.parse(_TransHisDisInvModels[index].wht!))}',

          ///---5
          '${nFormat.format((_TransHisDisInvModels[index].total == null) ? 0.00 : double.parse(_TransHisDisInvModels[index].total!))}',

          ///---6
        ],
    ];

///////////////--------------------------------------------------->

    Future.delayed(Duration(milliseconds: 500), () async {
      if (tem_page_ser.toString() == '0' || tem_page_ser == null) {
        Pdfgen_Reduce_debt_TP3.exportPDF_Reduce_debt_TP3(
            TitleType_Default_Receipt_Name,
            context,
            foder,
            renTal_name,
            bill_addr,
            bill_email,
            bill_tel,
            bill_tax,
            bill_name,
            newValuePDFimg,
            Form_nameshop,
            Form_bussscontact,
            Form_address,
            Form_tax,
            Form_custno,
            ciddoc,
            Form_zn,
            Form_ln,
            fname,
            tableData003,
            _TransHisDisInvModels,
            inv_num,
            docno_inv,
            Datex_invoice,
            amt_inv,
            vat_inv,
            wht_inv,
            nwht_inv,
            nvat_inv,
            sum_total);
      } else if (tem_page_ser.toString() == '1') {
        Pdfgen_Reduce_debt_TP4.exportPDF_Reduce_debt_TP4(
            TitleType_Default_Receipt_Name,
            context,
            foder,
            renTal_name,
            bill_addr,
            bill_email,
            bill_tel,
            bill_tax,
            bill_name,
            newValuePDFimg,
            Form_nameshop,
            Form_bussscontact,
            Form_address,
            Form_tax,
            Form_custno,
            ciddoc,
            Form_zn,
            Form_ln,
            fname,
            tableData003,
            _TransHisDisInvModels,
            inv_num,
            docno_inv,
            Datex_invoice,
            amt_inv,
            vat_inv,
            wht_inv,
            nwht_inv,
            nvat_inv,
            sum_total);
      } else if (tem_page_ser.toString() == '2') {
        Pdfgen_Reduce_debt_TP7.exportPDF_Reduce_debt_TP7(
            TitleType_Default_Receipt_Name,
            context,
            foder,
            renTal_name,
            bill_addr,
            bill_email,
            bill_tel,
            bill_tax,
            bill_name,
            newValuePDFimg,
            Form_nameshop,
            Form_bussscontact,
            Form_address,
            Form_tax,
            Form_custno,
            ciddoc,
            Form_zn,
            Form_ln,
            fname,
            tableData003,
            _TransHisDisInvModels,
            inv_num,
            docno_inv,
            Datex_invoice,
            amt_inv,
            vat_inv,
            wht_inv,
            nwht_inv,
            nvat_inv,
            sum_total);
      } else if (tem_page_ser.toString() == '3') {
        if (rtser.toString() == '72' ||
            rtser.toString() == '92' ||
            rtser.toString() == '93' ||
            rtser.toString() == '94') {
          Pdfgen_Reduce_debt_TP8.exportPDF_Reduce_debt_TP8(
              TitleType_Default_Receipt_Name,
              context,
              foder,
              renTal_name,
              bill_addr,
              bill_email,
              bill_tel,
              bill_tax,
              bill_name,
              newValuePDFimg,
              Form_nameshop,
              Form_bussscontact,
              Form_address,
              Form_tax,
              Form_custno,
              ciddoc,
              Form_zn,
              Form_ln,
              fname,
              tableData003,
              _TransHisDisInvModels,
              inv_num,
              docno_inv,
              Datex_invoice,
              amt_inv,
              vat_inv,
              wht_inv,
              nwht_inv,
              nvat_inv,
              sum_total);
        } else {
          Pdfgen_Reduce_debt_TP8.exportPDF_Reduce_debt_TP8(
              TitleType_Default_Receipt_Name,
              context,
              foder,
              renTal_name,
              bill_addr,
              bill_email,
              bill_tel,
              bill_tax,
              bill_name,
              newValuePDFimg,
              Form_nameshop,
              Form_bussscontact,
              Form_address,
              Form_tax,
              Form_custno,
              ciddoc,
              Form_zn,
              Form_ln,
              fname,
              tableData003,
              _TransHisDisInvModels,
              inv_num,
              docno_inv,
              Datex_invoice,
              amt_inv,
              vat_inv,
              wht_inv,
              nwht_inv,
              nvat_inv,
              sum_total);
        }
      }
    });
  }
}
