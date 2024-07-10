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
    bank1,
  ) async {
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
                // pw.Container(
                //   // height: 60,
                //   // width: 200,
                //   decoration: const pw.BoxDecoration(
                //     color: PdfColors.grey200,
                //     border: pw.Border(
                //       right: pw.BorderSide(color: PdfColors.grey300),
                //       left: pw.BorderSide(color: PdfColors.grey300),
                //       top: pw.BorderSide(color: PdfColors.grey300),
                //       bottom: pw.BorderSide(color: PdfColors.grey300),
                //     ),
                //   ),
                //   padding: const pw.EdgeInsets.all(2.0),
                //   child: pw.Text(
                //     (pos.toString() == '1' && pay_ptset.toString() != '7')
                //         ? 'ชำระแล้ว (รอตรวจสอบอนุมัติ)'
                //         : (pos.toString() == '1' && pay_ptset.toString() == '7')
                //             ? 'ยังไม่ได้ชำระ (รอรับชำระ)'
                //             : (datexPay == null || datexPay.toString() == '')
                //                 ? '-'
                //                 : 'ชำระแล้ว',
                //     textAlign: pw.TextAlign.center,
                //     style: pw.TextStyle(
                //       color: PdfColors.black,
                //       // fontWeight: FontWeight.bold,
                //       font: ttf,
                //       fontSize: 12,
                //     ),
                //   ),
                // )
                pw.Center(
                  child: pw.Container(
                    child: pw.BarcodeWidget(
                        color: PdfColors.grey800,
                        data: (pos.toString() == '1' &&
                                pay_ptset.toString() != '7')
                            ? '$url'
                            : (url.toString() == '')
                                ? '-'
                                : '$url ',
                        barcode: pw.Barcode.qrCode(),
                        width: 50,
                        height: 50),
                  ),
                ),
                // pw.Container(
                //   // height: 60,
                //   // width: 200,
                //   decoration: const pw.BoxDecoration(
                //     color: PdfColors.grey200,
                //     border: pw.Border(
                //       right: pw.BorderSide(color: PdfColors.grey300),
                //       left: pw.BorderSide(color: PdfColors.grey300),
                //       top: pw.BorderSide(color: PdfColors.grey300),
                //       bottom: pw.BorderSide(color: PdfColors.grey300),
                //     ),
                //   ),
                //   padding: const pw.EdgeInsets.all(2.0),
                //   child: pw.Text(
                //     (pos.toString() == '1' && pay_ptset.toString() != '7')
                //         ? 'ชำระแล้ว (รอตรวจสอบอนุมัติ)'
                //         : (pos.toString() == '1' && pay_ptset.toString() == '7')
                //             ? 'ยังไม่ได้ชำระ (รอรับชำระ)'
                //             : (datexPay == null || datexPay.toString() == '')
                //                 ? '-'
                //                 : 'ชำระแล้ว',
                //     textAlign: pw.TextAlign.center,
                //     style: pw.TextStyle(
                //       color: PdfColors.black,
                //       // fontWeight: FontWeight.bold,
                //       font: ttf,
                //       fontSize: 12,
                //     ),
                //   ),
                // )
                pw.Text(
                  (pos.toString() == '1' && pay_ptset.toString() != '7')
                      ? 'ชำระแล้ว (รอตรวจสอบอนุมัติ)'
                      : (pos.toString() == '1' && pay_ptset.toString() == '7')
                          ? 'ยังไม่ได้ชำระ (รอรับชำระ)'
                          : (datexPay == null || datexPay.toString() == '')
                              ? '-'
                              : 'ชำระแล้ว',
                  textAlign: pw.TextAlign.center,
                  style: pw.TextStyle(
                    color: PdfColors.black,
                    // fontWeight: FontWeight.bold,
                    font: ttf,
                    fontSize: 12,
                  ),
                ),
                // pw.SizedBox(
                //   height: 10,
                //   child:
                // pw.Text(
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
                        'ข้อมูลการจองพื้นที่ รายวัน/ล็อคเสียบ',
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
            //           textAlign: pw.TextAlign.left,
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
            //           textAlign: pw.TextAlign.left,
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
                      (datexbook.length == 0)
                          ? '-'
                          : (datexbook.length == 1)
                              ? '${datexbook.map((model) => '${DateFormat('dd-MM').format(DateTime.parse('${model} 00:00:00'))}-${DateTime.parse('${model} 00:00:00').year + 543}').join('')}'
                              : '${datexbook.map((model) => '${DateFormat('dd-MM').format(DateTime.parse('${model} 00:00:00'))}-${DateTime.parse('${model} 00:00:00').year + 543}').join(', ')}',
                      // (datexbook == null || datexbook.toString() == '')
                      //     ? '${datexbook}'
                      //     : '${DateFormat('dd-MM').format(DateTime.parse('${datexbook} 00:00:00'))}-${DateTime.parse('${datexbook} 00:00:00').year + 543}',
                      // '${datex_selected}',
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
                      (datex == null || datex.toString() == '')
                          ? '${datex}'
                          : '${DateFormat('dd-MM').format(DateTime.parse('${datex} 00:00:00'))}-${DateTime.parse('${datex} 00:00:00').year + 543}',
                      // '${datexbook}',
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
                      (pos.toString() == '1' && pay_ptset.toString() != '7')
                          ? '${DateFormat('dd-MM').format(DateTime.parse('${datexPay} 00:00:00'))}-${DateTime.parse('${datexPay} 00:00:00').year + 543} (รอตรวจสอบอนุมัติ)'
                          : (pos.toString() == '1' &&
                                  pay_ptset.toString() == '7')
                              ? ' ยังไม่ได้ชำระ (รอรับชำระ)'
                              : (datexPay == null || datexPay.toString() == '')
                                  ? '${datexPay}'
                                  : '${DateFormat('dd-MM').format(DateTime.parse('${datexPay} 00:00:00'))}-${DateTime.parse('${datexPay} 00:00:00').year + 543}',
                      // '${datexPay}',pay_ptset
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
                      (pos.toString() == '1' && pay_ptset.toString() != '7')
                          ? '${TextForm_time} (รอตรวจสอบอนุมัติ)'
                          : (pos.toString() == '1' &&
                                  pay_ptset.toString() == '7')
                              ? ' ยังไม่ได้ชำระ (รอรับชำระ)'
                              : '${TextForm_time}',
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
                      'ชื่อบัญชี : ',
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
                      '${bname1}',
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
                      'ธนาคาร/เลขที่บัญชี : ',
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
                      '${bank1}(${bno1})',
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
                      (pos.toString() == '1' && pay_ptset.toString() != '7')
                          ? 'หลักฐาน : ${fileNameSlip_} (รอตรวจสอบอนุมัติ)'
                          : (pos.toString() == '1' &&
                                  pay_ptset.toString() == '7')
                              ? 'หลักฐาน : ยังไม่ได้ชำระ (รอรับชำระ)'
                              : 'หลักฐาน : ${fileNameSlip_}',
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
                                'ลำดับ - No',
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
                            width: 15,
                            padding: const pw.EdgeInsets.all(2.0),
                            child: pw.Align(
                              alignment: pw.Alignment.center,
                              child: pw.Text(
                                'วันที่ - Datex',
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
                                'รายการ - Product',
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
                                'ราคา - Price',
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
                                'จำนวน - Quantity',
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
                                'ราคารวม - Total',
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
                            left: pw.BorderSide(
                                color: PdfColors.grey600, width: 1),
                            right: pw.BorderSide(
                                color: PdfColors.grey600, width: 1),
                            // bottom: pw.BorderSide(
                            //     color: PdfColors.grey600, width: 1),
                            verticalInside: pw.BorderSide(
                                width: 1,
                                color: PdfColors.grey600,
                                style: pw.BorderStyle.solid)),
                        children: [
                          pw.TableRow(children: [
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
                              width: 15,
                              padding: const pw.EdgeInsets.all(2.0),
                              child: pw.Align(
                                alignment: pw.Alignment.topCenter,
                                child: pw.Text(
                                  (_TransReBillModels[index].datex == null ||
                                          _TransReBillModels[index]
                                                  .datex
                                                  .toString() ==
                                              '')
                                      ? '${_TransReBillModels[index].datex}'
                                      : '${DateFormat('dd-MM').format(DateTime.parse('${_TransReBillModels[index].datex} 00:00:00'))}-${DateTime.parse('${_TransReBillModels[index].datex} 00:00:00').year + 543}',
                                  // '${_TransReBillModels[index].datex}',
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
                                      ? '${nFormat.format(double.parse(_TransReBillModels[index].total!))}'
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
                                  '${nFormat.format(double.parse(_TransReBillModels[index].total!))}',
                                  maxLines: 2,
                                  textAlign: pw.TextAlign.right,
                                  style: pw.TextStyle(
                                      fontSize: font_Size,
                                      font: ttf,
                                      color: PdfColors.grey800),
                                ),
                              ),
                            ),
                          ])
                        ]),
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
                      '',
                      // (selected_Area.length == 0)
                      //     ? 'ตัวอักษร (~${convertToThaiBaht(0.00)}~)'
                      //     : 'ตัวอักษร (~${convertToThaiBaht(double.parse((selected_Area.fold(0.0, (previousValue, element) => previousValue + ((element.rent != null) ? double.parse(element.rent!) : 0) * selected_Area.length).toString())) + double.parse((expModels.fold(0.0, (previousValue, element) => previousValue + ((element.pri_book != null) ? double.parse(element.pri_book!) : 0) * selected_Area.length).toString())))}~)',
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
                          (Total == null || Total.toString() == '')
                              ? '0.00'
                              : '${nFormat.format(double.parse('$Total'))}',
                          // (selected_Area.length == 0)
                          //     ? '0.00'
                          //     : '${nFormat.format(double.parse((selected_Area.fold(0.0, (previousValue, element) => previousValue + ((element.rent != null) ? double.parse(element.rent!) : 0) * selected_Area.length).toString())) + double.parse((expModels.fold(0.0, (previousValue, element) => previousValue + ((element.pri_book != null) ? double.parse(element.pri_book!) : 0) * selected_Area.length).toString())))}',
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
          builder: (context) => PreviewPdfgen_BillsMarket(
              doc: pdf, nameBills: 'หลักฐานการจอง จากเว็ปMarket ${cFinn}'),
        ));
  }
}

class PreviewPdfgen_BillsMarket extends StatelessWidget {
  final pw.Document doc;
  final renTal_name;
  final nameBills;
  const PreviewPdfgen_BillsMarket(
      {Key? key, required this.doc, this.renTal_name, this.nameBills})
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
      // theme: ThemeData(
      //   primarySwatch: customSwatch.withOpacity(0.5),
      // ),
      // theme: ThemeData(
      //   primarySwatch: Colors.green,
      //   scrollbarTheme: ScrollbarThemeData().copyWith(
      //     thumbColor: MaterialStateProperty.all(Colors.lightGreen[200]),
      //   )),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: AppBarColors.hexColor,
          leading: IconButton(
            onPressed: () async {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_outlined,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          title: Text(
            "$nameBills",
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
          pdfFileName: "$nameBills.pdf",
        ),
      ),
    );
  }
}
