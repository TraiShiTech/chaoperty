import 'package:file_saver/file_saver.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:math' as math;
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';

import '../../Constant/Myconstant.dart';
import '../../PeopleChao/Pays_.dart';
import '../../Style/ThaiBaht.dart';

class PdfgenReceipt_PayPakan_TP3 {
  //////////---------------------------------------------------->(ใบเสร็จรับเงินคืนเงินประกัน )
  static void exportPDF_Receipt_PayPakan_TP3(
      foder,
      tableData00,
      tableData01,
      context,
      _TransReBillHistoryModels,
      Num_cid,
      Namenew,
      sum_pvat,
      sum_vat,
      sum_wht,
      Sum_SubTotal,
      sum_disp,
      sum_disamt,
      Total,
      renTal_name,
      sname,
      cname,
      addr,
      tax,
      bill_addr,
      bill_email,
      bill_tel,
      bill_tax,
      bill_name,
      newValuePDFimg,
      numinvoice,
      numdoctax,
      finnancetransModels,
      date_Transaction,
      dayfinpay,
      type_bills,
      dis_sum_Matjum,
      TitleType_Default_Receipt_Name,
      dis_sum_Pakan,
      sum_fee,
      fonts_pdf) async {
    //////--------------------------------------------->

    final pdf = pw.Document();
    final font = await rootBundle.load("${fonts_pdf}");
    var Colors_pd = PdfColors.black;
    // final font = await rootBundle.load("fonts/Sarabun-Medium.ttf");

    int pageCount = 1; // Initialize the page count
    final ttf = pw.Font.ttf(font);
    double font_Size = 10.0;
    //////--------------------------------------------->
    DateTime date = DateTime.now();
    // var formatter = new DateFormat.MMMMd('th_TH');
    // String thaiDate = formatter.format(date);
    final thaiDate = DateTime.parse(date_Transaction);
    final formatter = DateFormat('d MMMM', 'th_TH');
    final formattedDate = formatter.format(thaiDate);
    //////--------------->พ.ศ.
    DateTime dateTime = DateTime.parse(date_Transaction);
    int newYear = dateTime.year + 543;
    //////--------------------------------------------->
    var nFormat = NumberFormat("#,##0.00", "en_US");
    var nFormat2 = NumberFormat("###0.00", "en_US");
    final iconImage =
        (await rootBundle.load('images/LOGO.png')).buffer.asUint8List();
    List netImage = [];
    List netImage_QR = [];

    ///
    ///
////////////////------------------------------->
    double Total_CASH = double.parse(
      '${finnancetransModels.where((model) => model.ptser == '1' && model.dtype == 'KP').fold<double>(
            0.0,
            (double previousValue, element) =>
                previousValue +
                (element.total != null ? double.parse(element.total!) : 0),
          )}',
    );

    // '${finnancetransModels.where((model) => model.ptser == '1' && model.dtype == 'KP').map((model) => model.total).join(', ')}';
    String total_QR =
        '${nFormat.format(double.parse('${Total}') - Total_CASH)}';
    String newTotal_QR = total_QR.replaceAll(RegExp(r'[^0-9]'), '');
    for (int i = 0; i < newValuePDFimg.length; i++) {
      netImage.add(await networkImage('${newValuePDFimg[i]}'));
    }
    for (int i = 0; i < finnancetransModels.length; i++) {
      if (finnancetransModels[i].img == null ||
          finnancetransModels[i].img.toString() == '') {
        netImage_QR.add(iconImage);
      } else {
        netImage_QR.add(await networkImage(
            '${MyConstant().domain}/files/$foder/payment/${finnancetransModels[i].img}'));
      }
    }
//////////---------------------------->
    bool hasNonCashTransaction = finnancetransModels.any((transaction) {
      return transaction.type.toString() != 'CASH' &&
          transaction.type != null &&
          transaction.dtype.toString() != 'FTA';
    }); ///// เงินโอน , Online Standard QR , Online Payment
////////////////------------------------------->
    bool hasNonCashTransaction1 = finnancetransModels.any((transaction) {
      return transaction.type.toString() == 'CASH' &&
          transaction.dtype.toString() != 'FTA';
    }); ///// เงินสด
////////////////------------------------------->
    bool hasNonCashTransaction2 = finnancetransModels.any((transaction) {
      return transaction.ptser.toString() == '6' &&
          transaction.dtype.toString() != 'FTA';
    }); //Online Standard QR
////////////////------------------------------->
    bool hasNonCashTransaction3 = finnancetransModels.any((transaction) {
      return transaction.ptser.toString() == '2' &&
          transaction.dtype.toString() != 'FTA';
    }); ///// เงินโอน
////////////////------------------------------->
    bool hasNonCashTransaction4 = finnancetransModels.any((transaction) {
      return transaction.ptser.toString() == '5' &&
          transaction.dtype.toString() != 'FTA';
    }); ///// Online Payment
////////////////------------------------------->
    bool hasNonCashTransaction5 = finnancetransModels.any((transaction) {
      return transaction.dtype.toString() == 'MM';
    }); ///// Online Payment
//////////---------------------------------->
    bool hasNonCashTransaction6 = finnancetransModels.any((transaction) {
      return transaction.dtype.toString() == 'FTA';
    }); ///// Online Payment
//////////---------------------------------->

///////////////////////------------------------------------------------->210

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4.copyWith(
          marginBottom: 4.00,
          marginLeft: 8.00,
          marginRight: 8.00,
          marginTop: 8.00,
        ),
        header: (context) {
          return pw.Column(children: [
            pw.Row(
              children: [
                (netImage.isEmpty)
                    ? pw.Container(
                        height: 72,
                        width: 70,
                        decoration: const pw.BoxDecoration(
                          color: PdfColors.grey200,
                          border: pw.Border(
                            right: pw.BorderSide(color: PdfColors.grey300),
                            left: pw.BorderSide(color: PdfColors.grey300),
                            top: pw.BorderSide(color: PdfColors.grey300),
                            bottom: pw.BorderSide(color: PdfColors.grey300),
                          ),
                        ),
                        child: pw.Center(
                          child: pw.Text(
                            '$bill_name ',
                            maxLines: 1,
                            style: pw.TextStyle(
                              fontSize: 10,
                              font: ttf,
                              color: Colors_pd,
                            ),
                          ),
                        ))

                    // pw.Image(
                    //     pw.MemoryImage(iconImage),
                    //     height: 72,
                    //     width: 70,
                    //   )
                    : pw.Container(
                        height: 72,
                        width: 70,
                        decoration: const pw.BoxDecoration(
                          color: PdfColors.grey200,
                          border: pw.Border(
                            right: pw.BorderSide(color: PdfColors.grey300),
                            left: pw.BorderSide(color: PdfColors.grey300),
                            top: pw.BorderSide(color: PdfColors.grey300),
                            bottom: pw.BorderSide(color: PdfColors.grey300),
                          ),
                        ),
                        child: pw.Image(
                          (netImage[0]),
                          height: 72,
                          width: 70,
                        ),
                      ),
                pw.SizedBox(width: 1 * PdfPageFormat.mm),
                pw.Container(
                  width: 200,
                  child: pw.Column(
                    mainAxisSize: pw.MainAxisSize.min,
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        '$bill_name',
                        //'$',
                        maxLines: 2,
                        style: pw.TextStyle(
                          color: Colors_pd,
                          fontSize: font_Size,
                          // fontWeight: pw.FontWeight.bold,
                          font: ttf,
                        ),
                      ),
                      pw.Text(
                        (bill_addr == null ||
                                bill_addr.toString() == 'null' ||
                                bill_addr.toString() == '')
                            ? 'ที่อยู่ : -'
                            : 'ที่อยู่ : $bill_addr',
                        maxLines: 3,
                        style: pw.TextStyle(
                          fontSize: font_Size,
                          color: Colors_pd,
                          font: ttf,
                        ),
                      ),
                      pw.Text(
                        'โทรศัพท์ : $bill_tel',
                        textAlign: pw.TextAlign.right,
                        maxLines: 1,
                        style: pw.TextStyle(
                          fontSize: font_Size,
                          font: ttf,
                          color: Colors_pd,
                        ),
                      ),
                      pw.Text(
                        'อีเมล : $bill_email',
                        maxLines: 1,
                        textAlign: pw.TextAlign.right,
                        style: pw.TextStyle(
                          fontSize: font_Size,
                          font: ttf,
                          color: Colors_pd,
                        ),
                      ),
                      pw.Text(
                        (bill_tax.toString() == '' || bill_tax == null)
                            ? 'เลขประจำตัวผู้เสียภาษี : 0'
                            : 'เลขประจำตัวผู้เสียภาษี : $bill_tax',
                        // textAlign: pw.TextAlign.justify,
                        textAlign: pw.TextAlign.right,
                        style: pw.TextStyle(
                          fontSize: font_Size,
                          font: ttf,
                          color: Colors_pd,
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
                      // if (TitleType_Default_Receipt_Name != null)
                      //   pw.Text(
                      //     '[ $TitleType_Default_Receipt_Name ]',
                      //     maxLines: 1,
                      //     style: pw.TextStyle(
                      //       fontSize: font_Size,
                      //       font: ttf,
                      //       color: PdfColors.grey400,
                      //     ),
                      //   ),
                      pw.SizedBox(
                        height: 6,
                      ),
                      pw.Text(
                        (TitleType_Default_Receipt_Name != null)
                            ? 'ใบเสร็จคืนเงินประกัน [ $TitleType_Default_Receipt_Name ]'
                            : 'ใบเสร็จคืนเงินประกัน',
                        maxLines: 1,
                        textAlign: pw.TextAlign.right,
                        style: pw.TextStyle(
                          fontSize: font_Size,
                          fontWeight: pw.FontWeight.bold,
                          font: ttf,
                          color: Colors_pd,
                        ),
                      ),
                      pw.Text(
                        (numdoctax.toString() == '')
                            ? 'เลขที่ : $numinvoice'
                            : 'เลขที่ : $numdoctax',
                        // 'เลขที่ : $cFinn',
                        maxLines: 2,
                        textAlign: pw.TextAlign.right,
                        style: pw.TextStyle(
                          fontSize: font_Size,
                          font: ttf,
                          color: Colors_pd,
                        ),
                      ),
                      pw.Text(
                        'วันที่ทำรายการ : $formattedDate ${newYear}',
                        textAlign: pw.TextAlign.right,
                        maxLines: 1,
                        style: pw.TextStyle(
                          fontSize: font_Size,
                          font: ttf,
                          color: Colors_pd,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            pw.Divider(),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
          ]);
        },
        build: (context) {
          return [
            pw.Row(
              children: [
                pw.Expanded(
                  flex: 4,
                  child: pw.Column(
                    mainAxisSize: pw.MainAxisSize.min,
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        'ลูกค้า',
                        style: pw.TextStyle(
                          fontSize: font_Size,
                          fontWeight: pw.FontWeight.bold,
                          font: ttf,
                          color: Colors_pd,
                        ),
                      ),
                      pw.Text(
                        (sname.toString() == null ||
                                sname.toString() == '' ||
                                sname.toString() == 'null')
                            ? ' -'
                            : '$sname',
                        // (Form_bussshop.toString() == '' ||
                        //         Form_bussshop == null ||
                        //         Form_bussshop.toString() == 'null')
                        //     ? '-'
                        //     : '$Form_bussshop',
                        textAlign: pw.TextAlign.justify,
                        style: pw.TextStyle(
                          fontSize: font_Size,
                          font: ttf,
                          color: Colors_pd,
                        ),
                      ),
                      // pw.Text(
                      //   'ที่อยู่:$Form_address',
                      //   textAlign: pw.TextAlign.left,
                      //   style: pw.TextStyle(
                      //       fontSize: 10.0, font: ttf, color: PdfColors.grey),
                      // ),
                      // pw.Text(
                      //   'เลขประจำตัวผู้เสียภาษี:$Form_tax',
                      //   textAlign: pw.TextAlign.justify,
                      //   style: pw.TextStyle(
                      //       fontSize: 10.0, font: ttf, color: PdfColors.grey),
                      // ),
                      pw.Text(
                        (addr.toString() == null ||
                                addr.toString() == '' ||
                                addr.toString() == 'null')
                            ? 'ที่อยู่ : -'
                            : 'ที่อยู่ : $addr',
                        textAlign: pw.TextAlign.left,
                        style: pw.TextStyle(
                          fontSize: font_Size,
                          font: ttf,
                          color: Colors_pd,
                        ),
                      ),
                      pw.Text(
                        (tax == null ||
                                tax.toString() == '' ||
                                tax.toString() == 'null')
                            ? 'เลขประจำตัวผู้เสียภาษี : 0'
                            : 'เลขประจำตัวผู้เสียภาษี : $tax',
                        textAlign: pw.TextAlign.justify,
                        style: pw.TextStyle(
                          fontSize: font_Size,
                          font: ttf,
                          color: Colors_pd,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            pw.SizedBox(height: 3 * PdfPageFormat.mm),
            pw.Row(
              children: [
                pw.Expanded(
                  flex: 4,
                  child: pw.Text(
                    'รูปแบบชำระ',
                    textAlign: pw.TextAlign.justify,
                    style: pw.TextStyle(
                      fontSize: font_Size,
                      font: ttf,
                      fontWeight: pw.FontWeight.bold,
                      color: Colors_pd,
                    ),
                  ),
                ),
                pw.SizedBox(width: 10 * PdfPageFormat.mm),
                pw.Expanded(
                  flex: 4,
                  child: pw.Column(
                    mainAxisSize: pw.MainAxisSize.min,
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    children: [
                      pw.Text(
                        (dayfinpay.toString() == '' ||
                                dayfinpay.toString() == 'null' ||
                                dayfinpay == null)
                            ? 'วันที่ชำระ : - '
                            : 'วันที่ชำระ : ${DateFormat('dd-MM').format(DateTime.parse(dayfinpay!))}-${DateTime.parse('${dayfinpay}').year + 543}',
                        style: pw.TextStyle(
                          fontSize: font_Size,
                          fontWeight: pw.FontWeight.bold,
                          font: ttf,
                          color: Colors_pd,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            pw.Row(
              children: [
                pw.Expanded(
                  flex: 4,
                  child: pw.Column(
                    mainAxisSize: pw.MainAxisSize.min,
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      for (var i = 0; i < finnancetransModels.length; i++)
                        // if (finnancetransModels[i].dtype.toString() != 'FTA')
                        pw.Row(
                          children: [
                            // (finnancetransModels[i].dtype.toString() == 'KP')
                            //     ?
                            pw.Expanded(
                                flex: 1,
                                child: pw.Container(
                                  // decoration: pw.BoxDecoration(
                                  //   color: PdfColors.green100,
                                  //   // border: pw.Border(
                                  //   //   bottom: pw.BorderSide(
                                  //   //       color: PdfColors.green900),
                                  //   // ),
                                  // ),
                                  child: pw.Text(
                                    (finnancetransModels[i].type.toString() ==
                                            'CASH')
                                        ? '${i + 1}.เงินสด : ${nFormat.format(double.parse(finnancetransModels[i].amt!.toString()))} บาท (~${convertToThaiBaht(double.parse(finnancetransModels[i].amt!.toString()))}~)'
                                        : '${i + 1}.เงินโอน : ${nFormat.format(double.parse(finnancetransModels[i].amt!.toString()))} บาท  (~${convertToThaiBaht(double.parse(finnancetransModels[i].amt!.toString()))}~)',
                                    textAlign: pw.TextAlign.justify,
                                    style: pw.TextStyle(
                                      fontSize: font_Size,
                                      font: ttf,
                                      fontWeight: pw.FontWeight.bold,
                                      color: Colors_pd,
                                    ),
                                  ),
                                ))
                            // : pw.Expanded(
                            //     flex: 1,
                            //     child: pw.Container(
                            //       // decoration: pw.BoxDecoration(
                            //       //   color: PdfColors.green100,
                            //       //   // border: pw.Border(
                            //       //   //   bottom: pw.BorderSide(
                            //       //   //       color: PdfColors.green900),
                            //       //   // ),
                            //       // ),
                            //       child: pw.Text(
                            //         '${i + 1}.${finnancetransModels[i].remark} : ${nFormat.format(double.parse(finnancetransModels[i].amt!.toString()))} บาท  (~${convertToThaiBaht(double.parse(finnancetransModels[i].amt!.toString()))}~)',
                            //         textAlign: pw.TextAlign.justify,
                            //         style: pw.TextStyle(
                            //           fontSize: font_Size,
                            //           font: ttf,
                            //           fontWeight: pw.FontWeight.bold,
                            //           color: Colors_pd,
                            //         ),
                            //       ),
                            //     )),
                          ],
                        )
                    ],
                  ),
                ),
              ],
            ),
            pw.SizedBox(height: 3 * PdfPageFormat.mm),
            pw.Container(
              decoration: const pw.BoxDecoration(
                color: PdfColors.green100,
                border: pw.Border(
                  bottom: pw.BorderSide(color: PdfColors.green900),
                ),
              ),
              child: pw.Row(
                children: [
                  pw.Container(
                    width: 50,
                    height: 20,
                    child: pw.Align(
                      alignment: pw.Alignment.centerLeft,
                      child: pw.Text(
                        'ลำดับ',
                        maxLines: 1,
                        textAlign: pw.TextAlign.left,
                        style: pw.TextStyle(
                            fontSize: font_Size,
                            fontWeight: pw.FontWeight.bold,
                            font: ttf,
                            color: PdfColors.green900),
                      ),
                    ),
                  ),
                  pw.Expanded(
                    flex: 2,
                    child: pw.Container(
                      height: 20,
                      child: pw.Align(
                        alignment: pw.Alignment.centerLeft,
                        child: pw.Text(
                          'เลขตั้งหนี้',
                          textAlign: pw.TextAlign.left,
                          maxLines: 1,
                          style: pw.TextStyle(
                              fontSize: font_Size,
                              fontWeight: pw.FontWeight.bold,
                              font: ttf,
                              color: PdfColors.green900),
                        ),
                      ),
                    ),
                  ),
                  pw.Expanded(
                    flex: 3,
                    child: pw.Container(
                      height: 20,
                      child: pw.Align(
                        alignment: pw.Alignment.centerLeft,
                        child: pw.Text(
                          'รายการ',
                          textAlign: pw.TextAlign.left,
                          maxLines: 1,
                          style: pw.TextStyle(
                              fontSize: font_Size,
                              fontWeight: pw.FontWeight.bold,
                              font: ttf,
                              color: PdfColors.green900),
                        ),
                      ),
                    ),
                  ),
                  pw.Expanded(
                    flex: 2,
                    child: pw.Container(
                      height: 20,
                      child: pw.Align(
                        alignment: pw.Alignment.centerRight,
                        child: pw.Text(
                          'ยอดสุทธิ',
                          textAlign: pw.TextAlign.right,
                          maxLines: 1,
                          style: pw.TextStyle(
                              fontSize: font_Size,
                              fontWeight: pw.FontWeight.bold,
                              font: ttf,
                              color: PdfColors.green900),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            for (int index = 0; index < tableData00.length; index++)
              pw.Row(
                children: [
                  pw.Container(
                    width: 50,
                    padding: const pw.EdgeInsets.all(2.0),
                    child: pw.Align(
                      alignment: pw.Alignment.centerLeft,
                      child: pw.Text(
                        '${index + 1}',
                        maxLines: 2,
                        textAlign: pw.TextAlign.left,
                        style: pw.TextStyle(
                            fontSize: font_Size,
                            font: ttf,
                            color: PdfColors.grey800),
                      ),
                    ),
                  ),
                  pw.Expanded(
                    flex: 2,
                    child: pw.Container(
                      padding: const pw.EdgeInsets.all(2.0),
                      child: pw.Align(
                        alignment: pw.Alignment.centerLeft,
                        child: pw.Text(
                          '${tableData00[index][0]}',
                          maxLines: 2,
                          textAlign: pw.TextAlign.left,
                          style: pw.TextStyle(
                              fontSize: font_Size,
                              font: ttf,
                              color: PdfColors.grey800),
                        ),
                      ),
                    ),
                  ),
                  pw.Expanded(
                    flex: 3,
                    child: pw.Container(
                      padding: const pw.EdgeInsets.all(2.0),
                      child: pw.Align(
                        alignment: pw.Alignment.centerLeft,
                        child: pw.Text(
                          '${tableData00[index][1]}',
                          maxLines: 2,
                          textAlign: pw.TextAlign.left,
                          style: pw.TextStyle(
                              fontSize: font_Size,
                              font: ttf,
                              color: PdfColors.grey800),
                        ),
                      ),
                    ),
                  ),
                  pw.Expanded(
                    flex: 2,
                    child: pw.Container(
                      padding: const pw.EdgeInsets.all(2.0),
                      child: pw.Align(
                        alignment: pw.Alignment.centerRight,
                        child: pw.Text(
                          '${tableData00[index][4]}',
                          maxLines: 2,
                          textAlign: pw.TextAlign.right,
                          style: pw.TextStyle(
                              fontSize: font_Size,
                              font: ttf,
                              color: PdfColors.grey800),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            for (int index = 0; index < tableData01.length; index++)
              pw.Row(
                children: [
                  pw.Expanded(
                    flex: 1,
                    child: pw.Container(
                      height: 25,
                      decoration: const pw.BoxDecoration(
                        color: PdfColors.white,
                        // border: const pw.Border(
                        //   bottom: pw.BorderSide(color: PdfColors.grey300),
                        // ),
                      ),
                      child: pw.Center(
                        child: pw.Text(
                          '${tableData00.length + 1}',
                          maxLines: 2,
                          textAlign: pw.TextAlign.left,
                          style: pw.TextStyle(
                              fontSize: font_Size,
                              font: ttf,
                              color: PdfColors.grey800),
                        ),
                      ),
                    ),
                  ),
                  pw.Expanded(
                    flex: 1,
                    child: pw.Container(
                        height: 25,
                        decoration: const pw.BoxDecoration(
                          color: PdfColors.white,
                          // border: const pw.Border(
                          //   bottom: pw.BorderSide(color: PdfColors.grey300),
                          // ),
                        ),
                        child: pw.Align(
                          alignment: pw.Alignment.centerRight,
                          child: pw.Text(
                            '',
                            //  '${_TransModels[x].name}',
                            maxLines: 2,
                            textAlign: pw.TextAlign.right,
                            style: pw.TextStyle(
                                fontSize: font_Size,
                                font: ttf,
                                color: PdfColors.grey800),
                          ),
                        )),
                  ),
                  pw.Expanded(
                    flex: 1,
                    child: pw.Container(
                        height: 25,
                        decoration: const pw.BoxDecoration(
                          color: PdfColors.white,
                          // border: const pw.Border(
                          //   bottom: pw.BorderSide(color: PdfColors.grey300),
                          // ),
                        ),
                        child: pw.Align(
                          alignment: pw.Alignment.centerRight,
                          child: pw.Text(
                            '',
                            //'${nFormat.format(double.parse(_TransModels[x].total!))}',
                            maxLines: 2,
                            textAlign: pw.TextAlign.right,
                            style: pw.TextStyle(
                                fontSize: font_Size,
                                font: ttf,
                                color: PdfColors.grey800),
                          ),
                        )),
                  ),
                ],
              ),
            pw.Divider(color: PdfColors.grey),
            pw.Container(
              alignment: pw.Alignment.centerRight,
              child: pw.Row(
                children: [
                  pw.Spacer(flex: 6),
                  pw.Expanded(
                    flex: 4,
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        // SubTotal, Vat, Deduct, Sum_SubTotal, DisC, Total
                        pw.Row(
                          children: [
                            pw.Expanded(
                              child: pw.Text(
                                'รวมราคาสินค้า/Sub Total',
                                style: pw.TextStyle(
                                    fontSize: font_Size,
                                    fontWeight: pw.FontWeight.bold,
                                    font: ttf,
                                    color: PdfColors.green900),
                              ),
                            ),
                            pw.Text(
                              '${nFormat.format(double.parse(sum_pvat.toString()))}',
                              // '${sum_pvat}',
                              // '$SubTotal',
                              style: pw.TextStyle(
                                  fontSize: font_Size,
                                  fontWeight: pw.FontWeight.bold,
                                  font: ttf,
                                  color: PdfColors.green900),
                            ),
                          ],
                        ),
                        pw.Row(
                          children: [
                            pw.Expanded(
                              child: pw.Text(
                                'ภาษีมูลค่าเพิ่ม/Vat',
                                style: pw.TextStyle(
                                    fontSize: font_Size,
                                    fontWeight: pw.FontWeight.bold,
                                    font: ttf,
                                    color: PdfColors.green900),
                              ),
                            ),
                            pw.Text(
                              '${nFormat.format(double.parse(sum_vat.toString()))}',
                              // '${sum_vat}',
                              // '$Vat',
                              style: pw.TextStyle(
                                  fontSize: font_Size,
                                  fontWeight: pw.FontWeight.bold,
                                  font: ttf,
                                  color: PdfColors.green900),
                            ),
                          ],
                        ),
                        pw.Row(
                          children: [
                            pw.Expanded(
                              child: pw.Text(
                                'หัก ณ ที่จ่าย',
                                style: pw.TextStyle(
                                    fontSize: font_Size,
                                    fontWeight: pw.FontWeight.bold,
                                    font: ttf,
                                    color: PdfColors.green900),
                              ),
                            ),
                            pw.Text(
                              '${nFormat.format(double.parse(sum_wht.toString()))}',
                              // '${sum_wht}',
                              // '$Deduct',
                              style: pw.TextStyle(
                                  fontSize: font_Size,
                                  fontWeight: pw.FontWeight.bold,
                                  font: ttf,
                                  color: PdfColors.green900),
                            ),
                          ],
                        ),
                        pw.Row(
                          children: [
                            pw.Expanded(
                              child: pw.Text(
                                'ค่าธรรมเนียม',
                                style: pw.TextStyle(
                                    fontSize: font_Size,
                                    fontWeight: pw.FontWeight.bold,
                                    font: ttf,
                                    color: PdfColors.green900),
                              ),
                            ),
                            pw.Text(
                              '${nFormat.format(double.parse(sum_fee.toString()))}',
                              // '$Sum_SubTotal',
                              style: pw.TextStyle(
                                  fontSize: font_Size,
                                  fontWeight: pw.FontWeight.bold,
                                  font: ttf,
                                  color: PdfColors.green900),
                            ),
                          ],
                        ),
                        pw.Row(
                          children: [
                            pw.Expanded(
                              child: pw.Text(
                                'ยอดรวม',
                                style: pw.TextStyle(
                                    fontSize: font_Size,
                                    fontWeight: pw.FontWeight.bold,
                                    font: ttf,
                                    color: PdfColors.green900),
                              ),
                            ),
                            pw.Text(
                              '${nFormat.format(double.parse(Sum_SubTotal.toString()) + double.parse(sum_fee.toString()))}',
                              // '$Sum_SubTotal',
                              style: pw.TextStyle(
                                  fontSize: font_Size,
                                  fontWeight: pw.FontWeight.bold,
                                  font: ttf,
                                  color: PdfColors.green900),
                            ),
                          ],
                        ),
                        pw.Row(
                          children: [
                            pw.Expanded(
                              child: pw.Text(
                                'ส่วนลด/Discount',
                                style: pw.TextStyle(
                                    fontSize: font_Size,
                                    fontWeight: pw.FontWeight.bold,
                                    font: ttf,
                                    color: PdfColors.green900),
                              ),
                            ),
                            pw.Text(
                              '${nFormat.format(double.parse(sum_disamt.toString()))}',
                              // '${sum_disamt}',
                              // '$DisC',
                              style: pw.TextStyle(
                                  fontSize: font_Size,
                                  fontWeight: pw.FontWeight.bold,
                                  font: ttf,
                                  color: PdfColors.green900),
                            ),
                          ],
                        ),
                        if (nFormat
                                .format(double.parse(dis_sum_Matjum.toString()))
                                .toString() !=
                            '0.00')
                          pw.Row(
                            children: [
                              pw.Expanded(
                                child: pw.Text(
                                  'เงินมัดจำ(ตัดมัดจำ)',
                                  //  'เงินมัดจำ(${nFormat.format(sum_matjum)})',
                                  style: pw.TextStyle(
                                      fontSize: font_Size,
                                      fontWeight: pw.FontWeight.bold,
                                      font: ttf,
                                      color: PdfColors.green900),
                                ),
                              ),
                              pw.Text(
                                dis_sum_Matjum == 0.00
                                    ? '${nFormat.format(double.parse(dis_sum_Matjum.toString()))}'
                                    : '${nFormat.format(double.parse(dis_sum_Matjum.toString()))}',
                                style: pw.TextStyle(
                                    fontSize: font_Size,
                                    fontWeight: pw.FontWeight.bold,
                                    font: ttf,
                                    color: PdfColors.green900),
                              ),
                            ],
                          ),
                        if (nFormat
                                .format(double.parse(dis_sum_Pakan.toString()))
                                .toString() !=
                            '0.00')
                          pw.Row(
                            children: [
                              pw.Expanded(
                                child: pw.Text(
                                  'เงินประกัน(ตัดเงินประกัน)',
                                  //  'เงินมัดจำ(${nFormat.format(sum_matjum)})',
                                  style: pw.TextStyle(
                                      fontSize: font_Size,
                                      fontWeight: pw.FontWeight.bold,
                                      font: ttf,
                                      color: PdfColors.green900),
                                ),
                              ),
                              pw.Text(
                                dis_sum_Pakan == 0.00
                                    ? '${nFormat.format(double.parse(dis_sum_Pakan.toString()))}'
                                    : '${nFormat.format(double.parse(dis_sum_Pakan.toString()))}',
                                style: pw.TextStyle(
                                    fontSize: font_Size,
                                    fontWeight: pw.FontWeight.bold,
                                    font: ttf,
                                    color: PdfColors.green900),
                              ),
                            ],
                          ),
                        pw.Divider(color: PdfColors.grey),
                        pw.Row(
                          children: [
                            pw.Expanded(
                              child: pw.Text(
                                'ยอดชำระ',
                                style: pw.TextStyle(
                                    fontSize: font_Size,
                                    fontWeight: pw.FontWeight.bold,
                                    font: ttf,
                                    color: PdfColors.green900),
                              ),
                            ),
                            pw.Text(
                              '${nFormat.format((double.parse(Total.toString()) + double.parse(sum_fee.toString())) - (double.parse(dis_sum_Matjum.toString()) + double.parse(dis_sum_Pakan.toString())))}',
                              style: pw.TextStyle(
                                  fontSize: font_Size,
                                  fontWeight: pw.FontWeight.bold,
                                  font: ttf,
                                  color: PdfColors.green900),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            pw.Container(
                height: 25,
                decoration: const pw.BoxDecoration(
                  color: PdfColors.green100,
                  border: pw.Border(
                    top: pw.BorderSide(color: PdfColors.green900),
                  ),
                ),
                alignment: pw.Alignment.centerRight,
                child: pw.Center(
                  child: pw.Row(
                    children: [
                      pw.SizedBox(width: 2 * PdfPageFormat.mm),
                      pw.Text(
                        'ตัวอักษร ',
                        style: pw.TextStyle(
                            fontSize: font_Size,
                            fontWeight: pw.FontWeight.bold,
                            font: ttf,
                            fontStyle: pw.FontStyle.italic,
                            color: PdfColors.green900),
                      ),
                      pw.Expanded(
                        flex: 4,
                        child: pw.Text(
                          //"${nFormat2.format(double.parse(Total.toString()))}";
                          '(~${convertToThaiBaht(double.parse(Total.toString()) + double.parse(sum_fee.toString()))}~)',
                          style: pw.TextStyle(
                            fontSize: font_Size,
                            fontWeight: pw.FontWeight.bold,
                            font: ttf,
                            fontStyle: pw.FontStyle.italic,
                            // decoration:
                            //     pw.TextDecoration.lineThrough,
                            color: PdfColors.green900,
                          ),
                        ),
                      ),
                      // pw.Spacer(flex: 6),
                      pw.Expanded(
                        flex: 2,
                        child: pw.Column(
                          mainAxisAlignment: pw.MainAxisAlignment.center,
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Row(
                              children: [
                                pw.Expanded(
                                  flex: 2,
                                  child: pw.Text(
                                    'ยอดรวมสุทธิ ',
                                    textAlign: pw.TextAlign.left,
                                    style: pw.TextStyle(
                                        fontWeight: pw.FontWeight.bold,
                                        font: ttf,
                                        fontSize: font_Size,
                                        color: PdfColors.green900),
                                  ),
                                ),
                                pw.Text(
                                  '${nFormat.format(double.parse(Total.toString()) + double.parse(sum_fee.toString()))}',
                                  // '${Total}',
                                  style: pw.TextStyle(
                                      fontWeight: pw.FontWeight.bold,
                                      font: ttf,
                                      fontSize: font_Size,
                                      color: PdfColors.green900),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
            pw.SizedBox(height: 5 * PdfPageFormat.mm),
          ];
        },

        /// เวลา หลักฐาน Form_time  , bno : selectedValue , bank 374 347
        footer: (context) {
          return pw.Column(
            mainAxisSize: pw.MainAxisSize.min,
            children: [
              pw.Container(
                  decoration: pw.BoxDecoration(
                    border: pw.Border.all(color: PdfColors.grey, width: 1),
                  ),
                  padding: pw.EdgeInsets.fromLTRB(2, 4, 2, 4),
                  child: pw.Row(
                    children: [
                      pw.Expanded(
                          flex: 2,
                          child: pw.Column(
                              mainAxisAlignment: pw.MainAxisAlignment.start,
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Text(
                                  'หมายเหตุ : ',
                                  textAlign: pw.TextAlign.left,
                                  style: pw.TextStyle(
                                    fontSize: font_Size,
                                    font: ttf,
                                    fontWeight: pw.FontWeight.bold,
                                    color: Colors_pd,
                                  ),
                                ),
                                pw.Text(
                                  (hasNonCashTransaction)
                                      ? '( / ) 1. เงินโอน, QR Code, Mobile Banking '
                                      : '(   ) 1. เงินโอน, QR Code, Mobile Banking ',
                                  textAlign: pw.TextAlign.left,
                                  style: pw.TextStyle(
                                    fontSize: font_Size,
                                    font: ttf,
                                    fontWeight: pw.FontWeight.bold,
                                    color: Colors_pd,
                                  ),
                                ),
                                pw.Text(
                                  (hasNonCashTransaction)
                                      ? '      บัญชี ${finnancetransModels.where((model) => model.dtype == 'KP' && model.ptser != null && model.ptser != '1').map((model) => model.bank).join(', ')} เลขที่ ${finnancetransModels.where((model) => model.dtype == 'KP' && model.ptser != null && model.ptser != '1').map((model) => model.bno).join(', ')} [ ${finnancetransModels.where((model) => model.dtype == 'KP' && model.ptser != null && model.ptser != '1').map((model) => (model.ptname.toString() == 'Online Payment' ? 'PromptPay QR' : model.ptname == 'เงินโอน' ? 'เลขบัญชี' : 'Online Standard QR')).join(', ')} ]'
                                      : '      บัญชี...................................เลขที่...................................',
                                  textAlign: pw.TextAlign.left,
                                  style: pw.TextStyle(
                                    fontSize: font_Size,
                                    font: ttf,
                                    fontWeight: pw.FontWeight.bold,
                                    color: Colors_pd,
                                  ),
                                ),
                                pw.Row(
                                  // mainAxisAlignment:
                                  //     pw.MainAxisAlignment.spaceBetween,
                                  children: [
                                    pw.Expanded(
                                      flex: 1,
                                      child: pw.Text(
                                        (hasNonCashTransaction1)
                                            ? '( / ) 2. เงินสด'
                                            : '(   ) 2. เงินสด',
                                        textAlign: pw.TextAlign.left,
                                        style: pw.TextStyle(
                                          fontSize: font_Size,
                                          font: ttf,
                                          fontWeight: pw.FontWeight.bold,
                                          color: Colors_pd,
                                        ),
                                      ),
                                    ),
                                    pw.Expanded(
                                      flex: 3,
                                      child: pw.Text(
                                        (hasNonCashTransaction ||
                                                hasNonCashTransaction1)
                                            ? '(   ) 3. อื่นๆ.............................'
                                            : '( / ) 3. อื่นๆ ${finnancetransModels.where((model) => model.ptser != '6' || model.ptser != '5' || model.ptser != '2' || model.ptser != '1' && model.dtype == 'KP').map((model) => model.bank).join(', ')}',
                                        textAlign: pw.TextAlign.left,
                                        style: pw.TextStyle(
                                          fontSize: font_Size,
                                          font: ttf,
                                          fontWeight: pw.FontWeight.bold,
                                          color: Colors_pd,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ])),
                      pw.Expanded(
                          flex: 1,
                          child: pw.Column(
                              mainAxisAlignment: pw.MainAxisAlignment.start,
                              // crossAxisAlignment: pw.CrossAxisAlignment.center,
                              children: [
                                pw.Text(
                                  'ลงชื่อ : ผู้จัดการ',
                                  textAlign: pw.TextAlign.left,
                                  style: pw.TextStyle(
                                    fontSize: font_Size,
                                    font: ttf,
                                    fontWeight: pw.FontWeight.bold,
                                    color: Colors_pd,
                                  ),
                                ),
                                pw.Text(
                                  '........................................................',
                                  textAlign: pw.TextAlign.center,
                                  style: pw.TextStyle(
                                    fontSize: font_Size,
                                    font: ttf,
                                    fontWeight: pw.FontWeight.bold,
                                    color: Colors_pd,
                                  ),
                                ),
                                pw.Text(
                                  '(......................................................)',
                                  textAlign: pw.TextAlign.center,
                                  style: pw.TextStyle(
                                    fontSize: font_Size,
                                    font: ttf,
                                    fontWeight: pw.FontWeight.bold,
                                    color: Colors_pd,
                                  ),
                                ),
                                pw.Text(
                                  'วันที่/Date...........................................',
                                  textAlign: pw.TextAlign.center,
                                  style: pw.TextStyle(
                                    fontSize: font_Size,
                                    font: ttf,
                                    fontWeight: pw.FontWeight.bold,
                                    color: Colors_pd,
                                  ),
                                ),
                              ])),
                      pw.Expanded(
                          flex: 1,
                          child: pw.Column(
                              mainAxisAlignment: pw.MainAxisAlignment.start,
                              // crossAxisAlignment: pw.CrossAxisAlignment.center,
                              children: [
                                pw.Text(
                                  'ลงชื่อ : เจ้าหน้าที่',
                                  textAlign: pw.TextAlign.left,
                                  style: pw.TextStyle(
                                    fontSize: font_Size,
                                    font: ttf,
                                    fontWeight: pw.FontWeight.bold,
                                    color: Colors_pd,
                                  ),
                                ),
                                pw.Text(
                                  '........................................................',
                                  textAlign: pw.TextAlign.center,
                                  style: pw.TextStyle(
                                    fontSize: font_Size,
                                    font: ttf,
                                    fontWeight: pw.FontWeight.bold,
                                    color: Colors_pd,
                                  ),
                                ),
                                pw.Text(
                                  '(......................................................)',
                                  textAlign: pw.TextAlign.center,
                                  style: pw.TextStyle(
                                    fontSize: font_Size,
                                    font: ttf,
                                    fontWeight: pw.FontWeight.bold,
                                    color: Colors_pd,
                                  ),
                                ),
                                pw.Text(
                                  'วันที่/Date...........................................',
                                  textAlign: pw.TextAlign.center,
                                  style: pw.TextStyle(
                                    fontSize: font_Size,
                                    font: ttf,
                                    fontWeight: pw.FontWeight.bold,
                                    color: Colors_pd,
                                  ),
                                ),
                              ])),
                      pw.Expanded(
                          flex: 1,
                          child: pw.Column(
                              mainAxisAlignment: pw.MainAxisAlignment.start,
                              // crossAxisAlignment: pw.CrossAxisAlignment.center,
                              children: [
                                pw.Text(
                                  'ลงชื่อ : ผู้รับเงิน',
                                  textAlign: pw.TextAlign.left,
                                  style: pw.TextStyle(
                                    fontSize: font_Size,
                                    font: ttf,
                                    fontWeight: pw.FontWeight.bold,
                                    color: Colors_pd,
                                  ),
                                ),
                                pw.Text(
                                  '........................................................',
                                  textAlign: pw.TextAlign.center,
                                  style: pw.TextStyle(
                                    fontSize: font_Size,
                                    font: ttf,
                                    fontWeight: pw.FontWeight.bold,
                                    color: Colors_pd,
                                  ),
                                ),
                                pw.Text(
                                  '(......................................................)',
                                  textAlign: pw.TextAlign.center,
                                  style: pw.TextStyle(
                                    fontSize: font_Size,
                                    font: ttf,
                                    fontWeight: pw.FontWeight.bold,
                                    color: Colors_pd,
                                  ),
                                ),
                                pw.Text(
                                  'วันที่/Date...........................................',
                                  textAlign: pw.TextAlign.center,
                                  style: pw.TextStyle(
                                    fontSize: font_Size,
                                    font: ttf,
                                    fontWeight: pw.FontWeight.bold,
                                    color: Colors_pd,
                                  ),
                                ),
                              ])),
                      // pw.Expanded(
                      //     flex: 1,
                      //     child: pw.Column(
                      //         mainAxisAlignment: pw.MainAxisAlignment.start,
                      //         // crossAxisAlignment: pw.CrossAxisAlignment.center,
                      //         children: [
                      //           if (hasNonCashTransaction2)
                      //             pw.Container(
                      //               child: pw.BarcodeWidget(
                      //                   data:
                      //                       '|${finnancetransModels.where((model) => model.ptser == '6' && model.dtype == 'KP').map((model) => model.bno).join(', ')}\r$numinvoice\r${DateFormat('dd-MM-yyyy').format(DateTime.parse('${dayfinpay}'))}\r${newTotal_QR}\r',
                      //                   barcode: pw.Barcode.qrCode(),
                      //                   width: 55,
                      //                   height: 55),
                      //             ),
                      //           if (hasNonCashTransaction4)
                      //             pw.BarcodeWidget(
                      //                 data: generateQRCode(
                      //                     promptPayID:
                      //                         "${finnancetransModels.where((model) => model.ptser == '5' && model.dtype == 'KP').map((model) => model.bno).join(', ')}",
                      //                     amount: double.parse((Total == null ||
                      //                             Total == '')
                      //                         ? '0'
                      //                         : '${finnancetransModels.where((model) => model.ptser == '5' && model.dtype == 'KP').map((model) => model.total).join(', ')}')),
                      //                 barcode: pw.Barcode.qrCode(),
                      //                 width: 55,
                      //                 height: 55),
                      //           if (hasNonCashTransaction3)
                      //             for (var i = 0;
                      //                 i < finnancetransModels.length;
                      //                 i++)
                      //               if (finnancetransModels[i]
                      //                           .ptser
                      //                           .toString() ==
                      //                       '2' &&
                      //                   finnancetransModels[i]
                      //                           .dtype
                      //                           .toString() ==
                      //                       'KP')
                      //                 pw.Image(
                      //                   (netImage_QR[i]),
                      //                   height: 55,
                      //                   width: 55,
                      //                 ),
                      //         ])),
                    ],
                  )),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Padding(
                    padding: const pw.EdgeInsets.fromLTRB(0, 2, 0, 0),
                    child: pw.Align(
                      alignment: pw.Alignment.bottomLeft,
                      child: pw.Text(
                        'พิมพ์เมื่อ : $date',
                        // textAlign: pw.TextAlign.left,
                        style: pw.TextStyle(
                          fontSize: 7.00,
                          font: ttf,
                          color: Colors_pd,
                          // fontWeight: pw.FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.fromLTRB(0, 2, 0, 0),
                    child: pw.Align(
                      alignment: pw.Alignment.bottomRight,
                      child: pw.Text(
                        'หน้าที่ ${context.pageNumber} / ${context.pagesCount} ',
                        // textAlign: pw.TextAlign.left,
                        style: pw.TextStyle(
                          fontSize: 7.00,
                          font: ttf,
                          color: Colors_pd,
                          // fontWeight: pw.FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          );
        },

        // footer: (context) {
        //   return pw.Column(
        //     mainAxisSize: pw.MainAxisSize.min,
        //     children: [
        //       pw.Container(
        //           decoration: pw.BoxDecoration(
        //             border: pw.Border.all(color: PdfColors.grey, width: 1),
        //           ),
        //           child: pw.Column(
        //             mainAxisAlignment: pw.MainAxisAlignment.center,
        //             crossAxisAlignment: pw.CrossAxisAlignment.start,
        //             children: [
        //               pw.Row(
        //                   mainAxisAlignment: pw.MainAxisAlignment.center,
        //                   children: [
        //                     pw.Expanded(
        //                       flex: 1,
        //                       child: pw.Container(
        //                         padding: const pw.EdgeInsets.all(4.0),
        //                         child: pw.Column(
        //                           children: [
        //                             pw.Text(
        //                               'หมายเหตุ',
        //                               textAlign: pw.TextAlign.center,
        //                               style: pw.TextStyle(
        //                                   fontSize: font_Size,
        //                                   font: ttf,
        //                                   color: Colors_pd,
        //                                   fontWeight: pw.FontWeight.bold),
        //                             ),
        //                             pw.SizedBox(height: 2 * PdfPageFormat.mm),
        //                             pw.Text(
        //                               '................................................................................................................................................................................',
        //                               textAlign: pw.TextAlign.center,
        //                               // maxLines: 1,
        //                               style: pw.TextStyle(
        //                                 fontSize: font_Size,
        //                                 font: ttf,
        //                                 color: Colors_pd,
        //                               ),
        //                             ),
        //                             pw.SizedBox(height: 2 * PdfPageFormat.mm),
        //                           ],
        //                         ),
        //                       ),
        //                     ),
        //                     pw.Expanded(
        //                       flex: 1,
        //                       child: pw.Container(
        //                         padding: const pw.EdgeInsets.all(4.0),
        //                         child: pw.Column(
        //                           children: [
        //                             pw.Text(
        //                               'ผู้รับเงิน',
        //                               textAlign: pw.TextAlign.left,
        //                               style: pw.TextStyle(
        //                                   fontSize: font_Size,
        //                                   font: ttf,
        //                                   color: Colors_pd,
        //                                   fontWeight: pw.FontWeight.bold),
        //                             ),
        //                             pw.SizedBox(height: 2 * PdfPageFormat.mm),
        //                             pw.Text(
        //                               ' (..............................................)',
        //                               textAlign: pw.TextAlign.left,
        //                               maxLines: 1,
        //                               style: pw.TextStyle(
        //                                 fontSize: font_Size,
        //                                 font: ttf,
        //                                 color: Colors_pd,
        //                               ),
        //                             ),
        //                             pw.SizedBox(height: 2 * PdfPageFormat.mm),
        //                             pw.Text(
        //                               'วันที่........../........../..........',
        //                               textAlign: pw.TextAlign.center,
        //                               style: pw.TextStyle(
        //                                 fontSize: font_Size,
        //                                 font: ttf,
        //                                 color: Colors_pd,
        //                               ),
        //                             ),
        //                             pw.SizedBox(height: 2 * PdfPageFormat.mm),
        //                           ],
        //                         ),
        //                       ),
        //                     ),
        //                   ]),
        //             ],
        //           )),
        //       pw.SizedBox(height: 3 * PdfPageFormat.mm),
        //       pw.Align(
        //         alignment: pw.Alignment.bottomRight,
        //         child: pw.Text(
        //           'หน้า ${context.pageNumber} / ${context.pagesCount} ',
        //           textAlign: pw.TextAlign.left,
        //           style: pw.TextStyle(
        //             fontSize: 10,
        //             font: ttf,
        //             color: Colors_pd,
        //             // fontWeight: pw.FontWeight.bold
        //           ),
        //         ),
        //       )
        //     ],
        //   );
        // },
      ),
    );
    // final bytes = await pdf.save();

    // final dir = await getApplicationDocumentsDirectory();
    // final file = File('${dir.path}/name');
    // await file.writeAsBytes(bytes);
    // return file;
    ///-------------------------------------------------->
    // final List<int> bytes = await pdf.save();
    // final Uint8List data = Uint8List.fromList(bytes);
    // MimeType type = MimeType.PDF;
    // final dir = await FileSaver.instance.saveFile(
    //     "ใบเสร็จรับเงิน(ณ วันที่${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day})",
    //     data,
    //     "pdf",
    //     mimeType: type);
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              PreviewPdfgen_Billsplay(doc: pdf, title: 'ใบเสร็จคืนเงินประกัน'),
        ));
  }

/////////////--------------------------------------------------->
}
