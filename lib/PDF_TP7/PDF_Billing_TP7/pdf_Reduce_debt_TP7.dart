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
import '../../Constant/Myconstant.dart';
import '../../PeopleChao/Pays_.dart';
import '../../Style/ThaiBaht.dart';
import '../../Style/loadAndCacheImage.dart';

class Pdfgen_Reduce_debt_TP7 {
//////////---------------------------------------------------->(ใบเสร็จรับเงิน/ใบกำกับภาษี)   ใช้  //

  static void exportPDF_Reduce_debt_TP7(
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
      sname,
      cname,
      addr,
      tax,
      Cust_no,
      cid_s,
      Zone_s,
      Ln_s,
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
      sum_total,
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
    final thaiDate = DateTime.parse(Datex_invoice.toString());
    final formatter = DateFormat('d MMMM', 'th_TH');
    final formattedDate = formatter.format(thaiDate);
    //////--------------->พ.ศ.
    DateTime dateTime = DateTime.parse(Datex_invoice.toString());
    int newYear = dateTime.year + 543;
    //////--------------------------------------------->
    var nFormat = NumberFormat("#,##0.00", "en_US");
    var nFormat2 = NumberFormat("###0.00", "en_US");
    final iconImage =
        (await rootBundle.load('images/LOGO.png')).buffer.asUint8List();
    List netImage = [];
    List netImage_QR = [];
    Uint8List? resizedLogo = await getResizedLogo();
    // for (int i = 0; i < newValuePDFimg.length; i++) {
    //   netImage.add(await networkImage('${newValuePDFimg[i]}'));
    // }

//////////---------------------------------->

    pw.Widget Header(int serpang) {
      return pw.Column(children: [
        pw.Row(
          children: [
            pw.Container(
              width: 200,
              child: pw.Column(
                mainAxisSize: pw.MainAxisSize.min,
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Container(
                    height: 30,
                    width: 40,
                    decoration: pw.BoxDecoration(
                      color: PdfColors.grey200,
                      border: pw.Border.all(color: PdfColors.grey300),
                    ),
                    child: resizedLogo != null
                        ? pw.Image(
                            pw.MemoryImage(resizedLogo),
                            height: 30,
                            width: 40,
                          )
                        : pw.Center(
                            child: pw.Text(
                              '$bill_name ',
                              maxLines: 1,
                              style: pw.TextStyle(
                                fontSize: 10,
                                font: ttf,
                                color: Colors_pd,
                              ),
                            ),
                          ),
                  ),
                  // (netImage.isEmpty)
                  //     ? pw.Container(
                  //         height: 30,
                  //         width: 40,
                  //         decoration: const pw.BoxDecoration(
                  //           color: PdfColors.grey200,
                  //           border: pw.Border(
                  //             right: pw.BorderSide(color: PdfColors.grey300),
                  //             left: pw.BorderSide(color: PdfColors.grey300),
                  //             top: pw.BorderSide(color: PdfColors.grey300),
                  //             bottom: pw.BorderSide(color: PdfColors.grey300),
                  //           ),
                  //         ),
                  //         child: pw.Center(
                  //           child: pw.Text(
                  //             '$bill_name ',
                  //             maxLines: 1,
                  //             style: pw.TextStyle(
                  //               fontSize: 10,
                  //               font: ttf,
                  //               color: Colors_pd,
                  //             ),
                  //           ),
                  //         ))
                  //     : pw.Container(
                  //         height: 30,
                  //         width: 40,
                  //         decoration: const pw.BoxDecoration(
                  //           color: PdfColors.grey200,
                  //           border: pw.Border(
                  //             right: pw.BorderSide(color: PdfColors.grey300),
                  //             left: pw.BorderSide(color: PdfColors.grey300),
                  //             top: pw.BorderSide(color: PdfColors.grey300),
                  //             bottom: pw.BorderSide(color: PdfColors.grey300),
                  //           ),
                  //         ),
                  //         child: pw.Image(
                  //           (netImage[0]),
                  //           height: 30,
                  //           width: 40,
                  //         ),
                  //       ),
                  pw.SizedBox(height: 1 * PdfPageFormat.mm),
                  pw.Text(
                    '${bill_name.toString().trim()}',
                    maxLines: 1,
                    textAlign: pw.TextAlign.left,
                    style: pw.TextStyle(
                      fontSize: font_Size,
                      color: Colors_pd,
                      fontWeight: pw.FontWeight.bold,
                      font: ttf,
                    ),
                  ),
                  pw.Text(
                    'ที่อยู่ : $bill_addr',
                    maxLines: 1,
                    textAlign: pw.TextAlign.left,
                    style: pw.TextStyle(
                      fontSize: font_Size,
                      color: Colors_pd,
                      font: ttf,
                    ),
                  ),
                  pw.Text(
                    (bill_tax.toString() == '' ||
                            bill_tax == null ||
                            bill_tax.toString() == 'null')
                        ? 'เลขประจำตัวผู้เสียภาษี : 0'
                        : 'เลขประจำตัวผู้เสียภาษี : $bill_tax',
                    textAlign: pw.TextAlign.right,
                    maxLines: 1,
                    style: pw.TextStyle(
                      fontSize: font_Size,
                      font: ttf,
                      color: Colors_pd,
                    ),
                  ),
                  pw.Text(
                    'โทร : $bill_tel',
                    textAlign: pw.TextAlign.right,
                    maxLines: 1,
                    style: pw.TextStyle(
                      fontSize: font_Size,
                      font: ttf,
                      color: Colors_pd,
                    ),
                  ),
                  pw.Text(
                    'ลูกค้า(Customer)',
                    textAlign: pw.TextAlign.right,
                    maxLines: 1,
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
                    textAlign: pw.TextAlign.right, maxLines: 1,
                    // textAlign: pw.TextAlign.justify,
                    style: pw.TextStyle(
                      fontSize: font_Size,
                      font: ttf,
                      color: Colors_pd,
                    ),
                  ),
                  pw.Text(
                    (addr.toString() == null ||
                            addr.toString() == '' ||
                            addr.toString() == 'null')
                        ? 'ที่อยู่ : -'
                        : 'ที่อยู่: $addr',
                    textAlign: pw.TextAlign.right,
                    maxLines: 1,
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
                    maxLines: 1,
                    style: pw.TextStyle(
                      fontSize: font_Size,
                      font: ttf,
                      color: Colors_pd,
                    ),
                  ),
                  // pw.Row(
                  //   children: [
                  //     pw.Text(
                  //       'อ้างอิงถึง : ',
                  //       textAlign: pw.TextAlign.justify,
                  //       maxLines: 1,
                  //       style: pw.TextStyle(
                  //         fontSize: font_Size,
                  //         font: ttf,
                  //         color: Colors_pd,
                  //       ),
                  //     ),
                  //     pw.Expanded(
                  //       flex: 4,
                  //       child: pw.Column(
                  //         mainAxisSize: pw.MainAxisSize.min,
                  //         crossAxisAlignment: pw.CrossAxisAlignment.end,
                  //         children: [
                  //           pw.Text(
                  //             'เลขที่ใบแจ้งหนี้-วางบิล : $inv_num ',
                  //             style: pw.TextStyle(
                  //               fontSize: font_Size,
                  //               fontWeight: pw.FontWeight.bold,
                  //               font: ttf,
                  //               color: Colors_pd,
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  pw.SizedBox(height: 3 * PdfPageFormat.mm),
                  pw.Row(
                    children: [
                      pw.Text(
                        'หมายเหตุ : ' + '.' * 200,
                        textAlign: pw.TextAlign.justify,
                        style: pw.TextStyle(
                          fontSize: font_Size,
                          font: ttf,
                          fontWeight: pw.FontWeight.bold,
                          color: Colors_pd,
                        ),
                      ),
                    ],
                  ),
                  pw.SizedBox(height: 2.5 * PdfPageFormat.mm),
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
                    'ใบลดหนี้',
                    textAlign: pw.TextAlign.right,
                    maxLines: 1,
                    style: pw.TextStyle(
                      fontSize: font_Size,
                      fontWeight: pw.FontWeight.bold,
                      font: ttf,
                      color: Colors_pd,
                    ),
                  ),
                  pw.Text(
                    (serpang == 1) ? 'ต้นฉบับ (Original)' : 'สำเนา (Copy)',
                    textAlign: pw.TextAlign.right,
                    maxLines: 1,
                    style: pw.TextStyle(
                      fontSize: font_Size,
                      font: ttf,
                      color: Colors_pd,
                    ),
                  ),
                  pw.Text(
                    'เลขที่(ID) : $docno_inv ',
                    textAlign: pw.TextAlign.right,
                    maxLines: 1,
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
                      fontWeight: pw.FontWeight.bold,
                      font: ttf,
                      color: Colors_pd,
                    ),
                  ),
                  pw.Text(
                    'อ้างอิงถึง : $inv_num',
                    textAlign: pw.TextAlign.right,
                    maxLines: 1,
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
        // pw.SizedBox(height: 1 * PdfPageFormat.mm),
        // pw.Divider(),
        // pw.SizedBox(height: 1 * PdfPageFormat.mm),
      ]);
    }

    pw.Widget footer_data(int serpang) {
      return pw.Align(
        alignment: pw.Alignment.bottomCenter,
        child: pw.Container(
            // decoration: new pw.BoxDecoration(
            //     border: pw.Border(
            //         bottom: pw.BorderSide(
            //             color: PdfColors.grey600,
            //             width: 2.0,
            //             style: pw.BorderStyle.none))),
            child: pw.Column(
          mainAxisSize: pw.MainAxisSize.min,
          children: [
            pw.Container(
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: PdfColors.grey, width: 1),
                ),
                padding: pw.EdgeInsets.fromLTRB(2, 4, 2, 4),
                child: pw.Row(
                  children: [
                    for (int index = 0; index < 4; index++)
                      pw.Expanded(
                          flex: 1,
                          child: pw.Column(
                              mainAxisAlignment: pw.MainAxisAlignment.start,
                              // crossAxisAlignment: pw.CrossAxisAlignment.center,
                              children: [
                                pw.Text(
                                  'ลงชื่อ :',
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
                  ],
                )),
            // pw.Row(
            //   mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            //   children: [
            //     pw.Padding(
            //       padding: const pw.EdgeInsets.fromLTRB(0, 2, 0, 0),
            //       child: pw.Align(
            //         alignment: pw.Alignment.bottomLeft,
            //         child: pw.Text(
            //           'พิมพ์เมื่อ : $date',
            //           // textAlign: pw.TextAlign.left,
            //           style: pw.TextStyle(
            //             fontSize: 7.00,
            //             font: ttf,
            //             color: Colors_pd,
            //             // fontWeight: pw.FontWeight.bold
            //           ),
            //         ),
            //       ),
            //     ),
            //     pw.Padding(
            //       padding: const pw.EdgeInsets.fromLTRB(0, 2, 0, 0),
            //       child: pw.Align(
            //         alignment: pw.Alignment.bottomRight,
            //         child: pw.Text(
            //           'หน้าที่ ${context.pageNumber} / ${context.pagesCount} ',
            //           // textAlign: pw.TextAlign.left,
            //           style: pw.TextStyle(
            //             fontSize: 7.00,
            //             font: ttf,
            //             color: Colors_pd,
            //             // fontWeight: pw.FontWeight.bold
            //           ),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            if (serpang == 1 && tableData003.length < 7)
              pw.Padding(
                padding: pw.EdgeInsets.all(0),
                child: pw.Text(
                  '...' * 140,
                  maxLines: 1,
                  textAlign: pw.TextAlign.center,
                  style: pw.TextStyle(
                      font: ttf, fontSize: font_Size, color: PdfColors.grey500),
                ),
              ),
            if (tableData003.length > 6)
              pw.SizedBox(height: 2.2 * PdfPageFormat.mm),
          ],
        )),
      );
    }

    pw.Widget Body_data(int serpang) {
      return pw.Container(
        child: pw.Column(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Align(
              alignment: pw.Alignment.topCenter,
              child: pw.Container(
                  child: pw.Column(
                children: [
                  pw.Container(
                    decoration: const pw.BoxDecoration(
                      // color: PdfColors.green100,
                      border: pw.Border(
                        top: pw.BorderSide(color: PdfColors.grey800),
                        bottom: pw.BorderSide(color: PdfColors.grey800),
                      ),
                    ),
                    // padding: const pw.EdgeInsets.all(1.0),
                    child: pw.Row(
                      children: [
                        pw.Container(
                          width: 40,
                          decoration: const pw.BoxDecoration(
                            // color: PdfColors.green100,
                            border: pw.Border(
                                // left: pw.BorderSide(color: PdfColors.grey800),
                                // top: pw.BorderSide(color: PdfColors.grey800),
                                // bottom: pw.BorderSide(color: PdfColors.grey800),
                                ),
                          ),
                          // height: 25,
                          child: pw.Text(
                            'ลำดับ(#)',
                            maxLines: 1,
                            textAlign: pw.TextAlign.left,
                            style: pw.TextStyle(
                                fontSize: font_Size,
                                fontWeight: pw.FontWeight.bold,
                                font: ttf,
                                color: PdfColors.black),
                          ),
                        ),
                        pw.Expanded(
                          flex: 2,
                          child: pw.Container(
                            decoration: const pw.BoxDecoration(
                              // color: PdfColors.green100,
                              border: pw.Border(
                                  // left: pw.BorderSide(color: PdfColors.grey800),
                                  // top: pw.BorderSide(color: PdfColors.grey800),
                                  // bottom: pw.BorderSide(color: PdfColors.grey800),
                                  ),
                            ),
                            // height: 25,
                            child: pw.Text(
                              'รหัสสินค้า (Produet Code)',
                              maxLines: 1,
                              textAlign: pw.TextAlign.left,
                              style: pw.TextStyle(
                                  fontSize: font_Size,
                                  fontWeight: pw.FontWeight.bold,
                                  font: ttf,
                                  color: PdfColors.black),
                            ),
                          ),
                        ),
                        pw.Expanded(
                          flex: 4,
                          child: pw.Container(
                            decoration: const pw.BoxDecoration(
                              // color: PdfColors.green100,
                              border: pw.Border(
                                  // left: pw.BorderSide(color: PdfColors.grey800),
                                  // top: pw.BorderSide(color: PdfColors.grey800),
                                  // bottom: pw.BorderSide(color: PdfColors.grey800),
                                  ),
                            ),
                            // height: 25,
                            child: pw.Text(
                              'รายละเอียด (Description)',
                              textAlign: pw.TextAlign.left,
                              maxLines: 1,
                              style: pw.TextStyle(
                                  fontSize: font_Size,
                                  fontWeight: pw.FontWeight.bold,
                                  font: ttf,
                                  color: PdfColors.black),
                            ),
                          ),
                        ),
                        pw.Expanded(
                          flex: 1,
                          child: pw.Container(
                            decoration: const pw.BoxDecoration(
                              // color: PdfColors.green100,
                              border: pw.Border(
                                  // left: pw.BorderSide(color: PdfColors.grey800),
                                  // top: pw.BorderSide(color: PdfColors.grey800),
                                  // bottom: pw.BorderSide(color: PdfColors.grey800),
                                  ),
                            ),
                            // height: 25,
                            child: pw.Text(
                              'ยอด (Amount)',
                              textAlign: pw.TextAlign.right,
                              maxLines: 1,
                              style: pw.TextStyle(
                                  fontSize: font_Size,
                                  fontWeight: pw.FontWeight.bold,
                                  font: ttf,
                                  color: PdfColors.black),
                            ),
                          ),
                        ),
                        pw.Expanded(
                          flex: 2,
                          child: pw.Container(
                            decoration: const pw.BoxDecoration(
                              // color: PdfColors.green100,
                              border: pw.Border(
                                  // left: pw.BorderSide(color: PdfColors.grey800),
                                  // top: pw.BorderSide(color: PdfColors.grey800),
                                  // bottom: pw.BorderSide(color: PdfColors.grey800),
                                  ),
                            ),
                            // height: 25,
                            child: pw.Text(
                              'ภาษีมูลค่าเพิ่ม (Vat)',
                              textAlign: pw.TextAlign.right,
                              maxLines: 1,
                              style: pw.TextStyle(
                                  fontSize: font_Size,
                                  fontWeight: pw.FontWeight.bold,
                                  font: ttf,
                                  color: PdfColors.black),
                            ),
                          ),
                        ),
                        pw.Expanded(
                          flex: 2,
                          child: pw.Container(
                            decoration: const pw.BoxDecoration(
                              // color: PdfColors.green100,
                              border: pw.Border(
                                  // left: pw.BorderSide(color: PdfColors.grey800),
                                  // top: pw.BorderSide(color: PdfColors.grey800),
                                  // bottom: pw.BorderSide(color: PdfColors.grey800),
                                  ),
                            ),
                            // height: 25,
                            child: pw.Text(
                              'หัก ณ ที่จ่าย (Wht)',
                              textAlign: pw.TextAlign.right,
                              maxLines: 1,
                              style: pw.TextStyle(
                                  fontSize: font_Size,
                                  fontWeight: pw.FontWeight.bold,
                                  font: ttf,
                                  color: PdfColors.black),
                            ),
                          ),
                        ),
                        pw.Expanded(
                          flex: 2,
                          child: pw.Container(
                            decoration: const pw.BoxDecoration(
                              // color: PdfColors.green100,
                              border: pw.Border(
                                  // left: pw.BorderSide(color: PdfColors.grey800),
                                  // top: pw.BorderSide(color: PdfColors.grey800),
                                  // bottom: pw.BorderSide(color: PdfColors.grey800),
                                  ),
                            ),
                            // height: 25,
                            child: pw.Text(
                              'ยอดสุทธิ (Total Amount)',
                              textAlign: pw.TextAlign.right,
                              maxLines: 1,
                              style: pw.TextStyle(
                                  fontSize: font_Size,
                                  fontWeight: pw.FontWeight.bold,
                                  font: ttf,
                                  color: PdfColors.black),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  for (int index = 0; index < tableData003.length; index++)
                    pw.Container(
                      // decoration: const pw.BoxDecoration(
                      //   // color: PdfColors.green100,
                      //   border: pw.Border(
                      //     bottom: pw.BorderSide(color: PdfColors.grey800),
                      //   ),
                      // ),
                      child: pw.Row(
                        children: [
                          pw.Container(
                            width: 40,
                            decoration: const pw.BoxDecoration(
                              color: PdfColors.white,
                              border: const pw.Border(
                                  // left: pw.BorderSide(color: PdfColors.grey600),
                                  // bottom: pw.BorderSide(color: PdfColors.grey600),
                                  ),
                            ),
                            // padding: const pw.EdgeInsets.all(1.0),
                            child: pw.Align(
                              alignment: pw.Alignment.centerLeft,
                              child: pw.Text(
                                '${index + 1}',
                                maxLines: 1,
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
                              // height: 25,
                              decoration: const pw.BoxDecoration(
                                color: PdfColors.white,
                                border: const pw.Border(
                                    // left: pw.BorderSide(color: PdfColors.grey600),
                                    // bottom: pw.BorderSide(color: PdfColors.grey600),
                                    ),
                              ),
                              // padding: const pw.EdgeInsets.all(1.0),
                              child: pw.Align(
                                alignment: pw.Alignment.centerLeft,
                                child: pw.Text(
                                  '${tableData003[index][1]}',
                                  maxLines: 1,
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
                            flex: 4,
                            child: pw.Container(
                              // padding: const pw.EdgeInsets.all(1.0),
                              // height: 25,
                              decoration: const pw.BoxDecoration(
                                color: PdfColors.white,
                                border: const pw.Border(
                                    // left: pw.BorderSide(color: PdfColors.grey600),
                                    // bottom: pw.BorderSide(color: PdfColors.grey600),
                                    ),
                              ),
                              child: pw.Align(
                                alignment: pw.Alignment.centerLeft,
                                child: pw.Text(
                                  '${tableData003[index][2]}',
                                  maxLines: 1,
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
                              // padding: const pw.EdgeInsets.all(1.0),
                              // height: 25,
                              decoration: const pw.BoxDecoration(
                                color: PdfColors.white,
                                border: pw.Border(
                                    // left: pw.BorderSide(color: PdfColors.grey600),
                                    // right: pw.BorderSide(color: PdfColors.grey600),
                                    // bottom: pw.BorderSide(color: PdfColors.grey600),
                                    ),
                              ),
                              child: pw.Align(
                                alignment: pw.Alignment.centerRight,
                                child: pw.Text(
                                  '${tableData003[index][3]}',
                                  maxLines: 1,
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
                              // padding: const pw.EdgeInsets.all(1.0),
                              // height: 25,
                              decoration: const pw.BoxDecoration(
                                color: PdfColors.white,
                                border: pw.Border(
                                    // left: pw.BorderSide(color: PdfColors.grey600),
                                    // right: pw.BorderSide(color: PdfColors.grey600),
                                    // bottom: pw.BorderSide(color: PdfColors.grey600),
                                    ),
                              ),
                              child: pw.Align(
                                alignment: pw.Alignment.centerRight,
                                child: pw.Text(
                                  '${tableData003[index][4]}',
                                  maxLines: 1,
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
                              // padding: const pw.EdgeInsets.all(1.0),
                              // height: 25,
                              decoration: const pw.BoxDecoration(
                                color: PdfColors.white,
                                border: pw.Border(
                                    // left: pw.BorderSide(color: PdfColors.grey600),
                                    // right: pw.BorderSide(color: PdfColors.grey600),
                                    // bottom: pw.BorderSide(color: PdfColors.grey600),
                                    ),
                              ),
                              child: pw.Align(
                                alignment: pw.Alignment.centerRight,
                                child: pw.Text(
                                  '${tableData003[index][5]}',
                                  maxLines: 1,
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
                              // padding: const pw.EdgeInsets.all(1.0),
                              // height: 25,
                              decoration: const pw.BoxDecoration(
                                color: PdfColors.white,
                                border: pw.Border(
                                    // left: pw.BorderSide(color: PdfColors.grey600),
                                    // right: pw.BorderSide(color: PdfColors.grey600),
                                    // bottom: pw.BorderSide(color: PdfColors.grey600),
                                    ),
                              ),
                              child: pw.Align(
                                alignment: pw.Alignment.centerRight,
                                child: pw.Text(
                                  '${tableData003[index][6]}',
                                  maxLines: 1,
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
                    ),

                  pw.Container(
                    // height: 25,
                    decoration: const pw.BoxDecoration(
                      // color: PdfColors.green100,
                      border: pw.Border(
                        top: pw.BorderSide(color: PdfColors.grey600),
                        // bottom: pw.BorderSide(color: PdfColors.grey600),
                      ),
                    ),
                    padding: const pw.EdgeInsets.fromLTRB(0, 1.5, 0, 0),
                    alignment: pw.Alignment.centerRight,
                    child: pw.Row(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Expanded(
                          flex: 6,
                          child: pw.Text(
                            '(~${convertToThaiBaht(amt_inv)}~)',
                            style: pw.TextStyle(
                              fontSize: font_Size,
                              // fontWeight: pw.FontWeight.bold,
                              font: ttf,
                              fontStyle: pw.FontStyle.italic,
                              // decoration:
                              //     pw.TextDecoration.lineThrough,
                              color: PdfColors.grey800,
                            ),
                          ),
                        ),
                        // pw.Spacer(flex: 6),
                        pw.Expanded(
                          flex: 4,
                          child: pw.Container(
                            decoration: const pw.BoxDecoration(
                              // color: PdfColors.green100,
                              border: pw.Border(
                                // top: pw.BorderSide(color: PdfColors.grey600),
                                bottom: pw.BorderSide(color: PdfColors.grey600),
                              ),
                            ),
                            child: pw.Column(
                              mainAxisAlignment: pw.MainAxisAlignment.start,
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Container(
                                    decoration: const pw.BoxDecoration(
                                      // color: PdfColors.green100,
                                      border: pw.Border(
                                        // top: pw.BorderSide(color: PdfColors.grey600),
                                        bottom: pw.BorderSide(
                                            color: PdfColors.grey300),
                                      ),
                                    ),
                                    child: pw.Column(
                                        mainAxisAlignment:
                                            pw.MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            pw.CrossAxisAlignment.start,
                                        children: [
                                          pw.Row(
                                            children: [
                                              pw.Expanded(
                                                child: pw.Text(
                                                  'มูลค่าตามใบกำกับเดิม',
                                                  style: pw.TextStyle(
                                                      fontSize: font_Size,
                                                      fontWeight:
                                                          pw.FontWeight.bold,
                                                      font: ttf,
                                                      color: PdfColors.grey800),
                                                ),
                                              ),
                                              pw.Text(
                                                '${nFormat.format(sum_total)}',
                                                style: pw.TextStyle(
                                                    fontSize: font_Size,
                                                    fontWeight:
                                                        pw.FontWeight.bold,
                                                    font: ttf,
                                                    color: PdfColors.grey800),
                                              ),
                                            ],
                                          ),
                                          pw.Row(
                                            children: [
                                              pw.Expanded(
                                                child: pw.Text(
                                                  'มูลค่าที่ถูกต้อง',
                                                  style: pw.TextStyle(
                                                      fontSize: font_Size,
                                                      fontWeight:
                                                          pw.FontWeight.bold,
                                                      font: ttf,
                                                      color: PdfColors.grey800),
                                                ),
                                              ),
                                              pw.Text(
                                                '${nFormat.format(amt_inv - vat_inv - wht_inv)}',
                                                style: pw.TextStyle(
                                                    fontSize: font_Size,
                                                    fontWeight:
                                                        pw.FontWeight.bold,
                                                    font: ttf,
                                                    color: PdfColors.grey800),
                                              ),
                                            ],
                                          ),
                                          pw.Row(
                                            children: [
                                              pw.Expanded(
                                                child: pw.Text(
                                                  'ผลต่าง',
                                                  style: pw.TextStyle(
                                                      fontSize: font_Size,
                                                      fontWeight:
                                                          pw.FontWeight.bold,
                                                      font: ttf,
                                                      color: PdfColors.grey800),
                                                ),
                                              ),
                                              pw.Text(
                                                '${nFormat.format(sum_total - (amt_inv - vat_inv - wht_inv))}',
                                                style: pw.TextStyle(
                                                    fontSize: font_Size,
                                                    fontWeight:
                                                        pw.FontWeight.bold,
                                                    font: ttf,
                                                    color: PdfColors.grey800),
                                              ),
                                            ],
                                          ),
                                        ])),
                                pw.Row(
                                  children: [
                                    pw.Expanded(
                                      child: pw.Text(
                                        'ภาษีมูลค่าเพิ่ม / Vat ( $nvat_inv % )',
                                        style: pw.TextStyle(
                                            fontSize: font_Size,
                                            fontWeight: pw.FontWeight.bold,
                                            font: ttf,
                                            color: PdfColors.grey800),
                                      ),
                                    ),
                                    pw.Text(
                                      '${nFormat.format(vat_inv)}',
                                      // '${sum_vat}',
                                      // '$Vat',
                                      style: pw.TextStyle(
                                          fontSize: font_Size,
                                          fontWeight: pw.FontWeight.bold,
                                          font: ttf,
                                          color: PdfColors.grey800),
                                    ),
                                  ],
                                ),
                                pw.Row(
                                  children: [
                                    pw.Expanded(
                                      child: pw.Text(
                                        'หัก ณ ที่จ่าย / Wht ( $nwht_inv % )',
                                        style: pw.TextStyle(
                                            fontSize: font_Size,
                                            fontWeight: pw.FontWeight.bold,
                                            font: ttf,
                                            color: PdfColors.grey800),
                                      ),
                                    ),
                                    pw.Text(
                                      '${nFormat.format(wht_inv)}',
                                      style: pw.TextStyle(
                                          fontSize: font_Size,
                                          fontWeight: pw.FontWeight.bold,
                                          font: ttf,
                                          color: PdfColors.grey800),
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
                                            color: PdfColors.grey800),
                                      ),
                                    ),
                                    pw.Text(
                                      '${nFormat.format(amt_inv)}',
                                      style: pw.TextStyle(
                                          fontSize: font_Size,
                                          fontWeight: pw.FontWeight.bold,
                                          font: ttf,
                                          color: PdfColors.grey800),
                                    ),
                                  ],
                                ),
                                pw.Container(
                                  decoration: const pw.BoxDecoration(
                                    // color: PdfColors.green100,
                                    border: pw.Border(
                                      top: pw.BorderSide(
                                          color: PdfColors.grey600),
                                    ),
                                  ),
                                  child: pw.Row(
                                    children: [
                                      pw.Expanded(
                                        child: pw.Text(
                                          'ยอดรวมสุทธิ',
                                          style: pw.TextStyle(
                                              fontSize: font_Size,
                                              fontWeight: pw.FontWeight.bold,
                                              font: ttf,
                                              color: PdfColors.grey800),
                                        ),
                                      ),
                                      pw.Text(
                                        '${nFormat.format(amt_inv)}',
                                        style: pw.TextStyle(
                                            fontSize: font_Size,
                                            fontWeight: pw.FontWeight.bold,
                                            font: ttf,
                                            color: PdfColors.grey800),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // pw.SizedBox(height: 1 * PdfPageFormat.mm),
                ],
              )),
            ),
            if (tableData003.length < 6) footer_data(serpang)
          ],
        ),
      );
    }

    if (tableData003.length < 6)
      pdf.addPage(
        pw.MultiPage(
          pageFormat: PdfPageFormat.a4.copyWith(
            marginBottom: 4.00,
            marginLeft: 8.00,
            marginRight: 8.00,
            marginTop: 8.00,
          ),
          build: (context) {
            return [
              pw.Container(
                  height: PdfPageFormat.a4.height / 2.05,
                  decoration: const pw.BoxDecoration(
                    // color: PdfColors.green50,
                    border: pw.Border(
                        // top: pw.BorderSide(color: PdfColors.grey800),
                        // bottom: pw.BorderSide(color: PdfColors.grey800),
                        ),
                  ),
                  child: pw.Column(
                    children: [
                      Header(1),
                      pw.Expanded(child: Body_data(1)),
                    ],
                  )),
              pw.Container(
                  height: PdfPageFormat.a4.height / 2.05,
                  decoration: const pw.BoxDecoration(
                    // color: PdfColors.red50,
                    border: pw.Border(
                        // top: pw.BorderSide(color: PdfColors.grey800),
                        // bottom: pw.BorderSide(color: PdfColors.grey800),
                        ),
                  ),
                  child: pw.Column(
                    children: [
                      Header(2),
                      pw.Expanded(child: Body_data(2)),
                    ],
                  )),
            ];
          },
        ),
      );
    // if (tableData00.length > 5)
    //   pdf.addPage(
    //     pw.MultiPage(
    //         pageFormat: PdfPageFormat.a4.copyWith(
    //           marginBottom: 4.00,
    //           marginLeft: 8.00,
    //           marginRight: 8.00,
    //           marginTop: 8.00,
    //         ),
    //         header: (context) {
    //           return Header(1);
    //         },
    //         build: (context) {
    //           return [Body_data(1)];
    //         },
    //         footer: (tableData00.length < 5)
    //             ? null
    //             : (context) {
    //                 return footer_data(1);
    //               }),
    //   );
    // if (tableData00.length > 5)
    //   pdf.addPage(
    //     pw.MultiPage(
    //         pageFormat: PdfPageFormat.a4.copyWith(
    //           marginBottom: 4.00,
    //           marginLeft: 8.00,
    //           marginRight: 8.00,
    //           marginTop: 8.00,
    //         ),
    //         header: (context) {
    //           return Header(2);
    //         },
    //         build: (context) {
    //           return [Body_data(2)];
    //         },
    //         footer: (tableData00.length < 5)
    //             ? null
    //             : (context) {
    //                 return footer_data(2);
    //               }),
    //   );

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
          builder: (context) => PreviewPdfgen_Billsplay(
              doc: pdf, title: 'ใบเสร็จรับเงิน/ใบกำกับภาษี'),
        ));
  }
}
