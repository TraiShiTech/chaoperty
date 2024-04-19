import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../Constant/Myconstant.dart';
import '../Model/GetFinnancetrans_Model.dart';
import '../Model/GetUser_Model.dart';
import '../Model/Read_DataONBill_PDF_Model.dart';
import '../Model/trans_re_bill_history_model.dart';
import '../PDF/PDF_Receipt/pdf_AC_his_statusbill.dart';
import '../PDF_TP2/PDF_Receipt_TP2/pdf_AC_his_statusbill_TP2.dart';
import '../PDF_TP3/PDF_Receipt_TP3/pdf_AC_his_statusbill_TP3.dart';
import '../PDF_TP4/PDF_Receipt_TP4/pdf_AC_his_statusbill_TP4.dart';
import '../PDF_TP5/PDF_Receipt_TP5/pdf_AC_his_statusbill_TP5.dart';
import '../PDF_TP6/PDF_Receipt_TP6/pdf_AC_his_statusbill_TP6.dart';
import '../PDF_TP7/PDF_Receipt_TP7/pdf_AC_his_statusbill_TP7.dart';
import '../PDF_TP8/PDF_Receipt_TP8/pdf_AC_his_statusbill_TP8.dart';
import '../PDF_TP8_Ortorkor/PDF_Receipt_TP8_Ortorkor/pdf_AC_his_statusbill_TP8.dart';

class ManPay_Receipt_PDF {
  // --------------------------------> PDF หลังรับชำระ และ ประวัติบิล
  static void ManPayReceipt_PDF(
      docno, ////----->เลขที่รับชำระ
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
      TitleType_Default_Receipt_Name, //->หัวบิล [ต้นฉับับ  สำเนา ไม่ระบุ]

      tem_page_ser,

      ///----->ser เทมเพลต
      bills_name) async {
    var nFormat = NumberFormat("#,##0.00", "en_US");
    List<FinnancetransModel> finnancetransModels = [];
    List<TransReBillHistoryModel> _TransReBillHistoryModels = [];
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    var rtser = preferences.getString('renTalSer');
    var user = preferences.getString('ser');
    var fname;
    var email = preferences.getString('email');
    var ciddoc = '';
    var qutser = '';
    var docnoin = docno;
    var pdate;
    String? Cust_no, Ln_s, Zone_s;
    double sum_pvat = 0.00,
        sum_vat = 0.00,
        sum_wht = 0.00,
        sum_amt = 0.00,
        sum_dis = 0.00,
        sum_disamt = 0.00,
        sum_disp = 0,
        dis_sum_Matjum = 0.00,
        dis_sum_Pakan = 0.00,
        sum_fee = 0.00;
    String numinvoice = '';
    String numdoctax = '';
    List<String> ref_invoice = [];
    String com_ment = '';
    var scname_, cname_, addr_, tax_, tel_, email_, stype_, type_, ser_user;
    var docno_,
        doctax_,
        cid_,
        datex_,
        znn_,
        daterec_,
        dateacc_,
        expname_,
        room_number_,
        date_Transaction,
        date_pay,
        Howto_LockJonPay;
    print('$docno ///  $docnoin docnoindocnoin');

/////////////////////------------------------->
    String url_1 =
        '${MyConstant().domain}/GC_Data_OnBill_PDF.php?isAdd=true&ren=$ren&ciddoc=$docnoin';
    try {
      var response = await http.get(Uri.parse(url_1));
      var result = json.decode(response.body);

      if (result.toString() != 'null') {
        print('GC_Data_OnBill_PDF>>>> $result');
        for (var map in result) {
          Read_DataONBill_PDFModel readDataONBillPDFModels =
              Read_DataONBill_PDFModel.fromJson(map);

          scname_ = (readDataONBillPDFModels.scname == null ||
                  readDataONBillPDFModels.scname.toString() == '' ||
                  readDataONBillPDFModels.scname == '')
              ? readDataONBillPDFModels.remark
              : readDataONBillPDFModels.scname;
          cname_ = readDataONBillPDFModels.cname;
          addr_ = readDataONBillPDFModels.addr1;
          tax_ = readDataONBillPDFModels.tax;
          tel_ = readDataONBillPDFModels.tel;
          email_ = readDataONBillPDFModels.email;
          stype_ = readDataONBillPDFModels.stype;
          type_ = readDataONBillPDFModels.type;
          Zone_s = (readDataONBillPDFModels.zn == null)
              ? readDataONBillPDFModels.znn
              : readDataONBillPDFModels.zn;
          Ln_s = (readDataONBillPDFModels.ln == null)
              ? readDataONBillPDFModels.room_number
              : readDataONBillPDFModels.ln;
          ser_user = readDataONBillPDFModels.user;
          docno_ = readDataONBillPDFModels.docno;
          doctax_ = readDataONBillPDFModels.doctax!;
          cid_ = readDataONBillPDFModels.cid;
          daterec_ = readDataONBillPDFModels.daterec;
          dateacc_ = readDataONBillPDFModels.dateacc;
          room_number_ = readDataONBillPDFModels.room_number;
          date_Transaction = readDataONBillPDFModels.daterec;
          date_pay = readDataONBillPDFModels.pdate;
          Howto_LockJonPay = readDataONBillPDFModels.room_number;
          Cust_no = readDataONBillPDFModels.custno;
          print(
              'GC_Data_OnBill_PDF //dateaccdateaccdateaccdateacc ::  ${readDataONBillPDFModels.dateacc!}_');
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
        print('GC_Data_OnBill_PDF>>>> $result');
        for (var map in result) {
          UserModel userModel = UserModel.fromJson(map);

          fname = '[${userModel.ser}] ${userModel.fname} ${userModel.lname}';
        }
      }
    } catch (e) {}

    print('$scname_ $cname_ $addr_');
//////////////////////-------------------------------------------->
    String url =
        '${MyConstant().domain}/GC_bill_pay_amt.php?isAdd=true&ren=$ren&ciddoc=$ciddoc&docnoin=$docnoin';
    try {
      var response = await http.get(Uri.parse(url));
      var result = json.decode(response.body);

      ///  print('BBBBBBBBBBBBBBBB>>>> $result');
      if (result.toString() != 'null') {
        for (var map in result) {
          FinnancetransModel finnancetransModel =
              FinnancetransModel.fromJson(map);

          var sidamt = double.parse(finnancetransModel.amt!);
          var siddisper = double.parse(finnancetransModel.disper!);
          var pdatex = finnancetransModel.pdate;
          com_ment = finnancetransModel.descr!;
          if (int.parse(finnancetransModel.receiptSer!) != 0) {
            finnancetransModels.add(finnancetransModel);
            pdate = pdatex;
          } else {
            if (finnancetransModel.type!.trim() == 'DISCOUNT') {
              sum_disamt = sidamt;
              sum_disp = siddisper;
            }
          }
          if (finnancetransModel.dtype! == 'MM') {
            dis_sum_Matjum =
                dis_sum_Matjum + double.parse(finnancetransModel.amt!);
          }
          if (finnancetransModel.dtype! == 'KF') {
            dis_sum_Pakan =
                dis_sum_Pakan + double.parse(finnancetransModel.amt!);
          }
          if (finnancetransModel.dtype! == 'FTA') {
            sum_fee = sum_fee + double.parse(finnancetransModel.amt!);
          }
          print(
              '>>>>> ${finnancetransModel.slip}>>>>>>dd>>> in $sidamt $siddisper  ');
        }
        FinnancetransModel itemToMove =
            finnancetransModels.firstWhere((model) => model.remark != '');

// Remove the item from the list
        finnancetransModels.remove(itemToMove);

// Add the item to the bottom of the list
        finnancetransModels.add(itemToMove);
      }
    } catch (e) {}
//////////////////////-------------------------------------------->

    if (_TransReBillHistoryModels.length != 0) {
      _TransReBillHistoryModels.clear();
      sum_pvat = 0;
      sum_vat = 0;
      sum_wht = 0;
      sum_amt = 0;
    }

    String url2 =
        '${MyConstant().domain}/GC_bill_pay_history.php?isAdd=true&ren=$ren&user=$user&ciddoc=$ciddoc&docnoin=$docnoin';
    try {
      var response = await http.get(Uri.parse(url2));

      var result = json.decode(response.body);
      //print(result);
      if (result.toString() != 'null') {
        for (var map in result) {
          TransReBillHistoryModel _TransReBillHistoryModel =
              TransReBillHistoryModel.fromJson(map);
          var dtypeinvoiceent = _TransReBillHistoryModel.dtype;
          var numinvoiceent = _TransReBillHistoryModel.docno;
          var expser_voiceent = _TransReBillHistoryModel.expser;

          var sum_pvatx = dtypeinvoiceent == 'KP' || dtypeinvoiceent == '!Z'
              ? double.parse(_TransReBillHistoryModel.pvat!)
              : 0.0;
          var sum_vatx = dtypeinvoiceent == 'KP' || dtypeinvoiceent == '!Z'
              ? double.parse(_TransReBillHistoryModel.vat!)
              : 0.0;
          var sum_whtx = dtypeinvoiceent == 'KP' || dtypeinvoiceent == '!Z'
              ? double.parse(_TransReBillHistoryModel.wht!)
              : 0.0;
          var sum_amtx = dtypeinvoiceent == 'KP' || dtypeinvoiceent == '!Z'
              ? double.parse(_TransReBillHistoryModel.total!)
              : 0.0;

          if (dtypeinvoiceent == 'KP') {
            sum_pvat = sum_pvat + sum_pvatx;
            sum_vat = sum_vat + sum_vatx;
            sum_wht = sum_wht + sum_whtx;
            sum_amt = sum_amt + sum_amtx;
            // sum_disamt = sum_disamtx;
            // sum_disp = sum_dispx;
            numinvoice = _TransReBillHistoryModel.docno!;
            numdoctax = _TransReBillHistoryModel.doctax!;
            ref_invoice.add(_TransReBillHistoryModel.inv!);
            _TransReBillHistoryModels.add(_TransReBillHistoryModel);
          } else if (dtypeinvoiceent == '!Z') {
            sum_pvat = sum_pvat + sum_pvatx;
            sum_vat = sum_vat + sum_vatx;
            sum_wht = sum_wht + sum_whtx;
            sum_amt = sum_amt + sum_amtx;
            // sum_disamt = sum_disamtx;
            // sum_disp = sum_dispx;
            // numinvoice = _TransReBillHistoryModel.docno;
            // numdoctax = _TransReBillHistoryModel.doctax;
            _TransReBillHistoryModels.add(_TransReBillHistoryModel);
          } else {
            // total_amt = total_amt + total_amtx;
            _TransReBillHistoryModels.add(_TransReBillHistoryModel);
          }
        }
      }
    } catch (e) {}

    /////////////////------------------------------------------>

    int count_inv = _TransReBillHistoryModels.where((element) =>
        element.count_inv != '0' || element.count_inv == '0.00').length;

    int sum_fine = _TransReBillHistoryModels.where(
        (element) => element.fine == '1' || element.fine == '1.00').length;
    /////////////////------------------------------------------>

    final tableData00 = (count_inv != 0)
        ? [
            for (int index = 0;
                index < _TransReBillHistoryModels.length;
                index++)
              [
                '${_TransReBillHistoryModels[index].unitser}',

                ///---0
                '${_TransReBillHistoryModels[index].date}',

                ///---1
                (_TransReBillHistoryModels[index].fine.toString() == '1.00' &&
                        _TransReBillHistoryModels[index]
                                .expname
                                .toString()
                                .trim() ==
                            'null')
                    ? 'ค่าปรับ [${_TransReBillHistoryModels[index].inv}]'
                    : '${_TransReBillHistoryModels[index].expname.toString().trim()}',

                ///---2
                '${nFormat.format((_TransReBillHistoryModels[index].vat == null) ? 0.00 : double.parse(_TransReBillHistoryModels[index].vat!))}',

                ///---3
                '${nFormat.format((_TransReBillHistoryModels[index].wht == null) ? 0.00 : double.parse(_TransReBillHistoryModels[index].wht!))}',

                ///---4
                '${nFormat.format((_TransReBillHistoryModels[index].amt == null) ? 0.00 : double.parse(_TransReBillHistoryModels[index].pvat!))}',

                ///---5
                '${nFormat.format((_TransReBillHistoryModels[index].total == null) ? 0.00 : double.parse(_TransReBillHistoryModels[index].total!))}',

                ///---6
                '${nFormat.format((_TransReBillHistoryModels[index].pri == null) ? 0.00 : double.parse(_TransReBillHistoryModels[index].pri!))}',

                ///---7
                '${_TransReBillHistoryModels[index].ovalue}',

                ///---8
                '${_TransReBillHistoryModels[index].nvalue}',

                ///---9
                '${nFormat.format((_TransReBillHistoryModels[index].qty == null) ? 0.00 : double.parse(_TransReBillHistoryModels[index].qty!))}',

                ///---10
                (_TransReBillHistoryModels[index].fine.toString() == '1.00' &&
                        _TransReBillHistoryModels[index]
                                .refno
                                .toString()
                                .trim() ==
                            'null')
                    ? '-'
                    : '${_TransReBillHistoryModels[index].refno}',

                ///---11

                '${nFormat.format((_TransReBillHistoryModels[index].dis == null) ? 0.00 : double.parse(_TransReBillHistoryModels[index].dis!))}',

                ///---12
                (_TransReBillHistoryModels[index].total == null)
                    ? '${nFormat.format(0.00 - ((_TransReBillHistoryModels[index].dis == null) ? 0.00 : double.parse(_TransReBillHistoryModels[index].dis!)))}'
                    : '${nFormat.format(double.parse(_TransReBillHistoryModels[index].total!) - ((_TransReBillHistoryModels[index].dis == null) ? 0.00 : double.parse(_TransReBillHistoryModels[index].dis!)))}'

                ///---13
              ]
          ]
        : [
            for (int index = 0;
                index < _TransReBillHistoryModels.length;
                index++)
              if (_TransReBillHistoryModels[index].fine.toString() != '1.00')
                // if (_TransReBillHistoryModels[index].fine.toString() != '1.00' &&
                //     _TransReBillHistoryModels[index].expser.toString().trim() != '0')
                [
                  '${_TransReBillHistoryModels[index].unitser}',

                  ///---0
                  '${_TransReBillHistoryModels[index].date}',

                  ///---1
                  '${_TransReBillHistoryModels[index].expname.toString().trim()}',

                  ///---2
                  '${nFormat.format((_TransReBillHistoryModels[index].vat == null) ? 0.00 : double.parse(_TransReBillHistoryModels[index].vat!))}',

                  ///---3
                  '${nFormat.format((_TransReBillHistoryModels[index].wht == null) ? 0.00 : double.parse(_TransReBillHistoryModels[index].wht!))}',

                  ///---4
                  '${nFormat.format((_TransReBillHistoryModels[index].amt == null) ? 0.00 : double.parse(_TransReBillHistoryModels[index].pvat!))}',

                  ///---5
                  '${nFormat.format((_TransReBillHistoryModels[index].total == null) ? 0.00 : double.parse(_TransReBillHistoryModels[index].total!))}',

                  ///---6
                  '${nFormat.format((_TransReBillHistoryModels[index].pri == null) ? 0.00 : double.parse(_TransReBillHistoryModels[index].pri!))}',

                  ///---7
                  '${_TransReBillHistoryModels[index].ovalue}',

                  ///---8
                  '${_TransReBillHistoryModels[index].nvalue}',

                  ///---9
                  '${nFormat.format((_TransReBillHistoryModels[index].qty == null) ? 0.00 : double.parse(_TransReBillHistoryModels[index].qty!))}',

                  ///---10
                  '${_TransReBillHistoryModels[index].refno}',

                  ///---11

                  '${nFormat.format((_TransReBillHistoryModels[index].dis == null) ? 0.00 : double.parse(_TransReBillHistoryModels[index].dis!))}',

                  ///---12
                  (_TransReBillHistoryModels[index].total == null)
                      ? '${nFormat.format(0.00 - ((_TransReBillHistoryModels[index].dis == null) ? 0.00 : double.parse(_TransReBillHistoryModels[index].dis!)))}'
                      : '${nFormat.format(double.parse(_TransReBillHistoryModels[index].total!) - ((_TransReBillHistoryModels[index].dis == null) ? 0.00 : double.parse(_TransReBillHistoryModels[index].dis!)))}'

                  ///---13
                ],
          ];
    final tableData01 = [];

    if (sum_fine != 0 && count_inv == 0) {
      tableData01.add(
        [
          '${_TransReBillHistoryModels.where((model) => model.fine == '1' || model.fine == '1.00').map((model) => model.unitser.toString()).first}',

          ///---0
          '${_TransReBillHistoryModels.where((model) => model.fine == '1' || model.fine == '1.00').map((model) => model.date.toString()).first}',

          ///---1
          'ค่าปรับ',

          ///---2
          '${nFormat.format(_TransReBillHistoryModels.where((model) => model.fine == '1' || model.fine == '1.00').map((model) => double.parse(model.vat ?? '0.00')).fold(0.0, (previousValue, element) => previousValue + element))}',

          ///---3
          '${nFormat.format(_TransReBillHistoryModels.where((model) => model.fine == '1' || model.fine == '1.00').map((model) => double.parse(model.wht ?? '0.00')).fold(0.0, (previousValue, element) => previousValue + element))}',

          ///---4
          '${nFormat.format(_TransReBillHistoryModels.where((model) => model.fine == '1' || model.fine == '1.00').map((model) => double.parse(model.wht ?? '0.00')).fold(0.0, (previousValue, element) => previousValue + element))}',

          ///---5
          '${nFormat.format(_TransReBillHistoryModels.where((model) => model.fine == '1' || model.fine == '1.00').map((model) => double.parse(model.total ?? '0.00')).fold(0.0, (previousValue, element) => previousValue + element))}',

          ///---6
          '${nFormat.format(_TransReBillHistoryModels.where((model) => model.fine == '1' || model.fine == '1.00').map((model) => double.parse(model.pri ?? '0.00')).fold(0.0, (previousValue, element) => previousValue + element))}',

          ///---7
          '${_TransReBillHistoryModels.where((model) => model.fine == '1' || model.fine == '1.00').map((model) => model.ovalue.toString()).first}',

          ///---8
          '${_TransReBillHistoryModels.where((model) => model.fine == '1' || model.fine == '1.00').map((model) => model.nvalue.toString()).first}',

          ///---9

          '${nFormat.format(_TransReBillHistoryModels.where((model) => model.fine == '1' || model.fine == '1.00').map((model) => double.parse(model.qty ?? '0.00')).fold(0.0, (previousValue, element) => previousValue + element))}',

          ///---10
          '${_TransReBillHistoryModels.where((model) => model.fine == '1' || model.fine == '1.00').map((model) => model.refno.toString()).first}',

          ///---11
        ],
      );
    }

    // double Fine_ = double.parse(
    //     '${_TransReBillHistoryModels.where((model) => model.fine == '1' || model.fine == '1.00').map((model) => double.parse(model.total ?? '0.00')).fold(0.0, (previousValue, element) => previousValue + element)}');
    print(
        '${finnancetransModels.length}///${dis_sum_Matjum}  // ${sum_amt} //${_TransReBillHistoryModels.length}////$docnoin  ****date_pay : $date_pay ');

    Future.delayed(Duration(milliseconds: 500), () async {
      if (tem_page_ser.toString() == '0' || tem_page_ser == null) {
        Pdfgen_his_statusbill_TP3.exportPDF_statusbill_TP3(
            Cust_no,
            cid_,
            Zone_s,
            Ln_s,
            foder,
            tableData00,
            tableData01,
            context,
            _TransReBillHistoryModels,
            'Num_cid',
            'Namenew',
            '${sum_pvat}',
            sum_vat,
            sum_wht,
            sum_amt,
            sum_disp,
            sum_disamt,
            '${(sum_amt - sum_disamt)}',
            renTal_name,
            scname_,
            cname_,
            addr_,
            tax_,
            bill_addr,
            bill_email,
            bill_tel,
            bill_tax,
            bill_name,
            newValuePDFimg,
            numinvoice,
            numdoctax,
            ref_invoice,
            finnancetransModels,
            date_Transaction,
            date_pay,
            Howto_LockJonPay,
            dis_sum_Matjum,
            TitleType_Default_Receipt_Name,
            dis_sum_Pakan,
            sum_fee,
            com_ment);
      } else if (tem_page_ser.toString() == '1') {
        Pdfgen_his_statusbill_TP4.exportPDF_statusbill_TP4(
            Cust_no,
            cid_,
            Zone_s,
            Ln_s,
            fname,
            foder,
            tableData00,
            tableData01,
            context,
            _TransReBillHistoryModels,
            'Num_cid',
            'Namenew',
            '${sum_pvat}',
            sum_vat,
            sum_wht,
            sum_amt,
            sum_disp,
            sum_disamt,
            '${(sum_amt - sum_disamt)}',
            renTal_name,
            scname_,
            cname_,
            addr_,
            tax_,
            bill_addr,
            bill_email,
            bill_tel,
            bill_tax,
            bill_name,
            newValuePDFimg,
            numinvoice,
            numdoctax,
            ref_invoice,
            finnancetransModels,
            date_Transaction,
            date_pay,
            Howto_LockJonPay,
            dis_sum_Matjum,
            TitleType_Default_Receipt_Name,
            dis_sum_Pakan,
            sum_fee,
            com_ment);
      } else if (tem_page_ser.toString() == '2') {
        Pdfgen_his_statusbill_TP7.exportPDF_statusbill_TP7(
            Cust_no,
            cid_,
            Zone_s,
            Ln_s,
            fname,
            foder,
            tableData00,
            tableData01,
            context,
            _TransReBillHistoryModels,
            'Num_cid',
            'Namenew',
            '${sum_pvat}',
            sum_vat,
            sum_wht,
            sum_amt,
            sum_disp,
            sum_disamt,
            '${(sum_amt - sum_disamt)}',
            renTal_name,
            scname_,
            cname_,
            addr_,
            tax_,
            bill_addr,
            bill_email,
            bill_tel,
            bill_tax,
            bill_name,
            newValuePDFimg,
            numinvoice,
            numdoctax,
            ref_invoice,
            finnancetransModels,
            date_Transaction,
            date_pay,
            Howto_LockJonPay,
            dis_sum_Matjum,
            TitleType_Default_Receipt_Name,
            dis_sum_Pakan,
            sum_fee,
            com_ment);
      } else if (tem_page_ser.toString() == '3') {
        if (rtser.toString() == '72' ||
            rtser.toString() == '92' ||
            rtser.toString() == '93' ||
            rtser.toString() == '94') {
          Pdfgen_his_statusbill_TP8_Ortorkor.exportPDF_statusbill_TP8_Ortorkor(
              Cust_no,
              cid_,
              Zone_s,
              Ln_s,
              fname,
              foder,
              tableData00,
              tableData01,
              context,
              _TransReBillHistoryModels,
              'Num_cid',
              'Namenew',
              '${sum_pvat}',
              sum_vat,
              sum_wht,
              sum_amt,
              sum_disp,
              sum_disamt,
              '${(sum_amt - sum_disamt)}',
              renTal_name,
              scname_,
              cname_,
              addr_,
              tax_,
              bill_addr,
              bill_email,
              bill_tel,
              bill_tax,
              bill_name,
              newValuePDFimg,
              numinvoice,
              numdoctax,
              ref_invoice,
              finnancetransModels,
              date_Transaction,
              date_pay,
              Howto_LockJonPay,
              dis_sum_Matjum,
              TitleType_Default_Receipt_Name,
              dis_sum_Pakan,
              sum_fee,
              com_ment);
        } else {
          Pdfgen_his_statusbill_TP8.exportPDF_statusbill_TP8(
              Cust_no,
              cid_,
              Zone_s,
              Ln_s,
              fname,
              foder,
              tableData00,
              tableData01,
              context,
              _TransReBillHistoryModels,
              'Num_cid',
              'Namenew',
              '${sum_pvat}',
              sum_vat,
              sum_wht,
              sum_amt,
              sum_disp,
              sum_disamt,
              '${(sum_amt - sum_disamt)}',
              renTal_name,
              scname_,
              cname_,
              addr_,
              tax_,
              bill_addr,
              bill_email,
              bill_tel,
              bill_tax,
              bill_name,
              newValuePDFimg,
              numinvoice,
              numdoctax,
              ref_invoice,
              finnancetransModels,
              date_Transaction,
              date_pay,
              Howto_LockJonPay,
              dis_sum_Matjum,
              TitleType_Default_Receipt_Name,
              dis_sum_Pakan,
              sum_fee,
              com_ment);
        }
      }
    });

    // Future.delayed(Duration(milliseconds: 500), () async {
    //   if (tem_page_ser.toString() == '0' || tem_page_ser == null) {
    //     Pdfgen_his_statusbill.exportPDF_statusbill(
    //         foder,
    //         tableData00,
    //         tableData01,
    //         context,
    //         _TransReBillHistoryModels,
    //         'Num_cid',
    //         'Namenew',
    //         '${sum_pvat}',
    //         sum_vat,
    //         sum_wht,
    //         sum_amt,
    //         sum_disp,
    //         sum_disamt,
    //         '${(sum_amt - sum_disamt)}',
    //         renTal_name,
    //         scname_,
    //         cname_,
    //         addr_,
    //         tax_,
    //         bill_addr,
    //         bill_email,
    //         bill_tel,
    //         bill_tax,
    //         bill_name,
    //         newValuePDFimg,
    //         numinvoice,
    //         numdoctax,
    //         finnancetransModels,
    //         date_Transaction,
    //         date_pay,
    //         Howto_LockJonPay,
    //         dis_sum_Matjum,
    //         TitleType_Default_Receipt_Name);
    //   } else if (tem_page_ser.toString() == '1') {
    //     Pdfgen_his_statusbill_TP2.exportPDF_statusbill_TP2(
    //         foder,
    //         tableData00,
    //         tableData01,
    //         context,
    //         _TransReBillHistoryModels,
    //         'Num_cid',
    //         'Namenew',
    //         '${sum_pvat}',
    //         sum_vat,
    //         sum_wht,
    //         sum_amt,
    //         sum_disp,
    //         sum_disamt,
    //         '${(sum_amt - sum_disamt)}',
    //         renTal_name,
    //         scname_,
    //         cname_,
    //         addr_,
    //         tax_,
    //         bill_addr,
    //         bill_email,
    //         bill_tel,
    //         bill_tax,
    //         bill_name,
    //         newValuePDFimg,
    //         // numdoctax == '' ? '$numinvoice' : '$numdoctax',
    //         numinvoice,
    //         numdoctax,
    //         finnancetransModels,
    //         date_Transaction,
    //         date_pay,
    //         Howto_LockJonPay,
    //         dis_sum_Matjum,
    //         TitleType_Default_Receipt_Name);
    //   } else if (tem_page_ser.toString() == '2') {
    //     Pdfgen_his_statusbill_TP3.exportPDF_statusbill_TP3(
    //         foder,
    //         tableData00,
    //         tableData01,
    //         context,
    //         _TransReBillHistoryModels,
    //         'Num_cid',
    //         'Namenew',
    //         '${sum_pvat}',
    //         sum_vat,
    //         sum_wht,
    //         sum_amt,
    //         sum_disp,
    //         sum_disamt,
    //         '${(sum_amt - sum_disamt)}',
    //         renTal_name,
    //         scname_,
    //         cname_,
    //         addr_,
    //         tax_,
    //         bill_addr,
    //         bill_email,
    //         bill_tel,
    //         bill_tax,
    //         bill_name,
    //         newValuePDFimg,
    //         numinvoice,
    //         numdoctax,
    //         finnancetransModels,
    //         date_Transaction,
    //         date_pay,
    //         Howto_LockJonPay,
    //         dis_sum_Matjum,
    //         TitleType_Default_Receipt_Name);
    //   } else if (tem_page_ser.toString() == '3') {
    //     Pdfgen_his_statusbill_TP4.exportPDF_statusbill_TP4(
    //         foder,
    //         tableData00,
    //         tableData01,
    //         context,
    //         _TransReBillHistoryModels,
    //         'Num_cid',
    //         'Namenew',
    //         '${sum_pvat}',
    //         sum_vat,
    //         sum_wht,
    //         sum_amt,
    //         sum_disp,
    //         sum_disamt,
    //         '${(sum_amt - sum_disamt)}',
    //         renTal_name,
    //         scname_,
    //         cname_,
    //         addr_,
    //         tax_,
    //         bill_addr,
    //         bill_email,
    //         bill_tel,
    //         bill_tax,
    //         bill_name,
    //         newValuePDFimg,
    //         numinvoice,
    //         numdoctax,
    //         finnancetransModels,
    //         date_Transaction,
    //         date_pay,
    //         Howto_LockJonPay,
    //         dis_sum_Matjum,
    //         TitleType_Default_Receipt_Name);
    //   } else if (tem_page_ser.toString() == '4') {
    //     Pdfgen_his_statusbill_TP5.exportPDF_statusbill_TP5(
    //         foder,
    //         tableData00,
    //         tableData01,
    //         context,
    //         _TransReBillHistoryModels,
    //         'Num_cid',
    //         'Namenew',
    //         '${sum_pvat}',
    //         sum_vat,
    //         sum_wht,
    //         sum_amt,
    //         sum_disp,
    //         sum_disamt,
    //         '${(sum_amt - sum_disamt)}',
    //         renTal_name,
    //         scname_,
    //         cname_,
    //         addr_,
    //         tax_,
    //         bill_addr,
    //         bill_email,
    //         bill_tel,
    //         bill_tax,
    //         bill_name,
    //         newValuePDFimg,
    //         numinvoice,
    //         numdoctax,
    //         finnancetransModels,
    //         date_Transaction,
    //         date_pay,
    //         Howto_LockJonPay,
    //         dis_sum_Matjum,
    //         TitleType_Default_Receipt_Name);
    //   } else if (tem_page_ser.toString() == '5') {
    //     Pdfgen_his_statusbill_TP6.exportPDF_statusbill_TP6(
    //         foder,
    //         tableData00,
    //         tableData01,
    //         context,
    //         _TransReBillHistoryModels,
    //         'Num_cid',
    //         'Namenew',
    //         '${sum_pvat}',
    //         sum_vat,
    //         sum_wht,
    //         sum_amt,
    //         sum_disp,
    //         sum_disamt,
    //         '${(sum_amt - sum_disamt)}',
    //         renTal_name,
    //         scname_,
    //         cname_,
    //         addr_,
    //         tax_,
    //         bill_addr,
    //         bill_email,
    //         bill_tel,
    //         bill_tax,
    //         bill_name,
    //         newValuePDFimg,
    //         numinvoice,
    //         numdoctax,
    //         finnancetransModels,
    //         date_Transaction,
    //         date_pay,
    //         Howto_LockJonPay,
    //         dis_sum_Matjum,
    //         TitleType_Default_Receipt_Name);
    //   } else if (tem_page_ser.toString() == '6') {
    //     Pdfgen_his_statusbill_TP7.exportPDF_statusbill_TP7(
    //         foder,
    //         tableData00,
    //         tableData01,
    //         context,
    //         _TransReBillHistoryModels,
    //         'Num_cid',
    //         'Namenew',
    //         '${sum_pvat}',
    //         sum_vat,
    //         sum_wht,
    //         sum_amt,
    //         sum_disp,
    //         sum_disamt,
    //         '${(sum_amt - sum_disamt)}',
    //         renTal_name,
    //         scname_,
    //         cname_,
    //         addr_,
    //         tax_,
    //         bill_addr,
    //         bill_email,
    //         bill_tel,
    //         bill_tax,
    //         bill_name,
    //         newValuePDFimg,
    //         numinvoice,
    //         numdoctax,
    //         finnancetransModels,
    //         date_Transaction,
    //         date_pay,
    //         Howto_LockJonPay,
    //         dis_sum_Matjum,
    //         TitleType_Default_Receipt_Name);
    //   } else if (tem_page_ser.toString() == '7') {
    //     if (rtser.toString() == '72' ||
    //         rtser.toString() == '92' ||
    //         rtser.toString() == '93' ||
    //         rtser.toString() == '94') {
    //       Pdfgen_his_statusbill_TP8_Ortorkor.exportPDF_statusbill_TP8_Ortorkor(
    //           Cust_no,
    //           cid_,
    //           Zone_s,
    //           Ln_s,
    //           fname,
    //           foder,
    //           tableData00,
    //           tableData01,
    //           context,
    //           _TransReBillHistoryModels,
    //           'Num_cid',
    //           'Namenew',
    //           '${sum_pvat}',
    //           sum_vat,
    //           sum_wht,
    //           sum_amt,
    //           sum_disp,
    //           sum_disamt,
    //           '${(sum_amt - sum_disamt)}',
    //           renTal_name,
    //           scname_,
    //           cname_,
    //           addr_,
    //           tax_,
    //           bill_addr,
    //           bill_email,
    //           bill_tel,
    //           bill_tax,
    //           bill_name,
    //           newValuePDFimg,
    //           numinvoice,
    //           numdoctax,
    //           finnancetransModels,
    //           date_Transaction,
    //           date_pay,
    //           Howto_LockJonPay,
    //           dis_sum_Matjum,
    //           TitleType_Default_Receipt_Name);
    //     } else {
    //       Pdfgen_his_statusbill_TP8.exportPDF_statusbill_TP8(
    //           Cust_no,
    //           cid_,
    //           Zone_s,
    //           Ln_s,
    //           fname,
    //           foder,
    //           tableData00,
    //           tableData01,
    //           context,
    //           _TransReBillHistoryModels,
    //           'Num_cid',
    //           'Namenew',
    //           '${sum_pvat}',
    //           sum_vat,
    //           sum_wht,
    //           sum_amt,
    //           sum_disp,
    //           sum_disamt,
    //           '${(sum_amt - sum_disamt)}',
    //           renTal_name,
    //           scname_,
    //           cname_,
    //           addr_,
    //           tax_,
    //           bill_addr,
    //           bill_email,
    //           bill_tel,
    //           bill_tax,
    //           bill_name,
    //           newValuePDFimg,
    //           numinvoice,
    //           numdoctax,
    //           finnancetransModels,
    //           date_Transaction,
    //           date_pay,
    //           Howto_LockJonPay,
    //           dis_sum_Matjum,
    //           TitleType_Default_Receipt_Name);
    //     }
    //   }
    // });
  }
}
