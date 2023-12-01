import 'package:auto_size_text/auto_size_text.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:math' as math;
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';

import '../../CRC_16_Prompay/generate_qrcode.dart';
import '../../ChaoArea/ChaoAreaRenew_Screen.dart';
import '../../Constant/Myconstant.dart';
import '../../PeopleChao/Bills_.dart';
import '../../Style/ThaiBaht.dart';

class Pdfgen_BillingNoteInvlice_TP3 {
  //////////---------------------------------------------------->(ใบวางบิล แจ้งหนี้)  ใช้  ++
  static void exportPDF_BillingNoteInvlice_TP3(

      ///(ser_BillingNote 1 = วางบิล  /// 2 = ประวัติวางบิล )
      // ser_BillingNote,
      tableData003,
      context,
      Num_cid,
      Namenew,
      SubTotal,
      Vat,
      Deduct,
      Sum_SubTotal,
      DisC,
      Total,
      renTal_name,
      sname_,
      addr_,
      tel_,
      email_,
      tax_,
      cname_,
      bill_addr,
      bill_email,
      bill_tel,
      bill_tax,
      bill_name,
      newValuePDFimg,
      cFinn,
      date_Transaction,
      paymentName1,
      paymentName2,
      selectedValue_bank_bno) async {
    final pdf = pw.Document();
    // final fontData = await rootBundle.load("ThaiFonts/Sarabun-Medium.ttf");
    // var dataint = fontData.buffer
    //     .asUint8List(fontData.offsetInBytes, fontData.lengthInBytes);
    // final PdfFont font = PdfFont.of(pdf, data: dataint);
    // final PdfFont font = PdfFont.of(pdf, data: dataint);
    final font = await rootBundle.load("fonts/THSarabunNew.ttf");
    var Colors_pd = PdfColors.black;
    var nFormat = NumberFormat("#,##0.00", "en_US");
    var nFormat2 = NumberFormat("###0.00", "en_US");
    var nFormat3 = NumberFormat("###-##-##0", "en_US");
    // double percen =
    //     (double.parse('$DisC') / double.parse(' $Sum_SubTotal')) * 100.00;
    final ttf = pw.Font.ttf(font);
    double font_Size = 10.0;
    //////---------------------------------------------> (วางบิล)
    DateTime date = DateTime.now();
    var formatter = new DateFormat.MMMMd('th_TH');
    String thaiDate = formatter.format(date);
    //////--------------------------------------------->(ประวัติวางบิล)

    // var formatter = new DateFormat.MMMMd('th_TH');
    // String thaiDate = formatter.format(date);
    final thaiDate2 = DateTime.parse(date_Transaction);
    final formatter2 = DateFormat('d MMMM', 'th_TH');
    final formattedDate2 = formatter.format(thaiDate2);
    //////--------------->พ.ศ.
    DateTime dateTime2 = DateTime.parse(date_Transaction);
    int newYear2 = dateTime2.year + 543;
    //////--------------------------------------------->

    String total_QR = '${nFormat.format(double.parse('${Total}'))}';
    String newTotal_QR = total_QR.replaceAll(RegExp(r'[^0-9]'), '');

    List netImage = [];

    for (int i = 0; i < newValuePDFimg.length; i++) {
      netImage.add(await networkImage('${newValuePDFimg[i]}'));
    }
    final tableHeaders = [
      'ลำดับ',
      'รายการ',
      'กำหนดชำระ',
      'จำนวน',
      'หน่วย',
      'ราคาต่อหน่วย',
      'ราคารวม',
      // 'Total',
    ];

    // final tableData = [
    //   for (int index = 0; index < _TransModels.length; index++)
    //     [
    //       '${index + 1}',
    //       '${_TransModels[index].name}',
    //       '${DateFormat('dd/MM/yyyy').format(DateTime.parse('${_TransModels[index].date} 00:00:00'))}',
    //       "${nFormat.format(double.parse('${_TransModels[index].tqty}'))}",
    //       // '${_TransModels[index].tqty}',
    //       '${_TransModels[index].unit_con}',
    //       _TransModels[index].qty_con == '0.00'
    //           ? "${nFormat.format(double.parse('${_TransModels[index].amt_con}'))}"
    //           // '${_TransModels[index].amt_con}'
    //           : "${nFormat.format(double.parse('${_TransModels[index].qty_con}'))}",
    //       //  '${_TransModels[index].qty_con}',
    //       "${nFormat.format(double.parse('${_TransModels[index].pvat}'))}",
    //       // '${_TransModels[index].pvat}',
    //     ],
    // ];

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
                        color: PdfColors.grey200,
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
                        '$bill_name',
                        maxLines: 2,
                        style: pw.TextStyle(
                          fontSize: font_Size,
                          color: Colors_pd,
                          fontWeight: pw.FontWeight.bold,
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
                        (bill_email.toString() == '' ||
                                bill_email == null ||
                                bill_email.toString() == 'null')
                            ? 'อีเมล : '
                            : 'อีเมล : $bill_email',
                        maxLines: 1,
                        textAlign: pw.TextAlign.right,
                        style: pw.TextStyle(
                          fontSize: font_Size,
                          font: ttf,
                          color: Colors_pd,
                        ),
                      ),
                      pw.Text(
                        (bill_tax.toString() == '' ||
                                bill_tax == null ||
                                bill_tax.toString() == 'null')
                            ? 'เลขประจำตัวผู้เสียภาษี : 0'
                            : 'เลขประจำตัวผู้เสียภาษี : $bill_tax',
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
              mainAxisAlignment: pw.MainAxisAlignment.center,
              children: [
                pw.Text(
                  'ใบวางบิล/ใบแจ้งหนี้',
                  textAlign: pw.TextAlign.center,
                  style: pw.TextStyle(
                    fontSize: font_Size,
                    fontWeight: pw.FontWeight.bold,
                    font: ttf,
                    color: Colors_pd,
                  ),
                ),
              ],
            ),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
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
                        (sname_.toString() == '' ||
                                sname_ == null ||
                                sname_.toString() == 'null')
                            ? ' '
                            : '${sname_}',
                        textAlign: pw.TextAlign.justify,
                        style: pw.TextStyle(
                          fontSize: font_Size,
                          font: ttf,
                          color: Colors_pd,
                        ),
                      ),
                      pw.Text(
                        (addr_.toString() == '' ||
                                addr_ == null ||
                                addr_.toString() == 'null')
                            ? 'ที่อยู่ : -'
                            : 'ที่อยู่ : ${addr_}',
                        textAlign: pw.TextAlign.justify,
                        style: pw.TextStyle(
                          fontSize: font_Size,
                          font: ttf,
                          color: Colors_pd,
                        ),
                      ),
                      // pw.Text(
                      //   'โทรศัพท์: ${tel_}',
                      //   // 'Tel:   ${tel_.substring(0, 3)}-${tel_.substring(3, 6)}-${tel_.substring(6)} ',
                      //   textAlign: pw.TextAlign.justify,
                      //   style: pw.TextStyle(
                      //       fontSize: 10.0,
                      //       font: ttf,
                      //       color: PdfColors.grey800),
                      // ),
                      pw.Text(
                        (email_.toString() == '' ||
                                email_ == null ||
                                email_.toString() == 'null')
                            ? 'อีเมล : -'
                            : 'อีเมล : ${email_}',
                        textAlign: pw.TextAlign.justify,
                        style: pw.TextStyle(
                          fontSize: font_Size,
                          font: ttf,
                          color: Colors_pd,
                        ),
                      ),
                      pw.Text(
                        (tax_.toString() == '' ||
                                tax_ == null ||
                                tax_.toString() == 'null')
                            ? 'เลขประจำตัวผู้เสียภาษี : 0'
                            : 'เลขประจำตัวผู้เสียภาษี : ${tax_}',
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
                pw.SizedBox(width: 10 * PdfPageFormat.mm),
                pw.Expanded(
                  flex: 4,
                  child: pw.Column(
                    mainAxisSize: pw.MainAxisSize.min,
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    children: [
                      pw.Text(
                        'เลขที่อ้างอิง(Reference ID)',
                        style: pw.TextStyle(
                          fontSize: font_Size,
                          font: ttf,
                          color: Colors_pd,
                        ),
                      ),
                      pw.Text(
                        (cFinn.toString() == '' ||
                                cFinn == null ||
                                cFinn.toString() == 'null')
                            ? ' '
                            : '${cFinn}',
                        style: pw.TextStyle(
                          fontSize: font_Size,
                          fontWeight: pw.FontWeight.bold,
                          font: ttf,
                        ),
                      ),
                      pw.Text(
                        'วันที่ทำรายการ(Transation Date)',
                        style: pw.TextStyle(
                          fontSize: font_Size,
                          font: ttf,
                          color: Colors_pd,
                        ),
                      ),
                      pw.Text(
                        (date_Transaction == null)
                            ? '-'
                            : '$formattedDate2 ${newYear2}',
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
            pw.Row(children: [
              pw.Text(
                'รับบิลไว้ตรวจสอบตามรายการข้างล่างนี้ถูกต้องแล้ว  ',
                textAlign: pw.TextAlign.justify,
                style: pw.TextStyle(
                  fontSize: font_Size,
                  font: ttf,
                  fontWeight: pw.FontWeight.bold,
                  color: Colors_pd,
                ),
              ),
            ]),
            pw.SizedBox(height: 2 * PdfPageFormat.mm),
            /////////----------------------------------------------->
            pw.Container(
              decoration: const pw.BoxDecoration(
                color: PdfColors.green100,
                border: pw.Border(
                  bottom: pw.BorderSide(color: PdfColors.green900),
                ),
              ),
              child: pw.Row(
                children: [
                  pw.Expanded(
                    flex: 1,
                    child: pw.Container(
                      height: 25,
                      child: pw.Center(
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
                  ),
                  pw.Expanded(
                    flex: 2,
                    child: pw.Container(
                      height: 25,
                      child: pw.Center(
                        child: pw.Text(
                          'กำหนดชำระ',
                          textAlign: pw.TextAlign.center,
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
                    flex: 4,
                    child: pw.Container(
                      height: 25,
                      child: pw.Center(
                        child: pw.Text(
                          'รายการ',
                          textAlign: pw.TextAlign.center,
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
                      height: 25,
                      child: pw.Center(
                        child: pw.Text(
                          'VAT',
                          textAlign: pw.TextAlign.center,
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
                      height: 25,
                      child: pw.Center(
                        child: pw.Text(
                          'WHT',
                          textAlign: pw.TextAlign.center,
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
                      height: 25,
                      child: pw.Center(
                        child: pw.Text(
                          'ราคารวมก่อนVAT',
                          textAlign: pw.TextAlign.center,
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
                      height: 25,
                      child: pw.Center(
                        child: pw.Text(
                          'ยอดสุทธิ',
                          textAlign: pw.TextAlign.center,
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
            for (int index = 0; index < tableData003.length; index++)
              pw.Row(
                children: [
                  pw.Expanded(
                    flex: 1,
                    child: pw.Container(
                      padding: const pw.EdgeInsets.all(2.0),
                      // height: 25,
                      decoration: const pw.BoxDecoration(
                        color: PdfColors.white,
                        // border: const pw.Border(
                        //   bottom: pw.BorderSide(color: PdfColors.grey300),
                        // ),
                      ),
                      child: pw.Center(
                        child: pw.Text(
                          '${tableData003[index][0]}',
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
                      // height: 25,
                      decoration: const pw.BoxDecoration(
                        color: PdfColors.white,
                        // border: const pw.Border(
                        //   bottom: pw.BorderSide(color: PdfColors.grey300),
                        // ),
                      ),
                      child: pw.Align(
                        alignment: pw.Alignment.center,
                        child: pw.Text(
                          '${tableData003[index][1]}',
                          maxLines: 2,
                          textAlign: pw.TextAlign.center,
                          style: pw.TextStyle(
                              fontSize: font_Size,
                              font: ttf,
                              color: PdfColors.grey800),
                        ),
                      ),
                    ),
                  ),
                  pw.Expanded(
                    flex: 4,
                    child: pw.Container(
                      padding: const pw.EdgeInsets.all(2.0),
                      // height: 25,
                      decoration: const pw.BoxDecoration(
                        color: PdfColors.white,
                        // border: const pw.Border(
                        //   bottom: pw.BorderSide(color: PdfColors.grey300),
                        // ),
                      ),
                      child: pw.Align(
                        alignment: pw.Alignment.centerLeft,
                        child: pw.Text(
                          '${tableData003[index][2]}',
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
                  pw.Expanded(
                    flex: 2,
                    child: pw.Container(
                      padding: const pw.EdgeInsets.all(2.0),
                      // height: 25,
                      decoration: const pw.BoxDecoration(
                        color: PdfColors.white,
                        // border: const pw.Border(
                        //   bottom: pw.BorderSide(color: PdfColors.grey300),
                        // ),
                      ),
                      child: pw.Align(
                        alignment: pw.Alignment.centerRight,
                        child: pw.Text(
                          '${tableData003[index][3]}',
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
                  pw.Expanded(
                    flex: 2,
                    child: pw.Container(
                      padding: const pw.EdgeInsets.all(2.0),
                      // height: 25,
                      decoration: const pw.BoxDecoration(
                        color: PdfColors.white,
                        // border: const pw.Border(
                        //   bottom: pw.BorderSide(color: PdfColors.grey300),
                        // ),
                      ),
                      child: pw.Align(
                        alignment: pw.Alignment.centerRight,
                        child: pw.Text(
                          '${tableData003[index][4]}',
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
                  pw.Expanded(
                    flex: 2,
                    child: pw.Container(
                      padding: const pw.EdgeInsets.all(2.0),
                      // height: 25,
                      decoration: const pw.BoxDecoration(
                        color: PdfColors.white,
                        // border: const pw.Border(
                        //   bottom: pw.BorderSide(color: PdfColors.grey300),
                        // ),
                      ),
                      child: pw.Align(
                        alignment: pw.Alignment.centerRight,
                        child: pw.Text(
                          '${tableData003[index][5]}',
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
                  pw.Expanded(
                    flex: 2,
                    child: pw.Container(
                      padding: const pw.EdgeInsets.all(2.0),
                      // height: 25,
                      decoration: const pw.BoxDecoration(
                        color: PdfColors.white,
                        // border: const pw.Border(
                        //   bottom: pw.BorderSide(color: PdfColors.grey300),
                        // ),
                      ),
                      child: pw.Align(
                        alignment: pw.Alignment.centerRight,
                        child: pw.Text(
                          '${tableData003[index][6]}',
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
                              '${nFormat.format(double.parse('$SubTotal'))}',
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
                              '${nFormat.format(double.parse('$Vat'))}',
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
                              '${nFormat.format(double.parse('$Deduct'))}',
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
                                'ยอดรวม',
                                style: pw.TextStyle(
                                    fontSize: font_Size,
                                    fontWeight: pw.FontWeight.bold,
                                    font: ttf,
                                    color: PdfColors.green900),
                              ),
                            ),
                            pw.Text(
                              '${nFormat.format(double.parse('$Sum_SubTotal'))}',
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
                                // 'ส่วนลด/Discount(${(double.parse('$DisC') / double.parse(' $Sum_SubTotal')) * 100.00} %)',
                                style: pw.TextStyle(
                                    fontSize: font_Size,
                                    fontWeight: pw.FontWeight.bold,
                                    font: ttf,
                                    color: PdfColors.green900),
                              ),
                            ),
                            pw.Text(
                              '${nFormat.format(double.parse('$DisC'))}',
                              // '$DisC',
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
                              '${nFormat.format(double.parse('$Total'))}',
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
                          '(~${convertToThaiBaht(double.parse(Total.toString()))}~)',
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
                                    'ยอดชำระทั้งหมด/Total',
                                    textAlign: pw.TextAlign.left,
                                    style: pw.TextStyle(
                                        fontWeight: pw.FontWeight.bold,
                                        font: ttf,
                                        fontSize: font_Size,
                                        color: PdfColors.green900),
                                  ),
                                ),
                                pw.Text(
                                  // '$Total',
                                  '${nFormat.format(double.parse('$Total'))}',
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
        footer: (context) {
          return pw.Column(
            mainAxisSize: pw.MainAxisSize.min,
            children: [
              pw.Container(
                  decoration: pw.BoxDecoration(
                    border: pw.Border.all(color: PdfColors.grey, width: 1),
                  ),
                  child: pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.SizedBox(height: 2 * PdfPageFormat.mm),
                      pw.Row(
                        children: [
                          if (paymentName1.toString().trim() != 'เงินสด')
                            pw.Expanded(
                                flex: 2,
                                child:
                                    (paymentName1.toString().trim() ==
                                                'เงินโอน' ||
                                            paymentName1.toString().trim() ==
                                                'เงินโอน' ||
                                            paymentName1.toString().trim() ==
                                                'Online Payment' ||
                                            paymentName1.toString().trim() ==
                                                'Online Payment' ||
                                            paymentName1.toString().trim() ==
                                                'Online Standard QR' ||
                                            paymentName2.toString().trim() ==
                                                'เงินโอน' ||
                                            paymentName2.toString().trim() ==
                                                'เงินโอน' ||
                                            paymentName2.toString().trim() ==
                                                'Online Payment' ||
                                            paymentName2.toString().trim() ==
                                                'Online Payment' ||
                                            paymentName2.toString().trim() ==
                                                'Online Standard QR')
                                        ? pw.Container(
                                            // decoration: pw.BoxDecoration(
                                            //   border: pw.Border.all(
                                            //       color: PdfColors.grey, width: 1),
                                            // ),
                                            child: pw.Column(
                                            mainAxisAlignment:
                                                pw.MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                pw.CrossAxisAlignment.start,
                                            children: [
                                              pw.Row(
                                                  mainAxisAlignment: pw
                                                      .MainAxisAlignment.center,
                                                  children: [
                                                    pw.Expanded(
                                                      flex: 2,
                                                      child: pw.Container(
                                                        padding: const pw
                                                                .EdgeInsets.all(
                                                            4.0),
                                                        child: pw.Column(
                                                          children: [
                                                            // pw.Container(
                                                            //     // height: 60,
                                                            //     // width: 200,
                                                            //     child: pw.Image(
                                                            //   pw.MemoryImage(uint8Listthaiqr),
                                                            //   height: 72,
                                                            //   width: 65,
                                                            // )),
                                                            pw.Container(
                                                              child: pw.BarcodeWidget(
                                                                  data: (paymentName1.toString().trim() == 'Online Standard QR' ||
                                                                          paymentName2.toString().trim() ==
                                                                              'Online Standard QR')
                                                                      ? '|$selectedValue_bank_bno\r$cFinn\r${DateFormat('dd-MM-yyyy').format(DateTime.parse(date_Transaction))}\r${newTotal_QR}\r'
                                                                      : generateQRCode(
                                                                          promptPayID:
                                                                              "$selectedValue_bank_bno",
                                                                          amount: double.parse((Total == null || Total == '')
                                                                              ? '0'
                                                                              : '$Total')),
                                                                  barcode: pw
                                                                          .Barcode
                                                                      .qrCode(),
                                                                  width: 55,
                                                                  height: 55),
                                                            ),
                                                            pw.Text(
                                                              'บัญชี : $selectedValue_bank_bno',
                                                              style:
                                                                  pw.TextStyle(
                                                                font: ttf,
                                                                fontSize:
                                                                    font_Size,
                                                                fontWeight: pw
                                                                    .FontWeight
                                                                    .bold,
                                                              ),
                                                            ),
                                                            if (paymentName1
                                                                        .toString()
                                                                        .trim() ==
                                                                    'Online Standard QR' ||
                                                                paymentName2
                                                                        .toString()
                                                                        .trim() ==
                                                                    'Online Standard QR')
                                                              pw.Text(
                                                                '(Ref1 : $cFinn , Ref2 : ${DateFormat('dd-MM-yyyy').format(DateTime.parse(date_Transaction))})',
                                                                style: pw
                                                                    .TextStyle(
                                                                  font: ttf,
                                                                  fontSize:
                                                                      font_Size,
                                                                  fontWeight: pw
                                                                      .FontWeight
                                                                      .bold,
                                                                ),
                                                              ),
                                                            pw.Text(
                                                              'สำหรับชำระด้วย Mobile Banking',
                                                              style:
                                                                  pw.TextStyle(
                                                                font: ttf,
                                                                fontSize:
                                                                    font_Size,
                                                                fontWeight: pw
                                                                    .FontWeight
                                                                    .bold,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    // pw.Expanded(
                                                    //   flex: 1,
                                                    //   child: pw.Container(
                                                    //     padding:
                                                    //         const pw.EdgeInsets.all(4.0),
                                                    //     child: pw.Column(
                                                    //       children: [
                                                    //         pw.Text(
                                                    //           'คำเตือน',
                                                    //           textAlign: pw.TextAlign.left,
                                                    //           style: pw.TextStyle(
                                                    //               fontSize: 6,
                                                    //               font: ttf,
                                                    //               color: PdfColors.red,
                                                    //               fontWeight:
                                                    //                   pw.FontWeight.bold),
                                                    //         ),
                                                    //         pw.SizedBox(
                                                    //             height:
                                                    //                 2 * PdfPageFormat.mm),
                                                    //         pw.Text(
                                                    //           'โปรดตรวจสอบความถูกต้องทุกครั้งก่อนทำการชำระเงิน',
                                                    //           textAlign: pw.TextAlign.left,
                                                    //           maxLines: 1,
                                                    //           style: pw.TextStyle(
                                                    //             fontSize: 6,
                                                    //             font: ttf,
                                                    //             color: PdfColors.red,
                                                    //           ),
                                                    //         ),
                                                    //         pw.SizedBox(
                                                    //             height:
                                                    //                 2 * PdfPageFormat.mm),
                                                    //         pw.Text(
                                                    //           '( หากเกิดข้อผิดพลาดโปรดเก็บหลักฐานการชำระไว้ เพื่อติดต่อเจ้าหน้าที่ )',
                                                    //           textAlign:
                                                    //               pw.TextAlign.center,
                                                    //           style: pw.TextStyle(
                                                    //             fontSize: 6,
                                                    //             font: ttf,
                                                    //             color: PdfColors.red,
                                                    //           ),
                                                    //         ),
                                                    //         pw.SizedBox(
                                                    //             height:
                                                    //                 2 * PdfPageFormat.mm),
                                                    //       ],
                                                    //     ),
                                                    //   ),
                                                    // ),
                                                  ]),
                                            ],
                                          ))
                                        : pw.Text('')),
                          pw.Expanded(
                              flex: 2,
                              child: pw.Column(
                                crossAxisAlignment:
                                    pw.CrossAxisAlignment.center,
                                children: [
                                  pw.Row(
                                    mainAxisAlignment:
                                        pw.MainAxisAlignment.spaceAround,
                                    children: [
                                      pw.Expanded(
                                        flex: 1,
                                        child: pw.Text(
                                          'ลงชื่อ',
                                          textAlign: pw.TextAlign.center,
                                          style: pw.TextStyle(
                                            fontSize: font_Size,
                                            fontWeight: pw.FontWeight.bold,
                                            font: ttf,
                                            color: Colors_pd,
                                          ),
                                        ),
                                      ),
                                      // pw.Expanded(
                                      //   flex: 1,
                                      //   child: pw.Text(
                                      //     'ผู้รับเงิน',
                                      //     textAlign: pw.TextAlign.center,
                                      //     style: pw.TextStyle(
                                      //       fontSize: 8.0,
                                      //       fontWeight: pw.FontWeight.bold,
                                      //       font: ttf,
                                      //       color: Colors_pd,
                                      //     ),
                                      //   ),
                                      // ),
                                      pw.Expanded(
                                        flex: 1,
                                        child: pw.Text(
                                          'ลงชื่อ',
                                          textAlign: pw.TextAlign.center,
                                          style: pw.TextStyle(
                                            fontSize: font_Size,
                                            fontWeight: pw.FontWeight.bold,
                                            font: ttf,
                                            color: Colors_pd,
                                          ),
                                        ),
                                      ),
                                      // pw.Expanded(
                                      //   flex: 1,
                                      //   child: pw.Text(
                                      //     'ผู้อนุมัติ',
                                      //     textAlign: pw.TextAlign.center,
                                      //     style: pw.TextStyle(
                                      //       fontSize: 8.0,
                                      //       fontWeight: pw.FontWeight.bold,
                                      //       font: ttf,
                                      //       color: Colors_pd,
                                      //     ),
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                  pw.SizedBox(height: 2 * PdfPageFormat.mm),
                                  pw.Row(
                                    mainAxisAlignment:
                                        pw.MainAxisAlignment.spaceAround,
                                    children: [
                                      pw.Expanded(
                                        flex: 1,
                                        child: pw.Text(
                                          '..........................................',
                                          textAlign: pw.TextAlign.center,
                                          style: pw.TextStyle(
                                            fontSize: font_Size,
                                            font: ttf,
                                            color: Colors_pd,
                                          ),
                                        ),
                                      ),
                                      pw.Expanded(
                                        flex: 1,
                                        child: pw.Text(
                                          '..........................................',
                                          textAlign: pw.TextAlign.center,
                                          style: pw.TextStyle(
                                            fontWeight: pw.FontWeight.bold,
                                            fontSize: font_Size,
                                            font: ttf,
                                            color: Colors_pd,
                                          ),
                                        ),
                                      ),
                                      // pw.Expanded(
                                      //   flex: 1,
                                      //   child: pw.Text(
                                      //     '..........................................',
                                      //     textAlign: pw.TextAlign.center,
                                      //     style: pw.TextStyle(
                                      //       fontWeight: pw.FontWeight.bold,
                                      //       fontSize: 8.0,
                                      //       font: ttf,
                                      //       color: Colors_pd,
                                      //     ),
                                      //   ),
                                      // ),
                                      // pw.Expanded(
                                      //   flex: 1,
                                      //   child: pw.Text(
                                      //     '..........................................',
                                      //     textAlign: pw.TextAlign.center,
                                      //     style: pw.TextStyle(
                                      //       fontWeight: pw.FontWeight.bold,
                                      //       fontSize: 8.0,
                                      //       font: ttf,
                                      //       color: Colors_pd,
                                      //     ),
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                  pw.SizedBox(height: 2 * PdfPageFormat.mm),
                                  pw.Row(
                                    mainAxisAlignment:
                                        pw.MainAxisAlignment.spaceAround,
                                    children: [
                                      pw.Expanded(
                                        flex: 1,
                                        child: pw.Text(
                                          '(................................)',
                                          textAlign: pw.TextAlign.center,
                                          style: pw.TextStyle(
                                            fontSize: font_Size,
                                            font: ttf,
                                            color: Colors_pd,
                                          ),
                                        ),
                                      ),
                                      pw.Expanded(
                                        flex: 1,
                                        child: pw.Text(
                                          '(................................)',
                                          textAlign: pw.TextAlign.center,
                                          style: pw.TextStyle(
                                            fontSize: font_Size,
                                            font: ttf,
                                            color: Colors_pd,
                                          ),
                                        ),
                                      ),
                                      // pw.Expanded(
                                      //   flex: 1,
                                      //   child: pw.Text(
                                      //     '(................................)',
                                      //     textAlign: pw.TextAlign.center,
                                      //     style: pw.TextStyle(
                                      //       fontSize: 8.0,
                                      //       font: ttf,
                                      //       color: Colors_pd,
                                      //     ),
                                      //   ),
                                      // ),
                                      // pw.Expanded(
                                      //   flex: 1,
                                      //   child: pw.Text(
                                      //     '(................................)',
                                      //     textAlign: pw.TextAlign.center,
                                      //     style: pw.TextStyle(
                                      //       fontSize: 8.0,
                                      //       font: ttf,
                                      //       color: Colors_pd,
                                      //     ),
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                  pw.SizedBox(height: 2 * PdfPageFormat.mm),
                                  pw.Row(
                                    mainAxisAlignment:
                                        pw.MainAxisAlignment.spaceAround,
                                    children: [
                                      pw.Expanded(
                                        flex: 1,
                                        child: pw.Text(
                                          'วันที่........../........../..........',
                                          textAlign: pw.TextAlign.center,
                                          style: pw.TextStyle(
                                            fontSize: font_Size,
                                            font: ttf,
                                            color: Colors_pd,
                                          ),
                                        ),
                                      ),
                                      pw.Expanded(
                                        flex: 1,
                                        child: pw.Text(
                                          'วันที่........../........../..........',
                                          textAlign: pw.TextAlign.center,
                                          style: pw.TextStyle(
                                            fontSize: font_Size,
                                            font: ttf,
                                            color: Colors_pd,
                                          ),
                                        ),
                                      ),
                                      // pw.Expanded(
                                      //   flex: 1,
                                      //   child: pw.Text(
                                      //     'วันที่........../........../..........',
                                      //     textAlign: pw.TextAlign.center,
                                      //     style: pw.TextStyle(
                                      //       fontSize: 8.0,
                                      //       font: ttf,
                                      //       color: Colors_pd,
                                      //     ),
                                      //   ),
                                      // ),
                                      // pw.Expanded(
                                      //   flex: 1,
                                      //   child: pw.Text(
                                      //     'วันที่........../........../..........',
                                      //     textAlign: pw.TextAlign.center,
                                      //     style: pw.TextStyle(
                                      //       fontSize: 8.0,
                                      //       font: ttf,
                                      //       color: Colors_pd,
                                      //     ),
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                ],
                              ))
                        ],
                      ),
                      pw.SizedBox(height: 1 * PdfPageFormat.mm),
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        children: [
                          pw.Text(
                            ' หมายเหตุ ...............................................................................................................................................................................................................',
                            textAlign: pw.TextAlign.left,
                            maxLines: 1,
                            style: pw.TextStyle(
                              fontSize: font_Size,
                              font: ttf,
                              color: Colors_pd,
                            ),
                          ),
                        ],
                      ),
                      pw.SizedBox(height: 2 * PdfPageFormat.mm),
                    ],
                  )),
              pw.SizedBox(height: 1 * PdfPageFormat.mm),
              pw.Align(
                alignment: pw.Alignment.bottomRight,
                child: pw.Text(
                  'หน้า ${context.pageNumber} / ${context.pagesCount} ',
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(
                    fontSize: 10.0,
                    font: ttf,
                    color: Colors_pd,
                    // fontWeight: pw.FontWeight.bold
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
    // final bytes = await pdf.save();

    // final dir = await getApplicationDocumentsDirectory();
    // final file = File('${dir.path}/name');
    // await file.writeAsBytes(bytes);
    // return file;
    ///////----------------------------------------->
    // final List<int> bytes = await pdf.save();
    // final Uint8List data = Uint8List.fromList(bytes);
    // MimeType type = MimeType.PDF;
    // final dir = await FileSaver.instance.saveFile(
    //     "ใบเสนอราคา(ณ วันที่${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day})",
    //     data,
    //     "pdf",
    //     mimeType: type);
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PreviewPdfgen_Bills(
              doc: pdf, nameBills: 'ใบวางบิล/ใบแจ้งหนี้${cFinn}'),
        ));
  }
}
