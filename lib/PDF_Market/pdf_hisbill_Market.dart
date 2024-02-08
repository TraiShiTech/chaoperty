import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:file_saver/file_saver.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:math' as math;
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../PeopleChao/Bills_.dart';
import '../Style/ThaiBaht.dart';
import '../Style/colors.dart';
import 'package:pdf/pdf.dart';
import 'package:auto_size_text/auto_size_text.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:math' as math;
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';

import '../../Constant/Myconstant.dart';

class Pdfgen_hisbill_Market {
  static void exportPDF_hisbill_market(
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
      datex_selected,
      datexPay,
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
      bno1,
      bank1) async {
    ///////
    final pdf = pw.Document();
    final font = await rootBundle.load("fonts/THSarabunNew.ttf");
    var Colors_pd = PdfColors.black;
    // final font = await rootBundle.load("fonts/Sarabun-Medium.ttf");

    int pageCount = 1; // Initialize the page count
    final ttf = pw.Font.ttf(font);
    double font_Size = 11.0;

    /////////--------------------------------->
    var nFormat = NumberFormat("#,##0.00", "en_US");
    var nFormat2 = NumberFormat("###0.00", "en_US");
    /////////--------------------------------->
    // final iconImage =
    //     (await rootBundle.load('images/LOGO.png')).buffer.asUint8List();
    // List netImage = [];
    // for (int i = 0; i < newValuePDFimg.length; i++) {
    //   netImage.add(await networkImage('${newValuePDFimg[i]}'));
    // }
    /////////--------------------------------->
    pw.Widget Header(context) {
      return pw.Column(children: [
        pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            // (netImage.isEmpty)
            //     ? pw.Container(
            //         height: 60,
            //         width: 60,
            //         color: PdfColors.grey200,
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

            //     // pw.Image(
            //     //     pw.MemoryImage(iconImage),
            //     //     height: 72,
            //     //     width: 70,
            //     //   )
            //     : pw.Image(
            //         (netImage[0]),
            //         // fit: pw.BoxFit.fill,
            //         height: 60,
            //         width: 60,
            //       ),
            // pw.SizedBox(width: 1 * PdfPageFormat.mm),
            pw.Container(
              // color: PdfColors.grey200,
              width: 400,
              child: pw.Column(
                mainAxisAlignment: pw.MainAxisAlignment.start,
                mainAxisSize: pw.MainAxisSize.min,
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    '$bill_name',
                    //'$',
                    maxLines: 2,
                    style: pw.TextStyle(
                      color: PdfColors.black,
                      fontSize: 14.00,
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
                  pw.Text(
                    (bill_tax.toString() == '' || bill_tax == null)
                        ? 'หมายเลขประจำตัวผู้เสียภาษี : 0'
                        : 'หมายเลขประจำตัวผู้เสียภาษี : $bill_tax',
                    // textAlign: pw.TextAlign.justify,
                    textAlign: pw.TextAlign.right,
                    style: pw.TextStyle(
                      fontSize: font_Size,
                      font: ttf,
                      color: Colors_pd,
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
                ],
              ),
            ),
            pw.Spacer(),
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              mainAxisAlignment: pw.MainAxisAlignment.end,
              children: [
                pw.Center(
                  child: pw.Container(
                    child: pw.BarcodeWidget(
                        color: PdfColors.grey800,
                        data: (cFinn.toString() == '') ? '-' : '$cFinn ',
                        barcode: pw.Barcode.qrCode(),
                        width: 50,
                        height: 50),
                  ),
                ),
                // pw.SizedBox(
                //   height: 10,
                //   child: pw.Text(
                //     '$cFinn',
                //     textAlign: pw.TextAlign.center,
                //     style: pw.TextStyle(
                //       color: PdfColors.black,
                //       // fontWeight: FontWeight.bold,
                //       font: ttf,
                //       fontSize: 12,
                //     ),
                //   ),
                // ),
              ],
            )
          ],
        ),
        pw.SizedBox(height: 1 * PdfPageFormat.mm),
        pw.SizedBox(height: 1 * PdfPageFormat.mm),
        pw.Divider(
          height: 0.5,
        ),
        pw.SizedBox(height: 4 * PdfPageFormat.mm),
      ]);
    }

    pdf.addPage(pw.MultiPage(
        pageFormat: PdfPageFormat.a4.copyWith(
          marginBottom: 14.00,
          marginLeft: 14.00,
          marginRight: 14.00,
          marginTop: 14.00,
        ),
        header: (context) {
          return Header(context);
        },
        build: (context) {
          return [
            pw.Padding(
              padding: const pw.EdgeInsets.all(1.0),
              child: pw.Row(
                children: [
                  pw.Expanded(
                    flex: 1,
                    child: pw.Container(
                      decoration: const pw.BoxDecoration(
                          color: PdfColors.grey200,
                          border: pw.Border(
                              bottom: pw.BorderSide(
                            color: PdfColors.grey600,
                            width: 1.0, // Underline thickness
                          ))),
                      padding: const pw.EdgeInsets.all(4.0),
                      child: pw.Text(
                        'ข้อมูลการจองพื้นที่ ขาจร/ล็อกเสียบ',
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                            fontSize: 12.00,
                            fontWeight: pw.FontWeight.bold,
                            font: ttf,
                            color: PdfColors.black),
                      ),
                    ),
                  )
                ],
              ),
            ),
            pw.Padding(
              padding: const pw.EdgeInsets.all(1.0),
              child: pw.Row(
                children: [
                  pw.Expanded(
                    flex: 1,
                    child: pw.Text(
                      'ชื่อผู้เช่า/บริษัท : ',
                      textAlign: pw.TextAlign.left,
                      style: pw.TextStyle(
                        color: PdfColors.black,
                        fontSize: 12,
                        font: ttf,
                      ),
                    ),
                  ),
                  pw.Expanded(
                    flex: 2,
                    child: pw.Text(
                      '${TextForm_name}',
                      textAlign: pw.TextAlign.left,
                      style: pw.TextStyle(
                        color: PdfColors.black,
                        fontSize: 12,
                        font: ttf,
                      ),
                    ),
                  ),
                  pw.Expanded(
                    flex: 1,
                    child: pw.Text(
                      'รหัสการจอง : ',
                      textAlign: pw.TextAlign.left,
                      style: pw.TextStyle(
                        color: PdfColors.black,
                        fontSize: 12,
                        font: ttf,
                      ),
                    ),
                  ),
                  pw.Expanded(
                    flex: 2,
                    child: pw.Text(
                      '$cFinn',
                      textAlign: pw.TextAlign.left,
                      style: pw.TextStyle(
                        color: PdfColors.black,
                        fontSize: 12,
                        font: ttf,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // pw.Padding(
            //   padding: const pw.EdgeInsets.all(1.0),
            //   child: pw.Row(
            //     children: [
            //       pw.Expanded(
            //         flex: 1,
            //         child: pw.Text(
            //           'ชื่อผู้เช่า/บริษัท : ',
            //           textAlign: pw.TextAlign.start,
            //           style: pw.TextStyle(
            //             color: PdfColors.black,
            //             // fontWeight: FontWeight.bold,
            //             font: ttf,
            //             fontSize: 12,
            //           ),
            //         ),
            //       ),
            //       pw.Expanded(
            //         flex: 5,
            //         child: pw.Text(
            //           '${TextForm_name.text}',
            //           textAlign: pw.TextAlign.start,
            //           style: pw.TextStyle(
            //             color: PdfColors.black,
            //             fontSize: 12,
            //             font: ttf,
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            pw.Padding(
              padding: const pw.EdgeInsets.all(1.0),
              child: pw.Row(
                children: [
                  pw.Expanded(
                    flex: 1,
                    child: pw.Text(
                      'เบอร์โทร : ',
                      textAlign: pw.TextAlign.left,
                      style: pw.TextStyle(
                        color: PdfColors.black,
                        fontSize: 12,
                        font: ttf,
                      ),
                    ),
                  ),
                  pw.Expanded(
                    flex: 2,
                    child: pw.Text(
                      '${TextForm_tel}',
                      textAlign: pw.TextAlign.left,
                      style: pw.TextStyle(
                        color: PdfColors.black,
                        fontSize: 12,
                        font: ttf,
                      ),
                    ),
                  ),
                  pw.Expanded(
                    flex: 1,
                    child: pw.Text(
                      'วันที่จอง : ',
                      textAlign: pw.TextAlign.left,
                      style: pw.TextStyle(
                        color: PdfColors.black,
                        fontSize: 12,
                        font: ttf,
                      ),
                    ),
                  ),
                  pw.Expanded(
                    flex: 2,
                    child: pw.Text(
                      '${datex_selected}',
                      textAlign: pw.TextAlign.left,
                      style: pw.TextStyle(
                        color: PdfColors.black,
                        fontSize: 12,
                        font: ttf,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            pw.Padding(
              padding: const pw.EdgeInsets.all(1.0),
              child: pw.Row(
                children: [
                  pw.Expanded(
                    flex: 1,
                    child: pw.Text(
                      'โซนพื้นที่ : ',
                      textAlign: pw.TextAlign.left,
                      style: pw.TextStyle(
                        color: PdfColors.black,
                        fontSize: 12,
                        font: ttf,
                      ),
                    ),
                  ),
                  pw.Expanded(
                    flex: 2,
                    child: pw.Text(
                      '${zoneName}',
                      textAlign: pw.TextAlign.left,
                      style: pw.TextStyle(
                        color: PdfColors.black,
                        fontSize: 12,
                        font: ttf,
                      ),
                    ),
                  ),
                  pw.Expanded(
                    flex: 1,
                    child: pw.Text(
                      'พื้นที่ทำการจอง : ',
                      textAlign: pw.TextAlign.left,
                      style: pw.TextStyle(
                        color: PdfColors.black,
                        fontSize: 12,
                        font: ttf,
                      ),
                    ),
                  ),
                  pw.Expanded(
                    flex: 2,
                    child: pw.Text(
                      (selected_Area == null)
                          ? 'ไม่พบพื้นที่ ที่ท่านจอง'
                          : '${selected_Area}',
                      textAlign: pw.TextAlign.left,
                      style: pw.TextStyle(
                        color: PdfColors.black,
                        fontSize: 12,
                        font: ttf,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            pw.Padding(
              padding: const pw.EdgeInsets.all(1.0),
              child: pw.Row(
                children: [
                  pw.Expanded(
                    flex: 1,
                    child: pw.Text(
                      'วันที่ทำรายการ : ',
                      textAlign: pw.TextAlign.left,
                      style: pw.TextStyle(
                        color: PdfColors.black,
                        fontSize: 12,
                        font: ttf,
                      ),
                    ),
                  ),
                  pw.Expanded(
                    flex: 2,
                    child: pw.Text(
                      '${datex_selected}',
                      textAlign: pw.TextAlign.left,
                      style: pw.TextStyle(
                        color: PdfColors.black,
                        fontSize: 12,
                        font: ttf,
                      ),
                    ),
                  ),
                  pw.Expanded(
                    flex: 1,
                    child: pw.Text(
                      'วันที่รับชำระ : ',
                      textAlign: pw.TextAlign.left,
                      style: pw.TextStyle(
                        color: PdfColors.black,
                        fontSize: 12,
                        font: ttf,
                      ),
                    ),
                  ),
                  pw.Expanded(
                    flex: 2,
                    child: pw.Text(
                      '${datexPay}',
                      textAlign: pw.TextAlign.left,
                      style: pw.TextStyle(
                        color: PdfColors.black,
                        fontSize: 12,
                        font: ttf,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            pw.Padding(
              padding: const pw.EdgeInsets.all(1.0),
              child: pw.Row(
                children: [
                  pw.Expanded(
                    flex: 1,
                    child: pw.Text(
                      'รูปแบบชำระ : ',
                      textAlign: pw.TextAlign.left,
                      style: pw.TextStyle(
                        color: PdfColors.black,
                        fontSize: 12,
                        font: ttf,
                      ),
                    ),
                  ),
                  pw.Expanded(
                    flex: 2,
                    child: pw.Text(
                      '${paymentName1}',
                      textAlign: pw.TextAlign.left,
                      style: pw.TextStyle(
                        color: PdfColors.black,
                        fontSize: 12,
                        font: ttf,
                      ),
                    ),
                  ),
                  pw.Expanded(
                    flex: 1,
                    child: pw.Text(
                      'เวลา/หลักฐาน : ',
                      textAlign: pw.TextAlign.left,
                      style: pw.TextStyle(
                        color: PdfColors.black,
                        fontSize: 12,
                        font: ttf,
                      ),
                    ),
                  ),
                  pw.Expanded(
                    flex: 2,
                    child: pw.Text(
                      '${TextForm_time}',
                      textAlign: pw.TextAlign.left,
                      style: pw.TextStyle(
                        color: PdfColors.black,
                        fontSize: 12,
                        font: ttf,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            pw.Padding(
              padding: const pw.EdgeInsets.all(1.0),
              child: pw.Row(
                children: [
                  pw.Expanded(
                    flex: 1,
                    child: pw.Text(
                      'ธนาคาร : ',
                      textAlign: pw.TextAlign.left,
                      style: pw.TextStyle(
                        color: PdfColors.black,
                        fontSize: 12,
                        font: ttf,
                      ),
                    ),
                  ),
                  pw.Expanded(
                    flex: 2,
                    child: pw.Text(
                      '$bank1',
                      textAlign: pw.TextAlign.left,
                      style: pw.TextStyle(
                        color: PdfColors.black,
                        fontSize: 12,
                        font: ttf,
                      ),
                    ),
                  ),
                  pw.Expanded(
                    flex: 1,
                    child: pw.Text(
                      'บัญชี : ',
                      textAlign: pw.TextAlign.left,
                      style: pw.TextStyle(
                        color: PdfColors.black,
                        fontSize: 12,
                        font: ttf,
                      ),
                    ),
                  ),
                  pw.Expanded(
                    flex: 2,
                    child: pw.Text(
                      '$bname1  ( ${bno1} )',
                      textAlign: pw.TextAlign.left,
                      style: pw.TextStyle(
                        color: PdfColors.black,
                        fontSize: 12,
                        font: ttf,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            pw.Padding(
              padding: const pw.EdgeInsets.all(1.0),
              child: pw.Row(
                children: [
                  pw.Expanded(
                    flex: 1,
                    child: pw.Text(
                      'หลักฐาน : ${fileNameSlip_}',
                      textAlign: pw.TextAlign.left,
                      style: pw.TextStyle(
                        color: PdfColors.black,
                        fontSize: 12,
                        font: ttf,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            pw.Divider(
              height: 0.5,
              color: PdfColors.grey600,
            ),
            pw.SizedBox(
              height: 10,
            ),
            pw.Align(
              alignment: pw.Alignment.topLeft,
              child: pw.Text(
                '# ค่าบริการทั้งหมด',
                maxLines: 2,
                textAlign: pw.TextAlign.left,
                style: pw.TextStyle(
                    fontSize: 14.00,
                    fontWeight: pw.FontWeight.bold,
                    font: ttf,
                    color: PdfColors.grey800),
              ),
            ),
            pw.SizedBox(
              height: 4,
            ),
            pw.Padding(
              padding: const pw.EdgeInsets.all(4.0),
              child: pw.Column(
                children: [
                  pw.Table(
                      border: const pw.TableBorder(
                          left:
                              pw.BorderSide(color: PdfColors.grey600, width: 1),
                          right:
                              pw.BorderSide(color: PdfColors.grey600, width: 1),
                          top:
                              pw.BorderSide(color: PdfColors.grey600, width: 1),
                          bottom:
                              pw.BorderSide(color: PdfColors.grey600, width: 1),
                          verticalInside: pw.BorderSide(
                              width: 1,
                              color: PdfColors.grey600,
                              style: pw.BorderStyle.solid)),
                      children: [
                        pw.TableRow(children: [
                          pw.Container(
                            color: PdfColors.grey200,
                            width: 15,
                            padding: const pw.EdgeInsets.all(2.0),
                            child: pw.Align(
                              alignment: pw.Alignment.center,
                              child: pw.Text(
                                'ลำดับ',
                                maxLines: 2,
                                textAlign: pw.TextAlign.center,
                                style: pw.TextStyle(
                                    fontSize: font_Size,
                                    fontWeight: pw.FontWeight.bold,
                                    font: ttf,
                                    color: PdfColors.grey800),
                              ),
                            ),
                          ),
                          pw.Container(
                            color: PdfColors.grey200,
                            width: 57,
                            padding: const pw.EdgeInsets.all(2.0),
                            child: pw.Align(
                              alignment: pw.Alignment.center,
                              child: pw.Text(
                                'รายการ',
                                maxLines: 2,
                                textAlign: pw.TextAlign.center,
                                style: pw.TextStyle(
                                    fontSize: font_Size,
                                    fontWeight: pw.FontWeight.bold,
                                    font: ttf,
                                    color: PdfColors.grey800),
                              ),
                            ),
                          ),
                          pw.Container(
                            color: PdfColors.grey200,
                            width: 30,
                            padding: const pw.EdgeInsets.all(2.0),
                            child: pw.Align(
                              alignment: pw.Alignment.center,
                              child: pw.Text(
                                'ราคา',
                                maxLines: 2,
                                textAlign: pw.TextAlign.center,
                                style: pw.TextStyle(
                                    fontSize: font_Size,
                                    fontWeight: pw.FontWeight.bold,
                                    font: ttf,
                                    color: PdfColors.grey800),
                              ),
                            ),
                          ),
                          pw.Container(
                            color: PdfColors.grey200,
                            width: 20,
                            padding: const pw.EdgeInsets.all(2.0),
                            child: pw.Align(
                              alignment: pw.Alignment.center,
                              child: pw.Text(
                                'จำนวน',
                                maxLines: 2,
                                textAlign: pw.TextAlign.center,
                                style: pw.TextStyle(
                                    fontSize: font_Size,
                                    fontWeight: pw.FontWeight.bold,
                                    font: ttf,
                                    color: PdfColors.grey800),
                              ),
                            ),
                          ),
                          pw.Container(
                            color: PdfColors.grey200,
                            width: 30,
                            padding: const pw.EdgeInsets.all(2.0),
                            child: pw.Align(
                              alignment: pw.Alignment.center,
                              child: pw.Text(
                                'ราคารวม',
                                maxLines: 2,
                                textAlign: pw.TextAlign.center,
                                style: pw.TextStyle(
                                    fontSize: font_Size,
                                    fontWeight: pw.FontWeight.bold,
                                    font: ttf,
                                    color: PdfColors.grey800),
                              ),
                            ),
                          ),
                        ])
                      ]),
                  for (int index = 0;
                      index < _TransReBillModels.length;
                      index++)
                    pw.Table(
                      border: const pw.TableBorder(
                          left:
                              pw.BorderSide(color: PdfColors.grey600, width: 1),
                          right:
                              pw.BorderSide(color: PdfColors.grey600, width: 1),
                          // bottom: pw.BorderSide(
                          //     color: PdfColors.grey600, width: 1),
                          verticalInside: pw.BorderSide(
                              width: 1,
                              color: PdfColors.grey600,
                              style: pw.BorderStyle.solid)),
                      children: [
                        pw.TableRow(
                          children: [
                            pw.Container(
                              width: 15,
                              padding: const pw.EdgeInsets.all(2.0),
                              child: pw.Align(
                                alignment: pw.Alignment.topCenter,
                                child: pw.Text(
                                  '${index + 1}',
                                  maxLines: 2,
                                  textAlign: pw.TextAlign.center,
                                  style: pw.TextStyle(
                                      fontSize: font_Size,
                                      font: ttf,
                                      color: PdfColors.grey800),
                                ),
                              ),
                            ),
                            pw.Container(
                              width: 57,
                              padding: const pw.EdgeInsets.all(2.0),
                              child: pw.Align(
                                alignment: pw.Alignment.topLeft,
                                child: pw.Text(
                                  '${_TransReBillModels[index].expname}',
                                  maxLines: 2,
                                  textAlign: pw.TextAlign.left,
                                  style: pw.TextStyle(
                                      fontSize: font_Size,
                                      font: ttf,
                                      color: PdfColors.grey800),
                                ),
                              ),
                            ),
                            pw.Container(
                              width: 30,
                              padding: const pw.EdgeInsets.all(2.0),
                              child: pw.Align(
                                alignment: pw.Alignment.topRight,
                                child: pw.Text(
                                  (_TransReBillModels[index].pri_book == null)
                                      ? (_TransReBillModels[index].total ==
                                              null)
                                          ? '0.00'
                                          : '${nFormat.format(double.parse(_TransReBillModels[index].total!))}'
                                      : '${nFormat.format(double.parse(_TransReBillModels[index].pri_book!))}',
                                  maxLines: 2,
                                  textAlign: pw.TextAlign.right,
                                  style: pw.TextStyle(
                                      fontSize: font_Size,
                                      font: ttf,
                                      color: PdfColors.grey800),
                                ),
                              ),
                            ),
                            pw.Container(
                              width: 20,
                              padding: const pw.EdgeInsets.all(2.0),
                              child: pw.Align(
                                alignment: pw.Alignment.topCenter,
                                child: pw.Text(
                                  (_TransReBillModels[index].expser == null ||
                                          _TransReBillModels[index]
                                                  .expser
                                                  .toString() ==
                                              '0')
                                      ? '1'
                                      : '$Areaqty',
                                  maxLines: 2,
                                  textAlign: pw.TextAlign.center,
                                  style: pw.TextStyle(
                                      fontSize: font_Size,
                                      font: ttf,
                                      color: PdfColors.grey800),
                                ),
                              ),
                            ),
                            pw.Container(
                              width: 30,
                              padding: const pw.EdgeInsets.all(2.0),
                              child: pw.Align(
                                alignment: pw.Alignment.topRight,
                                child: pw.Text(
                                  (_TransReBillModels[index].total == null)
                                      ? '0.00'
                                      : '${nFormat.format(double.parse(_TransReBillModels[index].total!))}',
                                  maxLines: 2,
                                  textAlign: pw.TextAlign.right,
                                  style: pw.TextStyle(
                                      fontSize: font_Size,
                                      font: ttf,
                                      color: PdfColors.grey800),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  pw.Divider(
                    height: 2,
                  )
                ],
              ),
            ),
            pw.Padding(
              padding: const pw.EdgeInsets.all(4.0),
              child: pw.Row(
                children: [
                  pw.Expanded(
                    flex: 4,
                    child: pw.Text(
                      // '${Total}',
                      (Total == null || Total.toString() == '')
                          ? 'ตัวอักษร (~${convertToThaiBaht(0.00)}~)'
                          : 'ตัวอักษร (~${convertToThaiBaht(double.parse(Total.toString()))}~)',
                      textAlign: pw.TextAlign.left,
                      style: pw.TextStyle(
                        color: PdfColors.black,
                        fontSize: 12,
                        font: ttf,
                      ),
                    ),
                  ),
                  pw.Expanded(
                    flex: 1,
                    child: pw.Text(
                      'ราคารวมทั้งหมด',
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(
                        color: PdfColors.black,
                        fontSize: 12,
                        font: ttf,
                      ),
                    ),
                  ),
                  pw.Expanded(
                    flex: 1,
                    child: pw.Container(
                      decoration: pw.BoxDecoration(
                        color: PdfColors.grey200,
                        borderRadius: const pw.BorderRadius.only(
                          topLeft: pw.Radius.circular(0),
                          topRight: pw.Radius.circular(0),
                          bottomLeft: pw.Radius.circular(0),
                          bottomRight: pw.Radius.circular(0),
                        ),
                        // border: pw.Border.all(color: PdfColors.grey, width: 1),
                      ),
                      padding: const pw.EdgeInsets.all(2.0),
                      child: pw.Center(
                        child: pw.Text(
                          // '${Total}',
                          (Total == null || Total.toString() == '')
                              ? '0.00'
                              : '${nFormat.format(double.parse(Total.toString()))}',
                          textAlign: pw.TextAlign.center,
                          style: pw.TextStyle(
                            color: PdfColors.black,
                            fontSize: 12,
                            font: ttf,
                          ),
                        ),
                      ),
                    ),
                  ),
                  pw.Text(
                    ' บาท',
                    textAlign: pw.TextAlign.center,
                    style: pw.TextStyle(
                      color: PdfColors.black,
                      fontSize: 12,
                      font: ttf,
                    ),
                  ),
                ],
              ),
            ),
          ];
        },
        footer: (context) {
          return pw.Column(mainAxisSize: pw.MainAxisSize.min, children: [
            // pw.Divider(height: 0.5, color: PdfColors.grey200),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Padding(
                  padding: const pw.EdgeInsets.fromLTRB(0, 2, 0, 0),
                  child: pw.Align(
                    alignment: pw.Alignment.bottomLeft,
                    child: pw.Text(
                      '# คำเตือน : กรุณาเก็บหลักฐานนี้ไว้ แสดงต่อเจ้าหน้าที่',
                      // textAlign: pw.TextAlign.left,
                      style: pw.TextStyle(
                        fontSize: 11.00,
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
                        fontSize: 11.00,
                        font: ttf,
                        color: Colors_pd,
                        // fontWeight: pw.FontWeight.bold
                      ),
                    ),
                  ),
                ),
              ],
            )
          ]);
        }));
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PreviewPdfgen_Bills(
              doc: pdf, nameBills: 'หลักฐานการจอง จากเว็ปMarket ${cFinn}'),
        ));
  }
}
